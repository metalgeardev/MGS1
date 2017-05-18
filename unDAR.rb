# Requires
require 'fileutils'

# Showing info
print "MGS_unDar v1.0

Unpack *.dar files.
Write the path and filename and hit enter.

dar file to unpack: "

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
FileUtils::mkdir_p "#{file.split(".")[0]}"
tex_jump = 0
while 0 == 0 do
	nam_hash = IO.binread(file, 2, tex_jump).unpack("H*").join.scan(/(..)(..)/).map(&:reverse).join
	ext_hash = IO.binread(file, 1, tex_jump + 2).unpack("H*").join
	tex_size = IO.binread(file, 4, tex_jump + 4).unpack("V*").join.to_i
	if ext_hash == "6b"
		ext_hash	= "kmd"
	elsif ext_hash == "6f"
		ext_hash	= "oar"
	elsif ext_hash == "70"
		ext_hash	= "pcx"
	elsif ext_hash == "72"
		ext_hash	= "res"
	end
	extract = File.new("#{file.split(".")[0]}/#{nam_hash}.#{ext_hash}", "wb")
	extract.write IO.binread(file, tex_size, tex_jump + 8)
	extract.close
	tex_jump += tex_size + 8
	if tex_jump >= File.size(file)
		break
	end
end