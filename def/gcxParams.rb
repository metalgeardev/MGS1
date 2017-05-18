def gcxParams(hash, param)
	if hash == "0d86" && param == "e"
		$data.write "else"
	elsif hash == "0d86" && param == "i"
		$data.write "elsif"
	elsif hash == "24e1" && param == "c"
		$data.write "codec"
	elsif hash == "430d" && param == "t"
		$data.write "time"
	elsif hash == "9906" && param == "m"
		$data.write "model"
	elsif hash == "9906" && param == "o"
		$data.write "oar"
	elsif hash == "9906" && param == "p"
		$data.write "position"
	elsif hash == "9906" && param == "l"
		$data.write "left"
	elsif hash == "9906" && param == "r"
		$data.write "right"
	else
		$data.write param
	end
end