def gcx70(bytes, space)
	if bytes.length > 0
		$data.write space
#		$data.write bytes[0].unpack("H*").join
		$data.write "include { "
		$data.write bytes[1].unpack("H*").join
		$data.write "\r\n"
		space	+= "  "
		bytes	= bytes[2..-1]
		while bytes.length != 0
			if bytes[0].unpack("H*").join == "00" && bytes.length == 1
				break
			else
				size	= 1
				$data.write space
				$data.write bytes[0..size].unpack("H*").join
			end
			$data.write "\r\n"
			bytes	= bytes[size+1..-1]
		end
		space	= space[2..-1]
		$data.write space
		$data.write "}"
		$data.write "\r\n"
	end
end