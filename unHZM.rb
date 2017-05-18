file = "63c661.hzm"
magic = IO.binread(file, 2, 0).unpack("H*").join
if magic != "0200"
	puts "Wrong file"
	exit
end

def load_xyzw(bytes,scale)
	val_x = bytes[0..1].unpack("v*").join.to_i
	val_y = bytes[2..3].unpack("v*").join.to_i
	val_z = bytes[4..5].unpack("v*").join.to_i
	val_w = bytes[6..7]
	val_x >= 32768 ? val_x += -32768 : val_x += 32768
	val_y >= 32768 ? val_y += -32768 : val_y += 32768
	val_z >= 32768 ? val_z += -32768 : val_z += 32768
	return [val_x/scale, val_y/scale, val_z/scale, val_w]
end

def create(width, height, var, id, display)
	$extract.write "  <canvas id=\"#{id}\"#{display} width=\"#{width}\" height=\"#{height}\">Your browser does not support the HTML5 canvas tag.</canvas>
  <script>
   var #{var} = document.getElementById(\"#{id}\");
   var draw = #{var}.getContext(\"2d\");\r\n"
end

def begin_draw()
	$extract.write "   draw.beginPath();\r\n"
end

def move(x,y)
	$extract.write "   draw.moveTo(#{x},#{y});\r\n"
end

def line(x,y)
	$extract.write "   draw.lineTo(#{x},#{y});\r\n"
end

def line_color(ref)
	$extract.write "   draw.strokeStyle = '#{ref}';\r\n"
end

def line_end
	$extract.write "   draw.stroke();\r\n"
end

view_3D = false
scale = 50.0
$extract = File.new("#{file.split(".")[0]}.htm", "wb")
$extract.write "<!DOCTYPE html>
<html>
 <head>
  <style>
   a{
    color:#2d7191;
    text-decoration:none;
    display:block;
	width:150px;
   }
   b{
    color:#50c7ff;
   }
   body {
    font-family:arial;
    font-size:9px;
   }
   canvas {
    border:1px solid #d3d3d3;
    position:absolute;
    top:0;
    left:0;
    z-index:-1;
   }
   .none {
    display:none;
   }
  </style>
 </head>
 <body>\r\n"

val0				= load_xyzw( IO.binread(file, 8, 2),scale )
val1				= load_xyzw( IO.binread(file, 8, 6),scale )
width				= (val1[0] - val0[0])
height				= (val1[1] - val0[1])
table_count			= IO.binread(file, 2, 10).unpack("v*").join.to_i
navmesh_count	 	= IO.binread(file, 2, 12).unpack("v*").join.to_i
pathfinding_count	= IO.binread(file, 2, 14).unpack("v*").join.to_i
table_offset		= IO.binread(file, 2, 16).unpack("v*").join.to_i
navmesh_offset	 	= IO.binread(file, 4, 20).unpack("V*").join.to_i
pathfinding_offset	= IO.binread(file, 4, 24).unpack("V*").join.to_i

##
# center
##
create(width,height,"ce","ce","")
move(32768/scale+2,32768/scale-20)
line(32768/scale,32768/scale-20)
line(32768/scale,32768/scale-10)
line(32768/scale+2,32768/scale-10)
line(32768/scale,32768/scale-10)
line(32768/scale,32768/scale)
line(32768/scale,32768/scale+10)
line(32768/scale-2,32768/scale+10)
line(32768/scale,32768/scale+10)
line(32768/scale,32768/scale+20)
line(32768/scale-2,32768/scale+20)
move(32768/scale-20,32768/scale-2)
line(32768/scale-20,32768/scale)
line(32768/scale-10,32768/scale)
line(32768/scale-10,32768/scale-2)
line(32768/scale-10,32768/scale)
line(32768/scale,32768/scale)
line(32768/scale+10,32768/scale)
line(32768/scale+10,32768/scale+2)
line(32768/scale+10,32768/scale)
line(32768/scale+20,32768/scale)
line(32768/scale+20,32768/scale+2)
line_color("#000")
line_end
$extract.write "  </script>\r\n\r\n"

##
# Navmesh
##
create(width,height,"nm","nm"," class=\"none\"")
for n0 in 0..navmesh_count-1
	val0 = load_xyzw( IO.binread(file, 8, navmesh_offset + n0*24 + 0),scale )
	w_size = IO.binread(file, 2, navmesh_offset + n0*24 + 6).unpack("v*").join.to_i/scale
	h_size = IO.binread(file, 2, navmesh_offset + n0*24 + 8).unpack("v*").join.to_i/scale
	$extract.write "    draw.beginPath();
    draw.fillStyle = 'rgba(62,139,255,0.2)';
    draw.strokeStyle = '#3e8bff';
    draw.rect(#{val0[0]-w_size},#{val0[1]-h_size},#{w_size*2},#{h_size*2});
    draw.fill();
    draw.stroke();"
end
$extract.write "  </script>\r\n\r\n"

##
# Pathfinding
##
for n0 in 0..pathfinding_count-1
	offset0 = IO.binread(file, 4, pathfinding_offset + 4 + 8 * n0).unpack("V*").join.to_i
	size0 = IO.binread(file, 4, pathfinding_offset + 8 * n0).unpack("V*").join.to_i
	if size0 != 0
		create(width,height,"pf","pf_#{n0}"," class=\"none\"")
		val0 = load_xyzw( IO.binread(file, 8, offset0),scale )
		move(val0[0],val0[1])
		line(val0[0]-7,val0[1]-9)
		line(val0[0]+7,val0[1]-9)
		line(val0[0],val0[1])
		$extract.write "   draw.font = \"9px Arial\";\r\n"
		$extract.write "   draw.fillText(\"---- #{n0}\",60,#{16}); draw.fillText(\"#{val0[3].unpack("H*").join}\",86,#{16});\r\n"
		for n1 in 1..size0-1
			oldx = val0[0]
			oldy = val0[1]
			oldz = val0[2]
			val0 = load_xyzw( IO.binread(file, 8, offset0 + n1*8),scale )
			line(val0[0],val0[1])
			$extract.write "   draw.font = \"9px Arial\"; draw.fillText(\""
			if oldx < val0[0] && oldy < val0[1] #LD
				$extract.write "\\u2198"
			elsif oldx < val0[0] && oldy > val0[1] #LU
				$extract.write "\\u2197"
			elsif oldx > val0[0] && oldy < val0[1] #RD
				$extract.write "\\u2199"
			elsif oldx > val0[0] && oldy > val0[1] #RU
				$extract.write "\\u2196"
			elsif oldy < val0[1] #Down
				$extract.write "\\u2193"
			elsif oldy > val0[1] #Up
				$extract.write "\\u2191"
			elsif oldx < val0[0] #Left
				$extract.write "\\u2192"
			elsif oldx > val0[0] #Right
				$extract.write "\\u2190"
			else
				$extract.write "= "
			end
			$extract.write "\",74,#{n1*10 + 15}); draw.fillText(\"#{val0[3].unpack("H*").join}\",86,#{n1*10 + 16});\r\n"
		end
		line_color("#f00")
		line_end
		$extract.write "  </script>\r\n\r\n"
	end
end

for n0 in 0..table_count-1
	flag_count			= IO.binread(file, 2, table_offset + 0 + n0*24).unpack("v*").join.to_i
	wall_count			= IO.binread(file, 2, table_offset + 2 + n0*24).unpack("v*").join.to_i
	elevator_count		= IO.binread(file, 2, table_offset + 4 + n0*24).unpack("v*").join.to_i
	unknown1			= IO.binread(file, 2, table_offset + 6 + n0*24).unpack("v*").join.to_i
	wall_offset		= IO.binread(file, 4, table_offset + 8 + n0*24).unpack("V*").join.to_i
	elevator_offset	= IO.binread(file, 4, table_offset + 12 + n0*24).unpack("V*").join.to_i #red triangles
	flag_offset		= IO.binread(file, 4, table_offset + 16 + n0*24).unpack("V*").join.to_i
	properties_offset	= IO.binread(file, 4, table_offset + 20 + n0*24).unpack("V*").join.to_i #crouch, transparent wal
 
##
# Walls radar
##
	create(width,height,"wr","wr_#{n0}","")
	for n1 in 0..wall_count-1
		val0 = load_xyzw( IO.binread(file, 8, wall_offset + n1*16 + 0),scale )
		val1 = load_xyzw( IO.binread(file, 8, wall_offset + n1*16 + 8),scale )
		config = IO.binread(file, 1, properties_offset + n1)
		if config.unpack("b*").join[-1] == "0"
			move(val0[0],val0[1])
			line(val1[0],val1[1])
		end
	end
	line_color("#00A048")
	line_end
	$extract.write "  </script>\r\n\r\n"

##
# Walls hidden
##
	create(width,height,"wh","wh_#{n0}"," class=\"none\"")
	for n1 in 0..wall_count-1
		val0 = load_xyzw( IO.binread(file, 8, wall_offset + n1*16 + 0),scale )
		val1 = load_xyzw( IO.binread(file, 8, wall_offset + n1*16 + 8),scale )
		config = IO.binread(file, 1, properties_offset + n1)
		if config.unpack("b*").join[-1] == "1"
			begin_draw
			move(val0[0],val0[1])
			line(val1[0],val1[1])
			caca = val0[3].unpack("v*").join.to_i
			caca >= 32768 ? caca += -32768 : caca += 32768
			caca = caca.to_s(16).rjust(4, "0").scan(/(..)(..)/).map(&:reverse).join
			line_color("#00#{caca}")
			line_end
		end
	end
	line_color("#004000")
	line_end
	$extract.write "  </script>\r\n\r\n"

##
# Flags
## Triggers
$hash	= File.new("#{file.split(".")[0]}_hash.txt", "wb")
	for n1 in 0..flag_count-1
		val0 = load_xyzw( IO.binread(file, 8, flag_offset + n1*32 + 0),scale )
		val1 = load_xyzw( IO.binread(file, 8, flag_offset + n1*32 + 8),scale )
		text0 = IO.binread(file, 12, flag_offset + n1*32 + 16)
		identi = IO.binread(file, 2, flag_offset + n1*32 + 28).unpack("H*").join
		unkn0 = IO.binread(file, 2, flag_offset + n1*32 + 30).unpack("H*").join

		create(width,height,"fl","fl_#{n0}_#{n1}"," class=\"none\"")
		move(val0[0],val0[1])
		line(val0[0],val1[1])
		line(val1[0],val1[1])
		line(val1[0],val0[1])
		line(val0[0],val0[1])
		if identi != "00ff"
			$extract.write "   draw.fillText(\"#{text0.gsub("\000", '')}\",#{val0[0]+2},#{val0[1]+10});\r\n"
			$hash.write "#{text0.gsub("\000", '')}\r\n"
		end
		line_color("#ff9900")
		line_end
		$extract.write "  </script>\r\n\r\n"
	end
$hash.close

##
# Flags
## Cammera
	for n1 in 0..flag_count-1
		val0 = load_xyzw( IO.binread(file, 8, flag_offset + n1*32 + 0),scale )
		val1 = load_xyzw( IO.binread(file, 8, flag_offset + n1*32 + 8),scale )
		val2 = load_xyzw( IO.binread(file, 8, flag_offset + n1*32 + 16),scale )
		val3 = load_xyzw( IO.binread(file, 8, flag_offset + n1*32 + 24),scale )
  
		to_x  = IO.binread(file, 2, flag_offset + n1*32 + 16).unpack("v*").join.to_i
		to_x >= 32768 ? to_x += -32768 : to_x += 32768
		to_x = to_x/scale
		to_y = IO.binread(file, 2, flag_offset + n1*32 + 18).unpack("v*").join.to_i
		to_y >= 32768 ? to_y += -32768 : to_y += 32768
		to_y = to_y/scale
		to_z = IO.binread(file, 2, flag_offset + n1*32 + 20).unpack("v*").join.to_i# * 360 / 65535
		to_z >= 32768 ? to_z += -32768 : to_z += 32768
		to_z = to_z/scale
		pos_x = IO.binread(file, 2, flag_offset + n1*32 + 22).unpack("v*").join.to_i
		pos_x >= 32768 ? pos_x += -32768 : pos_x += 32768
		pos_x = pos_x/scale
		pos_y = IO.binread(file, 2, flag_offset + n1*32 + 26).unpack("v*").join.to_i
		pos_y >= 32768 ? pos_y += -32768 : pos_y += 32768
		pos_y = pos_y/scale
		pos_z = IO.binread(file, 2, flag_offset + n1*32 + 24).unpack("v*").join.to_i
		pos_z >= 32768 ? pos_z += -32768 : pos_z += 32768
		pos_z = pos_z/scale
		identi = IO.binread(file, 2, flag_offset + n1*32 + 28).unpack("H*").join
		unkn0 = IO.binread(file, 2, flag_offset + n1*32 + 30).unpack("H*").join

		create(width,height,"cm","cm_#{n0}_#{n1}"," class=\"none\"")
		begin_draw
		move(val0[0],val0[1])
		line(val0[0],val1[1])
		line(val1[0],val1[1])
		line(val1[0],val0[1])
		line(val0[0],val0[1])
		line_color("#ff9900")
		line_end

		begin_draw
		move(pos_x+4,pos_y+4)
		line(pos_x-4,pos_y+4)
		line(pos_x-4,pos_y-4)
		line(pos_x+4,pos_y-4)
		line(pos_x+4,pos_y+4)
		line(pos_x,pos_y)
		line(to_x,to_z)
		line_color("#f00")
		line_end

		$extract.write "  </script>\r\n\r\n"
	end



##
# Altimetry
##
	create(width,height,"al","al_#{n0}"," class=\"none\"")
	for n1 in 0..elevator_count-1
		val0 = load_xyzw( IO.binread(file, 8, elevator_offset + 0 + n1*48),scale )
		val1 = load_xyzw( IO.binread(file, 8, elevator_offset + 8 + n1*48),scale )
		width	= val1[0] - val0[0]
		height	= val1[1] - val0[1]
		alt		= val0[0].floor / 2
		$extract.write "
		draw.beginPath();
    draw.fillStyle = 'rgba(#{alt},#{alt},#{alt},0.1)';
    draw.strokeStyle = '#ff0000';
    draw.rect(#{val0[0]},#{val0[1]},#{width},#{height});
    draw.fill();
    draw.stroke();"
		
		print val0[0..2]
		puts val0[3].unpack("v*").join.to_i
		print val1[0..2]
		puts val1[3].unpack("v*").join.to_i
		puts
	end
	$extract.write "  </script>\r\n\r\n"


end

lightFile	= "#{file.split(".")[0]}.lit"
if File.file?(lightFile)
	puts "light"
	##
	# Lights
	##
	rows			= IO.binread(lightFile, 4).unpack("V*").join.to_i
	light_offset	= 4
	for n0 in 0..rows-1
		create(width,height,"li","li_#{n0}"," class=\"none\"")
		val0	= load_xyzw( IO.binread(lightFile, 8, 4 + n0*16 + 0),scale )
		redCol	= IO.binread(lightFile, 1, 4 + n0*16 + 12).unpack("H*").join
		greCol	= IO.binread(lightFile, 1, 4 + n0*16 + 13).unpack("H*").join
		bluCol	= IO.binread(lightFile, 1, 4 + n0*16 + 14).unpack("H*").join
		$extract.write "	draw.beginPath();
    draw.fillStyle = 'rgba(#{redCol.hex},#{greCol.hex},#{bluCol.hex},0.2)';
    draw.strokeStyle = '##{redCol}#{greCol}#{bluCol}';
	draw.arc(#{val0[0]}, #{val0[2]}, 20, 0, 2 * Math.PI);
    draw.fill();
	draw.stroke();"
		$extract.write "  </script>\r\n\r\n"
	end
end




$extract.write "  <a href=\"javascript:show('pf')\"><b><i>Pathfinding</i></b></a>"
$extract.write "  <div id=\"pf\" class=\"none\" style=\"margin-left:5px;\">\r\n"
for n0 in 0..pathfinding_count-1
	$extract.write "   <a href=\"javascript:show('pf_#{n0}')\">pf_#{n0}</a>\r\n"
end
$extract.write "  </div>"

$extract.write "  <a href=\"javascript:show('nm')\"><b><i>Navmeshes</i></b></a>"
$extract.write "  <a href=\"javascript:show('walls')\"><b><i>Walls</i></b></a>"
$extract.write "  <div id=\"walls\" class=\"none\" style=\"margin-left:5px;\">\r\n"
for n0 in 0..table_count-1
	$extract.write "   <a href=\"javascript:hide('wr_#{n0}')\">wall_#{n0}</a>\r\n"
end
$extract.write "  </div>\r\n"

$extract.write "  <a href=\"javascript:show('walls_hi')\"><b><i>Walls hidden</i></b></a>"
$extract.write "  <div id=\"walls_hi\" class=\"none\" style=\"margin-left:5px;\">\r\n"
for n0 in 0..table_count-1
	$extract.write "   <a href=\"javascript:show('wh_#{n0}')\">wall_#{n0}</a>\r\n"
end
$extract.write "  </div>\r\n"

$extract.write "  <a href=\"javascript:show('flags')\"><b><i>Flags</i></b></a>"
$extract.write "  <div id=\"flags\" class=\"none\" style=\"margin-left:5px;\">\r\n"
for n0 in 0..table_count-1
	trigger_count		= IO.binread(file, 2, table_offset + 0 + n0*24).unpack("v*").join.to_i
	trigger_offset		= IO.binread(file, 4, table_offset + 16 + n0*24).unpack("V*").join.to_i
	$extract.write "   <a href=\"javascript:show('fl_#{n0}')\">fl_#{n0}</a>\r\n"
	$extract.write "  <div id=\"fl_#{n0}\" class=\"none\" style=\"margin-left:5px;\">\r\n"
	for n1 in 0..trigger_count-1
		text0 = IO.binread(file, 12, trigger_offset + n1*32 + 16).gsub("\000", '')
		identi = IO.binread(file, 2, trigger_offset + n1*32 + 28).unpack("H*").join
		if identi != "00ff"
			$extract.write "   <a href=\"javascript:show('fl_#{n0}_#{n1}')\">#{text0}</a>\r\n"
		end
	end
	$extract.write "  </div>\r\n"
end
$extract.write "  </div>\r\n"

$extract.write "  <a href=\"javascript:show('cameras')\"><b><i>Cameras</i></b></a>"
$extract.write "  <div id=\"cameras\" class=\"none\" style=\"margin-left:5px;\">\r\n"
for n0 in 0..table_count-1
	trigger_count		= IO.binread(file, 2, table_offset + 0 + n0*24).unpack("v*").join.to_i
	trigger_offset		= IO.binread(file, 4, table_offset + 16 + n0*24).unpack("V*").join.to_i
	$extract.write "   <a href=\"javascript:show('cm_#{n0}')\">cm_#{n0}</a>\r\n"
	$extract.write "  <div id=\"cm_#{n0}\" class=\"none\" style=\"margin-left:5px;\">\r\n"
	for n1 in 0..trigger_count-1
		text0 = IO.binread(file, 12, trigger_offset + n1*32 + 16).gsub("\000", '')
		identi = IO.binread(file, 2, trigger_offset + n1*32 + 28).unpack("H*").join
		if identi == "00ff"
			$extract.write "   <a href=\"javascript:show('cm_#{n0}_#{n1}')\">cam_#{text0.unpack("H*").join}</a>\r\n"
		end
	end
	$extract.write "  </div>\r\n"
end
$extract.write "  </div>\r\n"

$extract.write "  <a href=\"javascript:show('altimetries')\"><b><i>Altimetries</i></b></a>"
$extract.write "  <div id=\"altimetries\" class=\"none\" style=\"margin-left:5px;\">\r\n"
for n0 in 0..table_count-1
	$extract.write "   <a href=\"javascript:show('al_#{n0}')\">al_#{n0}</a>\r\n"
end
$extract.write "  </div>\r\n"

if File.file?("#{file.split(".")[0]}.lit")
	$extract.write "  <a href=\"javascript:show('lights')\"><b><i>Lights</i></b></a>"
	$extract.write "  <div id=\"lights\" class=\"none\" style=\"margin-left:5px;\">\r\n"
	for n0 in 0..rows-1
		$extract.write "   <a href=\"javascript:show('li_#{n0}')\">li_#{n0}</a>\r\n"
	end
	$extract.write "  </div>\r\n"
end
$extract.write "  <script>
   function show(id) {
    var e = document.getElementById(id);
    if(e.style.display == 'block')
     e.style.display = 'none';
    else
     e.style.display = 'block';
   }
   function hide(id) {
    var e = document.getElementById(id);
    if(e.style.display == 'none')
     e.style.display = 'block';
    else
     e.style.display = 'none';
   }
  </script>
 </body>
</html>"