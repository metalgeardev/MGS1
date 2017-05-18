require 'fileutils'

def getColor(binary)
	color = 16
	color += 80 if binary[0] == "1"
	color += 40 if binary[1] == "1"
	color += 20 if binary[2] == "1"
	color += 10 if binary[3] == "1"
	color += 8 if binary[4] == "1"
	return color
end

file		= "face.dat"
root		= "face"
trueColor	= false
FileUtils::mkdir_p root

offset	= 0
folder	= -1
while offset != File.size(file)
	puts folder	+= 1
	FileUtils::mkdir_p "#{root}/#{folder.to_s.rjust(3, "0")}"
	rows	= IO.binread(file, 4, offset).unpack("V*").join.to_i
	offset	+= 4
	for loop in 0..rows-1
		hash	= IO.binread(file, 2, offset + loop * 12 + 2).unpack("H*").join
		size	= IO.binread(file, 4, offset + loop * 12 + 4).unpack("V*").join.to_i
		absOff	= IO.binread(file, 4, offset + loop * 12 + 8).unpack("V*").join.to_i
#		$data = File.new("#{root}/#{folder.to_s.rjust(3, "0")}/#{hash}.bin", "wb")
#		$data.write IO.binread(file, size, offset + absOff)
#		$data.close
		palette	= IO.binread(file, 4, offset + absOff + 0).unpack("V*").join.to_i
		FileUtils::mkdir_p "#{root}/#{folder.to_s.rjust(3, "0")}/#{hash}"
		print "  #{hash}: "
		if palette == 32
			bitmap	= IO.binread(file, 4, offset + absOff + 4).unpack("V*").join.to_i
			eyes0	= IO.binread(file, 4, offset + absOff + 8).unpack("V*").join.to_i
			eyes1	= IO.binread(file, 4, offset + absOff + 12).unpack("V*").join.to_i
			zero0	= IO.binread(file, 4, offset + absOff + 16).unpack("H*").join
			mouth0	= IO.binread(file, 4, offset + absOff + 20).unpack("V*").join.to_i
			mouth1	= IO.binread(file, 4, offset + absOff + 24).unpack("V*").join.to_i
			zero1	= IO.binread(file, 4, offset + absOff + 28).unpack("H*").join
			if zero0 != "00000000" || zero1 != "00000000"
				puts 7.chr
				gets
			end

# Palette
			print "Palette"
			$data = File.new("#{root}/#{folder.to_s.rjust(3, "0")}/#{hash}/pal.tga", "wb")
			$data.write ["00000200000000000000000010001000"].pack("H*")
			if trueColor
				$data.write ["2020"].pack("H*")
				for byte in 0..0xff
					binary = IO.binread(file, 2, offset + absOff + palette + byte * 2).unpack('B*').join.scan(/(........)(........)/).map(&:reverse).join
					$data.write [ getColor(binary[1..5]).to_s(16) ].pack('H*')
					$data.write [ getColor(binary[6..10]).to_s(16) ].pack('H*')
					$data.write [ getColor(binary[11..16]).to_s(16) ].pack('H*')
					$data.write [ "ff" ].pack('H*')
				end
			else
				$data.write ["1020"].pack("H*")
				for byte in 0..0xff
					$data.write IO.binread(file, 2, offset + absOff + palette + byte * 2)
				end
			end
			$data.close
			paletteFile	= "#{root}/#{folder.to_s.rjust(3, "0")}/#{hash}/pal.tga"

# Bitmap
			print ", Bitmap"
			xOrigin	= IO.binread(file, 1, offset + absOff + bitmap + 0).unpack('H*').join.hex
			yOrigin	= IO.binread(file, 1, offset + absOff + bitmap + 1).unpack('H*').join.hex
			width	= IO.binread(file, 1, offset + absOff + bitmap + 2).unpack('H*').join
			height	= IO.binread(file, 1, offset + absOff + bitmap + 3).unpack('H*').join
			$data = File.new("#{root}/#{folder.to_s.rjust(3, "0")}/#{hash}/face_#{xOrigin}_#{yOrigin}.tga", "wb")
			$data.write ["000002000000000000000000#{width}00#{height}00"].pack("H*")
			if trueColor
				$data.write ["2020"].pack("H*")
				for byte in 0..(width.hex*height.hex-1)
					binary = IO.binread(file, 1, offset + absOff + bitmap + byte + 4).unpack('H*').join.hex
					$data.write IO.binread(paletteFile, 4, 18 + binary * 4)
				end
			else
				$data.write ["1020"].pack("H*")
				for byte in 0..(width.hex*height.hex-1)
					binary = IO.binread(file, 1, offset + absOff + bitmap + byte + 4).unpack('H*').join.hex
					$data.write IO.binread(paletteFile, 2, 18 + binary * 2)
				end
			end
			$data.close

# Eyes0
			if eyes0	!= 0
				print ", Eyes0"
				xOrigin	= IO.binread(file, 1, offset + absOff + eyes0 + 0).unpack('H*').join.hex
				yOrigin	= IO.binread(file, 1, offset + absOff + eyes0 + 1).unpack('H*').join.hex
				width	= IO.binread(file, 1, offset + absOff + eyes0 + 2).unpack('H*').join
				height	= IO.binread(file, 1, offset + absOff + eyes0 + 3).unpack('H*').join
				$data = File.new("#{root}/#{folder.to_s.rjust(3, "0")}/#{hash}/eyes0_#{xOrigin}_#{yOrigin}.tga", "wb")
				$data.write ["000002000000000000000000#{width}00#{height}00"].pack("H*")
				if trueColor
					$data.write ["2020"].pack("H*")
					for byte in 0..(width.hex*height.hex-1)
						binary = IO.binread(file, 1, offset + absOff + eyes0 + byte + 4).unpack('H*').join.hex
						$data.write IO.binread(paletteFile, 4, 18 + binary * 4)
					end
				else
					$data.write ["1020"].pack("H*")
					for byte in 0..(width.hex*height.hex-1)
						binary = IO.binread(file, 1, offset + absOff + eyes0 + byte + 4).unpack('H*').join.hex
						$data.write IO.binread(paletteFile, 2, 18 + binary * 2)
					end
				end
				$data.close
			end

# Eyes1
			if eyes1	!= 0
				print ", Eyes1"
				xOrigin	= IO.binread(file, 1, offset + absOff + eyes1 + 0).unpack('H*').join.hex
				yOrigin	= IO.binread(file, 1, offset + absOff + eyes1 + 1).unpack('H*').join.hex
				width	= IO.binread(file, 1, offset + absOff + eyes1 + 2).unpack('H*').join
				height	= IO.binread(file, 1, offset + absOff + eyes1 + 3).unpack('H*').join
				$data = File.new("#{root}/#{folder.to_s.rjust(3, "0")}/#{hash}/eyes1_#{xOrigin}_#{yOrigin}.tga", "wb")
				$data.write ["000002000000000000000000#{width}00#{height}00"].pack("H*")
				if trueColor
					$data.write ["2020"].pack("H*")
					for byte in 0..(width.hex*height.hex-1)
						binary = IO.binread(file, 1, offset + absOff + eyes1 + byte + 4).unpack('H*').join.hex
						$data.write IO.binread(paletteFile, 4, 18 + binary * 4)
					end
				else
					$data.write ["1020"].pack("H*")
					for byte in 0..(width.hex*height.hex-1)
						binary = IO.binread(file, 1, offset + absOff + eyes1 + byte + 4).unpack('H*').join.hex
						$data.write IO.binread(paletteFile, 2, 18 + binary * 2)
					end
				end
				$data.close
			end

# Mouth0
			if mouth0	!= 0
				print ", Mouth0"
				xOrigin	= IO.binread(file, 1, offset + absOff + mouth0 + 0).unpack('H*').join.hex
				yOrigin	= IO.binread(file, 1, offset + absOff + mouth0 + 1).unpack('H*').join.hex
				width	= IO.binread(file, 1, offset + absOff + mouth0 + 2).unpack('H*').join
				height	= IO.binread(file, 1, offset + absOff + mouth0 + 3).unpack('H*').join
				$data = File.new("#{root}/#{folder.to_s.rjust(3, "0")}/#{hash}/mouth0_#{xOrigin}_#{yOrigin}.tga", "wb")
				$data.write ["000002000000000000000000#{width}00#{height}00"].pack("H*")
				if trueColor
					$data.write ["2020"].pack("H*")
					for byte in 0..(width.hex*height.hex-1)
						binary = IO.binread(file, 1, offset + absOff + mouth0 + byte + 4).unpack('H*').join.hex
						$data.write IO.binread(paletteFile, 4, 18 + binary * 4)
					end
				else
					$data.write ["1020"].pack("H*")
					for byte in 0..(width.hex*height.hex-1)
						binary = IO.binread(file, 1, offset + absOff + mouth0 + byte + 4).unpack('H*').join.hex
						$data.write IO.binread(paletteFile, 2, 18 + binary * 2)
					end
				end
				$data.close
			end

# Mouth1
			if mouth1	!= 0
				print ", Mouth1"
				xOrigin	= IO.binread(file, 1, offset + absOff + mouth1 + 0).unpack('H*').join.hex
				yOrigin	= IO.binread(file, 1, offset + absOff + mouth1 + 1).unpack('H*').join.hex
				width	= IO.binread(file, 1, offset + absOff + mouth1 + 2).unpack('H*').join
				height	= IO.binread(file, 1, offset + absOff + mouth1 + 3).unpack('H*').join
				$data = File.new("#{root}/#{folder.to_s.rjust(3, "0")}/#{hash}/mouth1_#{xOrigin}_#{yOrigin}.tga", "wb")
				$data.write ["000002000000000000000000#{width}00#{height}00"].pack("H*")
				if trueColor
					$data.write ["2020"].pack("H*")
					for byte in 0..(width.hex*height.hex-1)
						binary = IO.binread(file, 1, offset + absOff + mouth1 + byte + 4).unpack('H*').join.hex
						$data.write IO.binread(paletteFile, 4, 18 + binary * 4)
					end
				else
					$data.write ["1020"].pack("H*")
					for byte in 0..(width.hex*height.hex-1)
						binary = IO.binread(file, 1, offset + absOff + mouth1 + byte + 4).unpack('H*').join.hex
						$data.write IO.binread(paletteFile, 2, 18 + binary * 2)
					end
				end
				$data.close
			end
			puts
			
		else # Animation
			puts
			for page in 0..palette-1
				palette	= IO.binread(file, 4, offset + absOff + page * 12 + 4).unpack("V*").join.to_i
				bitmap	= IO.binread(file, 4, offset + absOff + page * 12 + 8).unpack("V*").join.to_i
				unk0	= IO.binread(file, 2, offset + absOff + page * 12 + 12).unpack("H*").join
				unk1	= IO.binread(file, 2, offset + absOff + page * 12 + 14).unpack("H*").join
				print "    Anim: #{page}"

# Palette
				print "      Palette"
				$data = File.new("#{root}/#{folder.to_s.rjust(3, "0")}/#{hash}/pal-#{page.to_s.rjust(2, "0")}.tga", "wb")
				$data.write ["00000200000000000000000010001000"].pack("H*")
				if trueColor
					$data.write ["2020"].pack("H*")
					for byte in 0..0xff
						binary = IO.binread(file, 2, offset + absOff + palette + byte * 2).unpack('B*').join.scan(/(........)(........)/).map(&:reverse).join
							$data.write [ getColor(binary[1..5]).to_s(16) ].pack('H*')
						$data.write [ getColor(binary[6..10]).to_s(16) ].pack('H*')
						$data.write [ getColor(binary[11..16]).to_s(16) ].pack('H*')
						$data.write [ "ff" ].pack('H*')
					end
				else
					$data.write ["1020"].pack("H*")
					for byte in 0..0xff
						$data.write IO.binread(file, 2, offset + absOff + palette + byte * 2)
					end
				end
				$data.close
				paletteFile	= "#{root}/#{folder.to_s.rjust(3, "0")}/#{hash}/pal-#{page.to_s.rjust(2, "0")}.tga"

# Bitmap
				print ", Bitmap"
				xOrigin	= IO.binread(file, 1, offset + absOff + bitmap + 0).unpack('H*').join.hex
				yOrigin	= IO.binread(file, 1, offset + absOff + bitmap + 1).unpack('H*').join.hex
				width	= IO.binread(file, 1, offset + absOff + bitmap + 2).unpack('H*').join
				height	= IO.binread(file, 1, offset + absOff + bitmap + 3).unpack('H*').join
				$data = File.new("#{root}/#{folder.to_s.rjust(3, "0")}/#{hash}/face-#{page.to_s.rjust(2, "0")}_#{xOrigin}_#{yOrigin}.tga", "wb")
				$data.write ["000002000000000000000000#{width}00#{height}00"].pack("H*")
				if trueColor
					$data.write ["2020"].pack("H*")
					for byte in 0..(width.hex*height.hex-1)
						binary = IO.binread(file, 1, offset + absOff + bitmap + byte + 4).unpack('H*').join.hex
						$data.write IO.binread(paletteFile, 4, 18 + binary * 4)
					end
				else
					$data.write ["1020"].pack("H*")
					for byte in 0..(width.hex*height.hex-1)
						binary = IO.binread(file, 1, offset + absOff + bitmap + byte + 4).unpack('H*').join.hex
						$data.write IO.binread(paletteFile, 2, 18 + binary * 2)
					end
				end
				$data.close
				puts " - #{unk0} #{unk1}"
			end
		end
	end
	offset	+= absOff + size
	if offset % 2048 != 0
		offset += 2048 - offset % 2048
	end
end