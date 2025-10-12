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

input vector $t = (t_x, t_y, t_z)$, modify `m[3], m[7], m[11]`. Thus, the translation matrix would be:

<img width="222" height="124" alt="image" src="https://github.com/user-attachments/assets/1cb9a2e3-49e5-4a85-af22-6461827768a8" />

---
**Scalor Matrix**

input vector $s = (s_x, s_y, s_z)$, modify `m[0], m[5], m[10]`. Thus, the scalor matrix would be:

<img width="238" height="116" alt="image" src="https://github.com/user-attachments/assets/315bb1dd-836f-4978-86b1-101e1118f1d4" />

---
**Rotation Matrix**

input float `a` as rotation factor

<img width="366" height="345" alt="image" src="https://github.com/user-attachments/assets/4b554e1c-68f2-42c0-b179-f877a77043f7" />

---
### pnpoly

---
### bounding box

---
### Sutherland Hodgman algorithm
