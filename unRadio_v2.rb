# coding: utf-8
system("cls")
require 'digest'
require 'fileutils'

$CHARACTER_MAP = {
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
	"1f4b" => "n".unpack("H*"),#
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
	"1f5b" => "⁄".unpack("H*"),#
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
	"1f71" => "<APPLE LOGO>".unpack("H*"),
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

	"8020" => " ".unpack("H*"),
	"8021" => "!".unpack("H*"),
	"8022" => '"'.unpack("H*"),
	"8023" => "#".unpack("H*"),
	"8024" => "$".unpack("H*"),
	"8025" => "%".unpack("H*"),
	"8026" => "&".unpack("H*"),
	"8027" => "'".unpack("H*"),
	"8028" => "(".unpack("H*"),
	"8029" => ")".unpack("H*"),
	"802a" => "*".unpack("H*"),
	"802b" => "+".unpack("H*"),
	"802c" => ",".unpack("H*"),
	"802d" => "-".unpack("H*"),
	"802e" => ".".unpack("H*"),
	"802f" => "/".unpack("H*"),
	"8030" => "0".unpack("H*"),
	"8031" => "1".unpack("H*"),
	"8032" => "2".unpack("H*"),
	"8033" => "3".unpack("H*"),
	"8034" => "4".unpack("H*"),
	"8035" => "5".unpack("H*"),
	"8036" => "6".unpack("H*"),
	"8037" => "7".unpack("H*"),
	"8038" => "8".unpack("H*"),
	"8039" => "9".unpack("H*"),
	"803a" => ":".unpack("H*"),
	"803b" => ";".unpack("H*"),
	"803c" => "<".unpack("H*"),
	"803d" => "=".unpack("H*"),
	"803e" => ">".unpack("H*"),
	"803f" => "?".unpack("H*"),
	"8040" => "²".unpack("H*"),
	"8041" => "A".unpack("H*"),
	"8042" => "B".unpack("H*"),
	"8043" => "C".unpack("H*"),
	"8044" => "D".unpack("H*"),
	"8045" => "E".unpack("H*"),
	"8046" => "F".unpack("H*"),
	"8047" => "G".unpack("H*"),
	"8048" => "H".unpack("H*"),
	"8049" => "I".unpack("H*"),
	"804a" => "J".unpack("H*"),
	"804b" => "K".unpack("H*"),
	"804c" => "L".unpack("H*"),
	"804d" => "M".unpack("H*"),
	"804e" => "N".unpack("H*"),
	"804f" => "O".unpack("H*"),
	"8050" => "P".unpack("H*"),
	"8051" => "Q".unpack("H*"),
	"8052" => "R".unpack("H*"),
	"8053" => "S".unpack("H*"),
	"8054" => "T".unpack("H*"),
	"8055" => "U".unpack("H*"),
	"8056" => "V".unpack("H*"),
	"8057" => "W".unpack("H*"),
	"8058" => "X".unpack("H*"),
	"8059" => "Y".unpack("H*"),
	"805a" => "Z".unpack("H*"),
	"805b" => "[".unpack("H*"),
	"805c" => "\\".unpack("H*"),
	"805d" => "]".unpack("H*"),
	"805e" => "^".unpack("H*"),
	"805f" => "_".unpack("H*"),
	"8060" => "`".unpack("H*"),
	"8061" => "a".unpack("H*"),
	"8062" => "b".unpack("H*"),
	"8063" => "c".unpack("H*"),
	"8064" => "d".unpack("H*"),
	"8065" => "e".unpack("H*"),
	"8066" => "f".unpack("H*"),
	"8067" => "g".unpack("H*"),
	"8068" => "h".unpack("H*"),
	"8069" => "i".unpack("H*"),
	"806a" => "j".unpack("H*"),
	"806b" => "k".unpack("H*"),
	"806c" => "l".unpack("H*"),
	"806d" => "m".unpack("H*"),
	"806e" => "n".unpack("H*"),
	"806f" => "o".unpack("H*"),
	"8070" => "p".unpack("H*"),
	"8071" => "q".unpack("H*"),
	"8072" => "r".unpack("H*"),
	"8073" => "s".unpack("H*"),
	"8074" => "t".unpack("H*"),
	"8075" => "u".unpack("H*"),
	"8076" => "v".unpack("H*"),
	"8077" => "w".unpack("H*"),
	"8078" => "x".unpack("H*"),
	"8079" => "y".unpack("H*"),
	"807a" => "z".unpack("H*"),
	"807b" => "{".unpack("H*"),
	"807c" => "\r".unpack("H*"),
	"807d" => "}".unpack("H*"),
	"807e" => "¹".unpack("H*"),

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

	"8201" => "ァ".unpack("H*"),
	"8202" => "ア".unpack("H*"),
	"8203" => "ィ".unpack("H*"),
	"8204" => "イ".unpack("H*"),
	"8205" => "ゥ".unpack("H*"),
	"8206" => "ウ".unpack("H*"),
	"8207" => "ェ".unpack("H*"),
	"8208" => "エ".unpack("H*"),
	"8209" => "ォ".unpack("H*"),
	"820a" => "オ".unpack("H*"),
	"820b" => "カ".unpack("H*"),
	"820c" => "ガ".unpack("H*"),
	"820d" => "キ".unpack("H*"),
	"820e" => "ギ".unpack("H*"),
	"820f" => "ク".unpack("H*"),
	"8210" => "グ".unpack("H*"),
	"8211" => "ケ".unpack("H*"),
	"8212" => "ゲ".unpack("H*"),
	"8213" => "コ".unpack("H*"),
	"8214" => "ゴ".unpack("H*"),
	"8215" => "サ".unpack("H*"),
	"8216" => "ザ".unpack("H*"),
	"8217" => "シ".unpack("H*"),
	"8218" => "ジ".unpack("H*"),
	"8219" => "ス".unpack("H*"),
	"821a" => "ズ".unpack("H*"),
	"821b" => "セ".unpack("H*"),
	"821c" => "ゼ".unpack("H*"),
	"821d" => "ソ".unpack("H*"),
	"821e" => "ゾ".unpack("H*"),
	"821f" => "タ".unpack("H*"),
	"8220" => "ダ".unpack("H*"),
	"8221" => "チ".unpack("H*"),
	"8222" => "ヂ".unpack("H*"),
	"8223" => "ッ".unpack("H*"),
	"8224" => "ツ".unpack("H*"),
	"8225" => "ヅ".unpack("H*"),
	"8226" => "テ".unpack("H*"),
	"8227" => "デ".unpack("H*"),
	"8228" => "ト".unpack("H*"),
	"8229" => "ド".unpack("H*"),
	"822a" => "ナ".unpack("H*"),
	"822b" => "ニ".unpack("H*"),
	"822c" => "ヌ".unpack("H*"),
	"822d" => "ネ".unpack("H*"),
	"822e" => "ノ".unpack("H*"),
	"822f" => "ハ".unpack("H*"),
	"8230" => "バ".unpack("H*"),
	"8231" => "パ".unpack("H*"),
	"8232" => "ヒ".unpack("H*"),
	"8233" => "ビ".unpack("H*"),
	"8234" => "ピ".unpack("H*"),
	"8235" => "フ".unpack("H*"),
	"8236" => "ブ".unpack("H*"),
	"8237" => "プ".unpack("H*"),
	"8238" => "ヘ".unpack("H*"),
	"8239" => "ベ".unpack("H*"),
	"823a" => "ペ".unpack("H*"),
	"823b" => "ホ".unpack("H*"),
	"823c" => "ボ".unpack("H*"),
	"823d" => "ポ".unpack("H*"),
	"823e" => "マ".unpack("H*"),
	"823f" => "ミ".unpack("H*"),
	"8240" => "ム".unpack("H*"),
	"8241" => "メ".unpack("H*"),
	"8242" => "モ".unpack("H*"),
	"8243" => "ャ".unpack("H*"),
	"8244" => "ヤ".unpack("H*"),
	"8245" => "ュ".unpack("H*"),
	"8246" => "ユ".unpack("H*"),
	"8247" => "ョ".unpack("H*"),
	"8248" => "ヨ".unpack("H*"),
	"8249" => "ラ".unpack("H*"),
	"824a" => "リ".unpack("H*"),
	"824b" => "ル".unpack("H*"),
	"824c" => "レ".unpack("H*"),
	"824d" => "ロ".unpack("H*"),
	"824e" => "ワ".unpack("H*"),
	"824f" => "ヲ".unpack("H*"),
	"8253" => "ン".unpack("H*"),

	"9022" => "眼".unpack("H*"),
	"9034" => "見".unpack("H*"),
	"9035" => "赤".unpack("H*"),
	"9036" => "外".unpack("H*"),
	"9037" => "線".unpack("H*"),
	"903f" => "毒".unpack("H*"),

	"d8f1a5a8b41006b91b946303e4e11f1b" => "気".unpack("H*"),
	"8f4b4413694065bf59748c041f758fb4" => "仕".unpack("H*"),
	"1f18bbcda5146256489165c93a457e5d" => "掛".unpack("H*"),
	"047d54ae745b76ac2ac216c15b21f0eb" => "肉".unpack("H*"),
	"2e6c6b893224866b5d3c6b93a5c7710d" => "壁".unpack("H*"),
	"33e15123073b6ffc39b9c58cda7fa688" => "何".unpack("H*"),
	"4966d3fca0ee883cada78883083eb9d9" => "本".unpack("H*"),
	"174176e9cb1b9587995648a425518317" => "出".unpack("H*"),
	"a00ab7e373bffbdfe3808418a6ffad6c" => "触".unpack("H*"),
	"843e6271cb0e1b06ecd5474aab97dc05" => "扉".unpack("H*"),
	"0cf00755b700ee5168f9ab0667214a08" => "閉".unpack("H*"),
	"cad1f9a02ec8eb54d491140dfae53cc2" => "吹".unpack("H*"),
	"49cb0a01903cbfaa11b894c748742693" => "命".unpack("H*"),
	"81e463638d7491cb69038013c861292d" => "進".unpack("H*"),

	"c123" => "っ".unpack("H*"),
	"c147" => "ょ".unpack("H*"),
	"c223" => "ッ".unpack("H*"),

	"d002" => "、".unpack("H*"),
	"d003" => "。".unpack("H*"),
	"d006" => "ー".unpack("H*"),
}

def dat2tga(file)
#	print "Convertig #{file}: "
	name	= file.split(".")[0]
	file	= IO.binread(file).unpack("B*")[0]
	width	= file.length / 2
	$data	= File.new("#{name}.tga", "wb")
	$data.write ["0000020000000000000000000c00#{[width / 12].pack("v*").unpack("H*")[0]}2020"].pack("H*")
	for byte in 0..width-1
		bits	= file[byte * 2, 2]
		if bits == "00"
			$data.write ["000000ff"].pack("H*")
		elsif bits == "01"
			$data.write ["555555ff"].pack("H*")
		elsif bits == "10"
			$data.write ["aaaaaaff"].pack("H*")
		else
			$data.write ["ffffffff"].pack("H*")
		end
	end
	$data.close
	FileUtils.rm("#{name}.dat")
#	puts "done"
end

def getText(data, extraChar)
	# Go byte by byte, if the byte isn't an ASCII char,
	# try a pair of bytes and check if part of the character map
	bytes_unpckt = data.unpack("H*")[0]
	res = ''
	while bytes_unpckt.length() > 0
		# Pop the first char
		current_char = bytes_unpckt[0..1]
		bytes_unpckt[0] = ''
		bytes_unpckt[0] = ''
		if current_char != '1f' && current_char < '7f' # If printable
			res += current_char
		elsif current_char == '96' || current_char == '97' || current_char == '98' || current_char == '99' || current_char == '9a' || current_char == '9b'
			current_char += bytes_unpckt[0..1]
			bytes_unpckt[0] = ''
			bytes_unpckt[0] = ''
			if $CHARACTER_MAP.has_key? extraChar[current_char.hex - 38401]
				res += $CHARACTER_MAP[extraChar[current_char.hex - 38401]][0]
			else
				res += current_char
			end
		else
			current_char += bytes_unpckt[0..1]
			bytes_unpckt[0] = ''
			bytes_unpckt[0] = ''
			if $CHARACTER_MAP.has_key? current_char
				res += $CHARACTER_MAP[current_char][0]
			else
				res += current_char
			end
		end
	end

	return [res].pack("H*")
end

def actorName(hash)
	if hash == "21ca"
		hash	= "SOLID SNAKE"
	elsif hash == "33af"
		hash	= "NASTASHA RO"
	elsif hash == "3d2c"
		hash	= "DR EMMERICH"
	elsif hash == "6588"
		hash	= "COL CAMPBEL"
	elsif hash == "6c22"
		hash	= "MAST MILLER"
	elsif hash == "7982"
		hash	= "CIBORG NINJ"
	elsif hash == "7c90"
		hash	= "NOISY IMAGE"
	elsif hash == "9475"
		hash	= "NAOMI HUNTE"
	elsif hash == "95f2"
		hash	= "MERYL SILVE"
	elsif hash == "962c"
		hash	= "SNIPER WOLF"
	elsif hash == "d78a"
		hash	= "MEI LING___"
	elsif hash == "fb95"
		hash	= "JIM HOUSEMA"
	else
		hash	= "#{hash}ojete  "
	end
	return hash
end

def faceImage(hash)
	return hash
end

def dat2txt(data, space, extraChar)
	pos		= 0
	noSet	= false
	len10	= 2
	putsFF	= true
	while pos != data.length
		code	= data[pos].unpack("H*")[0]
		if code == "01"
		# set Subtitle
			length	= data[pos + 1, 2].unpack("H*")[0].hex + 1
			actor	= actorName(data[pos + 3, 2].unpack("H*")[0])
			face	= faceImage(data[pos + 5, 2].unpack("H*")[0])
			unk00	= data[pos + 7, 2].unpack("H*")[0]
			$radio.write "#{space}TEXT #{actor} #{face} #{unk00} #{getText(data[pos + 9, length - 10], extraChar)}"
			pos		+= length
		elsif code == "02"
		# set Voice
			length	= 7
			length1	= data[pos + 1, 2].unpack("H*")[0]
			unk00	= data[pos + 3, 2].unpack("H*")[0]
			unk01	= data[pos + 5, 2].unpack("H*")[0]
			$radio.write "#{space}VOICE #{unk00} #{unk01} "
			pos		+= length
			noSet	= true
		elsif code == "03"
		# set FACE.DAT images
			length	= data[pos + 1, 2].unpack("H*")[0].hex + 1
			actor	= actorName(data[pos + 3, 2].unpack("H*")[0])
			face	= faceImage(data[pos + 5, 2].unpack("H*")[0])
			unk00	= data[pos + 7, 2].unpack("H*")[0]
			$radio.write "#{space}FACE #{actor} #{face} #{unk00}"
			pos		+= length
		elsif code == "04"
		# MEMORY NAME
			length	= data[pos + 1, 2].unpack("H*")[0].hex + 1
			frequen	= (data[pos + 3, 2].unpack("H*")[0].hex / 100.0).to_s.ljust(6, "0")
			name	= data[pos + 5, length - 6]
			$radio.write "#{space}MEMORY #{frequen} #{name}"
			pos		+= length
		elsif code == "05"
		# SAVE
			length	= data[pos + 1, 2].unpack("H*")[0].hex + 1
			$radio.write "#{space}#{data[pos, length].unpack("H*")[0]}"
			pos		+= length
		elsif code == "06"
		# Audio
			length	= data[pos + 1, 2].unpack("H*")[0].hex + 1
			unk0	= data[pos + 3, 2].unpack("H*")[0]
			unk1	= data[pos + 5, 2].unpack("H*")[0]
			unk2	= data[pos + 7, 2].unpack("H*")[0]
			$radio.write "#{space}AUDIO #{unk0} #{unk1} #{unk2}"
			pos		+= length
		elsif code == "07"
		# Prompt
			length	= data[pos + 1, 2].unpack("H*")[0].hex + 1
			count	= 3
			#$radio.write "#{space}#{data[pos, length].unpack("H*")[0]}"
			$radio.write "#{space}SYSTEM [\r"
			while 0 == 0
				if data[pos + count].unpack("H*")[0] == "00"
					$radio.write "#{space}]\r"
					break
				end
				size	= data[pos + count + 1].unpack("H*")[0].hex + 2
				$radio.write "#{space}	#{data[pos + count, size]}\r"
				count	+= size
			end
			pos		+= length
		elsif code == "08"
		# related with saves
			length	= data[pos + 1, 2].unpack("H*")[0].hex + 1
			$radio.write "#{space}#{code} #{data[pos, length].unpack("H*")[0]}"
			pos		+= length
		elsif code == "10"
		# Conditional
			length	= data[pos + 1, 2].unpack("H*")[0].hex + 1
#			$radio.write "#{space}#{data[pos].unpack("H*")[0]} #{data[pos + 1, 2].unpack("H*")[0]}{\r"
			$radio.write "#{space}IF "
			pos		+= 3
			space	+= "	"
			len10	= 1
		elsif code == "11"
			$radio.write "#{space}ELSE "
			pos		+= 1
		elsif code == "12"
			$radio.write "#{space}ELSIF "
			len10	= 1
			pos		+= 1
		elsif code == "31"
		# unk
			length	= 3
			$radio.write "#{space}#{code} #{data[pos, length].unpack("H*")[0]}"
			pos		+= 3
		elsif code == "30"
		# unk
			length	= data[pos + 1, len10].unpack("H*")[0].hex + 1
			if len10 == 2
				length	= 8
				$radio.write "#{space}#{data[pos, length].unpack("H*")[0]} "
				space	+= "	"
			else
				$radio.write "#{data[pos, length].unpack("H*")[0]} "
			end
			pos		+= length
			len10	= 2
		elsif code == "40"
		# gcx
			length	= data[pos + 1, 2].unpack("H*")[0].hex + 1
			$radio.write "#{space}#{code} #{data[pos + 1, 2].unpack("H*")[0]} | "
			pos		+= 3
			len10	= 1
		elsif code == "80"
			length	= data[pos + 1, 2].unpack("H*")[0].hex
			$radio.write "80{"
			pos		+= 3
			space	+= "	"
		elsif code == "ff"
			$radio.write "\r"
			pos		+= 1
		elsif code == "00"
			space	= space[0..-2]
			$radio.write "\r#{space}}"
			pos		+= 1
		else
			$radio.write "#{data[pos, 100].unpack("H*")[0]}\r\n"
			puts "EXIT CODE error: #{code} @ #{pos}"
			exit
		end
	end
	$radio.write "\r\n\r\n"
end

file	= IO.binread("RADIO_jp.DAT")

offset	= 0			# Offset on where it should start
name	= -1		# Gives a name to bitmap
FileUtils::mkdir_p "extra"
$radio	= File.new("radio_.txt", "wb")
#$radio.write ["efbbbf"].pack("H*")

extraChar	= []
while 0 == 0
	break if offset == file.length
	isFreq		= file[offset, 2].unpack("H*")[0].hex
	# It's text or bitmap?
	if isFreq >= 14000 && isFreq <= 14300
		# Text
		size	= file[offset + 9, 2].unpack("H*")[0].hex
		offset	+= size + 9
#	elsif isFreq == 0
#		offset += (0x800 - (offset%0x800))
	else
		# Bitmap
		char	= Digest::MD5.hexdigest file[offset, 36]
		if extraChar.include? char
		else
			extraChar.push(char)
			name	+= 1
			$data	= File.new("extra/bitmap_#{name.to_s.rjust(5, "0")}.dat", "wb")
			$data.write file[offset, 36]
			$data.close
			dat2tga("extra/bitmap_#{name.to_s.rjust(5, "0")}.dat")
		end
		offset	+= 36
	end
end

offset	= 0
while 0 == 0
	break if offset == file.length
	isFreq		= file[offset, 2].unpack("H*")[0].hex
	# It's text or bitmap?
	if isFreq >= 14000 && isFreq <= 14300
		# Text
		freq	= file[offset + 0, 2].unpack("H*")[0].hex
		unk0	= file[offset + 2, 2].unpack("H*")[0]
		unk1	= file[offset + 4, 2].unpack("H*")[0]
		unk2	= file[offset + 6, 2].unpack("H*")[0]
		flag	= file[offset + 8].unpack("H*")[0]
		size	= file[offset + 9, 2].unpack("H*")[0].hex
		$radio.write "#{(freq / 100.00).to_s.ljust(6, "0")} #{unk0} #{unk1} #{unk2}"
		dat2txt(file[offset + 8, size+1], "", extraChar)
		offset	+= size + 9
#	elsif isFreq == 0
#		offset += (0x800 - (offset%0x800))
	else
		# Bitmap
		offset	+= 36
	end
end
