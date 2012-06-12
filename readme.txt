-- A 2D coordinate transformation library.

-- load the library
a = require 'affine'

-- transformations:
-- all the following methods return a transformation table
-- that can be called as a function to transform a point

-- translate a point by dx and dy
T = a.trans(dx,dy)

-- rotate counter clockwise from the origin in radians when x+ is right and y+ is up
T = a.rotate(theta)

-- scale a point with respect to the origin where sx and sy are the scale factor for x and y, respectively
T = a.scale(sx,sy)

-- shear a point where kx and ky are the shear factor for x and y, respectively
T = a.shear(kx,ky)

-- return the inverse of transformation table T
T = a.inverse(T)

-- apply transformation to point (x,y)
T(x,y)

-- conversions
r,theta	= a.polar(x,y)		-- convert from cartesian to polar coordinate
x,y		= a.cart(r,theta)	-- convert from polar to cartesian coordinate

-- use the * operator to combine transformations into a new transformation table
-- order of transformation is from right to left
T = a.trans(dx,dy) * a.scale(sx,sy)

Example:

T	= a.trans(10,10) * a.scale(-1,-1)
IT	= a.inverse(T)

x,y = T(10,10)

print(x,y) --> 0 0

x,y = (IT*T)(10,10)

print(x,y) --> 10 10

T	= a.scale(-1,-1) * a.trans(10,10)
x,y	= T(10,10)

print(x,y) --> -20 -20