# Lab 1
follow instruction: https://hackmd.io/@lab31718/CGlab1

## functions completed
- [X] line algorithm
- [X] circle algorithm
- [X] ellipse algorithm
- [X] curve algorithm
- [X] eraser

## how to implement?
#### line algorithm
reference: <https://www.geeksforgeeks.org/dsa/mid-point-line-generation-algorithm/>

reference: <https://www.geeksforgeeks.org/dsa/bresenhams-line-generation-algorithm/>

Using "Bresenhams line algorithm", the main idea is as same as the mid-point line algorithm, but we try to avoid floating point computation(see formulae listed below). `sx` and `sy` represent direction (+ or -) of x and y of the given line. There are two cases. In the first one, when `dy <= dx`, x is the driving axis. Update x every step, using mid-point to determine whether we should update y or not. On the other hand, when `dx <= dy`, y is the driving axis. Update y every step, using mid-point to determine whether we should update x or not.

We have two points $(x_1, y_1)$ , $(x_2, y_2)$ and a line function: $y = m * x + c$ where $m = (y_2 - y_1)/(x_2 -x_1)$

Insert point $(x_1, y_1)$ into line function => $c = y_1 - m*x_1$

Insert constant `c` into line function => $y - m * x - (y_1 - m * x_1) = 0$ => $y - y_1 = m*(x - x_1)$

Insert slope `m` => $y - y_1 = ((y_2 - y_1)/(x_2 - x_1))*(x - x_1)$

Multiply $(x_2 - x_1)$ at both side => $y*(x_2 - x_1) - y_1*(x_2 - x_1) = (y_2 - y_1)*x - (y_2 - y_1)*x_1$

Derive it => $y*(x_2 - x_1) - (y_2 - y_1)*x - (x_2 * y_1 - x_1 * y_2) = 0$

Let $dy = A = (y_1 - y_2) , -dx = B = (x_1 - x_2), C = x_1 * y_2 - x_2 * y_1$, then we have $F(x,y)=A * x + B * y + C$

Because y might be 0.5 in mid-point, we multiply 2, so it becomes $F(x,y)=2 * A * x + 2 * B * y + 2 * C$

Initial condition: $F(x_1 + 1,y_1 + 0.5) = 2 * A * x_1 + 2 * A + 2 * B * y_1 + B + 2 * C = 2 * A + B = 2 * dy - dx$

Previous mid-point:

If we choose E: 

---
#### circle algorithm
reference: <https://medium.com/@dillihangrae/mid-point-circle-algorithm-84f5971dcd08>

Using "mid-point circle algorithm". Given center point `(x, y)` and radius `r`, starting at the top of the circle, which is  (x, y+r). Only need to calculate pixels form `pi/4` ~ `pi/2` (i.e. `45°` ~ `90°`). At each iteration, ploting 8 points every step based on symmetry (x-axis, y-axis, line with slope 1, line with slope -1). Avoid floating point computation vai assigning all parameters as integer type.

---
#### ellipse algorithm
reference: <https://www.geeksforgeeks.org/dsa/midpoint-ellipse-drawing-algorithm/>

Using "mid-point ellipse algorithm". Given center point `(x, y)` and 2 axis `r1`, `r2`. Separate curve of first quadrant into region 1 and 2 via tangent. When tangent < -1, choose `E` or `SE` to be next pixel according to mid-point decission parameter. When tangent > -1, choose `S` or `SE` to be next pixel according to mid-point decission parameter. Then plot 4 points every step based on symmetry (x-axis, y-axis).

---
#### Cubic Bezier Curve algorithm
reference: <https://www.geeksforgeeks.org/dsa/cubic-bezier-curve-implementation-in-c/>

follow formulae: 

$x(u) = (1-u)^3 * x_1 + 3 * u * (1-u)^2 * x_2 + 3 * u^2 * (1-u) * x_3 + u^3 * x_4$

$y(u) = (1-u)^3 * y_1 + 3 * u * (1-u)^2 * y_2 + 3 * u^2 * (1-u) * y_3 + u^3 * y_4$

where x and y represent coordinates of given points.

---
#### eraser
use nested loop to plot every pixel with color(250) in the area bounded by p1 and p2 (2 vectors)

## used LLM as assistance
After reading the references websites and writing my own codes, if it still could not work, I would past my code to ChatGPT and explained problems that I encountered so far, asking it where I need to modify to make it right.
