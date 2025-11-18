public class Camera {
    Matrix4 projection = new Matrix4();
    Matrix4 worldView = new Matrix4();
    int wid;
    int hei;
    float near;
    float far;
    Transform transform;

    Camera() {
        wid = 256;
        hei = 256;
        worldView.makeIdentity();
        projection.makeIdentity();
        transform = new Transform();
    }

    Matrix4 inverseProjection() {
        Matrix4 invProjection = Matrix4.Zero();
        float a = projection.m[0];
        float b = projection.m[5];
        float c = projection.m[10];
        float d = projection.m[11];
        float e = projection.m[14];
        invProjection.m[0] = 1.0f / a;
        invProjection.m[5] = 1.0f / b;
        invProjection.m[11] = 1.0f / e;
        invProjection.m[14] = 1.0f / d;
        invProjection.m[15] = -c / (d * e);
        return invProjection;
    }

    Matrix4 Matrix() {
        return projection.mult(worldView);
    }

    void setSize(int w, int h, float n, float f) {
        wid = w;
        hei = h;
        near = n;
        far = f;
        
        // TODO HW3
        // This function takes four parameters, which are 
        // the width of the screen, the height of the screen
        // the near plane and the far plane of the camera.
        // Where GH_FOV has been declared as a global variable.
        // Finally, pass the result into projection matrix.

        projection.makeIdentity();
        projection.m[5] = float(wid)/float(hei);
        projection.m[10] = 1;
        projection.m[11] = 1;
        projection.m[14] = tan(GH_FOV);
        projection.m[15] = 0;

    }

    void setPositionOrientation(Vector3 pos, float rotX, float rotY) {

    }
    
    void setPositionOrientation(Vector3 pos, Vector3 lookat) {
        // TODO HW3
        // This function takes two parameters, which are the position of the camera and
        // the point the camera is looking at.
        // We uses topVector = (0,1,0) to calculate the eye matrix.
        // Finally, pass the result into worldView matrix.
        
        Vector3 topVector = new Vector3(0,1,0);
        Vector3 eyeVector = new Vector3(lookat.x-pos.x, lookat.y - pos.y, lookat.z - pos.z);
        Vector3 v1 = Vector3.cross(topVector, eyeVector);
        Vector3 v3 = new Vector3(eyeVector.x, eyeVector.y, eyeVector.z);
        Vector3 v2 = Vector3.cross(v3, v1);
        
        worldView.makeIdentity();
        worldView.m[0] = v1.x;
        worldView.m[1] = v1.y;
        worldView.m[2] = v1.z;
        worldView.m[4] = v2.x;
        worldView.m[5] = v2.y;
        worldView.m[6] = v2.z;
        worldView.m[8] = v3.x;
        worldView.m[9] = v3.y;
        worldView.m[10] = v3.z;
    }
}
