public void CGLine(float x1, float y1, float x2, float y2) {
    // TODO HW1
    // Please paste your code from HW1 CGLine.
    // start pointA(x1, y1), end pointB(x2, y2)
    int dx = abs(int(x2 - x1));
    int dy = abs(int(y2 - y1));
    
    int sx = (x2 >= x1) ? 1 : -1;  // x of vector A->B is + or -
    int sy = (y2 >= y1) ? 1 : -1;  // y of vector A->B is + or -
    
    int x = int(x1);
    int y = int(y1);
    drawPoint(x, y, 0);  // initial point
    
    if(dy <= dx){ // 0 < abs(slope) <= 1
        int d = 2*dy - dx; // initial condition
        for(int i = 0; i < dx; i++){
            x = x + sx;
            if(d < 0){  // choose E
                d = d + 2*dy;
            }
            else{  // choose NE
                d = d + 2*(dy - dx);
                y = y + sy;
            }
            drawPoint(x, y, color(0));
        }
    }
    else if(dx <= dy){ // abs(slope) > 1
        int d = 2*dx - dy; // initial condition
        for(int i = 0; i < int(dy); i++){
            y = y + sy;
            if(d < 0){  // choose N
                d = d + 2*dx;
            }
            else{  // choose NE
                d = d + 2*(dx - dy);
                x = x + sx;
            }
            drawPoint(x, y, color(0));
        }
    }
}

public boolean outOfBoundary(float x, float y) {
    if (x < 0 || x >= width || y < 0 || y >= height)
        return true;
    return false;
}

public void drawPoint(float x, float y, color c) {
    int index = (int) y * width + (int) x;
    if (outOfBoundary(x, y))
        return;
    pixels[index] = c;
}

public float distance(Vector3 a, Vector3 b) {
    Vector3 c = a.sub(b);
    return sqrt(Vector3.dot(c, c));
}

boolean pnpoly(float x, float y, Vector3[] vertexes) {
    // TODO HW2 
    // You need to check the coordinate p(x,v) if inside the vertices. 
    // If yes return true, vice versa.

    return false;
}

public Vector3[] findBoundBox(Vector3[] v) {
    
    
    // TODO HW2 
    // You need to find the bounding box of the vertices v.
    // r1 -------
    //   |   /\  |
    //   |  /  \ |
    //   | /____\|
    //    ------- r2

    Vector3 recordminV = new Vector3(0);
    Vector3 recordmaxV = new Vector3(999);
    Vector3[] result = { recordminV, recordmaxV };
    return result;

}

public Vector3[] Sutherland_Hodgman_algorithm(Vector3[] points, Vector3[] boundary) {
    ArrayList<Vector3> input = new ArrayList<Vector3>();
    ArrayList<Vector3> output = new ArrayList<Vector3>();
    for (int i = 0; i < points.length; i += 1) {
        input.add(points[i]);
    }

    // TODO HW2
    // You need to implement the Sutherland Hodgman Algorithm in this section.
    // The function you pass 2 parameter. One is the vertexes of the shape "points".
    // And the other is the vertices of the "boundary".
    // The output is the vertices of the polygon.

    output = input;

    Vector3[] result = new Vector3[output.size()];
    for (int i = 0; i < result.length; i += 1) {
        result[i] = output.get(i);
    }
    return result;
}
