require 'fileutils'

# Showing info
print "unWVX v0.2

Extracts wvx to vag
Write the path and filename and hit enter.

wvx file: "

# Get the filename
file = gets.gsub('\\', '/').gsub(["0a"].pack("H*"), '')

# Exist?
if file == ""
 puts "No filename specified, hit enter to exit."
 gets
 exit
elsif !File.file?(file)
 puts "The file \"#{file}\" don't exist, hit enter to exit."
 gets
 exit
end

puts file.split(".")[0]
FileUtils::mkdir_p file.split(".")[0]

offset		= 0
# Block 1: table
unk00		= IO.binread(file, 4, 0).unpack("H*").join
blockSize	= IO.binread(file, 4, 4).unpack("H*").join.hex
unk02		= IO.binread(file, 4, 8).unpack("H*").join
unk03		= IO.binread(file, 4, 12).unpack("H*").join

rows		= blockSize / 16
reset		= IO.binread(file, 4, 16).unpack("V*").join.to_i
block2Start	= blockSize + 32


# Block 2: VB
jump		= 16
loop		= 0
datainfo	= []
while 0 == 0
	if block2Start + jump != File.size(file)
		line	= IO.binread(file, 16, block2Start + jump).unpack("H*").join.hex
	else
		$data	= File.new("#{file.split(".")[0]}/#{loop}.vag", "wb")
		$data.write ["5641477000000003"].pack("H*")
		$data.write ["00000000"].pack("H*")
		$data.write [(jump).to_s(16).rjust(8, "0")].pack("H*")
		$data.write ["00002b1100000000"].pack("H*")
		$data.write ["0000000000000000"].pack("H*")
		$data.write "#{file.split(".")[0]}_#{loop}".ljust(16, "\0")
		$data.write IO.binread(file, jump, block2Start)
		$data.close
		datainfo.push(block2Start - blockSize - 32)
		break
	end
	if line == 0
		$data	= File.new("#{file.split(".")[0]}/#{loop}.vag", "wb")
		$data.write ["5641477000000003"].pack("H*")
		$data.write ["00000000"].pack("H*")
		$data.write [(jump).to_s(16).rjust(8, "0")].pack("H*")
		$data.write ["00002b1100000000"].pack("H*")
		$data.write ["0000000000000000"].pack("H*")
		$data.write "#{file.split(".")[0]}_#{loop}".ljust(16, "\0")
		$data.write IO.binread(file, jump, block2Start)
		$data.close
		datainfo.push(block2Start - blockSize - 32)
		loop		+= 1
		block2Start	+= jump
		jump		= 0
	end
	jump	+= 16
end

$data	= File.new("#{file.split(".")[0]}/data.txt", "wb")
for read in 1..rows
	relOffs	= IO.binread(file, 4, offset + read * 16 + 0).unpack("V*").join.to_i - reset
	unk04	= IO.binread(file, 2, offset + read * 16 + 4).unpack("H*").join
	unk05	= IO.binread(file, 2, offset + read * 16 + 6).unpack("H*").join
	unk06	= IO.binread(file, 2, offset + read * 16 + 8).unpack("H*").join
	unk07	= IO.binread(file, 2, offset + read * 16 + 10).unpack("H*").join
	unk08	= IO.binread(file, 2, offset + read * 16 + 12).unpack("H*").join
	unk09	= IO.binread(file, 2, offset + read * 16 + 14).unpack("H*").join
	name	= datainfo.index(relOffs)
	$data.write "#{name}.vag	#{unk04} #{unk05} #{unk06} #{unk07} #{unk08} #{unk09}\r\n"
end
$data.close
