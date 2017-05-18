if ARGV[0]
 # Showing info
 print "MGS_kmd2obj v1.1 by SecaProject
kmd file to convert: "

 file = ARGV[0]
 puts file
else
 # Showing info
 print "MGS_kmd2obj v1.8
Convert KMD files (Konami MoDel) from Metal Gear Solid to OBJ.
Write the path and filename and hit enter.

kmd file to convert: "

 # Get the filename
 file = gets.gsub('\\', '/').gsub(["0a"].pack("H*"), '')
end

# Exist?
if file == ""
 puts "No filename specified, hit enter to exit."
 gets
 exit
elsif !File.file?(file)
 puts "The file \"#{file}\" don't exist, hit enter to exit."
 if !ARGV[0]
  gets
 end
 exit
end

# Creamos valores que se usarán más adelante
jump_v			= 0
jump_vn			= 0
jump_vt			= 0
coords			= []
material_memory	= []
filename		= file.split("/")[-1].split(".")[0]
filepath		= file.split("/")[0..-2].join("/")

# Cabecera
faces			= IO.binread(file, 4, 0).unpack("V*").join.to_i
meshes			= IO.binread(file, 4, 4).unpack("V*").join.to_i
mdl_ini_x		= IO.binread(file, 4, 8).unpack("l").join.to_i
mdl_ini_y		= IO.binread(file, 4, 12).unpack("l").join.to_i
mdl_ini_z		= IO.binread(file, 4, 16).unpack("l").join.to_i
mdl_end_x		= IO.binread(file, 4, 20).unpack("l").join.to_i
mdl_end_y		= IO.binread(file, 4, 24).unpack("l").join.to_i
mdl_end_z		= IO.binread(file, 4, 28).unpack("l").join.to_i

# Creamos el archivo OBJ con el mismo nombre
$mtl = File.new("#{filepath}/#{filename}.mtl", "wb")
$obj = File.new("#{filepath}/#{filename}.obj", "wb")
$obj.write "################################
#
# MGS kmd2obj v1.8 tool | Coded by SeCaProject
# more info: www.secaproject.com
#
# General info
# Size: width #{mdl_ini_x.abs + mdl_end_x.abs} | height #{mdl_ini_y.abs + mdl_end_y.abs} | deep #{mdl_ini_z.abs + mdl_end_z.abs}
# Starts at: x #{mdl_ini_x} | y #{mdl_ini_y} | z #{mdl_ini_z}
# Ends in: x #{mdl_end_x} | y #{mdl_end_y} | z #{mdl_end_z}
#
################################
mtllib #{filename}.mtl
\r\n"

# Leemos cada mesh
for block_mesh in 0..meshes-1 do
	# Info
	val0		= IO.binread(file, 2, 32 + block_mesh * 88).unpack("v*").join.to_i
	val1		= IO.binread(file, 2, 34 + block_mesh * 88).unpack("v*").join.to_i
	mesh		= IO.binread(file, 2, 36 + block_mesh * 88).unpack("v*").join.to_i
	pos_ini_x	= IO.binread(file, 2, 40 + block_mesh * 88).unpack("s").join.to_i
	pos_ini_y	= IO.binread(file, 2, 44 + block_mesh * 88).unpack("s").join.to_i
	pos_ini_z	= IO.binread(file, 2, 48 + block_mesh * 88).unpack("s").join.to_i
	pos_end_x	= IO.binread(file, 2, 52 + block_mesh * 88).unpack("s").join.to_i
	pos_end_y	= IO.binread(file, 2, 56 + block_mesh * 88).unpack("s").join.to_i
	pos_end_z	= IO.binread(file, 2, 60 + block_mesh * 88).unpack("s").join.to_i
	mov_obj_x	= IO.binread(file, 2, 64 + block_mesh * 88).unpack("s").join.to_i
	mov_obj_y	= IO.binread(file, 2, 68 + block_mesh * 88).unpack("s").join.to_i
	mov_obj_z	= IO.binread(file, 2, 72 + block_mesh * 88).unpack("s").join.to_i
	referency	= IO.binread(file, 2, 76 + block_mesh * 88).unpack("s").join.to_i
	val2		= IO.binread(file, 2, 80 + block_mesh * 88).unpack("s").join.to_i

	coords.push([mov_obj_x, mov_obj_y, mov_obj_z])
	mov_obj_x	+= coords[referency][0]
	mov_obj_y	+= coords[referency][1]
	mov_obj_z	+= coords[referency][2]
	coords[block_mesh] = [mov_obj_x, mov_obj_y, mov_obj_z]

	vert_num	= IO.binread(file, 4, 84 + block_mesh * 88).unpack("V*").join.to_i 
	vert_off	= IO.binread(file, 4, 88 + block_mesh * 88).unpack("V*").join.to_i
	vert_ord	= IO.binread(file, 4, 92 + block_mesh * 88).unpack("V*").join.to_i
	norm_num	= IO.binread(file, 4, 96 + block_mesh * 88).unpack("V*").join.to_i
	norm_off	= IO.binread(file, 4, 100 + block_mesh * 88).unpack("V*").join.to_i
	norm_ord	= IO.binread(file, 4, 104 + block_mesh * 88).unpack("V*").join.to_i
	uv_off		= IO.binread(file, 4, 108 + block_mesh * 88).unpack("V*").join.to_i
	txtu_off	= IO.binread(file, 4, 112 + block_mesh * 88).unpack("V*").join.to_i

	$obj.write "\r\n\r\n
# Object: #{filename}_#{block_mesh}
# Vertex: #{vert_num} | Mesh: #{mesh}
# Size: #{pos_ini_x.abs + pos_end_x.abs} x #{pos_ini_y.abs + pos_end_y.abs} x #{pos_ini_z.abs + pos_end_z.abs}
# Start at: x #{pos_ini_x} | y #{pos_ini_y} | z #{pos_ini_z}
# Ends in: x #{pos_end_x} | y #{pos_end_y} | z #{pos_end_z}
\r\n"

	# Leemos la tabla de vértices y la vamos guardando
	for loop_v in 0..vert_num-1 do
		$obj.write "v "
		# X
		$obj.write (IO.binread(file, 2, vert_off + 0 + (loop_v * 8)).unpack("s").join.to_i + mov_obj_x)
		$obj.write " "
		# Y
		$obj.write (IO.binread(file, 2, vert_off + 2 + (loop_v * 8)).unpack("s").join.to_i + mov_obj_y)
		$obj.write " "
		# Z
		$obj.write (IO.binread(file, 2, vert_off + 4 + (loop_v * 8)).unpack("s").join.to_i + mov_obj_z)
		$obj.write " "
		# W
		$obj.write (IO.binread(file, 2, vert_off + 6 + (loop_v * 8)).unpack("s").join.to_i)
		$obj.write "\r\n"
	end
	$obj.write "\r\n"

	for loop_vn in 0..norm_num-1 do
		$obj.write "vn "
		$obj.write (IO.binread(file, 2, norm_off + 0 + (loop_vn * 8)).unpack("v*").join.to_i / 65536.0).to_s[0..5]
		$obj.write " "
		$obj.write (IO.binread(file, 2, norm_off + 2 + (loop_vn * 8)).unpack("v*").join.to_i / 65536.0).to_s[0..5]
		$obj.write " "
		$obj.write (IO.binread(file, 2, norm_off + 4 + (loop_vn * 8)).unpack("v*").join.to_i / 65536.0).to_s[0..5]
		$obj.write "\r\n"
	end
	$obj.write "\r\n"

	for loop_vt in 0..(txtu_off-uv_off)/2-1 do
		$obj.write "vt "
		$obj.write IO.binread(file, 1, uv_off + 0 + (loop_vt * 2)).unpack("H*").join.hex / 256.0
		$obj.write " "
		$obj.write 1 - IO.binread(file, 1, uv_off + 1 + (loop_vt * 2)).unpack("H*").join.hex / 256.0
		$obj.write "\r\n"
	end
	$obj.write "\r\n"

	# Leemos la tabla de los lados y la guardamos también
	$obj.write "g #{filename}_#{block_mesh}\r\n"
	material_count	= 0
	prev_texture	= false
	for loop_f in 0..mesh-1 do
		get_texture	= IO.binread(file, 2, txtu_off + loop_f*2).unpack("H*").join.scan(/(..)(..)/).map(&:reverse).join
		if prev_texture != get_texture
			material_count	+= 1
			prev_texture	= get_texture
			$obj.write "usemtl Material_#{filename}_#{get_texture}\r\n"
			# Comprobamos que no existe el material
			if !material_memory.include? get_texture
				material_memory.push(get_texture)
				if File.file?("#{filepath.split("/")[0..-2].join("/")}/stg_tex1/70#{get_texture}.png")
					map_Kd	= "map_Kd \"../stg_tex1/70#{get_texture}.png\""
				elsif File.file?("#{filepath.split("/")[0..-2].join("/")}/stg_tex2/70#{get_texture}.png")
					map_Kd	= "map_Kd \"../stg_tex2/70#{get_texture}.png\""
				elsif File.file?("#{filepath.split("/")[0..-2].join("/")}/stg_tex3/70#{get_texture}.png")
					map_Kd	= "map_Kd \"../stg_tex3/70#{get_texture}.png\""
				else
					map_Kd	= "# 70#{get_texture} Not Found!!"
				end
				$mtl.write "newmtl Material_#{filename}_#{get_texture}\r\n Ka 1.000 1.000 1.000\r\n Kd 1.000 1.000 1.000\r\n Ks 0.000 0.000 0.000\r\n Ns 10.000\r\n Tr 0\r\n#{map_Kd}"
				$mtl.write "\r\n"
				$mtl.write "\r\n"
			end
		end

		set_w		= IO.binread(file, 1, vert_ord + 3 + (loop_f * 4)).unpack("H*").join.hex + 1 + jump_v
		set_x		= IO.binread(file, 1, vert_ord + 2 + (loop_f * 4)).unpack("H*").join.hex + 1 + jump_v
		set_y		= IO.binread(file, 1, vert_ord + 1 + (loop_f * 4)).unpack("H*").join.hex + 1 + jump_v
		set_z		= IO.binread(file, 1, vert_ord + 0 + (loop_f * 4)).unpack("H*").join.hex + 1 + jump_v
		set_uv_w	= loop_f * 4 + 4 + jump_vt
		set_uv_x	= loop_f * 4 + 3 + jump_vt
		set_uv_y	= loop_f * 4 + 2 + jump_vt
		set_uv_z	= loop_f * 4 + 1 + jump_vt
		set_vn_w	= IO.binread(file, 1, norm_ord + 3 + loop_f * 4).unpack("H*").join.hex + 1 + jump_vn
		set_vn_x	= IO.binread(file, 1, norm_ord + 2 + loop_f * 4).unpack("H*").join.hex + 1 + jump_vn
		set_vn_y	= IO.binread(file, 1, norm_ord + 1 + loop_f * 4).unpack("H*").join.hex + 1 + jump_vn
		set_vn_z	= IO.binread(file, 1, norm_ord + 0 + loop_f * 4).unpack("H*").join.hex + 1 + jump_vn

		$obj.write "s #{loop_f+1}\r\n"
		$obj.write "f "
		$obj.write "#{set_x}/#{set_uv_x}"#/#{set_vn_z}"
		$obj.write " "
		$obj.write "#{set_y}/#{set_uv_y}"#/#{set_vn_y}"
		$obj.write " "
		$obj.write "#{set_z}/#{set_uv_z}"#/#{set_vn_x}"
		$obj.write " "
		$obj.write "#{set_w}/#{set_uv_w}"#/#{set_vn_w}"
		$obj.write "\r\n"
	end
	$obj.write "\r\n"

	if block_mesh == -1
		break
	end

	jump_v	+= loop_v + 1
	jump_vn	+= loop_vn + 1
	jump_vt	= set_uv_w

end
$obj.close
$mtl.close