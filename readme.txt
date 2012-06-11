-- A 2D coordinate transformation library.

a = require 'affine'

-- transformations
T = a.trans(dx,dy)		-- return a function that translates a point by dx and dy
T = a.rotate(theta)		-- return a function that rotates a point by theta angle in radians
T = a.scale(sx,sy)		-- return a function that scales a point by sx and sy
T = a.shear(kx,ky)		-- return a function that shears a point by kx and ky

T(x,y) -- apply transformation to point (x,y)

-- conversions
r,theta = a.polar(x,y)		-- convert from cartesian to polar coordinate
x,y 	= a.cart(r,theta)	-- convert from polar to cartesian coordinate

-- use the * operator to combine transformations
-- order of transformation is from left to right
transf_new = a.trans(dx,dy) * a.scale(sx,sy) 

-- apply scale then translation transformation to point (x,y)
transf_new(x,y)

Example:

transf_new 	= a.trans(10,10) * a.scale(-1,-1)
x,y 		= transf_new(10,10)

print(x,y) --> 0 0

transf_new 	= a.scale(-1,-1) * a.trans(10,10)
x,y 		= transf_new(10,10)

print(x,y) --> -20 -20