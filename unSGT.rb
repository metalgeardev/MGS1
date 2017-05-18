file	= "1303.73"

datSize	= IO.binread(file, 2, 0).unpack("v*").join.to_i
unk0	= IO.binread(file, 1, 2).unpack("H*").join.hex
rows	= IO.binread(file, 1, 3).unpack("H*").join.hex
tblOff	= IO.binread(file, 4, 4).unpack("V*").join.to_i
datOff	= IO.binread(file, 4, 8).unpack("V*").join.to_i
unk1Off	= IO.binread(file, 4, 12).unpack("V*").join.to_i
unk2Off	= IO.binread(file, 4, 16).unpack("V*").join.to_i
unk3Off	= IO.binread(file, 4, 20).unpack("V*").join.to_i
$extract = File.new("#{file.split(".")[0]}.htm", "wb")
$extract.write "<!DOCTYPE html>
<html>
  <body style=\"background-color: #fff;\">
    <svg width=\"320\" height=\"224\">\r\n"# style=\"background-image: url('https://d1v8u1ev1s9e4n.cloudfront.net/53fa6d12ddcb212b87b445a5');\">\r\n"
for read in 0..rows-1
	order	= IO.binread(file, 1, tblOff + 4 * read + 0).unpack("H*").join.hex
	colorS	= IO.binread(file, 1, tblOff + 4 * read + 1).unpack("H*").join.hex
	offset	= IO.binread(file, 2, tblOff + 4 * read + 2).unpack("v*").join.to_i
	size	= IO.binread(file, 4, datOff + offset).unpack("V*").join.to_i
	colorR	= IO.binread(file, 1, datOff + offset + 4).unpack("H*").join.hex
	colorG	= IO.binread(file, 1, datOff + offset + 5).unpack("H*").join.hex
	colorB	= IO.binread(file, 1, datOff + offset + 6).unpack("H*").join.hex
	colorA	= IO.binread(file, 1, datOff + offset + 7).unpack("H*").join.hex
	coord0	= IO.binread(file, 2, datOff + offset + 8).unpack("v*").join.to_i
	coord1	= IO.binread(file, 2, datOff + offset + 10).unpack("v*").join.to_i
	if size == 3
		coord2	= IO.binread(file, 2, datOff + offset + 12).unpack("v*").join.to_i
		coord3	= IO.binread(file, 2, datOff + offset + 14).unpack("v*").join.to_i
		$extract.write "      <line x1=\"#{coord0}\" y1=\"#{coord1}\" x2=\"#{coord2}\" y2=\"#{coord3}\" style=\"stroke:rgba(#{colorR},#{colorG},#{colorB},0.2);stroke-width:1\" />"
	elsif size == 5
		coord2	= IO.binread(file, 2, datOff + offset + 12).unpack("v*").join.to_i
		coord3	= IO.binread(file, 2, datOff + offset + 14).unpack("v*").join.to_i
		coord4	= IO.binread(file, 2, datOff + offset + 16).unpack("v*").join.to_i
		coord5	= IO.binread(file, 2, datOff + offset + 18).unpack("v*").join.to_i
		coord6	= IO.binread(file, 2, datOff + offset + 20).unpack("v*").join.to_i
		coord7	= IO.binread(file, 2, datOff + offset + 22).unpack("v*").join.to_i
		coords0	= "#{coord0},#{coord1}"
		coords1	= " #{coord2},#{coord3}"
		coords2	= " #{coord4},#{coord5}"
		coords3	= " #{coord6},#{coord7}"
		if coords0 == " 21845,21845"
			coords0	= ""
		end
		if coords1 == " 21845,21845"
			coords1	= ""
		end
		if coords2 == " 21845,21845"
			coords2	= ""
		end
		if coords3 == " 21845,21845"
			coords3	= ""
		end
		$extract.write "      <polyline points=\"#{coords0}#{coords1}#{coords3}#{coords2}\""
		if colorS > 127 && colorS < 192
			$extract.write " style=\"fill:rgba(#{255-colorR},#{255-colorG},#{255-colorB},1);stroke-width:0;\" />"
		elsif colorS > 63 && colorS < 127
			$extract.write " style=\"fill:rgba(#{colorR},#{colorG},#{colorB},0.2);stroke-width:0;\" />"
		elsif colorA == 72
			$extract.write " style=\"fill:none;stroke:rgba(#{colorR},#{colorG},#{colorB},0.2);stroke-width:1;\" />"
		elsif colorA == 74
			$extract.write " style=\"fill:none;stroke:rgba(#{colorR},#{colorG},#{colorB},0.2);stroke-width:1;\" />"
		elsif colorA == 40
			$extract.write " style=\"fill:rgba(#{colorR},#{colorG},#{colorB},1);stroke-width:1;\" />"
		else
			$extract.write " style=\"fill:rgba(#{colorR},#{colorG},#{colorB},0.2);stroke-width:1;\" />"
		end
	elsif size == 6
		coord2	= IO.binread(file, 2, datOff + offset + 12).unpack("v*").join.to_i
		coord3	= IO.binread(file, 2, datOff + offset + 14).unpack("v*").join.to_i
		coord4	= IO.binread(file, 2, datOff + offset + 16).unpack("v*").join.to_i
		coord5	= IO.binread(file, 2, datOff + offset + 18).unpack("v*").join.to_i
		coord6	= IO.binread(file, 2, datOff + offset + 20).unpack("v*").join.to_i
		coord7	= IO.binread(file, 2, datOff + offset + 22).unpack("v*").join.to_i
		$extract.write "      <polyline points=\"#{coord0},#{coord1} #{coord2},#{coord3} #{coord4},#{coord5} #{coord6},#{coord7}\" style=\"fill:none;stroke:rgba(#{colorR},#{colorG},#{colorB},0.2);stroke-width:1;\" />"
	elsif size == 8
		colorRa	= IO.binread(file, 1, datOff + offset + 4).unpack("H*").join.hex
		colorGa	= IO.binread(file, 1, datOff + offset + 5).unpack("H*").join.hex
		colorBa	= IO.binread(file, 1, datOff + offset + 6).unpack("H*").join.hex
		colorAa	= IO.binread(file, 1, datOff + offset + 7).unpack("H*").join.hex
		coord0	= IO.binread(file, 2, datOff + offset + 8).unpack("v*").join.to_i
		coord1	= IO.binread(file, 2, datOff + offset + 10).unpack("v*").join.to_i
		colorRb	= IO.binread(file, 1, datOff + offset + 12).unpack("H*").join.hex
		colorGb	= IO.binread(file, 1, datOff + offset + 13).unpack("H*").join.hex
		colorBb	= IO.binread(file, 1, datOff + offset + 14).unpack("H*").join.hex
		colorAb	= IO.binread(file, 1, datOff + offset + 15).unpack("H*").join.hex
		coord2	= IO.binread(file, 2, datOff + offset + 16).unpack("v*").join.to_i
		coord3	= IO.binread(file, 2, datOff + offset + 18).unpack("v*").join.to_i
		colorRc	= IO.binread(file, 1, datOff + offset + 20).unpack("H*").join.hex
		colorGc	= IO.binread(file, 1, datOff + offset + 21).unpack("H*").join.hex
		colorBc	= IO.binread(file, 1, datOff + offset + 22).unpack("H*").join.hex
		colorAc	= IO.binread(file, 1, datOff + offset + 23).unpack("H*").join.hex
		coord4	= IO.binread(file, 2, datOff + offset + 24).unpack("v*").join.to_i
		coord5	= IO.binread(file, 2, datOff + offset + 26).unpack("v*").join.to_i
		colorRd	= IO.binread(file, 1, datOff + offset + 28).unpack("H*").join.hex
		colorGd	= IO.binread(file, 1, datOff + offset + 29).unpack("H*").join.hex
		colorBd	= IO.binread(file, 1, datOff + offset + 30).unpack("H*").join.hex
		colorAd	= IO.binread(file, 1, datOff + offset + 31).unpack("H*").join.hex
		coord6	= IO.binread(file, 2, datOff + offset + 32).unpack("v*").join.to_i
		coord7	= IO.binread(file, 2, datOff + offset + 34).unpack("v*").join.to_i
		colorA= "#{colorAa}-#{colorAb}-#{colorAc}-#{colorAd}"
		$extract.write "      <defs>
        <linearGradient id=\"grad#{read}\" x1=\"0%\" y1=\"0%\" x2=\"0%\" y2=\"100%\">
          <stop offset=\"0%\" style=\"stop-color:rgb(255,255,255);stop-opacity:1\" />
          <stop offset=\"100%\" style=\"stop-color:rgb(0,0,0);stop-opacity:1\" />
        </linearGradient>
      </defs>
      <polygon points=\"#{coord0},#{coord1} #{coord4},#{coord5} #{coord6},#{coord7} #{coord2},#{coord3}\" style=\"fill:url(#grad#{read});\" />"
	elsif size == 255
		text	= IO.binread(file, 16, datOff + offset + 12).delete("\000")
		$extract.write "      <text fill=\"rgba(#{colorR},#{colorG},#{colorB},0.9)\" font-size=\"10\" font-family=\"MS gothic\" x=\"#{coord0}\""
		if colorS == 1
			$extract.write " y=\"#{coord1+4}\">#{text}</text>"
		else
			$extract.write " y=\"#{coord1}\">#{text}</text>"
		end
	else
		puts size
	end
	$extract.write "      <!-- #{size}|#{colorA}|#{colorS} -->\r\n"
end

$extract.write "Sorry, your browser does not support inline SVG.
    </svg><br>\r\n"
$extract.write "rows: #{rows}<br>"
$extract.write "unk: #{unk0}<br>"
$extract.write "#{IO.binread(file, unk2Off - unk1Off, unk1Off).unpack("H*").join.scan(/(........)/).join(" ")}<br><br>\r\n"
$extract.write "#{IO.binread(file, unk3Off - unk2Off, unk2Off).unpack("H*").join.scan(/(........)/).join(" ")}<br><br>\r\n"
$extract.write "#{IO.binread(file, File.size(file) - unk3Off, unk3Off).unpack("H*").join.scan(/(........)/).join(" ")}<br>\r\n"
$extract.write "  </body>
</html>"
$extract.close
