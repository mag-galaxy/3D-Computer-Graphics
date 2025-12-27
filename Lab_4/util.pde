public void CGLine(float x1, float y1, float x2, float y2) {
    stroke(0);
    line(x1, y1, x2, y2);
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
    // You need to check the coordinate p(x,v) if inside the vertexes. 
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
    // You need to find the bounding box of the vertexes v.

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
    ArrayList<Vector3> input = new ArrayList<Vector3>();
    ArrayList<Vector3> output = new ArrayList<Vector3>();
    for (int i = 0; i < points.length; i += 1) {
        input.add(points[i]);
    }

    // TODO HW2
    // You need to implement the Sutherland Hodgman Algorithm in this section.
    // The function you pass 2 parameter. One is the vertexes of the shape "points".
    // And the other is the vertexes of the "boundary".
    // The output is the vertexes of the polygon.
    
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

public float getDepth(float x, float y, Vector3[] vertex) {
    // TODO HW3
    // You need to calculate the depth (z) in the triangle (vertex) based on the
    // positions x and y. and return the z value;
    
    // vertex defines a face, need 3 vertices for finding plane equation
    Vector3 a = vertex[0];
    Vector3 b = vertex[1];
    Vector3 c = vertex[2];
    Vector3 ab = new Vector3(b.x - a.x, b.y - a.y, b.z - a.z);
    Vector3 ac = new Vector3(c.x - a.x, c.y - a.y, c.z - a.z);
    
    Vector3 n = Vector3.cross(ab, ac);
    // plane equation E = n.x * (x -a.x) + n.y * (y - a.y) + n.z * (z - a.z) = 0
    float z = (-n.x * (x -a.x) - n.y * (y - a.y)) / n.z + a.z;
    return z;
}

float[] barycentric(Vector3 P, Vector4[] verts) {

    Vector3 A = verts[0].homogenized();
    Vector3 B = verts[1].homogenized();
    Vector3 C = verts[2].homogenized();

    Vector4 AW = verts[0];
    Vector4 BW = verts[1];
    Vector4 CW = verts[2];

    // TODO HW4
    // Calculate the barycentric coordinates of point P in the triangle verts using
    // the barycentric coordinate system.
    // Please notice that you should use Perspective-Correct Interpolation otherwise
    // you will get wrong answer.
    
    Vector3 V0 = Vector3.sub(C, A);
    Vector3 V1 = Vector3.sub(B, A);
    Vector3 V2 = Vector3.sub(P, A);
    
    float dot00 = Vector3.dot(V0, V0);
    float dot01 = Vector3.dot(V0, V1);
    float dot02 = Vector3.dot(V0, V2);
    float dot11 = Vector3.dot(V1, V1);
    float dot12 = Vector3.dot(V1, V2);
    
    float u = (dot11*dot02 - dot01*dot12) / (dot00*dot11 - dot01*dot01);
    float v = (dot00*dot12 - dot01*dot02) / (dot00*dot11 - dot01*dot01);
    
    // P = (1-u-v) * A + v * B + u * C
    float lamdaA = 1-u-v;
    float lamdaB = v;
    float lamdaC = u;
    
    float alpha = lamdaA / AW.w;
    float beta  = lamdaB / BW.w;
    float gamma = lamdaC / CW.w;
    
    float sum = alpha + beta + gamma;
    
    alpha /= sum;
    beta  /= sum;
    gamma /= sum;

    float[] result = { alpha, beta, gamma };
    return result;
}

Vector3 interpolation(float[] abg, Vector3[] v) {
    return v[0].mult(abg[0]).add(v[1].mult(abg[1])).add(v[2].mult(abg[2]));
}

Vector4 interpolation(float[] abg, Vector4[] v) {
    return v[0].mult(abg[0]).add(v[1].mult(abg[1])).add(v[2].mult(abg[2]));
}

float interpolation(float[] abg, float[] v) {
    return v[0] * abg[0] + v[1] * abg[1] + v[2] * abg[2];
}
