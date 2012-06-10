local coord = {}

local __call = function (self,x,y)
	local u = {x,y,1}
	local t = {}
	for i = 1,2 do
		t[i] = self[i][1]*u[1] + self[i][2]*u[2] + self[i][3]*u[3]
	end
	return unpack(t)
end

local __mul
__mul = function (a,b)
	local t = {__call = __call, __mul = __mul}
	setmetatable(t,t)
	for i = 1,3 do
		t[i] = {}
		for j = 1,3 do
			t[i][j] = a[i][1]*b[1][j] + a[i][2]*b[2][j] + a[i][3]*b[3][j]
		end
	end
	return t
end

coord.trans = function (dx,dy)
	local t = {__call = __call, __mul = __mul}
	setmetatable(t,t)
	t[1] = { 1, 0, dx}
	t[2] = { 0, 1, dy}
	t[3] = { 0, 0,  1}
	return t
end

coord.rotate = function(theta)
	local t = {__call = __call, __mul = __mul}
	setmetatable(t,t)
	t[1] = { 	math.cos(theta),	-math.sin(theta),	0}
	t[2] = {	math.sin(theta), 	math.cos(theta),	0}
	t[3] = { 	0, 					0,  				1}
	return t
end

coord.scale = function (sx,sy)
	local t = {__call = __call, __mul = __mul}
	setmetatable(t,t)
	t[1] = { sx, 0, 0}
	t[2] = { 0, sy, 0}
	t[3] = { 0, 0,  1}
	return t
end

coord.shear = function (kx,ky)
	kx = kx or 1
	ky = ky or 1
	local t = {__call = __call, __mul = __mul}
	setmetatable(t,t)
	t[1] = { 1, kx, 0}
	t[2] = { ky, 1, 0}
	t[3] = { 0, 0,  1}
	return t
end

coord.polar = function (x,y)
	local r 	= (x^2 + y^2)^0.5
	local theta = math.atan2(y,x)
	return r,theta
end

coord.cart = function (r,theta)
	return r*math.cos(theta),r*math.sin(theta)
end

return coord