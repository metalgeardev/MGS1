require 'fileutils'
file	= "brf.dat"
#file	= "brfvr.dat"
folder	= file.split(".")[0]
FileUtils::mkdir_p folder
offset	= 0
size	= 0
count	= 0

$log = File.new("log.txt", "wb")
while (files = IO.binread(file, 0x02, offset).unpack("v*").join.to_i) != 0
  if files == 1290
    break
  end
  FileUtils::mkdir_p "#{folder}/#{count.to_s(16).rjust(6, "0")}"
  offset += 0x03
  for loop in 0..files-1
    name = ""
    while 0 == 0
      offset += 0x01
      byte = IO.binread(file, 0x01, offset)
      if byte == "\x00"
        if offset%0x04 >= 0 && offset%0x04 < 0x04
          offset += (0x04 - (offset%0x04))
        end
        break
      end
      name += byte
    end
    size = IO.binread(file, 0x04, offset).unpack("V*").join.to_i
    offset += 0x04
    $extract = File.new("#{folder}/#{count.to_s(16).rjust(6, "0")}/#{name}", "wb")
    $extract.write IO.binread(file, size, offset)
    $extract.close
	info = "#{folder}/#{count.to_s(16).rjust(6, "0")}/#{name}"
	$log.write IO.binread(info, 2, 0).unpack("H*").join + " "
	$log.write "P" + IO.binread(info, 2, 2).unpack("H*").join + " "
	$log.write "W" + IO.binread(info, 2, 4).unpack("H*").join + " "
	$log.write "H" + IO.binread(info, 2, 6).unpack("H*").join + " "
	$log.write IO.binread(info, 2, 8).unpack("H*").join + " "
	$log.write IO.binread(info, 2, 10).unpack("H*").join + " "
	$log.write IO.binread(info, 2, 12).unpack("H*").join + " "
	$log.write IO.binread(info, 2, 14).unpack("H*").join + " "
	$log.write IO.binread(info, 2, 16).unpack("H*").join + " "
	$log.write IO.binread(info, 2, 18).unpack("H*").join + " "
	$log.write info + "\r\n"
    offset += size
    puts name
  end
  if offset%0x800 >= 0 && offset%0x800 < 0x800
    offset += (0x800 - (offset%0x800))
  end
  count += 1
end

while File.size(file) != offset
  if IO.binread(file, 0x03, offset).unpack("H*").join == "0a0501"
    count += 1
    $extract = File.new("#{folder}/#{count.to_s(16).rjust(6, "0")}.pcx", "wb")
    $extract.close
  end
  puts "#{count.to_s(16).rjust(6, "0")}.pcx"
  $extract = File.new("#{folder}/#{count.to_s(16).rjust(6, "0")}.pcx", "ab")
  $extract.write IO.binread(file, 0x800, offset)
  $extract.close
  offset += 0x800
end