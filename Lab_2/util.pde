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
    float numx = (x1 * y2 - y1 * x2) * (x3 - x4) - (x1 - x2) * (x3 * y4 - y3 * x4);
    float numy = (x1 * y2 - y1 * x2) * (y3 - y4) - (y1 - y2) * (x3 * y4 - y3 * x4);
    float den = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);
    
    Vector3 intersec_point = new Vector3(numx/den, numy/den, 0);
    return intersec_point;
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
    
    for(int i = 0; i < boundary.length; ++i){
        int j = (i+1) % boundary.length;  // i, j are consecutive indexes of boundary
        float x1 = boundary[i].x, y1 = boundary[i].y;
        float x2 = boundary[j].x, y2 = boundary[j].y;
        output.clear();
        
        for(int k = 0; k < input.size(); ++k){            
            //int l = (k+1) % input.size();  // k, l are consecutive indexes of polygon
            int l = (k + input.size() - 1) % input.size();
            float kx = input.get(k).x, ky = input.get(k).y;
            float lx = input.get(l).x, ly = input.get(l).y;
            
            // is the point inside of the boundary?
            float k_pos = (x2 - x1) * (ky - y1) - (y2 - y1) * (kx - x1);
            float l_pos = (x2 - x1) * (ly - y1) - (y2 - y1) * (lx - x1);
            
            // inside to inside
            if(k_pos < 0 && l_pos < 0){
                output.add(points[k]);
            }
            // outside to inside
            else if(k_pos >= 0 && l_pos < 0){
                output.add(intersection(x1, y1, x2, y2, kx, ky, lx, ly));
                output.add(points[k]);
            }
            // inside to outside
            else if(k_pos < 0 && l_pos >= 0){
                output.add(intersection(x1, y1, x2, y2, kx, ky, lx, ly));
            }
        }
        input = output;
    }    

    Vector3[] result = new Vector3[output.size()];
    for (int i = 0; i < result.length; i += 1) {
        result[i] = output.get(i);
    }
    return result;
}
