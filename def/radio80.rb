# coding: utf-8
$CHARACTER_MAP = {
    "8023804e" => "\n".unpack("H*"),
    "1f01" =>  "Ä".unpack("H*"),
    "1f02" =>  "Å".unpack("H*"),
    "1f03" =>  "Ç".unpack("H*"),
    "1f04" =>  "É".unpack("H*"),
    "1f05" =>  "Ñ".unpack("H*"),
    "1f06" =>  "Ö".unpack("H*"),
    "1f07" =>  "Ü".unpack("H*"),
    "1f08" =>  "á".unpack("H*"),
    "1f09" =>  "à".unpack("H*"),
    "1f0a" =>  "â".unpack("H*"),
    "1f0b" =>  "ä".unpack("H*"),
    "1f0c" =>  "ã".unpack("H*"),
    "1f0d" =>  "å".unpack("H*"),
    "1f0e" =>  "ç".unpack("H*"),
    "1f0f" =>  "é".unpack("H*"),
    "1f10" =>  "è".unpack("H*"),
    "1f11" =>  "ê".unpack("H*"),
    "1f12" =>  "ë".unpack("H*"),
    "1f13" =>  "í".unpack("H*"),
    "1f14" =>  "ì".unpack("H*"),
    "1f15" =>  "î".unpack("H*"),
    "1f16" =>  "ï".unpack("H*"),
    "1f17" =>  "ñ".unpack("H*"),
    "1f18" =>  "ó".unpack("H*"),
    "1f19" =>  "ò".unpack("H*"),
    "1f1a" =>  "ô".unpack("H*"),
    "1f1b" =>  "ö".unpack("H*"),
    "1f1c" =>  "õ".unpack("H*"),
    "1f1d" =>  "ú".unpack("H*"),
    "1f1e" =>  "ù".unpack("H*"),
    "1f1f" =>  "û".unpack("H*"),
    "1f20" =>  "ü".unpack("H*"),
    "1f21" =>  "†".unpack("H*"),
    "1f22" =>  "°".unpack("H*"),
    "1f23" =>  "¢".unpack("H*"),
    "1f24" =>  "£".unpack("H*"),
    "1f25" =>  "§".unpack("H*"),
    "1f26" =>  "•".unpack("H*"),
    "1f27" =>  "¶".unpack("H*"),
    "1f28" =>  "ß".unpack("H*"),
    "1f29" =>  "®".unpack("H*"),
    "1f2a" =>  "©".unpack("H*"),
    "1f2b" =>  "™".unpack("H*"),
    "1f2c" =>  "´".unpack("H*"),
    "1f2d" =>  "¨".unpack("H*"),
    "1f2e" =>  "≠".unpack("H*"),
    "1f2f" =>  "Æ".unpack("H*"),
    "1f30" =>  "Ø".unpack("H*"),
    "1f31" =>  "∞".unpack("H*"),
    "1f32" =>  "±".unpack("H*"),
    "1f33" =>  "≤".unpack("H*"),
    "1f34" =>  "≥".unpack("H*"),
    "1f35" =>  "¥".unpack("H*"),
    "1f36" =>  "µ".unpack("H*"),
    "1f37" =>  "∂".unpack("H*"),
    "1f38" =>  "∑".unpack("H*"),
    "1f39" =>  "∏".unpack("H*"),
    "1f3a" =>  "π".unpack("H*"),
    "1f3b" =>  "∫".unpack("H*"),
    "1f3c" =>  "ª".unpack("H*"),
    "1f3d" =>  "º".unpack("H*"),
    "1f3e" =>  "Ω".unpack("H*"),
    "1f3f" =>  "æ".unpack("H*"),
    "1f40" =>  "ø".unpack("H*"),
    "1f41" =>  "¿".unpack("H*"),
    "1f42" =>  "¡".unpack("H*"),
    "1f43" =>  "¬".unpack("H*"),
    "1f44" =>  "√".unpack("H*"),
    "1f45" =>  "ƒ".unpack("H*"),
    "1f46" =>  "≈".unpack("H*"),
    "1f47" =>  "∆".unpack("H*"),
    "1f48" =>  "«".unpack("H*"),
    "1f49" =>  "»".unpack("H*"),
    "1f4a" =>  "…".unpack("H*"),
    "1f4b" =>  "n".unpack("H*"),
    "1f4c" =>  "À".unpack("H*"),
    "1f4d" =>  "Ã".unpack("H*"),
    "1f4e" =>  "Õ".unpack("H*"),
    "1f4f" =>  "Œ".unpack("H*"),
    "1f50" =>  "œ".unpack("H*"),
    "1f51" =>  "–".unpack("H*"),
    "1f52" =>  "—".unpack("H*"),
    "1f53" =>  "“".unpack("H*"),
    "1f54" =>  "”".unpack("H*"),
    "1f55" =>  "‘".unpack("H*"),
    "1f56" =>  "’".unpack("H*"),
    "1f57" =>  "÷".unpack("H*"),
    "1f58" =>  "◊".unpack("H*"),
    "1f59" =>  "ÿ".unpack("H*"),
    "1f5a" =>  "Ÿ".unpack("H*"),
    "1f5b" =>  "⁄".unpack("H*"),
    "1f5c" =>  "€".unpack("H*"),
    "1f5d" =>  "‹".unpack("H*"),
    "1f5e" =>  "›".unpack("H*"),
    "1f5f" =>  "ﬁ".unpack("H*"),
    "1f60" =>  "ﬂ".unpack("H*"),
    "1f61" =>  "‡".unpack("H*"),
    "1f62" =>  "·".unpack("H*"),
    "1f63" =>  "‚".unpack("H*"),
    "1f64" =>  "„".unpack("H*"),
    "1f65" =>  "‰".unpack("H*"),
    "1f66" =>  "Â".unpack("H*"),
    "1f67" =>  "Ê".unpack("H*"),
    "1f68" =>  "Á".unpack("H*"),
    "1f69" =>  "Ë".unpack("H*"),
    "1f6a" =>  "È".unpack("H*"),
    "1f6b" =>  "Í".unpack("H*"),
    "1f6c" =>  "Î".unpack("H*"),
    "1f6d" =>  "Ï".unpack("H*"),
    "1f6e" =>  "Ì".unpack("H*"),
    "1f6f" =>  "Ó".unpack("H*"),
    "1f70" =>  "Ô".unpack("H*"),
    "1f72" =>  "Ò".unpack("H*"),
    "1f73" =>  "Ú".unpack("H*"),
    "1f74" =>  "Û".unpack("H*"),
    "1f75" =>  "Ù".unpack("H*"),
    "1f76" =>  "ı".unpack("H*"),
    "1f77" =>  "ˆ".unpack("H*"),
    "1f78" =>  "˜".unpack("H*"),
    "1f79" =>  "¯".unpack("H*"),
    "1f7a" =>  "˘".unpack("H*"),
    "1f7b" =>  "˙".unpack("H*"),
    "1f7c" =>  "˚".unpack("H*"),
    "1f7d" =>  "¸".unpack("H*"),
    "1f7e" =>  "˝".unpack("H*"),
    "8101" =>  "ぁ".unpack("H*"),
    "8102" =>  "あ".unpack("H*"),
    "8103" =>  "ぃ".unpack("H*"),
    "8104" =>  "い".unpack("H*"),
    "8105" =>  "ぅ".unpack("H*"),
    "8106" =>  "う".unpack("H*"),
    "8107" =>  "ぇ".unpack("H*"),
    "8108" =>  "え".unpack("H*"),
    "8109" =>  "ぉ".unpack("H*"),
    "810a" =>  "お".unpack("H*"),
    "810b" =>  "か".unpack("H*"),
    "810c" =>  "が".unpack("H*"),
    "810d" =>  "き".unpack("H*"),
    "810e" =>  "ぎ".unpack("H*"),
    "810f" =>  "く".unpack("H*"),
    "8110" =>  "ぐ".unpack("H*"),
    "8111" =>  "け".unpack("H*"),
    "8112" =>  "げ".unpack("H*"),
    "8113" =>  "こ".unpack("H*"),
    "8114" =>  "ご".unpack("H*"),
    "8115" =>  "さ".unpack("H*"),
    "8116" =>  "ざ".unpack("H*"),
    "8117" =>  "し".unpack("H*"),
    "8118" =>  "じ".unpack("H*"),
    "8119" =>  "す".unpack("H*"),
    "811a" =>  "ず".unpack("H*"),
    "811b" =>  "せ".unpack("H*"),
    "811c" =>  "ぜ".unpack("H*"),
    "811d" =>  "そ".unpack("H*"),
    "811e" =>  "ぞ".unpack("H*"),
    "811f" =>  "た".unpack("H*"),
    "8120" =>  "だ".unpack("H*"),
    "8121" =>  "ち".unpack("H*"),
    "8122" =>  "ぢ".unpack("H*"),
    "8123" =>  "っ".unpack("H*"),
    "8124" =>  "つ".unpack("H*"),
    "8125" =>  "づ".unpack("H*"),
    "8126" =>  "て".unpack("H*"),
    "8127" =>  "で".unpack("H*"),
    "8128" =>  "と".unpack("H*"),
    "8129" =>  "ど".unpack("H*"),
    "812a" =>  "な".unpack("H*"),
    "812b" =>  "に".unpack("H*"),
    "812c" =>  "ぬ".unpack("H*"),
    "812d" =>  "ね".unpack("H*"),
    "812e" =>  "の".unpack("H*"),
    "812f" =>  "は".unpack("H*"),
    "8130" =>  "ば".unpack("H*"),
    "8131" =>  "ぱ".unpack("H*"),
    "8132" =>  "ひ".unpack("H*"),
    "8133" =>  "び".unpack("H*"),
    "8134" =>  "ぴ".unpack("H*"),
    "8135" =>  "ふ".unpack("H*"),
    "8136" =>  "ぶ".unpack("H*"),
    "8137" =>  "ぷ".unpack("H*"),
    "8138" =>  "へ".unpack("H*"),
    "8139" =>  "べ".unpack("H*"),
    "813a" =>  "ぺ".unpack("H*"),
    "813b" =>  "ほ".unpack("H*"),
    "813c" =>  "ぼ".unpack("H*"),
    "813d" =>  "ぽ".unpack("H*"),
    "813e" =>  "ま".unpack("H*"),
    "813f" =>  "み".unpack("H*"),
    "8140" =>  "む".unpack("H*"),
    "8141" =>  "め".unpack("H*"),
    "8142" =>  "も".unpack("H*"),
    "8143" =>  "ゃ".unpack("H*"),
    "8144" =>  "や".unpack("H*"),
    "8145" =>  "ゅ".unpack("H*"),
    "8146" =>  "ゆ".unpack("H*"),
    "8147" =>  "ょ".unpack("H*"),
    "8148" =>  "よ".unpack("H*"),
    "8149" =>  "ら".unpack("H*"),
    "814a" =>  "り".unpack("H*"),
    "814b" =>  "る".unpack("H*"),
    "814c" =>  "れ".unpack("H*"),
    "814d" =>  "ろ".unpack("H*"),
    "814e" =>  "ゎ".unpack("H*"),
    "814f" =>  "わ".unpack("H*"),
    "8150" =>  "ゐ".unpack("H*"),
    "8151" =>  "ん".unpack("H*"),
    "8152" =>  "ァ".unpack("H*"),
    "8153" =>  "ア".unpack("H*"),
    "8154" =>  "ィ".unpack("H*"),
    "8155" =>  "イ".unpack("H*"),
    "8156" =>  "ゥ".unpack("H*"),
    "8157" =>  "ウ".unpack("H*"),
    "8158" =>  "ェ".unpack("H*"),
    "8159" =>  "エ".unpack("H*"),
    "815a" =>  "ォ".unpack("H*"),
    "815b" =>  "オ".unpack("H*"),
    "815c" =>  "カ".unpack("H*"),
    "815d" =>  "ガ".unpack("H*"),
    "815e" =>  "キ".unpack("H*"),
    "815f" =>  "ギ".unpack("H*"),
    "8160" =>  "ク".unpack("H*"),
    "8161" =>  "グ".unpack("H*"),
    "8162" =>  "ケ".unpack("H*"),
    "8163" =>  "ゲ".unpack("H*"),
    "8164" =>  "コ".unpack("H*"),
    "8165" =>  "ゴ".unpack("H*"),
    "8166" =>  "サ".unpack("H*"),
    "8167" =>  "ザ".unpack("H*"),
    "8168" =>  "シ".unpack("H*"),
    "8169" =>  "ジ".unpack("H*"),
    "816a" =>  "ス".unpack("H*"),
    "816b" =>  "ズ".unpack("H*"),
    "816c" =>  "セ".unpack("H*"),
    "816d" =>  "ゼ".unpack("H*"),
    "816e" =>  "ソ".unpack("H*"),
    "816f" =>  "ゾ".unpack("H*"),
    "8170" =>  "タ".unpack("H*"),
    "8171" =>  "ダ".unpack("H*"),
    "8172" =>  "チ".unpack("H*"),
    "8173" =>  "ヂ".unpack("H*"),
    "8174" =>  "ッ".unpack("H*"),
    "8175" =>  "ツ".unpack("H*"),
    "8176" =>  "ヅ".unpack("H*"),
    "8177" =>  "テ".unpack("H*"),
    "8178" =>  "デ".unpack("H*"),
    "8179" =>  "ト".unpack("H*"),
    "817a" =>  "ド".unpack("H*"),
    "817b" =>  "ナ".unpack("H*"),
    "817c" =>  "ニ".unpack("H*"),
    "817d" =>  "ヌ".unpack("H*"),
    "817e" =>  "ネ".unpack("H*"),
    "817f" =>  "ノ".unpack("H*"),
    "8180" =>  "ハ".unpack("H*"),
    "8181" =>  "バ".unpack("H*"),
    "8182" =>  "パ".unpack("H*"),
    "8183" =>  "ヒ".unpack("H*"),
    "8184" =>  "ビ".unpack("H*"),
    "8185" =>  "ピ".unpack("H*"),
    "8186" =>  "フ".unpack("H*"),
    "8187" =>  "ブ".unpack("H*"),
    "8188" =>  "プ".unpack("H*"),
    "8189" =>  "ヘ".unpack("H*"),
    "818a" =>  "ベ".unpack("H*"),
    "818b" =>  "ペ".unpack("H*"),
    "818c" =>  "ホ".unpack("H*"),
    "818d" =>  "ボ".unpack("H*"),
    "818e" =>  "ポ".unpack("H*"),
    "818f" =>  "マ".unpack("H*"),
    "8190" =>  "ミ".unpack("H*"),
    "8191" =>  "ム".unpack("H*"),
    "8192" =>  "メ".unpack("H*"),
    "8193" =>  "モ".unpack("H*"),
    "8194" =>  "ャ".unpack("H*"),
    "8195" =>  "ヤ".unpack("H*"),
    "8196" =>  "ュ".unpack("H*"),
    "8197" =>  "ユ".unpack("H*"),
    "8198" =>  "ョ".unpack("H*"),
    "8199" =>  "ヨ".unpack("H*"),
    "819a" =>  "ラ".unpack("H*"),
    "819b" =>  "リ".unpack("H*"),
    "819c" =>  "ル".unpack("H*"),
    "819d" =>  "レ".unpack("H*"),
    "819e" =>  "ロ".unpack("H*"),
    "819f" =>  "ヮ".unpack("H*"),
    "81a0" =>  "ワ".unpack("H*"),
    "81a1" =>  "ヲ".unpack("H*"),
    "81a2" =>  "ン".unpack("H*"),
    "81a3" =>  "ヴ".unpack("H*"),
    "81a4" =>  "ヵ".unpack("H*"),
    "81a5" =>  "ヶ".unpack("H*"),
    "c307" =>  "！".unpack("H*"),
    "c308" =>  "？".unpack("H*"),
    "c309" =>  "。".unpack("H*"),
    "c30a" =>  "」".unpack("H*"),
    "c30b" =>  "』".unpack("H*"),
    "c30c" =>  "］".unpack("H*"),
    "c30d" =>  "〉".unpack("H*"),
    "c30e" =>  "》".unpack("H*"),
    "c30f" =>  "】".unpack("H*"),
    "c310" =>  "”".unpack("H*"),
    "c311" =>  "、".unpack("H*"),
    "c312" =>  "’".unpack("H*"),
    "c313" =>  "‐".unpack("H*"),
    "c314" =>  "―".unpack("H*"),
    "c315" =>  "…".unpack("H*"),
    "c316" =>  "‥".unpack("H*"),
    "c317" =>  "「".unpack("H*"),
    "c318" =>  "『".unpack("H*"),
    "c319" =>  "《".unpack("H*"),
    "c31a" =>  "［".unpack("H*"),
    "c31b" =>  "【".unpack("H*"),
    "c31c" =>  "“".unpack("H*"),
    "c31d" =>  "‘".unpack("H*"),
}

def parse_text_line(bytes)
  bytes_unpckt = bytes.unpack("H*")[0]
  $CHARACTER_MAP.each do |k, v|
    bytes_unpckt.gsub! k, v[0]
  end
  repacked = [bytes_unpckt].pack("H*")
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
  end
end
