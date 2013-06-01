-- Affine v1.01c

local affine = {}

local mt

local __call = function (self,x,y)
	return 	self[1][1]*x + self[1][2]*y + self[1][3],
			self[2][1]*x + self[2][2]*y + self[2][3]
end

local __mul = function (a,b)
	local t = setmetatable({},mt)
	for i = 1,3 do
		t[i] = {}
		for j = 1,3 do
			t[i][j] = a[i][1]*b[1][j] + a[i][2]*b[2][j] + a[i][3]*b[3][j]
		end
	end
	return t
end

local __pow = function (a,b)
	if b == -1 then
		return affine.inverse(a)
	elseif b == 0 then
		return a/a
	else
		local c = a
		for i = 2,b do
			c = c*a
		end
		return c
	end
end

local __div = function (a,b)
	return a*affine.inverse(b)
end

mt = {__call = __call, __mul = __mul,__pow = __pow,__div = __div}

affine.matrix = function (a, b, c, d, e, f) -- svg style
	local t = setmetatable({},mt)
	t[1] = { a or 1, c or 0, e or 0}
	t[2] = { b or 0, d or 1, f or 0}
	t[3] = {      0,      0,      1}
	return t
end

affine.trans = function (dx,dy)
	local t = setmetatable({},mt)
	t[1] = { 1, 0, dx}
	t[2] = { 0, 1, dy}
	t[3] = { 0, 0,  1}
	return t
end

affine.rotate = function(theta)
	local t = setmetatable({},mt)
	t[1] = {math.cos(theta),-math.sin(theta), 0}
	t[2] = {math.sin(theta), math.cos(theta), 0}
	t[3] = {0,            0,                  1}
	return t
end

affine.scale = function (sx,sy)
	local t = setmetatable({},mt)
	t[1] = { sx, 0, 0}
	t[2] = { 0, sy, 0}
	t[3] = { 0, 0,  1}
	return t
end

affine.shear = function (kx,ky)
	local t = setmetatable({},mt)
	t[1] = { 1, kx, 0}
	t[2] = { ky, 1, 0}
	t[3] = { 0, 0,  1}
	return t
end

affine.inverse = function (u)
	local t = setmetatable({},mt)
	local a = u[1][1]
	local b = u[1][2]
	local c = u[2][1]
	local d = u[2][2]
	
	local det = a*d - b*c
	assert(det ~= 0, 'transformation is not invertible!')
	local f1 = ( d * u[1][3] + (-b) * u[2][3])/det
	local f2 = (-c * u[1][3] +   a  * u[2][3])/det
	
	t[1] = { d/det, -b/det, -f1}
	t[2] = {-c/det,  a/det, -f2}
	t[3] = {     0,      0,   1}
	return t
end

affine.polar = function (x,y)
	local r     = (x^2 + y^2)^0.5
	local theta = math.atan2(y,x)
	return r,theta
end

affine.cart = function (r,theta)
	return r*math.cos(theta),r*math.sin(theta)
end

return affine