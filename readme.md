# Affine

Affine is simple 2D transformation library for Lua.

To load the library: `a = require 'affine'`

## Transformations

All transformation functions return a table `T` that stores the affine transformation matrix. The table `T` can be called as a function to transform a given point (x,y): 

`x',y' = T(x,y)`

----------------------------
### Translation

Return a table that stores the translation transformation.

`T = a.trans(dx,dy)`

	x' = x + dx
	y' = y + dy

----------------------------
### Scaling

Return a table that stores the scaling transformation. Scaling is with respect to the origin.

`T = a.scale(sx,sy)`

	x' = x * sx
	y' = y * sy

----------------------------
### Rotation

Return a table that stores the rotation transformation. Rotation is in radians with respect to the origin.

`T = a.rotate(theta)`

	x' = x*cos(theta) - y*sin(theta)
	y' = x*sin(theta) + y*cos(theta)

----------------------------
### Shearing

Return a table that stores the shearing transformation.

`T = a.shear(kx,ky)`

	x' = x + kx*y
	y' = y + ky*x

----------------------------
### Inversion

Return a table `IT` that has the inverse transformation of `T`.

`IT = a.inverse(T)`

Example:

````lua
T	= a.shear(kx,ky)
IT	= a.inverse(T)

x2,y2 = IT(T(x,y))

print(x2,y2) -- should be the same as x,y
````

## Combining Transformations

You can compose transformation tables into a new transformation table by using the `*` operator. Like matrix multiplication, the order in which you multiply transformations matters.

Example:

````lua
T1 = a.trans(dx,dy)
T2 = a.scale(sx,sy)
T3 = T1 * T2

x2,y2 = T3(x,y)
x2,y2 = T1(T2(x,y)) -- is the same as above
````

## Conversions

The following functions can be used to transform between polar and cartesian coordinates. Angles are in radians measured from the +x axis.

Convert from cartesian to polar coordinate:

	r,theta	= a.polar(x,y)

Convert from polar to cartesian coordinate:

	x,y = a.cart(r,theta)