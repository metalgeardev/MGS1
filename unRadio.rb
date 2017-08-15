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

$unkown_block_headers = [
  "0000",
  "0001",
  "0002",
  "000e",
  "0024",
  "0028",
  "002c",
  "0038",
  "0064",
  "00a0",
  "00a4",
  "00a9",
  "00b0",
  "00b4",
  "00e0",
  "00e3",
  "010b",
  "01e0",
  "0290",
  "0380",
  "0400",
  "0609",
  "062c",
  "0aaa",
  "0aae",
  "0b00",
  "24b4",
  "2baa",
  "2c00",
  "2c02",
  "2c03",
  "2c0e",
  "6aaa",
  "6ba3",
  "bf8b",
  "gggg",
]
file	= "RADIO.DAT"

offset	= 0
files	= 0
$data	= File.new("#{file.split(".")[0]}.txt", "wb")
start	= TRUE
while offset < File.size(file)
  byte	= IO.binread(file, 2, offset).unpack("H*").join
  if $unkown_block_headers.include? byte
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
