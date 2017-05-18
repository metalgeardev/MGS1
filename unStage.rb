require 'fileutils'

# File to load
file = "stage.dir"

# Creating folder to save content
FileUtils::mkdir_p "stage"

# Get filenames chunk
dir_names_size = IO.binread(file, 4, 0).unpack("V*").join.to_i

# Extracting files
for loop in 0..dir_names_size/12-1

 # Get data for extract
 name = IO.binread(file, 8, 4 + (loop * 12)).delete("\000") # Filename
 offset = IO.binread(file, 4, 12 + (loop * 12)).unpack("V*").join.to_i * 2048 # File start at...
 size = IO.binread(file, 2, offset + 2).unpack("v*").join.to_i * 2048 # File size
 puts name # Puts name on screen

 # Saving file
 extract = File.new("stage/#{name}.stg", "wb")
 extract.write IO.binread(file, size, offset)
 extract.close
end