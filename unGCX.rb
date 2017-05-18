system("cls")

puts "Loading external ruby files"
dir = "./def/"
d = Dir.new(dir)
d.each {|rubyFile|
	if File.extname(rubyFile) == ".rb"
		print "  #{rubyFile}: "
		require "#{dir}/#{rubyFile}"
		puts "OK"
	end
}
puts

file	= "63ea54.gcx"

magicKey	= IO.binread(file, 2, 0)
chunkSize	= IO.binread(file, 2, 2).unpack("H*").join.hex

offset		= 4
hashRow		= IO.binread(file, 2, offset).unpack("H*").join
while hashRow != "0000"
	offset	+= 4
	hashRow	= IO.binread(file, 2, offset).unpack("H*").join
end
jump	= 4 + offset
offset	= 4

$data	= File.new("#{file.split(".")[0]}.txt", "wb")
puts "definitions"
$data.write "***************\r\n* DEFINITIONS *\r\n***************\r\n"
hashRow		= IO.binread(file, 2, offset).unpack("H*").join
while hashRow != "0000"
	sizeRow	= IO.binread(file, 2, offset + 2).unpack("H*").join.hex + jump
	puts "#{hashRow} @#{sizeRow}"
	$data.write "<DEF name=\"#{hashRow}\">\r\n"
	size	= IO.binread(file, 2, sizeRow + 1).unpack("H*").join.hex + 1
	gcx40(IO.binread(file, size, sizeRow), "  ")
	$data.write "\r\n</DEF>\r\n\r\n"
	offset	+= 4
	hashRow	= IO.binread(file, 2, offset).unpack("H*").join
end

puts "bytecode"
$data.write "************\r\n* BYTECODE *\r\n************\r\n"
offset	= chunkSize + 8
size	= IO.binread(file, 2, offset + 1).unpack("H*").join.hex + 1
gcx40(IO.binread(file, size, offset), "")
$data.write "\r\n\r\n"
offset	+= size + 2

puts "extra"
$data.write "*********\r\n* EXTRA *\r\n*********\r\n"
size	= IO.binread(file, 2, offset).unpack("H*").join.hex + 1
if size != 1
	$data.write IO.binread(file, size, offset+2).unpack("H*").join
end
$data.write "\r\n\r\n"

puts "finish"
$data.write "**********\r\n* FINISH *\r\n**********"
$data.close