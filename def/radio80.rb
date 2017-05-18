def radio80(bytes, space)
	if bytes.length > 0
		type	= 0
		while bytes.length != 0
			if bytes[0].unpack("H*").join == "01"
				size	= bytes[1..2].unpack("H*").join.hex
				$data.write space
#				$data.write bytes[0..2].unpack("H*").join
				$data.write "TEXT"
				$data.write " Chara:"
				dehash(bytes[3..4].unpack("H*").join)
				$data.write " Face:"
				$data.write bytes[5..6].unpack("H*").join
				$data.write " "
				$data.write bytes[7..8].unpack("H*").join
				$data.write "\r\n"
				$data.write space
				$data.write "\""
				$data.write bytes[9..size]
				$data.write "\""
			elsif bytes[0].unpack("H*").join == "02"
#				size	= bytes[1..2].unpack("H*").join.hex
#				$data.write space
#				$data.write bytes[0..size].unpack("H*").join
				size	= 6
				$data.write space
				$data.write bytes[0..2].unpack("H*").join
				$data.write " "
				$data.write bytes[3..4].unpack("H*").join
				$data.write " "
				$data.write bytes[5..6].unpack("H*").join
				$data.write "\r\n"
			elsif bytes[0].unpack("H*").join == "03"
				size	= bytes[1..2].unpack("H*").join.hex
				$data.write space
#				$data.write bytes[0..2].unpack("H*").join
				$data.write "SET"
				$data.write " Chara:"
				dehash(bytes[3..4].unpack("H*").join)
				$data.write " Face:"
				$data.write bytes[5..6].unpack("H*").join
				$data.write " Unk:"
				$data.write bytes[7..8].unpack("H*").join
			elsif bytes[0].unpack("H*").join == "04"
				size	= bytes[1..2].unpack("H*").join.hex
				$data.write space
				$data.write bytes[0..size].unpack("H*").join
			elsif bytes[0].unpack("H*").join == "05"
				size	= bytes[1..2].unpack("H*").join.hex
				$data.write space
				$data.write bytes[0..size].unpack("H*").join
			elsif bytes[0].unpack("H*").join == "06"
				size	= bytes[1..2].unpack("H*").join.hex
				$data.write space
				$data.write bytes[0..size].unpack("H*").join
			elsif bytes[0].unpack("H*").join == "07"
				size	= bytes[1..2].unpack("H*").join.hex
				$data.write space
				$data.write bytes[0..size].unpack("H*").join
			elsif bytes[0].unpack("H*").join == "08"
				size	= bytes[1..2].unpack("H*").join.hex
				$data.write space
				$data.write bytes[0..size].unpack("H*").join
			elsif bytes[0].unpack("H*").join == "10"
				size	= 2
				type	= 1
				$data.write space
				$data.write bytes[0..2].unpack("H*").join
				$data.write "\r\n"
			elsif bytes[0].unpack("H*").join == "30" && type == 0
				size	= bytes[1..2].unpack("H*").join.hex
				$data.write space
				$data.write bytes[0..size].unpack("H*").join
			elsif bytes[0].unpack("H*").join == "30" && type == 1
				type	= 0
				size	= bytes[1].unpack("H*").join.hex
				$data.write space
				$data.write bytes[0..1].unpack("H*").join
				$data.write " "
				$data.write bytes[2..size].unpack("H*").join
				$data.write "\r\n"
			elsif bytes[0].unpack("H*").join == "40"
				size	= bytes[1..2].unpack("H*").join.hex
				$data.write space
				$data.write bytes[0..size].unpack("H*").join
			elsif bytes[0].unpack("H*").join == "80"
				size	= bytes[1..2].unpack("H*").join.hex
				$data.write space
#				$data.write bytes[0..2].unpack("H*").join
				$data.write "Create"
				$data.write "{"
				radio80( bytes[3..size], space+"  ")
				$data.write space
				$data.write "}"
			elsif bytes[0].unpack("H*").join == "00"
				size	= 0
				$data.write "\r\n"
			elsif bytes[0].unpack("H*").join == "11"
				size	= 0
				$data.write "OR"
				$data.write "\r\n"
			elsif bytes[0].unpack("H*").join == "12"
				size	= 0
				type	= 1
				$data.write "AND"
				$data.write "\r\n"
			elsif bytes[0].unpack("H*").join == "ff"
				size	= 0
				$data.write "\r\n"
			else
				size	= bytes.length - 1
				type	= 0
				$data.write "****"
				$data.write bytes[0..size].unpack("H*").join
				$data.write "\r\n"
			end
#$data.write bytes[0..-1].unpack("H*").join
#$data.write "\r\n"
			bytes	= bytes[size+1..-1]
		end
	end
end