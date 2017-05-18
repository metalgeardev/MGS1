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

file	= "RADIO.DAT"

offset	= 0
files	= 0
$data	= File.new("#{file.split(".")[0]}.txt", "wb")
start	= TRUE
while 0 == 0
	byte	= IO.binread(file, 2, offset).unpack("H*").join
	if byte == "0000" || byte == "0002" || byte == "000e" ||
	   byte == "0024" || byte == "002c" || byte == "0064" ||
	   byte == "0aaa" || byte == "00e0" || byte == "00a9" ||
	   byte == "00b4" || byte == "01e0" || byte == "2c0e" ||
	   byte == "bf8b" || byte == "0b00" || byte == "00b0" ||
	   byte == "2c00" || byte == "0380" || byte == "2c02" ||
	   byte == "0038" || byte == "6aaa" || byte == "2c03" ||
	   byte == "0001" || byte == "00a4" || byte == "0609" ||
	   byte == "0290" || byte == "gggg" || byte == "0028" ||
	   byte == "6ba3" || byte == "0aae" || byte == "2baa" ||
	   byte == "0400" || byte == "062c" || byte == "00a0" ||
	   byte == "00e3" || byte == "24b4" || byte == "010b"
		size	= 36
		$data.write IO.binread(file, size, offset).unpack("H*").join
		$data.write "\r\n"
	else
		$data.write "FREQ:"
		$data.write IO.binread(file, 2, offset).unpack("H*").join.hex / 100.0
		$data.write " "
		$data.write IO.binread(file, 2, offset + 2).unpack("H*").join
		$data.write " "
		$data.write IO.binread(file, 2, offset + 4).unpack("H*").join
		$data.write " "
		$data.write IO.binread(file, 2, offset + 6).unpack("H*").join
		$data.write "\r\n"
		offset	+= 8
		byte	= IO.binread(file, 1, offset).unpack("H*").join
		if byte == "80"
			size	= IO.binread(file, 2, offset + 1).unpack("H*").join.hex + 1
#			$data.write IO.binread(file, 3, offset).unpack("H*").join
			$data.write "CREATE"
			$data.write "{"
			radio80( IO.binread(file, size - 3, offset + 3), "  ")
			$data.write "}\r\n"
		else
			size	= 1000
		end
	end
	$data.write "\r\n"
	offset	+= size
	puts files	+= 1
end