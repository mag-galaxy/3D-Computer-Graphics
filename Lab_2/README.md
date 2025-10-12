# Lab 2
follow instruction: https://hackmd.io/@lab31718/CGlab2

modify Matrix4.pde and util.pde

## functions completed
- [ ] 3 transformation matrices
- [ ] `pnpoly`
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
input vector $t = t_x, t_y, t_z$

translation uses `m[3], m[7], m[11]`. Thus, the translation matrix would be:

\begin{bmatrix}
    1 & 0 & 0 & $t_x$ \\
    0 & 1 & 0 & $t_x$ \\
    0 & 0 & 1 & $t_x$ \\
    0 & 0 & 0 & 1 
\end{bmatrix}

**Scalor Matrix**
input vector $s = s_x, s_y, s_z$

scalor uses `m[0], m[5], m[10]`. Thus, the scalor matrix would be:

\begin{bmatrix}
    $s_x$ & 0 & 0 & 0 \\
    0 & $s_y$ & 0 & 0 \\
    0 & 0 & $s_z$ & 0 \\
    0 & 0 & 0 & 1 
\end{bmatrix}

**Rotation Matrix**

---
### pnpoly

---
### bounding box

---
### Sutherland Hodgman algorithm