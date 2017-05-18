def gcx40(bytes, space)
	if bytes.length > 0
		$data.write space
#		$data.write bytes[0].unpack("H*").join
#		$data.write "<SCRIPT size=\""
#		$data.write bytes[1..2].unpack("H*").join
#		$data.write "\">\r\n"
		$data.write "<SCRIPT>\r\n\r\n"
		space	+= "  "
		bytes	= bytes[3..-1]
		while bytes.length != 0
			if bytes[0].unpack("H*").join == "00" && bytes.length == 1
				break
			elsif bytes[0].unpack("H*").join == "60"
				size	= bytes[1..2].unpack("H*").join.hex
				gcx60(bytes[0..size], space)
			elsif bytes[0].unpack("H*").join == "70"
				size	= bytes[1].unpack("H*").join.hex
				gcx70(bytes[0..size], space)
			else
				size	= bytes.length - 1
				$data.write space
				$data.write "*"
				$data.write bytes[0..size].unpack("H*").join
				$data.write "\r\n"
			end
			bytes	= bytes[size+1..-1]
		end
		space	= space[2..-1]
		$data.write space
		$data.write "</SCRIPT>"
	end
end