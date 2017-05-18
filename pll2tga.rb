def pixels(block2)
	if block2 == "0000" # 00
		block	= [1, 1]
		total	= 2
	elsif block2 == "0001"	# 01
		block	= [2, 1]
		total	= 3
	elsif block2 == "0010"	# 02
		block	= [3, 1]
		total	= 4
	elsif block2 == "0011"	# 03
		block	= [4, 1]
		total	= 5
	elsif block2 == "0100"	# 04
		block	= [1, 2]
		total	= 3
	elsif block2 == "0101"	# 05
		block	= [2, 2]
		total	= 4
	elsif block2 == "0110"	# 06
		block	= [3, 2]
		total	= 5
	elsif block2 == "0111"	# 07
		block	= [4, 2]
		total	= 6
	elsif block2 == "1000"	# 08
		block	= [1, 3]
		total	= 4
	elsif block2 == "1001"	# 09
		block	= [2, 3]
		total	= 5
	elsif block2 == "1010"	# 0A
		block	= [3, 3]
		total	= 6
	elsif block2 == "1011"	# 0B
		block	= [4, 3]
		total	= 7
	elsif block2 == "1100"	# 0C
		block	= [1, 4]
		total	= 5
	elsif block2 == "1101"	# 0D
		block	= [2, 4]
		total	= 6
	elsif block2 == "1110"	# 0E
		block	= [3, 4]
		total	= 7
	elsif block2 == "1111"	# 0F
		block	= [4, 4]
		total	= 8
	end
	return [block, total]
end

# Cleaning screen
system("cls")

# Showing info
print "PLL 2 TGA v1 by SecaProject
Convert PLL files in TGA
PLL file: "

# Get the filename
if ARGV[0]
  puts file	= File.expand_path(ARGV[0])
else
  file		= File.expand_path(gets.gsub('\\', '/').gsub(["0a"].pack("H*"), ''))
end
puts dir = file.split(".")[0]

flag0	= IO.binread(file, 2, 0x00).unpack("H*").join
divisor	= ( IO.binread(file, 1, 0x01).unpack("H*").join.hex - 2 ) / 0x10
nColors	= IO.binread(file, 2, 0x02).unpack("v*").join.to_i
width	= IO.binread(file, 2, 0x04).unpack("H*").join
height	= IO.binread(file, 2, 0x06).unpack("H*").join
width1	= IO.binread(file, 2, 0x04).unpack("v*").join.to_i
height1	= IO.binread(file, 2, 0x06).unpack("v*").join.to_i
unknow4	= IO.binread(file, 2, 0x08)
unknow5	= IO.binread(file, 2, 0x0a)
unknow6	= IO.binread(file, 2, 0x0c)
unknow7	= IO.binread(file, 2, 0x0e)
unknow8	= IO.binread(file, 2, 0x10)
unknow9	= IO.binread(file, 2, 0x12).unpack("v*").join.to_i

if flag0 == "0182"
	divisor	= 8; times = 4; condit = 0xff
elsif flag0 == "0172"
	divisor	= 7; times = 4; condit = 0x7f
elsif flag0 == "0162"
	divisor	= 6; times = 5; condit = 0x3f
elsif flag0 == "0152"
	divisor	= 5; times = 6; condit = 0x1f
elsif flag0 == "0042"
	divisor	= 4; times = 8; condit = 0xf
elsif flag0 == "0032"
	divisor	= 3; times = 10; condit = 0x7
elsif flag0 == "0022"
	divisor	= 2; times = 8; condit = 0x3
elsif flag0 == "0012"
	divisor	= 1; times = 32; condit	= 0x1
end

puts "Colors:     #{nColors}"
puts "Resolution: #{width1}x#{height1}"

palOff	= 20
bitmOff	= palOff + nColors * 2
if bitmOff % 4 != 0
	bitmOff += 4 - bitmOff % 4
end
jump	= 0
bitmap	= []
readed	= 0

print "Converting:\r\n  Palette: "
#$data = File.new("#{file.split(".")[0]}_pal.tga", "wb")
#$data.write ["00000200000000000000000010000800"].pack("H*")
#$data.write ["1020"].pack("H*")
#for loop in 0..nColors-1
#	$data.write IO.binread(file, 2, 20 + loop*2)
#end
#for loop in nColors..128
#	$data.write "\000\000"
#end
#$data.close

print "OK\r\n  Mapping: "
$data = File.new("#{file.split(".")[0]}.tga", "wb")
$data.write ["000002000000000000000000#{width}#{height}"].pack("H*")
$data.write ["1020"].pack("H*")
while 0 == 0
	bits	= IO.binread(file, 1, bitmOff + jump).unpack("B*").join
	readed	+= pixels(bits[4..7])[1] + pixels(bits[0..3])[1]
	bitmap.push(pixels(bits[4..7])[0][0], pixels(bits[4..7])[0][1], pixels(bits[0..3])[0][0], pixels(bits[0..3])[0][1])
	jump	+= 1
	if readed >= width1 * height1
		break
	end
end
print "OK\r\n  Coloring: "

offset	= bitmOff + jump

if offset % 4 != 0
	offset += 4 - offset % 4
end

for loop in 0..bitmap.count/times
	colors	= IO.binread(file, 4, offset + loop * 4).unpack("V*").join.to_i
	for set in 0..times-1
		color	= colors >> divisor * set
		color	= color.to_s(16).rjust(2, "0")[-2..-1].hex
		color	= color & condit
		if bitmap.count < loop * times + set + 1
			break
		end
		for repeat in 1..bitmap[loop * times + set]
			bitRGB = IO.binread(file, 2, palOff + color * 2).unpack("B*").join
			$data.write ["#{bitRGB[0..2]}#{bitRGB[9..13]}#{bitRGB[8]}#{bitRGB[3..7]}#{bitRGB[14..15]}"].pack("B*")
		end
	end
end
$data.close

puts "OK"