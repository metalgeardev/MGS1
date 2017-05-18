def getExtn(extension)
	extension_reference = {
  '61' => 'azm', '62' => 'bin', '63' => 'con', '64' => 'dar',
  '65' => 'efx', '67' => 'gcx', '68' => 'hzm', '69' => 'img',
  '6b' => 'kmd', '6c' => 'lit', '6d' => 'mdx', '6f' => 'oar',
  '70' => 'pcc', '72' => 'rar', '73' => 'sgt', '77' => 'wvx',
  '7a' => 'zmd', 'ff' => 'dar'
	}
	if extension_reference.assoc(extension)
		return extension_reference.assoc(extension)[1]
	else
		return extension
	end
end

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

# Requires
require 'fileutils'

# File to load
file = "stage/s03a.stg"
Dir.entries('stage').select{ |e| File.file? e
if e != "." &&  e != ".." 

	file = "stage/#{e}"
	puts e
	# Creating folder to extract
	FileUtils::mkdir_p file.split(".")[0]

	# File Size
	total_size = IO.binread(file, 2, 2).unpack("v*").join.to_i * 2048

	# Reading table
	offset = 4
	row = 0
	text = 0
	start_at = 2048 # First file starts at 2048
	while 0 == 0
		name = IO.binread(file, 3, offset + (row * 8)).unpack("H*").join.scan(/(..)(..)(..)/).map(&:reverse).join
		extn = IO.binread(file, 1, offset + 3 + (row * 8)).unpack("H*").join
		if name == "000000" # End of table
			break
		elsif name[0, 2] == "63" # Files within model pack
			remember = start_at
			# Creating folder to extract
			FileUtils::mkdir_p "#{file.split(".")[0]}/stg_mdl1"
			while 0 == 0
				name = IO.binread(file, 3, offset + (row * 8)).unpack("H*").join.scan(/(..)(..)(..)/).map(&:reverse).join
				extn = IO.binread(file, 1, offset + 3 + (row * 8)).unpack("H*").join
				if name == "630000" # Model pack, no need to save
					start_at = remember
					break
				end
				print "    #{name}.#{getExtn(extn)} unpacked "
				size = IO.binread(file, 4, offset + 12 + (row * 8)).unpack("V*").join.to_i - IO.binread(file, 4, offset + 4 + (row * 8)).unpack("V*").join.to_i
				extract = File.new("#{file.split(".")[0]}/stg_mdl1/#{name}.#{getExtn(extn)}", "wb")
				extract.write IO.binread(file, size, start_at)
				start_at += size
				extract.close
				row += 1
			end
		elsif name == "6e0000" && text == 1 # Texture 2 pack
			puts "  #{name}.#{getExtn(extn)} text_2"
			text = 2
			size = IO.binread(file, 4, offset + 4 + (row * 8)).unpack("V*").join.to_i
			extract = File.new("#{file.split(".")[0]}/stg_tex2.#{getExtn(extn)}", "wb")
			extract.write IO.binread(file, size, start_at)
			extract.close
			undar("#{file.split(".")[0]}/stg_tex2.#{getExtn(extn)}")
		elsif name == "6e0000" && text == 2 # Texture 3 pack
			puts "  #{name}.#{getExtn(extn)} text_3"
			text = 3
			size = IO.binread(file, 4, offset + 4 + (row * 8)).unpack("V*").join.to_i
			extract = File.new("#{file.split(".")[0]}/stg_tex3.#{getExtn(extn)}", "wb")
			extract.write IO.binread(file, size, start_at)
			extract.close
			undar("#{file.split(".")[0]}/stg_tex3.#{getExtn(extn)}")
		elsif name == "6e0000" # Texture 1 pack
			puts "  #{name}.#{getExtn(extn)} text_1"
			text = 1
			size = IO.binread(file, 4, offset + 4 + (row * 8)).unpack("V*").join.to_i
			extract = File.new("#{file.split(".")[0]}/stg_tex1.#{getExtn(extn)}", "wb")
			extract.write IO.binread(file, size, start_at)
			extract.close
			undar("#{file.split(".")[0]}/stg_tex1.#{getExtn(extn)}")
		else # Regular file
			print "  #{name}.#{getExtn(extn)}"
			size = IO.binread(file, 4, offset + 4 + (row * 8)).unpack("V*").join.to_i
			extract = File.new("#{file.split(".")[0]}/#{name}.#{getExtn(extn)}", "wb")
			extract.write IO.binread(file, size, start_at)
			extract.close
		end
		if name == "630000" # Model pack, no need to save
			print "  #{name}.#{getExtn(extn)}"
			size = IO.binread(file, 4, offset + 4 + (row * 8)).unpack("V*").join.to_i
			puts " extracted"
		end
		row += 1

		start_at += size
		if start_at % 2048 != 0
			start_at += 2048 - start_at % 2048
		end
	end
	puts
	puts
end
}
