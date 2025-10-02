public void CGLine(float x1, float y1, float x2, float y2) {
    // TODO HW1
    // You need to implement the "line algorithm" in this section.
    // You can use the function line(x1, y1, x2, y2); to verify the correct answer.
    // However, remember to comment out before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).
    // For instance: drawPoint(114, 514, color(255, 0, 0)); signifies drawing a red
    // point at (114, 514).
    
    // start pointA(x1, y1), end pointB(x2, y2)
    float dx = abs(x2 - x1);
    float dy = abs(y2 - y1);
    
    int sx = (x2 >= x1) ? 1 : -1;  // x of vector A->B is + or -
    int sy = (y2 >= y1) ? 1 : -1;  // y of vector A->B is + or -
    
    if(dy <= dx){ // 0 < abs(slope) <= 1
        float d = dy - (dx / 2); // initial condition
        float x = x1;
        float y = y1;
        
        drawPoint(x, y, 0);  // initial point
        for(int i = 0; i < int(dx); i++){
            x = x + sx;
            if(d < 0){  // choose E
                d = d + dy;
            }
            else{  // choose NE
                d = d + dy - dx;
                y = y + sy;
            }
            drawPoint(x, y, 0);
        }
    }
    else if(dx <= dy){ // abs(slope) > 1
        float d = dx - (dy / 2); // initial condition
        float x = x1;
        float y = y1;
        
        drawPoint(x, y, 0);  // initial point
        for(int i = 0; i < int(dy); i++){
            y = y + sy;
            if(d < 0){  // choose N
                d = d + dx;
            }
            else{  // choose NE
                d = d + dx - dy;
                x = x + sx;
            }
            drawPoint(x, y, 0);
        }
    }
    /*
     stroke(0);
     noFill();
     line(x1,y1,x2,y2);
    */
}

public void CGCircle(float x, float y, float r) {
    // TODO HW1
    // You need to implement the "circle algorithm" in this section.
    // You can use the function circle(x, y, r); to verify the correct answer.
    // However, remember to comment out before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).
    
    // center point(x, y), radius r
    float X = 0;
    float Y = r;
    float d = 1.25 - r;
    while(X <= Y){
        // draw 8 points based on symmetry
        drawPoint(x+X, y+Y, color(0));
        drawPoint(x-X, y+Y, color(0));
        drawPoint(x+X, y-Y, color(0));
        drawPoint(x-X, y-Y, color(0));
        drawPoint(x+Y, y+X, color(0));
        drawPoint(x-Y, y+X, color(0));
        drawPoint(x+Y, y-X, color(0));
        drawPoint(x-Y, y-X, color(0));
        
        if(d < 0){
            d = d + 2 * X + 3;
            X += 1;
        }
        else{
            d = d + 2 * (X - Y) + 5;
            X += 1;
            Y -= 1;
        }
    }
    /*
    stroke(0);
    noFill();
    circle(x,y,r*2);
    */
}

public void CGEllipse(float x, float y, float r1, float r2) {
    // TODO HW1
    // You need to implement the "ellipse algorithm" in this section.
    // You can use the function ellipse(x, y, r1,r2); to verify the correct answer.
    // However, remember to comment out the function before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).
    
    float X = 0;
    float Y = r2;
    
    // region 1, abs(slope) < 1
    float d1 = r2*r2 - r1*r1*r2 + 0.25*r1*r1;
    while(2*r2*r2*X < 2*r1*r1*Y){
        // draw 4 points based on symmetry
        drawPoint(x+X, y+Y, color(0));
        drawPoint(x-X, y+Y, color(0));
        drawPoint(x+X, y-Y, color(0));
        drawPoint(x-X, y-Y, color(0));
        
        if(d1 < 0){  // choose E
            d1 = d1 + 2*X*r2*r2 + 3*r2*r2;
            X += 1;
        }
        else{ // choose SE
            d1 = d1 + 2*X*r2*r2 + 3*r2*r2 - 2*Y*r1*r1 + 2*r1*r1;
            X += 1;
            Y -= 1;
        }
    }
    
    // region 2, abs(slope) < 1
    float d2 = (X + 0.5)*(X + 0.5)*r2*r2 + (Y - 1)*(Y - 1)*r1*r1 - r1*r1*r2*r2;
    while(Y >= 0){
        // draw 4 points based on symmetry
        drawPoint(x+X, y+Y, color(0));
        drawPoint(x-X, y+Y, color(0));
        drawPoint(x+X, y-Y, color(0));
        drawPoint(x-X, y-Y, color(0));
        
        if(d2 > 0){ // choose S
            d2 = d2 - 2*Y*r1*r1 + 3*r1*r1;
            Y -= 1;
        }
        else{ // choose SE
            d2 = d2 - 2*Y*r1*r1 + 3*r1*r1 + 2*X*r2*r2 + 2*r2*r2;
            Y -= 1;
            X += 1;
        }
    }
    /*
    stroke(0);
    noFill();
    ellipse(x,y,r1*2,r2*2);
    */

}

public void CGCurve(Vector3 p1, Vector3 p2, Vector3 p3, Vector3 p4) {
    // TODO HW1
    // You need to implement the "bezier curve algorithm" in this section.
    // You can use the function bezier(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y, p4.x,
    // p4.y); to verify the correct answer.
    // However, remember to comment out before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).
    
    float xu = 0.0, yu = 0.0;
    for(float u = 0.0; u <= 1.0; u += 0.0001){
        xu = (1-u)*(1-u)*(1-u)*p1.x + 3*u*(1-u)*(1-u)*p2.x + 3*u*u*(1-u)*p3.x + u*u*u*p4.x;
        yu = (1-u)*(1-u)*(1-u)*p1.y + 3*u*(1-u)*(1-u)*p2.y + 3*u*u*(1-u)*p3.y + u*u*u*p4.y;
        drawPoint(xu, yu, color(0));
    }
    /*
    stroke(0);
    noFill();
    bezier(p1.x,p1.y,p2.x,p2.y,p3.x,p3.y,p4.x,p4.y);
    */
}

public void CGEraser(Vector3 p1, Vector3 p2) {
    // TODO HW1
    // You need to erase the scene in the area defined by points p1 and p2 in this
    // section.
    // p1 ------
    // |       |
    // |       |
    // ------ p2
    // The background color is color(250);
    // You can use the mouse wheel to change the eraser range.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).
    
    float x1 = min(p1.x, p2.x);
    float y1 = min(p1.y, p2.y);
    float x2 = max(p1.x, p2.x);
    float y2 = max(p1.y, p2.y);
    for(float i = x1; i < x2; ++i){
        for(float j = y1; j < y2; ++j){
            drawPoint(i , j, color(250));
        }
    }    
}

public void drawPoint(float x, float y, color c) {
    stroke(c);
    point(x, y);
}

public float distance(Vector3 a, Vector3 b) {
    Vector3 c = a.sub(b);
    return sqrt(Vector3.dot(c, c));
}
