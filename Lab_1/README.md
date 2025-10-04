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

Using "mid-point line algorithm", `sx` and `sy` represent direction (+ or -) of x and y of the given line. There are two cases. In the first one, when `dy <= dx`, x is the driving axis. Update x every step, using mid-point to determine whether we should update y or not. On the other hand, when `dx <= dy`, y is the driving axis. Update y every step, using mid-point to determine whether we should update x or not.

#### circle algorithm
reference: <https://medium.com/@dillihangrae/mid-point-circle-algorithm-84f5971dcd08>

Using "mid-point circle algorithm". Given center point `(x, y)` and radius `r`, starting at the top of the circle, which is  (x, y+r). Only need to calculate pixels form `pi/4` ~ `pi/2` (i.e. `45°` ~ `90°`). At each iteration, ploting 8 points every step based on symmetry (x-axis, y-axis, line with slope 1, line with slope -1).

#### ellipse algorithm
reference: <https://www.geeksforgeeks.org/dsa/midpoint-ellipse-drawing-algorithm/>

Using "mid-point ellipse algorithm". Given center point `(x, y)` and 2 axis `r1`, `r2`. Separate curve of first quadrant into region 1 and 2 via tangent. When tangent < -1, choose `E` or `SE` to be next pixel according to mid-point decission parameter. When tangent > -1, choose `S` or `SE` to be next pixel according to mid-point decission parameter. Then plot 4 points every step based on symmetry (x-axis, y-axis).



#### Cubic Bezier Curve algorithm
reference: <https://www.geeksforgeeks.org/dsa/cubic-bezier-curve-implementation-in-c/>

follow formulae: 

`x(u) = (1-u)^3 * x1 + 3 * u * (1-u)^2 * x2 + 3 * u^2 * (1-u) * x3 + u^3 * x4`

`y(u) = (1-u)^3 * y1 + 3 * u * (1-u)^2 * y2 + 3 * u^2 * (1-u) * y3 + u^3 * y4`

where x1~x4 and y1~y4 represent coordinates of given points.

#### eraser
use nested loop to plot every pixel with color(250) in the area bounded by p1 and p2 (2 vectors)

## used LLM as assistance
After reading the references websites and writing my own codes, if it still could not work, I would past my code to ChatGPT and explained problems that I encountered so far, asking it where I need to modify to make it right.
