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
directly modify array `m` (because those transformation methods are void), which represents 16 elements of the 4x4 matrix, treat it as translation matrix, scalor matrix, rotation matrix

---
### pnpoly

---
### bounding box

---
### Sutherland Hodgman algorithm