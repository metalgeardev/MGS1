$HASH_MAP = {
  "0d86" => "if",
  "226d" => "menu",
  "22ff" => "mesg",
  "24e1" => "radio",
  "306a" => "light",
  "430d" => "delay",
  "4ad9" => "system",
  "5c9e" => "varsave",
  "64c0" => "eval",
  "698d" => "sound",
  "9906" => "chara",
  "9a1f" => "start",
  "a242" => "demo",
  "b96e" => "print",
  "c091" => "map",
  "c8bb" => "load",
  "dbab" => "ntrap",
  "e43c" => "str_status",
  "ec9d" => "jimaku",
  "eee9" => "camera",
  "6d43" => "00a_o1",
  "6d44" => "00a_o2",
  "6d45" => "00a_o3",
  "6d46" => "00a_o4",
  "6da3" => "00a_r1",
  "6da4" => "00a_r2",
  "7693" => "sne_wet2",
  "c661" => "00a",
  "e224" => "null",
  "e8fe" => "sne_00a",
  "21ca" => "Solid_Snake",
  "6588" => "Roy_Campbell",
  "9475" => "Naomi",
  "95f2" => "Meryl",
  "d78a" => "Mei_Ling",
  "7982" => "Cyborg_Ninja",
  "33af" => "Unknown01",
  "6c22" => "Master_Miller",
  "3d2c" => "Otacon",
  "fb95" => "Jim_Houseman",
  "7c90" => "Unknown00",
}

def dehash(hash)
  if $HASH_MAP.has_key? hash
    $data.write $HASH_MAP[hash]
  else
    $data.write "#{hash}"
  end
end
