def gcx60(bytes, space)
	noSpace	= FALSE
	if bytes.length > 0
		$data.write space
		$data.write "<COMMAND>\r\n"
#$data.write bytes.unpack("H*").join
#$data.write "\r\n"
		space	+= "  "
		bytes	= bytes[3..-1]
		while bytes.empty? == FALSE
# Check command
			hash	= bytes[0..1].unpack("H*").join
			npi		= bytes[2].unpack("H*").join
			$data.write space
#			$data.write "<"
			dehash(hash)
#			$data.write " size='#{npi}'> "
			$data.write " "
			bytes	= bytes[3..-1]
			space	+= "  "
			while 0 == 0
				if bytes.empty? || bytes == "\0"
					space	= space[2..-1]
#					$data.write space
#					$data.write "</#{hash}>"
					$data.write "\r\n"
					bytes.clear
					break
				end
				inst	= bytes[0].unpack("H*").join
				size	= bytes[1].unpack("H*").join.hex
				if inst == "01"
					size	= 2
#					$data.write bytes[0..size].unpack("H*").join
					$data.write bytes[1..size].unpack("H*").join.hex
					$data.write ","
				elsif inst == "02"
					size	= 1
					$data.write bytes[0..size].unpack("H*").join
				elsif inst == "03"
					size	= 1
					$data.write bytes[0..size].unpack("H*").join
				elsif inst == "06"
					size	= 2
#					$data.write bytes[0..size].unpack("H*").join
					$data.write "("
					dehash(bytes[1..size].unpack("H*").join)
					$data.write ")"
				elsif inst == "07"
					size	+= 1
					$data.write "\""
					$data.write bytes[2..size].gsub!("\0", "")
					$data.write "\"\r\n"
				elsif inst == "08"
					size	= 2
					$data.write bytes[0..size].unpack("H*").join
				elsif inst == "11"
					size	= 3
					$data.write bytes[0..size].unpack("H*").join
				elsif inst == "16"
					size	= 3
					$data.write bytes[0..size].unpack("H*").join
				elsif inst == "20"
					size	= 1
					$data.write bytes[0..size].unpack("H*").join
				elsif inst == "30"
					$data.write bytes[0..size].unpack("H*").join
				elsif inst == "40"
					size	= bytes[1..2].unpack("H*").join.hex
					$data.write "\r\n"
					gcx40(bytes[0..size], space)
				elsif inst == "50"
					$data.write "\r\n"
					$data.write space
					size	= 2
					$data.write "-"
					gcxParams(hash, bytes[1])
#					$data.write "/"
#					$data.write bytes[2].unpack("H*").join
					$data.write ":"
				else
					size	= bytes.length-1
					$data.write "***"
					$data.write bytes.unpack("H*").join
				end
				$data.write " "
				bytes	= bytes[size+1..-1]
			end
			extraSp	= FALSE
			space	= space[2..-1]
		end
		$data.write space
		$data.write "</COMMAND>"
		$data.write "\r\n\r\n"
	end
end