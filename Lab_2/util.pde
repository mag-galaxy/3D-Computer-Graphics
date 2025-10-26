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
    
    //print(vertexes);
    // vertexes = [(a.x, a.y, a.z), (b.x, b.y, b.z)...]
    int n = vertexes.length;
    float x1 = vertexes[0].x, y1 = vertexes[0].y;
    float x2, y2;
    boolean inside = false;
    for(int i = 1; i <= n; ++i){
        // next point: (x2, y2)
        x2 = vertexes[i % n].x;
        y2 = vertexes[i % n].y;
        if(y > min(y1, y2)){
            if(y <= max(y1, y2)){
                if(x <= max(x1, x2)){
                    float x_intersection = x1 + (y-y1) * (x2-x1) / (y2-y1);
                    if(x1 == x2 || x <= x_intersection){
                        inside = !inside;
                    }
                }
            }
        }
        x1 = x2;
        y1 = y2;
    }
    return inside;
}

public Vector3[] findBoundBox(Vector3[] v) {
    // TODO HW2 
    // You need to find the bounding box of the vertices v.
    // r1 -------
    //   |   /\  |
    //   |  /  \ |
    //   | /____\|
    //    ------- r2
    
    //print(v);
    // v = [(a.x, a.y, a.z), (b.x, b.y, b.z)...]
    float minX = Float.MAX_VALUE, minY = Float.MAX_VALUE, maxX = -Float.MAX_VALUE, maxY = -Float.MAX_VALUE;
    for(int i = 0; i < v.length; ++i){
        if(v[i].x <= minX){minX = v[i].x;}
        if(v[i].y <= minY){minY = v[i].y;}
        if(v[i].x >= maxX){maxX = v[i].x;}
        if(v[i].y >= maxY){maxY = v[i].y;}
    }
    
    Vector3 recordminV = new Vector3(minX, minY, 0);
    Vector3 recordmaxV = new Vector3(maxX, maxY, 0);
    Vector3[] result = { recordminV, recordmaxV };
    return result;
}

public Vector3 intersection(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4){
    //calculate intersection point of line (x1,y1)-(x2,y2) and line (x3,y3)-(x4,y4)
    float a1 = y2 - y1, b1 = x1 - x2, c1 = - (a1 * x1 + b1 * y1);
    float a2 = y4 - y3, b2 = x3 - x4, c2 = - (a2 * x3 + b2 * y3);
    float d = a1 * b2 - a2 * b1;
    float x = (b1 * c2 - b2 * c1) / d;
    float y = (a2 * c1 - a1 * c2) / d;
    
    if (abs(d) < 1e-6) return null; // if d == 0
    
    Vector3 intersection_point = new Vector3(x, y, 0);
    return intersection_point;
}

public Vector3[] Sutherland_Hodgman_algorithm(Vector3[] points, Vector3[] boundary) {
    ArrayList<Vector3> input = new ArrayList<Vector3>();  // empty
    ArrayList<Vector3> output = new ArrayList<Vector3>();  // empty
    for (int i = 0; i < points.length; i += 1) {
        input.add(points[i]);  // input of firsr iteration equals to points
    }

    // TODO HW2
    // You need to implement the Sutherland Hodgman Algorithm in this section.
    // The function you pass 2 parameter. One is the vertexes of the shape "points".
    // And the other is the vertices of the "boundary".
    // The output is the vertices of the polygon.

    //print("this is input: ");
    //print(input);
    //print("this is boundary: ");
    //print(boundary);

    ///*
    for(int i = 0; i < boundary.length; ++i){
        int j = (i+1) % boundary.length;  // i, j are consecutive indexes of boundary
        Vector3 A = boundary[i];
        Vector3 B = boundary[j];
        output.clear();  // update output each pass, reset "output" to be empty
        
        for(int k = 0; k < input.size(); ++k){            
            int l = (k+1) % input.size();  // k, l are consecutive indexes of polygon, k -> l
            Vector3 Pk = input.get(k);  // current point of the current polygon
            Vector3 Pl = input.get(l);  // next point of the current polygon
            
            Vector3 A_B = new Vector3(B.x - A.x, B.y - A.y, B.z - A.z);
            Vector3 A_Pk = new Vector3(Pk.x - A.x, Pk.y - A.y, Pk.z - A.z);
            Vector3 A_Pl = new Vector3(Pl.x - A.x, Pl.y - A.y, Pl.z - A.z);
            
            // is the point inside (at left) of the boundary line?
            boolean k_pos = ((A_B.x * A_Pk.y - A_B.y * A_Pk.x) < 0);
            boolean l_pos = ((A_B.x * A_Pl.y - A_B.y * A_Pl.x) < 0);
            
            // inside to inside
            if(k_pos && l_pos){
                output.add(input.get(l));
            }
            // outside to inside
            else if(!k_pos && l_pos){
                output.add(intersection(A.x, A.y, B.x, B.y, Pk.x, Pk.y, Pl.x, Pl.y));
                output.add(input.get(l));
            }
            // inside to outside
            else if(k_pos && !l_pos){
                output.add(intersection(A.x, A.y, B.x, B.y, Pk.x, Pk.y, Pl.x, Pl.y));
            }
            // outside to outside
            else{
                // add nothing to the output
            }
        }
        input = new ArrayList<Vector3>(output);
        // the output of this round will be the input of next round
        // array uses pointer, cannot directly write "input = output"
    }
    //*/
    //output = input;
    Vector3[] result = new Vector3[output.size()];
    for (int i = 0; i < result.length; i += 1) {
        result[i] = output.get(i);
    }
    return result;
}
