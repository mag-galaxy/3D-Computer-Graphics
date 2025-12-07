# Lab 3
follow instruction: https://hackmd.io/@lab31718/CGlab3

## functions completed
- [X] 3 transformation matrices
- [X] depth buffer
- [X] camera control
- [X] backculling

## how to implement?
### 3 transformation matrices
**Model Transformation (Model Matrix)** `GameObject::Matrix4 localToWorld()`
inverse of `worldToLocal()`, the Model Matrix is defined as <img width="476" height="21" alt="image" src="https://github.com/user-attachments/assets/1bab5dd1-1a6a-4b40-b402-c1d8dc77ae65" />


**Camera Transformation (View Matrix)** `Camera::void setPositionOrientation(Vector3 pos, Vector3 lookat)`
`pos` is the position of eyes, `lookat` is the point the eye is looking at. 

<img width="502" height="26" alt="image" src="https://github.com/user-attachments/assets/7d6a18bd-95e2-4194-9f0f-25f8b8fa6c6f" />


<img width="317" height="16" alt="image" src="https://github.com/user-attachments/assets/5b389231-1711-4fb0-aba8-cbb1bbfabde2" />

 
 and general rotation matrix is defined as 
 
 <img width="230" height="93" alt="image" src="https://github.com/user-attachments/assets/834b9ca8-d986-4677-baa0-b12e7a98139a" />


the View Matrix is defined as <img width="282" height="24" alt="image" src="https://github.com/user-attachments/assets/5d2e5b29-9072-4f8c-a3d4-be7ffa62ee86" />


**Perspective Rendering (Projection Matrix)** `Camera::setSize(int w, int h, float n, float f)`
reference:
* https://www.youtube.com/watch?v=U0_ONQQ5ZNM

the Projection Matrix is defined as 

<img width="748" height="83" alt="image" src="https://github.com/user-attachments/assets/ac55c116-74ed-4ba7-b329-2298c61b6c25" />


---
### depth buffer `util::getDepth(float x, float y, Vector3[] vertex)`
first, calculate the plane equation of given vertices (only 3 vertices are needed). then plug in the given `(x,y)`, and we will get the corrosponding `z`.

select 3 points (vertices) form `vertex`: `a, b, c`. 

<img width="111" height="27" alt="image" src="https://github.com/user-attachments/assets/f4e8a1ca-ff25-433e-9c87-83744b8a678e" />


<img width="381" height="22" alt="image" src="https://github.com/user-attachments/assets/2da5110b-461c-4cd6-968b-901633bdf183" />


---
### camera control `HW3::keyPressed()`
reference:
* https://processing.org/reference/keyPressed_.html

use `Q, E, W, S, A, D` to control the camera horizontally or vertically, coordinates of camera position and the point it is looking at need to be updated at the same time

| Key Pressed | Effect |
| ----------- | ------------- |
| Q | camera moves up  |
| E | camera moves down |
| A | camera moves left |
| D | camera moves right |
| W | camera moves forward |
| S | camera moves backward |

---
### backculling `GameObject::debugDraw()`
reference:
* https://learnopengl.com/Advanced-OpenGL/Face-culling
* https://www.tutorialspoint.com/computer_graphics/computer_graphics_back_face_culling.htm

find normal vectors of triangles of the mesh, then calculate $ \vec{norm} \cdot \vec{eye} $ . if it is greater than `0`, which means the angle between normal vector and eye vector (from face to camera) is smaller than `90°`, then the triangle is a front face. draw lines. otherwise, it is a back face. do not draw lines.

## YouTube DEMO Video
link: <https://youtu.be/NE1tb68EwCg>

## used LLM as assistance
after implementing tasks by myself, if it did not work and I could not find solutions by myself nor on the Internet either, I would explain the problem and ask `Gemini` for help
