-- Draw a circle -- draw.Circle( x, y, radius, segments , colour )
function draw.Circle(x,y,radius,seg,colour)
	local cir = {}
	table.insert(cir, { x = x, y = y, u = 0.5, v = 0.5 })
	for i = 0, seg do
		local a = math.rad((i / seg) * -360)
		table.insert(cir, { x = x + math.sin(a) * radius, y = y + math.cos(a) * radius, u = math.sin(a) / 2 + 0.5, v = math.cos(a) / 2 + 0.5 })
	end
	local a = math.rad(0) -- This is need for non absolute segment counts
	table.insert(cir, { x = x + math.sin(a) * radius, y = y + math.cos(a) * radius, u = math.sin(a) / 2 + 0.5, v = math.cos(a) / 2 + 0.5 })
	surface.SetDrawColor(colour.r,colour.g,colour.b,colour.a)
	draw.NoTexture()
	surface.DrawPoly(cir)
end

-- Draw a line -- draw.Line( startX, startY, endX, endY, colour )
function draw.Line(startX,startY,endX,endY,colour)
	surface.SetDrawColor(colour.r,colour.g,colour.b,colour.a)
	surface.DrawLine(startX,startY,endX,endY)
end

-- Draw a rectangle -- draw.Rectangle( x, y, width, height, colour )
function draw.Rectangle(x,y,width,height,colour)
	surface.SetDrawColor(colour.r,colour.g,colour.b,colour.a)
	surface.DrawRect(x,y,width,height)
end