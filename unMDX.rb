def snap0(data)
	if data < 26
		return (5 * data + 0x80).to_s(16)
	elsif data < 52
		return (5 * data + 0x8100).to_s(16)
	elsif data < 76
		return (5 * data + 0x8180).to_s(16)
	elsif data < 102
		return (5 * data + 0x8200).to_s(16)
	elsif data < 127
		return (5 * data + 0x8280).to_s(16)
	elsif data < 153
		return (5 * data + 0x8300).to_s(16)
	elsif data < 179
		return (5 * data + 0x8380).to_s(16)
	elsif data < 205
		return	(5 * data + 0x8400).to_s(16)
	elsif data < 283
		return	(5 * data + 0x8480).to_s(16)
	else
		p "#{data} "
		exit
	end
end

# Showing info
print "unMDX v0.5

Convert mdx to midi
Write the path and filename and hit enter.

mdx file: "

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

chunks	= IO.binread(file, 4, 0).unpack("l").join.to_i
trash	= "#{file.split(".")[0]}.tbg"

$log = File.new("#{file.split(".")[0]}.txt", "wb")
for loop in 1..chunks
	print "song #{loop}:"
	$log.write "SONG #{loop}\r\n"
	$mid = File.new("#{file.split(".")[0]}_#{loop}.mid", "wb")

# Header
	$mid.write "MThd"
	$mid.write ["00000006"].pack("H*")	# Header Size
	$mid.write ["0001"].pack("H*")		# Format
	$mid.write ["0018"].pack("H*")		# Number of tracks
	$mid.write ["3c00"].pack("H*")		# Division

# 1st track
	$mid.write "MTrk"
	$mid.write ["0000004000"].pack("H*")
	$mid.write ["FF030b"].pack("H*")			# Sequence / Track name
	$mid.write "SecaProject\0"
	$mid.write ["FF0412"].pack("H*")			# Instrument name
	$mid.write "Hackers_Of_Liberty\0"
	$mid.write ["FF21010000"].pack("H*")		# MIDI port
#	$mid.write ["FF51030CB73500"].pack("H*")	# Tempo
	$mid.write ["FF5103#{(60000000 / 120).to_s(16).rjust(6, "0")}00"].pack("H*")	# Tempo
	$mid.write ["FF580404021808"].pack("H*")	# Time signature
	$mid.write ["80808000"].pack("H*")
	$mid.write ["FF2F00"].pack("H*")			# End of track
	offset	= IO.binread(file, 4, loop * 4).unpack("l").join.to_i
	for row in 0..23
		notes	= []
		$log.write "	TRACK #{row}\r\n"
		start	= IO.binread(file, 4, row * 4 + offset).unpack("l").join.to_i
		bytes	= IO.binread(file, 4, start).unpack("H*").join.hex
		jump	= 0
		repeat	= 0
		loopPos	= 0
		while bytes != 65279
			type	= IO.binread(file, 1, start + jump + 3).unpack("H*").join
			if type == "e0"
				$log.write "		???????         -         -         -         : #{IO.binread(file, 4, start + jump + 0).unpack("H*").join}\r\n"
			elsif type == "e4"
				$log.write "		???????         -         -         -         : #{IO.binread(file, 4, start + jump + 0).unpack("H*").join}\r\n"
			elsif type == "e7" # Loop x3
				$log.write "		CueIni          -         -         -         : #{IO.binread(file, 4, start + jump + 0).unpack("H*").join}\r\n"
				cueIni	= notes.count
			elsif type == "e8" # Loop x3
				$log.write "		CueEnd  Rep x#{IO.binread(file, 1, start + jump + 2).unpack("H*").join} -         -         -         : #{IO.binread(file, 4, start + jump + 0).unpack("H*").join}\r\n"
				cueRep	= IO.binread(file, 1, start + jump + 2).unpack("H*").join.hex
				cueNote	= notes[cueIni - notes.count..-1]
				for repeating in 2..cueRep
					notes.push(cueNote)
				end
			elsif type == "ea"
				$log.write "		???????         -         -         -         : #{IO.binread(file, 4, start + jump + 0).unpack("H*").join}\r\n"
			elsif type == "eb"
				$log.write "		Loop L          -         -         -         : #{IO.binread(file, 4, start + jump + 0).unpack("H*").join}\r\n"
			elsif type == "ec"
				$log.write "		Loop R          -         -         -         : #{IO.binread(file, 4, start + jump + 0).unpack("H*").join}\r\n"
				if loopPos == 2
					notes.push(cueNote)
					loopPos	= 0
				end
			elsif type == "ed"
				$log.write "		Ini x2          -         -         -         : #{IO.binread(file, 4, start + jump + 0).unpack("H*").join}\r\n"
#				loopIni	= jump
				loopIni	= notes.count
			elsif type == "ee"
				$log.write "		End x2          -         -         -         : #{IO.binread(file, 4, start + jump + 0).unpack("H*").join}\r\n"
				loopPos	+= 1
				if loopPos == 1
					loopEnd	= notes.count
					cueNote	= notes[loopIni..loopEnd]
				elsif loopPos == 2
					notes.push(cueNote)
					loopPos	= 0
				end
			elsif type == "d0" #
				$log.write "		Tempo   val. #{IO.binread(file, 1, start + jump + 2).unpack("H*").join} -         -         -         : #{IO.binread(file, 4, start + jump + 0).unpack("H*").join}\r\n"
				tempo	= IO.binread(file, 1, start + jump + 2).unpack("H*").join.hex
			elsif type == "d2" #
				$log.write "		Bank    bank #{IO.binread(file, 1, start + jump + 2).unpack("H*").join} -         -         -         : #{IO.binread(file, 4, start + jump + 0).unpack("H*").join}\r\n"
			elsif type == "d5" #
				$log.write "		Master  vol. #{IO.binread(file, 1, start + jump + 2).unpack("H*").join} -         -         -         : #{IO.binread(file, 4, start + jump + 0).unpack("H*").join}\r\n"
			elsif type == "d6"
				$log.write "		???????         -         -         -         : #{IO.binread(file, 4, start + jump + 0).unpack("H*").join}\r\n"
			elsif type == "d7"
				$log.write "		Volume  vol. #{IO.binread(file, 1, start + jump + 2).unpack("H*").join} -         -         -         : #{IO.binread(file, 4, start + jump + 0).unpack("H*").join}\r\n"
			elsif type == "d8"
				$log.write "		???????         -         -         -         : #{IO.binread(file, 4, start + jump + 0).unpack("H*").join}\r\n"
			elsif type == "d9"
				$log.write "		???????         -         -         -         : #{IO.binread(file, 4, start + jump + 0).unpack("H*").join}\r\n"
			elsif type == "dd"
				$log.write "		Pan0            -         -         -         : #{IO.binread(file, 4, start + jump + 0).unpack("H*").join}\r\n"
			elsif type == "de"
				$log.write "		Pan1            -         -         -         : #{IO.binread(file, 4, start + jump + 0).unpack("H*").join}\r\n"
			elsif type == "df"
				$log.write "		???????         -         -         -         : #{IO.binread(file, 4, start + jump + 0).unpack("H*").join}\r\n"
			elsif type == "f2"
				$log.write "		Silence dura #{IO.binread(file, 1, start + jump + 2).unpack("H*").join} -         -         -         : #{IO.binread(file, 4, start + jump + 0).unpack("H*").join}\r\n"
				realSnap= IO.binread(file, 1, start + jump + 2).unpack("H*").join.hex
				write	= snap0(realSnap)
				notes.push("800000#{write}00")
			elsif type == "f3"
				$log.write "		???????         -         -         -         : #{IO.binread(file, 4, start + jump + 0).unpack("H*").join}\r\n"
			elsif type == "f6"
				$log.write "		???????         -         -         -         : #{IO.binread(file, 4, start + jump + 0).unpack("H*").join}\r\n"
			elsif type == "ff"
				$log.write "		END             -         -         -         : #{IO.binread(file, 4, start + jump + 0).unpack("H*").join}\r\n"
			else
				note	= IO.binread(file, 1, start + jump + 3).unpack("H*").join.hex
				if note < 97 && note > 0
					vel		= IO.binread(file, 1, start + jump + 0).unpack("H*").join
					len		= IO.binread(file, 1, start + jump + 1).unpack("H*").join
					snap	= IO.binread(file, 1, start + jump + 2).unpack("H*").join
					realNote	= note
					realNote0	= 0
					while 0 == 0
						if realNote < 12
							break
						else
							realNote0	+= 1
							realNote	+= -12
						end
					end
					if realNote0 == 0
						$log.write "c-2 "
					elsif realNote0 == 1
						$log.write "c-1 "
					elsif realNote0 == 2
						$log.write "c0  "
					elsif realNote0 == 3
						$log.write "c1  "
					elsif realNote0 == 4
						$log.write "c2  "
					elsif realNote0 == 5
						$log.write "c3  "
					elsif realNote0 == 6
						$log.write "c4  "
					elsif realNote0 == 7
						$log.write "c5  "
					elsif realNote0 == 8
						$log.write "c6  "
					else
						$log.write "#{realNote0} "
					end
					if realNote == 0
						$log.write "Do  "
					elsif realNote == 1
						$log.write "Do# "
					elsif realNote == 2
						$log.write "Re  "
					elsif realNote == 3
						$log.write "Re# "
					elsif realNote == 4
						$log.write "Mi  "
					elsif realNote == 5
						$log.write "Fa  "
					elsif realNote == 6
						$log.write "Fa# "
					elsif realNote == 7
						$log.write "Sol "
					elsif realNote == 8
						$log.write "Sol#"
					elsif realNote == 9
						$log.write "La  "
					elsif realNote == 10
						$log.write "La# "
					elsif realNote == 11
						$log.write "Si  "
					else
						puts realNote
					end
					notes.push("80000000")
					realSnap	= snap.hex
					$log.write " #{realSnap}"
					write	= snap0(realSnap)
					puts len if len.hex > 100
					$log.write "	Note    velo #{vel} - Leng #{len} - snap #{snap} - Note #{note.to_s(16)}\r\n"
					notes.push("90#{(note).to_s(16)}#{vel}#{write}0080#{(note).to_s(16)}0000")
				else
					$log.write "		***#{IO.binread(file, 4, start + jump + 0).unpack("H*").join}\r\n"
				end
			end
			bytes	= IO.binread(file, 4, start + jump).unpack("H*").join.hex
			jump	+= 4
		end

		trackName	= "MGS #{row.to_s.rjust(2, "0")}"
		instrName	= "MGS #{row.to_s.rjust(2, "0")}"

		$mid.write "MTrk"
		$mid.write [(notes.join.length/2 + trackName.length + 1 + instrName.length + 1 + 15).to_s(16).rjust(8, "0")].pack("H*") # CHUNK SIZE
		$mid.write ["00"].pack("H*")

# Sequence / Track Name
		$mid.write ["ff03#{trackName.length.to_s(16).rjust(2, "0")}"].pack("H*")
		$mid.write trackName
		$mid.write ["00"].pack("H*")

# Instrument Name
		$mid.write ["ff04#{instrName.length.to_s(16).rjust(2, "0")}"].pack("H*")
		$mid.write instrName
		$mid.write ["00"].pack("H*")

# Assign port 
		$mid.write ["ff2101"].pack("H*")
		$mid.write [(row + 1).to_s(16).rjust(2, "0")].pack("H*")
		$mid.write ["00"].pack("H*")

# Notas
		$mid.write [notes.join].pack("H*")

# End of track
		$mid.write ["FF2F00"].pack("H*")
	end
	$mid.close
	puts " done"
end
$log.close