--[[
Copyright (c) 2012 Minh Ngo

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
--]]

local affine = {}

local mt

local __call = function (self,x,y)
	return 	self[1][1]*x + self[1][2]*y + self[1][3],
			self[2][1]*x + self[2][2]*y + self[2][3],
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

mt = {__call = __call, __mul = __mul}

affine.trans = function (dx,dy)
	local t = setmetatable({},mt)
	t[1] = { 1, 0, dx}
	t[2] = { 0, 1, dy}
	t[3] = { 0, 0,  1}
	return t
end

affine.rotate = function(theta)
	local t = setmetatable({},mt)
	t[1] = { 	math.cos(theta),	-math.sin(theta),	0}
	t[2] = {	math.sin(theta), 	math.cos(theta),	0}
	t[3] = { 	0, 					0,  				1}
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

affine.polar = function (x,y)
	local r 	= (x^2 + y^2)^0.5
	local theta = math.atan2(y,x)
	return r,theta
end

affine.cart = function (r,theta)
	return r*math.cos(theta),r*math.sin(theta)
end

return affine