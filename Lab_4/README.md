# Lab 4
follow instruction: https://hackmd.io/@lab31718/CGlab4

## functions completed
- [X] barycentric coordinates
- [X] Phong shading
- [X] Flat shading
- [X] Gouraud shading
- [X] Bonus: Texture Shader

## how to implement?
### Barycentric Coordinates 
`util::barycentric(Vector3 P, Vector4[] verts)`

reference:
* https://www.dowen.idv.tw/2016/09/12/%E9%87%8D%E5%BF%83%E5%BA%A7%E6%A8%99%E7%B3%BB%E7%B5%B1/
* https://blog.csdn.net/seizeF/article/details/92760068

barycentric coordinate of point `P` in triangle `ABC` is:

$P = {\lambda}_A A + {\lambda}_B B + {\lambda}_C C$

we can get 3 coefficient in the equation above by solving `u` and `v` in equation below:

$P - A = u * (B - A) + v * (C - A) $

then we have:

$P = (1 - u - v) * A + v * B + u * C $

where $(1 - u - v) = {\lambda}_A, v = {\lambda}_B, u = {\lambda}_C$

now, we have barycentric coordinates of screen space, we need to consider perspective divide (w). then we have **perspective-correct interpolation** as below:

$({\lambda}_A attribute_A/wA + {\lambda}_B attribute_B/wB + {\lambda}_C attribute_C/wC)/({\lambda}_A/wA + {\lambda}_B/wB + {\lambda}_C/wC) $

![image](/Lab_4/data/checker.png)

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

---
### Bonus: Texture Shader
`Material::TextureMaterial`, `ColorShader::TextureVertexShader`, `ColorShader::TextureFragmentShader`

Inherit from `Material` and `Shader`.

In `TextureMaterial`constructor, add `selectFile()` and `loadImage(path)` to load texture file. Also, passing `uv` of triangle to `VertexShader`, passing `texture` to `FragmentShader`.

In `VertexShader`, return `uv` for latter interpolation. In `FragmentShader`, using interpolated `uv` to compute corresponding pixel coordinates `(tx, ty)` in `texture`. Noted that `pixels` are stored in one-dimensional array, thus we accessed them using index `ty * texture.width + tx`.

Also, in `Renderer.pde`, add case `TM` in `materialButton`. The order is `Phong` -> `Texture` -> `Depth` -> `Flat` -> `Gouraud`.

![image](/Lab_4/data/block.png)
![image](/Lab_4/data/glass.png)
![image](/Lab_4/data/road.png)

## used LLM as assistance
First I readed codes of classes `Material`, `Shader`, `Mesh`, but I did not really understand them. Then, I asked `ChatGPT` about relation between three classes, figuring out the structure with LLM.
