-- A 2D coordinate transformation library.

-- load the library
a = require 'affine'

-- transformations:
-- all the following methods return a transformation table 
-- that can be called as a function to transform a point
T = a.trans(dx,dy)		-- translates a point by dx and dy
T = a.rotate(theta)		-- rotates a point by theta angle in radians
T = a.scale(sx,sy)		-- scales a point by sx and sy
T = a.shear(kx,ky)		-- shears a point by kx and ky

T(x,y) -- apply transformation to point (x,y)

-- conversions
r,theta = a.polar(x,y)		-- convert from cartesian to polar coordinate
x,y 	= a.cart(r,theta)	-- convert from polar to cartesian coordinate

-- use the * operator to combine transformations
-- order of transformation is from right to left
T = a.trans(dx,dy) * a.scale(sx,sy) 

-- apply scale then translation transformation to point (x,y)
T(x,y)

Example:

T	= a.trans(10,10) * a.scale(-1,-1)
x,y = T(10,10)

print(x,y) --> 0 0

T 	= a.scale(-1,-1) * a.trans(10,10)
x,y = T(10,10)

print(x,y) --> -20 -20