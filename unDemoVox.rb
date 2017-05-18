require 'fileutils'
file	= "vox.dat"
offset	= 0
bankNum	= 0
audio	= false
caps	= false
demo	= false
puts "Bank #{bankNum}"
FileUtils::mkdir_p "#{file.split(".")[0]}/#{bankNum}"
while 0 == 0
	code	= IO.binread(file, 1, offset).unpack("H*").join.hex
	size	= IO.binread(file, 2, offset + 1).unpack("v*").join.to_i
	if code == 1 # Audio
		$vag.write IO.binread(file, size, offset)
		offset	+= size
	elsif code == 2 # Audio header
		$vag.write IO.binread(file, size, offset)
		sample	= IO.binread(file, 1, offset + 10).unpack("H*").join.hex
		chanels	= IO.binread(file, 1, offset + 12).unpack("H*").join.hex
		print "Audio: "
		if sample == 8
			print "2208"
		elsif sample == 12
			print "3200"
		elsif sample == 16
			print "4410"
		end
		print "0Hz/"
		if chanels == 1
			puts "Mono"
		elsif chanels == 2
			puts "Stero"
		end
		offset	+= size
	elsif code == 3 # Captions
#		$caps.write IO.binread(file, size, offset)
		allSize	= IO.binread(file, 2, offset + 1).unpack("v*").join.to_i
		unk00	= IO.binread(file, 4, offset + 4).unpack("V*").join.to_i
		unk01	= IO.binread(file, 4, offset + 8).unpack("V*").join.to_i
		data1	= IO.binread(file, 2, offset + 12).unpack("v*").join.to_i
		data2	= IO.binread(file, 2, offset + 14).unpack("v*").join.to_i
		unk04	= IO.binread(file, 4, offset + 16).unpack("V*").join.to_i
		unk05	= IO.binread(file, 4, offset + 20).unpack("V*").join.to_i
		$lips1.write IO.binread(file, data2-data1, offset + data1 + 4)
		$lips1.write "\r\n******************\r\n"
		readLips = 0
		goDown = true
		while 0 == 0
			byteLips	= IO.binread(file, 1, offset + data1 + 4 + readLips).unpack('B*').join
			if byteLips == "00000000"
				break
			elsif byteLips[0..3] == "0001"
				$lips1.write "sleep: #{IO.binread(file, 1, offset + data1 + 4 + readLips + 1).unpack('H*').join.hex}ms\r\n"
				readLips	+= 2
			elsif byteLips[0..3] == "0010"
				$lips1.write "chara_#{["0000"+"#{byteLips[4..7]}"].pack("B*").unpack("H*").join.hex}: "
				chara	= IO.binread(file, 2, offset + data1 + 4 + readLips + 1).unpack('H*').join
				if chara == "21ca"
					$lips1.write "Snake\r\n"
				elsif chara == "6588"
					$lips1.write "Campbell\r\n"
				elsif chara == "9475"
					$lips1.write "Naomi\r\n"
				elsif chara == "95f2"
					$lips1.write "Meryl\r\n"
				elsif chara == "d78a"
					$lips1.write "Mei Ling\r\n"
				else
					$lips1.write "#{chara}\r\n"
				end
				readLips	+= 3
			elsif byteLips[0..3] == "0100"
				$lips1.write "\r\ntrack_#{["0000"+"#{byteLips[4..7]}"].pack("B*").unpack("H*").join.hex}\r\n"
				readLips	+= 1
			elsif byteLips[0..3] == "1000"
				$lips1.write "  #{byteLips[0..7]}\r\n"
				readLips	+= 1
			elsif byteLips[0..3] == "1001"
				$lips1.write "  O #{["0000"+"#{byteLips[4..7]}"].pack("B*").unpack("H*").join.hex}ms\r\n"
				readLips	+= 1
			elsif byteLips[0..3] == "1010"
				$lips1.write "  o #{["0000"+"#{byteLips[4..7]}"].pack("B*").unpack("H*").join.hex}ms\r\n"
				readLips	+= 1
			elsif byteLips[0..3] == "1011"
				$lips1.write "  - #{["0000"+"#{byteLips[4..7]}"].pack("B*").unpack("H*").join.hex}ms\r\n"
				readLips	+= 1
			elsif byteLips[0..3] == "1100"
				$lips1.write "  -.- #{["0000"+"#{byteLips[4..7]}"].pack("B*").unpack("H*").join.hex}ms\r\n"
				readLips	+= 1
			else
				$lips1.write "#{byteLips}\r\n"
				readLips	+= 1
			end
		end
		$lips1.write "\r\n******************\r\n"
		jump	= data2+4
		while jump < allSize
			dataSize	= IO.binread(file, 4, offset + jump).unpack("V*").join.to_i
			if dataSize == 0
				dataSize	= allSize-jump
			end
			showAtTime	= IO.binread(file, 4, offset + jump + 4).unpack("V*").join.to_i
			duration	= IO.binread(file, 4, offset + jump + 8).unpack("V*").join.to_i
			unk06		= IO.binread(file, 4, offset + jump + 12).unpack("V*").join.to_i
			$lang1.write "@ #{Time.at(showAtTime/23.8).utc.strftime("%M:%S")} Dur: #{duration/23.8}\r\n"
			$lang1.write "@ #{showAtTime} Dur: #{duration}\r\n"
#			$lang1.write IO.binread(file, dataSize - 16, offset + jump + 16).gsub("", "#{0x61}").gsub("", 'é').gsub("", 'í').gsub('', 'ó').gsub("A", '¿')
			text		= IO.binread(file, dataSize - 16, offset + jump + 16).unpack("H*").join.scan(/(..)/).flatten!
			text.each_index.select{|i|
				if text[i] == "1f"
					text.delete_at(i)
					if text[i] == "08"
						text[i] = "e1"
					elsif text[i] == "0f"
						text[i] = "e9"
					elsif text[i] == "13"
						text[i] = "ed"
					elsif text[i] == "18"
						text[i] = "f3"
					elsif text[i] == "1d"
						text[i] = "fa"
					elsif text[i] == "17"
						text[i] = "f1"
					elsif text[i] == "41"
						text[i] = "bf"
					elsif text[i] == "42"
						text[i] = "a1"
					end
				elsif text[i] == "80"
					if text[i+1] == "23"
						text[i] = "0d"
						text[i+1] = "0a"
					elsif text[i+1] == "4e"
						text[i] = "0d"
						text[i+1] = "0a"
					elsif text[i+1] == "7c"
						text[i] = "0d"
						text[i+1] = "0a"
					end
				end
			}
			$lang1.write [text.join].pack("H*")
			$lang1.write "\r\n\r\n"
			jump		+= dataSize
		end
		offset	+= size
	elsif code == 4 # data_1 Caps header
#		$caps.write IO.binread(file, size, offset)
		$logan	= File.new("#{file.split(".")[0]}/#{bankNum}/tbg4.txt", "ab")
		$logan.write IO.binread(file, size, offset)
		$logan.close
		puts IO.binread(file, 4, offset + 4).unpack("H*").join
		offset	+= size
	elsif code == 5 # Demo
		$demo.write IO.binread(file, size, offset)
		offset	+= size
	elsif code == 6 # data_1 JP Caps header
		allSize	= IO.binread(file, 2, offset + 1).unpack("v*").join.to_i
		unk00	= IO.binread(file, 4, offset + 4).unpack("V*").join.to_i
		unk01	= IO.binread(file, 4, offset + 8).unpack("V*").join.to_i
		data1	= IO.binread(file, 2, offset + 12).unpack("v*").join.to_i
		data2	= IO.binread(file, 2, offset + 14).unpack("v*").join.to_i
		unk04	= IO.binread(file, 4, offset + 16).unpack("V*").join.to_i
		unk05	= IO.binread(file, 4, offset + 20).unpack("V*").join.to_i
		$lips2.write IO.binread(file, data2-data1, offset + data1 + 4)
		$lips2.write "\r\n******************\r\n"
		readLips = 0
		goDown = true
		while 0 == 0
			byteLips	= IO.binread(file, 1, offset + data1 + 4 + readLips).unpack('B*').join
			if byteLips == "00000000"
				break
			elsif byteLips[0..3] == "0001"
				$lips2.write "sleep: #{IO.binread(file, 1, offset + data1 + 4 + readLips + 1).unpack('H*').join.hex}ms\r\n"
				readLips	+= 2
			elsif byteLips[0..3] == "0010"
				$lips2.write "chara_#{["0000"+"#{byteLips[4..7]}"].pack("B*").unpack("H*").join.hex}: "
				chara	= IO.binread(file, 2, offset + data1 + 4 + readLips + 1).unpack('H*').join
				if chara == "21ca"
					$lips2.write "Snake\r\n"
				elsif chara == "6588"
					$lips2.write "Campbell\r\n"
				elsif chara == "9475"
					$lips2.write "Naomi\r\n"
				elsif chara == "95f2"
					$lips2.write "Meryl\r\n"
				elsif chara == "d78a"
					$lips2.write "Mei Ling\r\n"
				else
					$lips2.write "#{chara}\r\n"
				end
				readLips	+= 3
			elsif byteLips[0..3] == "0100"
				$lips2.write "\r\ntrack_#{["0000"+"#{byteLips[4..7]}"].pack("B*").unpack("H*").join.hex}\r\n"
				readLips	+= 1
			elsif byteLips[0..3] == "1000"
				$lips2.write "  #{byteLips[0..7]}\r\n"
				readLips	+= 1
			elsif byteLips[0..3] == "1001"
				$lips2.write "  O #{["0000"+"#{byteLips[4..7]}"].pack("B*").unpack("H*").join.hex}ms\r\n"
				readLips	+= 1
			elsif byteLips[0..3] == "1010"
				$lips2.write "  o #{["0000"+"#{byteLips[4..7]}"].pack("B*").unpack("H*").join.hex}ms\r\n"
				readLips	+= 1
			elsif byteLips[0..3] == "1011"
				$lips2.write "  - #{["0000"+"#{byteLips[4..7]}"].pack("B*").unpack("H*").join.hex}ms\r\n"
				readLips	+= 1
			elsif byteLips[0..3] == "1100"
				$lips2.write "  -.- #{["0000"+"#{byteLips[4..7]}"].pack("B*").unpack("H*").join.hex}ms\r\n"
				readLips	+= 1
			else
				$lips2.write "#{byteLips}\r\n"
				readLips	+= 1
			end
		end
		$lips2.write "\r\n******************\r\n"
		jump	= data2+4
		while jump < allSize
			dataSize	= IO.binread(file, 4, offset + jump).unpack("V*").join.to_i
			if dataSize == 0
				dataSize	= allSize-jump
			end
			showAtTime	= IO.binread(file, 4, offset + jump + 4).unpack("V*").join.to_i
			duration	= IO.binread(file, 4, offset + jump + 8).unpack("V*").join.to_i
			unk06		= IO.binread(file, 4, offset + jump + 12).unpack("V*").join.to_i
			$lang2.write "@ #{Time.at(showAtTime/23.8).utc.strftime("%M:%S")} Dur: #{duration/23.8}\r\n"
			$lang2.write "@ #{showAtTime} Dur: #{duration}\r\n"
#			$lang1.write IO.binread(file, dataSize - 16, offset + jump + 16).gsub("", "#{0x61}").gsub("", 'é').gsub("", 'í').gsub('', 'ó').gsub("A", '¿')
			text		= IO.binread(file, dataSize - 16, offset + jump + 16).unpack("H*").join.scan(/(..)/).flatten!
			text.each_index.select{|i|
				if text[i] == "1f"
					text.delete_at(i)
					if text[i] == "08"
						text[i] = "e1"
					elsif text[i] == "0f"
						text[i] = "e9"
					elsif text[i] == "13"
						text[i] = "ed"
					elsif text[i] == "18"
						text[i] = "f3"
					elsif text[i] == "1d"
						text[i] = "fa"
					elsif text[i] == "17"
						text[i] = "f1"
					elsif text[i] == "41"
						text[i] = "bf"
					elsif text[i] == "42"
						text[i] = "a1"
					end
				elsif text[i] == "80"
					if text[i+1] == "23"
						text[i] = "0d"
						text[i+1] = "0a"
					elsif text[i+1] == "4e"
						text[i] = "0d"
						text[i+1] = "0a"
					elsif text[i+1] == "7c"
						text[i] = "0d"
						text[i+1] = "0a"
					end
				end
			}
			$lang2.write [text.join].pack("H*")
			$lang2.write "\r\n\r\n"
			jump		+= dataSize
		end
		offset	+= size
	elsif code == 7
		$logan	= File.new("#{file.split(".")[0]}/#{bankNum}/tbg7.txt", "ab")
		$logan.write IO.binread(file, size, offset)
		$logan.close
		offset	+= size
	elsif code == 16 # Init
		ready	= IO.binread(file, 4, offset + 4).unpack("V*").join.to_i
		if ready == 1
			audio	= true
			$vag	= File.new("#{file.split(".")[0]}/#{bankNum}/#{bankNum}.vag", "wb")
			$vag.write IO.binread(file, size, offset)
		elsif ready == 3
			caps	= true
#			$caps	= File.new("#{file.split(".")[0]}/#{bankNum}/caps.txt", "wb")
			$lang1	= File.new("#{file.split(".")[0]}/#{bankNum}/lang1.txt", "wb")
			$lang2	= File.new("#{file.split(".")[0]}/#{bankNum}/lang2.txt", "wb")
			$lips1	= File.new("#{file.split(".")[0]}/#{bankNum}/lips1.txt", "wb")
			$lips2	= File.new("#{file.split(".")[0]}/#{bankNum}/lips2.txt", "wb")
		elsif ready == 5 && demo == false
			demo	= true
			$demo	= File.new("#{file.split(".")[0]}/#{bankNum}/#{bankNum}.dmo", "wb")
		else
			puts ready
		end
		offset	+= size
	elsif code == 240 # End
		if audio
			audio	= false
			$vag.close
		end
		
		if caps
			caps	= false
#			$caps.close
			$lang1.close
			$lang2.close
			$lips1.close
			$lips2.close
		end
		
		if demo
			demo	= false
			$demo.close
		end
		
		offset	+= size
		if offset % 2048 != 0
			offset += 2048 - offset % 2048
		end
		if offset == File.size(file)
			break
		end
		bankNum	+= 1
		FileUtils::mkdir_p "#{file.split(".")[0]}/#{bankNum}"
		puts "Bank #{bankNum}"
	else
		puts code
	end
end
