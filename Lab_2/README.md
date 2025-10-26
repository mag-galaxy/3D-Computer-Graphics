# Lab 2
follow instruction: https://hackmd.io/@lab31718/CGlab2

modify Matrix4.pde and util.pde

## functions completed
- [X] 3 transformation matrices
- [X] `pnpoly`
- [X] bounding box
- [X] Sutherland Hodgman algorithm

## struction of class `Matrix4`
Matrix4: a 4x4 matrix, 16 elements are stored in array`m` (m[0] to m[15])
Constuctors: `Matrix4()`, `Matrix4(float b)`, `Matrix4(Vector3 a, Vector3 b, Vector3 c)`

## how to implement?
### 3 transformation matrices
reference:
* https://www.brainvoyager.com/bv/doc/UsersGuide/CoordsAndTransforms/SpatialTransformationMatrices.html

In `Matrix4.ped`, directly modify array `m` (because those transformation methods are void), which represents 16 elements of the 4x4 matrix, treat it as translation matrix, scalor matrix, rotation matrix.

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

Use **Rat Casting** to determine whether a point(x, y) is inside a given polygon or not. Set up initial value of variables, `boolean inside` is used to record how many times the horizontal line `y` intersects with polygon edges. If count of intersections is odd, then (x, y) is inside the polygon (or on the edge), on the other hand, if count of intersections is even, then (x, y) is outside the polygon. Initial value of `inside` is `false`, each time we find an intersection, flip the value of variable `inside`. At the end, return `inside`.

In each iteration, `(x1, y1)` and `(x2, y2)` create a line, which is an edge of the polygon. Check if `y > min(y1, y2)`, if `y <= max(y1, y2)`, if `x <= max(x1, x2)` in order, then calculate x value of intersection point of horizontal line `y` and the line between (x1, y1), (x2, y2). If `x1==x2`, it's a vertical line, there must exists an intersection point. If `x <= x_intersection`, there also exists an intersection point. Flip value of `inside`.

---
### bounding box
Given series of vertices v, again, check structure of `Vector3[] v` through `print`, v = [(a.x, a.y, a.z), (b.x, b.y, b.z)...]

We need to find `min X` , `min Y`, `max X`, `max Y` among those vertices. Set 4 variables to store 4 values listed above. To find a min value, initialize variable with max value a float can store, in contrast, to find a max value, initialize variable with min value a float can store. Then travere all vertices via loop, do comparison each iteration. At the end, return a vector with `min X` and `min Y`, another vector with `max X` and `max Y`.

---
### Sutherland Hodgman algorithm
reference:
* https://www.geeksforgeeks.org/dsa/polygon-clipping-sutherland-hodgman-algorithm/
* https://www.geeksforgeeks.org/maths/point-of-intersection-of-two-lines-formula/

Input parameters `Vector3[] points`: points of the polygon, `Vector3[] boundary`: points of the clipping window. both are given in counterclockwise order.

Local variables `ArrayList<Vector3> input`: input vertices of each pass, `ArrayList<Vector3> output`: output vertices of each pass. The `input` of first pass equals to `points`.

In this nested loop, the outter one is for each line (2 points) of clipping window (`boundary`), the inner one is for each line (2 points) of current polygon (`input`). `Pk` is the current input point, and `Pl` is the next input point. At each iteration of inner loop, compute vector `A->B`, `A->Pk`, `A-Pl`. Then check if `Pk` and `Pl` are inside the clipping window. Note that the coordinate system of computer graphics is that x-axis increases to the right, while y-axis increases downward. Thus, if (A_B.x * A_Pk.y - A_B.y * A_Pk.x) < 0, `Pk` lies inside the boundary, otherwise, if it is > 0, `Pk` lies outside the boundary.

After that, there four cases of position of two points `Pk` and `Pl`. Case 1: inside to inside, then add `Pl` to the output. Case 2: outside to inside, then add intersection point and `Pl` in order. Case 3: inside to outside, then add intersection point only. Case 4: outside to outside, do nothing.

At the end of each iteration, copy the contents of output to the input. Note that we cannot use `input = output` directly. Finally, return `output` of last iteration.

I wrote an additional function `intersection` for calculating intersection point of two lines. Please see the second reference.

## YouTube DEMO Video
link: <https://youtu.be/DJb7IB1640Q>

## used LLM as assistance
First I read the references websites. If I could not understand algorithms, I would ask `ChatGPT` to explain it. Then I wrote codes to implement the function, if it could not work, I would past my code to ChatGPT and typed problems that I encountered so far, asking it where I need to modify to make it right.
