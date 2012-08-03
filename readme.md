# Affine

Affine is simple 2D transformation library for Lua.

To load the library: `a = require 'affine'`

## Transformations

All transformation functions return a table `T` that stores the 3x3 transformation matrix. Where i is the i-th row, and j is the j-th column, The value at (i,j) is stored in `T[i][j]`. The table `T` can be called as a function to transform a given point (x,y): `x2,y2 = T(x,y)`

Below each transformation function are the transformation formulas.

----------------------------
### Translation

Return a table that stores the translation transformation.

`T = a.trans(dx,dy)`

	x2 = x + dx
	y2 = y + dy

----------------------------
### Scaling

Return a table that stores the scaling transformation. Scaling is with respect to the origin.

`T = a.scale(sx,sy)`

	x2 = x * sx
	y2 = y * sy

----------------------------
### Rotation

Return a table that stores the rotation transformation. Rotation is in radians with respect to the origin.

`T = a.rotate(theta)`

	x2 = x*math.cos(theta) - y*math.sin(theta)
	y2 = x*math.sin(theta) + y*math.cos(theta)

----------------------------
### Shearing

Return a table that stores the shearing transformation.

`T = a.shear(kx,ky)`

	x2 = x + kx*y
	y2 = y + ky*x

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

## Transformation Operators

You can compose transformations into a new transformation by using the `*`,`/`, or `^` operator. To get the inverse transformation, you can do: `IT = T^-1` Negative,zero,and non-integer powers are undefined. For division: `A/B` is the same as `A*B^-1`

**Order of operation matters for multiplication and division!**

Example:

````lua
T1 = a.trans(10,10)
T2 = a.scale(-1,-1)
T3 = T1 * T2

x2,y2 = T3(10,10)

print(x2,y2) --> 0 0

T3 = T2 * T1

x2,y2 = T3(10,10)

print(x2,y2) --> -20 -20 // order of operation matters!
````

## Conversions

The following functions can be used to transform between polar and cartesian coordinates. Angles are in radians measured from the +x axis.

Convert from cartesian to polar coordinate:

	r,theta	= a.polar(x,y)

Convert from polar to cartesian coordinate:

	x,y = a.cart(r,theta)