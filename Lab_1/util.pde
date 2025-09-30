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
    
    if(dy <= dx){
        float d = dy - (dx / 2);
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
    else if(dx <= dy){
        float d = dx - (dy / 2);
        float x = x1;
        float y = y1;
        
        drawPoint(x, y, 0);  // initial point
        for(int i = 0; i < int(dy); i++){
            y = y + sy;
            if(d < 0){  // choose E
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
    float x_centre = x;
    float y_centre = y;
    
    drawPoint(x_centre, y_centre+r, 0);
    drawPoint(x_centre+r, y_centre, 0);
    drawPoint(x_centre, y_centre-r, 0);
    drawPoint(x_centre-r, y_centre, 0);
    
    float X = x;
    float Y = y + r;
    //float d = 1.25 - r;
    float d = X*X + 2*X + Y*Y + 2*Y*r - Y - r + 1.25;
    while(X < Y){
        X += 1;
        if(d < 0){
            d = d + 2 * X + 3;
        }
        else{
            d = d + 2 * (X - Y) + 5;
            Y -= 1;
        }
        drawPoint(x_centre+X, y_centre+Y, 0);
        drawPoint(x_centre-X, y_centre+Y, 0);
        drawPoint(x_centre+X, y_centre-Y, 0);
        drawPoint(x_centre-X, y_centre-Y, 0);
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

}

public void drawPoint(float x, float y, color c) {
    stroke(c);
    point(x, y);
}

public float distance(Vector3 a, Vector3 b) {
    Vector3 c = a.sub(b);
    return sqrt(Vector3.dot(c, c));
}
