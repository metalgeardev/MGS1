# coding: utf-8
$CHARACTER_MAP = {
    "8023804e" => "\n".unpack("H*"),
    "1f01" => "Ä".unpack("H*"),
    "1f02" => "Å".unpack("H*"),
    "1f03" => "Ç".unpack("H*"),
    "1f04" => "É".unpack("H*"),
    "1f05" => "Ñ".unpack("H*"),
    "1f06" => "Ö".unpack("H*"),
    "1f07" => "Ü".unpack("H*"),
    "1f08" => "á".unpack("H*"),
    "1f09" => "à".unpack("H*"),
    "1f0a" => "â".unpack("H*"),
    "1f0b" => "ä".unpack("H*"),
    "1f0c" => "ã".unpack("H*"),
    "1f0d" => "å".unpack("H*"),
    "1f0e" => "ç".unpack("H*"),
    "1f0f" => "é".unpack("H*"),
    "1f10" => "è".unpack("H*"),
    "1f11" => "ê".unpack("H*"),
    "1f12" => "ë".unpack("H*"),
    "1f13" => "í".unpack("H*"),
    "1f14" => "ì".unpack("H*"),
    "1f15" => "î".unpack("H*"),
    "1f16" => "ï".unpack("H*"),
    "1f17" => "ñ".unpack("H*"),
    "1f18" => "ó".unpack("H*"),
    "1f19" => "ò".unpack("H*"),
    "1f1a" => "ô".unpack("H*"),
    "1f1b" => "ö".unpack("H*"),
    "1f1c" => "õ".unpack("H*"),
    "1f1d" => "ú".unpack("H*"),
    "1f1e" => "ù".unpack("H*"),
    "1f1f" => "û".unpack("H*"),
    "1f20" => "ü".unpack("H*"),
    "1f21" => "†".unpack("H*"),
    "1f22" => "°".unpack("H*"),
    "1f23" => "¢".unpack("H*"),
    "1f24" => "£".unpack("H*"),
    "1f25" => "§".unpack("H*"),
    "1f26" => "•".unpack("H*"),
    "1f27" => "¶".unpack("H*"),
    "1f28" => "ß".unpack("H*"),
    "1f29" => "®".unpack("H*"),
    "1f2a" => "©".unpack("H*"),
    "1f2b" => "™".unpack("H*"),
    "1f2c" => "´".unpack("H*"),
    "1f2d" => "¨".unpack("H*"),
    "1f2e" => "≠".unpack("H*"),
    "1f2f" => "Æ".unpack("H*"),
    "1f30" => "Ø".unpack("H*"),
    "1f31" => "∞".unpack("H*"),
    "1f32" => "±".unpack("H*"),
    "1f33" => "≤".unpack("H*"),
    "1f34" => "≥".unpack("H*"),
    "1f35" => "¥".unpack("H*"),
    "1f36" => "µ".unpack("H*"),
    "1f37" => "∂".unpack("H*"),
    "1f38" => "∑".unpack("H*"),
    "1f39" => "∏".unpack("H*"),
    "1f3a" => "π".unpack("H*"),
    "1f3b" => "∫".unpack("H*"),
    "1f3c" => "ª".unpack("H*"),
    "1f3d" => "º".unpack("H*"),
    "1f3e" => "Ω".unpack("H*"),
    "1f3f" => "æ".unpack("H*"),
    "1f40" => "ø".unpack("H*"),
    "1f41" => "¿".unpack("H*"),
    "1f42" => "¡".unpack("H*"),
    "1f43" => "¬".unpack("H*"),
    "1f44" => "√".unpack("H*"),
    "1f45" => "ƒ".unpack("H*"),
    "1f46" => "≈".unpack("H*"),
    "1f47" => "∆".unpack("H*"),
    "1f48" => "«".unpack("H*"),
    "1f49" => "»".unpack("H*"),
    "1f4a" => "…".unpack("H*"),
    "1f4b" => "n".unpack("H*"),
    "1f4c" => "À".unpack("H*"),
    "1f4d" => "Ã".unpack("H*"),
    "1f4e" => "Õ".unpack("H*"),
    "1f4f" => "Œ".unpack("H*"),
    "1f50" => "œ".unpack("H*"),
    "1f51" => "–".unpack("H*"),
    "1f52" => "—".unpack("H*"),
    "1f53" => "“".unpack("H*"),
    "1f54" => "”".unpack("H*"),
    "1f55" => "‘".unpack("H*"),
    "1f56" => "’".unpack("H*"),
    "1f57" => "÷".unpack("H*"),
    "1f58" => "◊".unpack("H*"),
    "1f59" => "ÿ".unpack("H*"),
    "1f5a" => "Ÿ".unpack("H*"),
    "1f5b" => "⁄".unpack("H*"),
    "1f5c" => "€".unpack("H*"),
    "1f5d" => "‹".unpack("H*"),
    "1f5e" => "›".unpack("H*"),
    "1f5f" => "ﬁ".unpack("H*"),
    "1f60" => "ﬂ".unpack("H*"),
    "1f61" => "‡".unpack("H*"),
    "1f62" => "·".unpack("H*"),
    "1f63" => "‚".unpack("H*"),
    "1f64" => "„".unpack("H*"),
    "1f65" => "‰".unpack("H*"),
    "1f66" => "Â".unpack("H*"),
    "1f67" => "Ê".unpack("H*"),
    "1f68" => "Á".unpack("H*"),
    "1f69" => "Ë".unpack("H*"),
    "1f6a" => "È".unpack("H*"),
    "1f6b" => "Í".unpack("H*"),
    "1f6c" => "Î".unpack("H*"),
    "1f6d" => "Ï".unpack("H*"),
    "1f6e" => "Ì".unpack("H*"),
    "1f6f" => "Ó".unpack("H*"),
    "1f70" => "Ô".unpack("H*"),
    "1f72" => "Ò".unpack("H*"),
    "1f73" => "Ú".unpack("H*"),
    "1f74" => "Û".unpack("H*"),
    "1f75" => "Ù".unpack("H*"),
    "1f76" => "ı".unpack("H*"),
    "1f77" => "ˆ".unpack("H*"),
    "1f78" => "˜".unpack("H*"),
    "1f79" => "¯".unpack("H*"),
    "1f7a" => "˘".unpack("H*"),
    "1f7b" => "˙".unpack("H*"),
    "1f7c" => "˚".unpack("H*"),
    "1f7d" => "¸".unpack("H*"),
    "1f7e" => "˝".unpack("H*"),

    "8104" => "い".unpack("H*"),
    "8106" => "う".unpack("H*"),
    "8108" => "え".unpack("H*"),
    "810b" => "か".unpack("H*"),
    "810c" => "が".unpack("H*"),
    "810d" => "き".unpack("H*"),
    "810f" => "く".unpack("H*"),
    "8111" => "け".unpack("H*"),
    "8117" => "し".unpack("H*"),
    "811d" => "そ".unpack("H*"),
    "811f" => "た".unpack("H*"),
    "8124" => "つ".unpack("H*"),
    "8126" => "て".unpack("H*"),
    "8127" => "で".unpack("H*"),
    "8128" => "と".unpack("H*"),
    "8129" => "ど".unpack("H*"),
    "812a" => "な".unpack("H*"),
    "812b" => "に".unpack("H*"),
    "812e" => "の".unpack("H*"),
    "812f" => "は".unpack("H*"),
    "813e" => "ま".unpack("H*"),
    "8142" => "も".unpack("H*"),
    "8148" => "よ".unpack("H*"),
    "8149" => "ら".unpack("H*"),
    "814b" => "る".unpack("H*"),
    "814c" => "れ".unpack("H*"),
    "814f" => "わ".unpack("H*"),
    "8152" => "を".unpack("H*"),
    "8153" => "ん".unpack("H*"),
    "8202" => "ア".unpack("H*"),
    "8208" => "エ".unpack("H*"),
    "820c" => "ガ".unpack("H*"),
    "820f" => "ク".unpack("H*"),
    "8215" => "サ".unpack("H*"),
    "8219" => "ス".unpack("H*"),
    "821b" => "セ".unpack("H*"),
    "822d" => "ネ".unpack("H*"),
    "824d" => "ロ".unpack("H*"),
    "8253" => "ン".unpack("H*"),
    "9022" => "眼".unpack("H*"),
    "9034" => "見".unpack("H*"),
    "9035" => "赤".unpack("H*"),
    "9036" => "外".unpack("H*"),
    "9037" => "線".unpack("H*"),
    "903f" => "毒".unpack("H*"),
    "9601" => "気".unpack("H*"),
    "9602" => "仕".unpack("H*"),
    "9603" => "掛".unpack("H*"),
    "9604" => "肉".unpack("H*"),
    "9605" => "壁".unpack("H*"),
    "9606" => "何".unpack("H*"),
    "9607" => "本".unpack("H*"),
    "9608" => "出".unpack("H*"),
    "9609" => "触".unpack("H*"),
    "960a" => "扉".unpack("H*"),
    "960b" => "閉".unpack("H*"),
    "960c" => "吹".unpack("H*"),
    "960d" => "命".unpack("H*"),
    "960e" => "進".unpack("H*"),
    "c123" => "っ".unpack("H*"),
    "c147" => "ょ".unpack("H*"),
    "c223" => "ッ".unpack("H*"),
    "d002" => "、".unpack("H*"),
    "d003" => "。".unpack("H*"),
    "d006" => "ー".unpack("H*"),
}

$line = 0

def parse_text_line(bytes)
  # Go byte by byte, if the byte isn't an ASCII char,
  # try a pair of bytes and check if part of the character map
  bytes_unpckt = bytes.unpack("H*")[0]
  puts bytes_unpckt + "\n"
  res = ''
  while bytes_unpckt.length() > 0
    # Pop the first char
    current_char = bytes_unpckt[0..1]
    bytes_unpckt[0] = ''
    bytes_unpckt[0] = ''
    if current_char > '31' && current_char < '7f' # If printable
      res += first_char
    else
      current_char += bytes_unpckt[0..1]
      bytes_unpckt[0] = ''
      bytes_unpckt[0] = ''
      if $CHARACTER_MAP.has_key? current_char
        res += $CHARACTER_MAP[current_char][0]
        puts current_char + " => " + $CHARACTER_MAP[current_char].pack("H*")
      else
        res += current_char
        puts current_char
      end
    end
  end

  repacked = [res].pack("H*")
  puts repacked + "\n"
  $line += 1
  return repacked
end


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
        $data.write parse_text_line(bytes[9..size])
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
  else
    exit
  end
end
