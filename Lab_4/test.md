# Lab 4
follow instruction: https://hackmd.io/@lab31718/CGlab4

## functions completed
- [X] barycentric coordinates
- [X] Phong shading
- [X] Flat shading
- [X] Gouraud shading

## how to implement?
### Barycentric Coordinates 
`util::barycentric(Vector3 P, Vector4[] verts)`

reference:
* https://www.dowen.idv.tw/2016/09/12/%E9%87%8D%E5%BF%83%E5%BA%A7%E6%A8%99%E7%B3%BB%E7%B5%B1/

barycentric coordinate of point `P` in triangle `ABC` is:

$P = {\lambda}_A A + {\lambda}_B B + {\lambda}_C C$

we can get 3 coefficient in the equation above by solving `u` and `v` in equation below:

$P - A = u * (B - A) + v * (C - A) $

then we have:

$P = (1 - u - v) * A + v * B + u * C $

---
### 3 shading
`GameObject` calls `Material`, `Material` determines what  necessary parameters should be passed to the `ColorShaders`. `VertexShader` passes variables that need to be interpolated to `GameObject`, after interpolation, results are passed to `FragmentShader`. `FragmentShader` passes results of **Phong lighting** to `GamdObject`

lighting function is the same for 3 shading method (Phong lighting = ambient + diffuse + specular), but in different part of shader

$ambient = I_a * K_a $

$diffuse = I_p * K_d * max(0, \vec N \cdot \vec L) $

$specular = I_p * K_s * (max(0, \vec R \cdot \vec V))^m $

$lighting = ambient + diffuse + specular $

---
### Phong shading
`Material::PhongMaterial`, `ColorShader::PhongVertexShader`, `ColorShader::PhongFragmentShader`

reference:
* https://cg2010studio.com/2011/11/01/flat%E3%80%81gouraud%E3%80%81phong-shading%E7%9A%84%E5%B7%AE%E5%88%A5-comparison-flat-gouraud-phong-shading/
* https://www.geeksforgeeks.org/computer-graphics/phong-shading-computer-graphics/

We pass `normal`, `position` and `modle matrix` from material to `VertexShader`, compute its `world normal` and `world position`. Then **do interpolation on normals**, return results to `FragmentShader` and calculate lighting using interpolated normals and relative parameters passed from material (Ka, Kd, Ks, m...).

![image](/Lab_4/data/phong.png)

---
### Flat shading
`Material::FlatMaterial`, `ColorShader::FlatVertexShader`, `ColorShader::FlatFragmentShader`

reference:
* https://www.geeksforgeeks.org/computer-graphics/constant-intensity-shading-in-computer-graphics/

We pass `normal`, `position` and `modle matrix` from material to `VertexShader`, **compute `world normal` and `world position` of one point**. Then in `FragmentShader`, calculate lighting using interpolated normal and relative parameters passed from material (Ka, Kd, Ks, m...).

![image](/Lab_4/data/flat.png)

---
### Gouraud shading
`Material::GouraudMaterial`, `ColorShader::GouraudVertexShader`, `ColorShader::GouraudFragmentShader`

reference:
* https://www.geeksforgeeks.org/computer-graphics/gouraud-shading-in-computer-graphics/

We pass `normal`, `position` and `modle matrix` from material to `VertexShader`, compute its `world normal` and `world position`. Compute lighting (color) in `VertexShader`, then **do interpolation on lighting (color)**. In `FragmentShader`, directly return results of color interpolation.

![image](/Lab_4/data/gouraud.png)

## used LLM as assistance
Asked `ChatGPT` about relation between classes `Material` and `Shader` at the begining, figuring out the structure with LLM.
