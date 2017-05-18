def gcxCommand(bytes, space)
	if bytes.length > 0
		$data.write space
		$data.write bytes[0..1].unpack("H*").join
		$data.write "{ "
		$data.write bytes[2].unpack("H*").join
		$data.write "\r\n"
		space	+= "  "
		bytes	= bytes[3..-1]
		while bytes.length != 0
			if bytes[0].unpack("H*").join == "00"
				$data.write space
				$data.write ">"
				$data.write bytes[0..-1].unpack("H*").join
				$data.write "\r\n"
				break
			elsif bytes[0].unpack("H*").join == "30"
				size	= bytes[1].unpack("H*").join.hex
				gcx30(bytes[0..size], space)
				break
			else
				size	= bytes.length - 1
				$data.write space
				$data.write "/"
				$data.write bytes[0..size].unpack("H*").join
				$data.write "\r\n"
			end
			bytes	= bytes[size+1..-1]
		end
		space	= space[2..-1]
		$data.write space
		$data.write "}60"
		$data.write "\r\n"
	end
end