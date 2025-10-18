# Lab 2
follow instruction: https://hackmd.io/@lab31718/CGlab2

modify Matrix4.pde and util.pde

## functions completed
- [X] 3 transformation matrices
- [X] `pnpoly`
- [ ] bounding box
- [ ] Sutherland Hodgman algorithm

## struction of class `Matrix4`
Matrix4: a 4x4 matrix, 16 elements are stored in array`m` (m[0] to m[15])
Constuctors: `Matrix4()`, `Matrix4(float b)`, `Matrix4(Vector3 a, Vector3 b, Vector3 c)`

## how to implement?
### 3 transformation matrices
reference:
* https://www.brainvoyager.com/bv/doc/UsersGuide/CoordsAndTransforms/SpatialTransformationMatrices.html

In `Matrix4.ped`, directly modify array `m` (because those transformation methods are void), which represents 16 elements of the 4x4 matrix, treat it as translation matrix, scalor matrix, rotation matrix

**Translation Matrix**

input vector $t = (t_x, t_y, t_z)$, modify `m[3], m[7], m[11]`. Thus, the translation matrix would be:

<img width="222" height="124" alt="image" src="https://github.com/user-attachments/assets/1cb9a2e3-49e5-4a85-af22-6461827768a8" />

---
**Scalor Matrix**

input vector $s = (s_x, s_y, s_z)$, modify `m[0], m[5], m[10]`. Thus, the scalor matrix would be:

<img width="238" height="116" alt="image" src="https://github.com/user-attachments/assets/315bb1dd-836f-4978-86b1-101e1118f1d4" />

---
**Rotation Matrix**

input float `a` as rotation factor

<img width="361" height="346" alt="image" src="https://github.com/user-attachments/assets/a088b65c-5792-46c1-833c-cfa03dc584ed" />


---
### pnpoly
reference:
* https://www.geeksforgeeks.org/dsa/how-to-check-if-a-given-point-lies-inside-a-polygon/

First check structure of `Vector3[] vertexes` through `print`, vertexes = [(a.x, a.y, a.z), (b.x, b.y, b.z)...]

Use Rat Casting to determine whether a point(x, y) is inside a given polygon or not. Set up initial value of variables, `boolean inside` is used to record how many times the horizontal line `y` intersects with polygon edges. If count of intersects is odd, then (x, y) is inside the polygon (or on the edge), on the other hand, if count of intersects is even, then (x, y) is outside the polygon. Initial value of `inside` is `false`, each time we find an intersection, flip the value of variable `inside`. At the end, return `inside`.

In each iteration, `(x1, y1)` and `(x2, y2)` create a line, which is an edge of the polygon. Check if `y > min(y1, y2)`, if `y <= max(y1, y2)`, if `x <= max(x1, x2)` in order, then calculate x value of intersection point of horizontal line `y` and the line between (x1, y1), (x2, y2). If `x1==x2`, it's a vertical line, there must exists an intersection point. If `x <= x_intersection`, there also exists an intersection point. Flip value of `inside`.

---
### bounding box
given series of vertices v, again, check structure of `Vector3[] v` through `print`, v = [(a.x, a.y, a.z), (b.x, b.y, b.z)...]

We need to find min X , min Y, max X, max Y of those vertices.Set 4 variables to store 4 values listed above. To find a min value, initialize variable with max value a float can store, in contrast, to find a max value, initialize variable with min value a float can store. Then travere all vertices via loop, do comparison each iteration. At the end, return a vector with min X and min Y, another vector with max X and max Y.

---
### Sutherland Hodgman algorithm
