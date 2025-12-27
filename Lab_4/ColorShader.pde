public class PhongVertexShader extends VertexShader {
    // variables passed from Material
    Vector4[][] main(Object[] attribute, Object[] uniform) {
        Vector3[] aVertexPosition = (Vector3[]) attribute[0];
        Vector3[] aVertexNormal = (Vector3[]) attribute[1];
        Matrix4 MVP = (Matrix4) uniform[0];
        Matrix4 M = (Matrix4) uniform[1];
        Vector4[] gl_Position = new Vector4[3];
        Vector4[] w_position = new Vector4[3];
        Vector4[] w_normal = new Vector4[3];

        for (int i = 0; i < gl_Position.length; i++) {
            gl_Position[i] = MVP.mult(aVertexPosition[i].getVector4(1.0));
            w_position[i] = M.mult(aVertexPosition[i].getVector4(1.0));
            w_normal[i] = M.mult(aVertexNormal[i].getVector4(0.0));
        }

        Vector4[][] result = { gl_Position, w_position, w_normal };

        return result;
    }
}

public class PhongFragmentShader extends FragmentShader {
    // variables passed from Material
    Vector4 main(Object[] varying) {
        Vector3 position = (Vector3) varying[0];
        Vector3 w_position = (Vector3) varying[1]; // world position
        Vector3 w_normal = (Vector3) varying[2]; // world normal
        Vector3 albedo = (Vector3) varying[3]; // color of the object (reflection rate)
        Vector3 kdksm = (Vector3) varying[4]; // Kd, Ks, m
        Vector3 Ka = (Vector3) varying[5];
        Light light = basic_light;
        Camera cam = main_camera;

        // TODO HW4
        // In this section, we have passed in all the variables you need.
        // Please use these variables to calculate the result of Phong shading
        // for that point and return it to GameObject for rendering
        float Kd = kdksm.x;
        float Ks = kdksm.y;
        float m = kdksm.z;
        
        Vector3 f_color = light.light_color.product(albedo); // consider both object color and light color
        
        Vector3 ambient = Ka.mult(light.intensity); // Ia (scalar) * Ka (Vector3)
        
        Vector3 N = w_normal.unit_vector();
        Vector3 L = light.transform.position.sub(w_position).unit_vector();

        float NL = Vector3.dot(N, L); // N dot L (scalar)
        Vector3 diffuse = f_color.mult(light.intensity).mult(Kd).mult(max(0.0, NL)); // Ip (scalar) * Kd (scalar) * (N dot L) (scalar) 
        
        Vector3 L_prim = N.mult(NL); // (N dot L) (scalar) * N (Vector3)
        Vector3 V = cam.transform.position.sub(w_position).unit_vector();
        Vector3 R = (L_prim.mult(2)).sub(L).unit_vector(); // 2 * L_prime (Vector3) - L (Vector3)
        float RV = Vector3.dot(R,V); // R dot V (scalar)
        Vector3 specular = light.light_color.mult(light.intensity).mult(Ks).mult(pow(max(0.0, RV), m)); // Ip (scalar) * Ks (scalar) * (R dot V)^m (scalar)
        
        Vector3 illumination = ambient.add(diffuse).add(specular);

        return new Vector4(illumination, 1.0);
    }
}

public class FlatVertexShader extends VertexShader {
    Vector4[][] main(Object[] attribute, Object[] uniform) {
        Vector3[] aVertexPosition = (Vector3[]) attribute[0];
        Vector3[] aVertexNormal = (Vector3[]) attribute[1];
        Matrix4 MVP = (Matrix4) uniform[0];
        Matrix4 M = (Matrix4) uniform[1];
        Vector4[] gl_Position = new Vector4[3];
        Vector4[] w_position = new Vector4[3];
        Vector4[] w_normal = new Vector4[3];

        // TODO HW4
        // Here you have to complete Flat shading.
        // We have instantiated the relevant Material, and you may be missing some
        // variables.
        // Please refer to the templates of Phong Material and Phong Shader to complete
        // this part.

        // Note: Here the first variable must return the position of the vertex.
        // Subsequent variables will be interpolated and passed to the fragment shader.
        // The return value must be a Vector4.
        
        // one triangle use one point and one normal
        Vector3 screen_pos = aVertexPosition[0]; // choose one point
        Vector4 world_pos = M.mult(screen_pos.getVector4(0.0));
        Vector3 screen_face_normal = aVertexNormal[0]; // use the same normal
        Vector4 world_face_normal = M.mult(screen_face_normal.getVector4(0.0));
        for (int i = 0; i < gl_Position.length; i++) {
            gl_Position[i] = MVP.mult(aVertexPosition[i].getVector4(1.0));
            w_position[i] = world_pos;
            w_normal[i] = world_face_normal;
        }

        Vector4[][] result = { gl_Position, w_position, w_normal };

        return result;
    }
}

public class FlatFragmentShader extends FragmentShader {
    Vector4 main(Object[] varying) {
        Vector3 position = (Vector3) varying[0];
        // TODO HW4
        // Here you have to complete Flat shading.
        // We have instantiated the relevant Material, and you may be missing some
        // variables.
        // Please refer to the templates of Phong Material and Phong Shader to complete
        // this part.

        // Note : In the fragment shader, the first 'varying' variable must be its
        // screen position.
        // Subsequent variables will be received in order from the vertex shader.
        // Additional variables needed will be passed by the material later.
        Vector3 w_position = (Vector3) varying[1];
        Vector3 w_normal = (Vector3) varying[2];
        Vector3 albedo = (Vector3) varying[3];
        Vector3 kdksm = (Vector3) varying[4];
        Vector3 Ka = (Vector3) varying[5];
        Light light = basic_light;
        Camera cam = main_camera;
        
        float Kd = kdksm.x;
        float Ks = kdksm.y;
        float m = kdksm.z;
        
        Vector3 f_color = light.light_color.product(albedo);
        
        Vector3 ambient = Ka.mult(light.intensity); // Ia (scalar) * Ka (Vector3)
        
        Vector3 N = w_normal.unit_vector();
        Vector3 L = light.transform.position.sub(w_position).unit_vector();

        float NL = Vector3.dot(N, L); // N dot L (scalar)
        Vector3 diffuse = f_color.mult(light.intensity).mult(Kd).mult(max(0.0, NL)); // Ip (scalar) * Kd (scalar) * (N dot L) (scalar) 
        
        Vector3 L_prim = N.mult(NL); // (N dot L) (scalar) * N (Vector3)
        Vector3 V = cam.transform.position.sub(w_position).unit_vector();
        Vector3 R = (L_prim.mult(2)).sub(L).unit_vector(); // 2 * L_prime (Vector3) - L (Vector3)
        float RV = Vector3.dot(R,V); // R dot V (scalar)
        Vector3 specular = light.light_color.mult(light.intensity).mult(Ks).mult(pow(max(0.0, RV), m)); // Ip (scalar) * Ks (scalar) * (R dot V)^m (scalar)
        
        Vector3 illumination = ambient.add(diffuse).add(specular);

        return new Vector4(illumination, 1.0);
    }
}

public class GouraudVertexShader extends VertexShader {
    Vector4[][] main(Object[] attribute, Object[] uniform) {
        Vector3[] aVertexPosition = (Vector3[]) attribute[0];
        Vector3[] aVertexNormal = (Vector3[]) attribute[1];
        Vector3 Ka = (Vector3) attribute[2];
        float Kd = (float) attribute[3];
        float Ks = (float) attribute[4];
        float m = (float) attribute[5];
        Vector3 albedo = (Vector3) attribute[6];
        Matrix4 MVP = (Matrix4) uniform[0];
        Matrix4 M = (Matrix4) uniform[1];

        Vector4[] gl_Position = new Vector4[3];
        Vector4[] v_color = new Vector4[3];
        
        Light light = basic_light;
        Camera cam = main_camera;

        // TODO HW4
        // Here you have to complete Gouraud shading.
        // We have instantiated the relevant Material, and you may be missing some
        // variables.
        // Please refer to the templates of Phong Material and Phong Shader to complete
        // this part.

        // Note: Here the first variable must return the position of the vertex.
        // Subsequent variables will be interpolated and passed to the fragment shader.
        // The return value must be a Vector4.
        
        Vector3 f_color = light.light_color.product(albedo);

        for (int i = 0; i < gl_Position.length; i++) {
            gl_Position[i] = MVP.mult(aVertexPosition[i].getVector4(1.0));
            Vector3 w_position = M.mult(aVertexPosition[i].getVector4(1.0)).xyz();

            Vector3 ambient = Ka.mult(light.intensity); // Ia (scalar) * Ka (Vector3)
            
            Vector3 N = M.mult(aVertexNormal[i].getVector4(0.0)).xyz();
            Vector3 L = light.transform.position.sub(w_position).unit_vector();
            float NL = Vector3.dot(N, L); // N dot L (scalar)
            Vector3 diffuse = f_color.mult(light.intensity).mult(Kd).mult(max(0.0, NL)); // Ip (scalar) * Kd (scalar) * (N dot L) (scalar) 
            
            Vector3 L_prim = N.mult(NL); // (N dot L) (scalar) * N (Vector3)
            Vector3 R = (L_prim.mult(2)).sub(L).unit_vector(); // 2 * L_prime (Vector3) - L (Vector3)
            Vector3 V = cam.transform.position.sub(w_position).unit_vector();
            float RV = Vector3.dot(R,V); // R dot V (scalar)
            Vector3 specular = light.light_color.mult(light.intensity).mult(Ks).mult(pow(max(0.0, RV), m)); // Ip (scalar) * Ks (scalar) * (R dot V)^m (scalar)
            
            Vector3 illumination = ambient.add(diffuse).add(specular);
            v_color[i] = illumination.getVector4(1.0);
        }

        Vector4[][] result = { gl_Position, v_color };

        return result;
    }
}

public class GouraudFragmentShader extends FragmentShader {
    Vector4 main(Object[] varying) {
        Vector3 position = (Vector3) varying[0];

        // TODO HW4
        // Here you have to complete Gouraud shading.
        // We have instantiated the relevant Material, and you may be missing some
        // variables.
        // Please refer to the templates of Phong Material and Phong Shader to complete
        // this part.

        // Note : In the fragment shader, the first 'varying' variable must be its
        // screen position.
        // Subsequent variables will be received in order from the vertex shader.
        // Additional variables needed will be passed by the material later.
        Vector3 point_color = (Vector3) varying[1];

        return new Vector4(point_color.x, point_color.y, point_color.z, 1.0);
    }
}

public class TextureVertexShader extends VertexShader {
    Vector4[][] main(Object[] attribute, Object[] uniform) {
        Vector3[] aVertexPosition = (Vector3[]) attribute[0];
        Vector3[] aVertexNormal = (Vector3[]) attribute[1];
        Vector3[] aVertexUV = (Vector3[]) attribute[2];
        Matrix4 MVP = (Matrix4) uniform[0];
        Matrix4 M = (Matrix4) uniform[1];
        Vector4[] gl_Position = new Vector4[3];
        Vector4[] w_position = new Vector4[3];
        Vector4[] w_normal = new Vector4[3];
        Vector4[] v_uv = new Vector4[3];
        
        for (int i = 0; i < gl_Position.length; i++) {
            gl_Position[i] = MVP.mult(aVertexPosition[i].getVector4(1.0));
            w_position[i] = M.mult(aVertexPosition[i].getVector4(1.0));
            w_normal[i] = M.mult(aVertexNormal[i].getVector4(0.0));
            v_uv[i] = new Vector4(aVertexUV[i].x, aVertexUV[i].y, 0.0, 0.0);
        }

        Vector4[][] result = { gl_Position, w_position, w_normal, v_uv };

        return result;
    }
}

public class TextureFragmentShader extends FragmentShader {
    Vector4 main(Object[] varying) {
        Vector3 position = (Vector3) varying[0];
        Vector3 w_position = (Vector3) varying[1]; // world position
        Vector3 w_normal = (Vector3) varying[2]; // world normal
        Vector3 uv = (Vector3) varying[3];
        Vector3 albedo = (Vector3) varying[4]; // color of the object (reflection rate)
        Vector3 kdksm = (Vector3) varying[5]; // Kd, Ks, m
        Vector3 Ka = (Vector3) varying[6];
        PImage texture = (PImage) varying[7];
        float Kd = kdksm.x;
        float Ks = kdksm.y;
        float m = kdksm.z;
        
        float u = constrain(uv.x, 0, 1);
        float v = constrain(uv.y, 0, 1);

        int tx = int(u * (texture.width  - 1));
        int ty = int((1.0 - v) * (texture.height - 1));
        
        int c = texture.pixels[ty * texture.width + tx];
        Vector3 t_color = new Vector3 (red(c)/255.0, green(c)/255.0, blue(c)/255.0); // color of texture
        
        Light light = basic_light;
        Camera cam = main_camera;
        
        Vector3 f_color = light.light_color.product(t_color); // consider both texture color and light color
        
        Vector3 ambient = Ka.mult(light.intensity); // Ia (scalar) * Ka (Vector3)
        
        Vector3 N = w_normal.unit_vector();
        Vector3 L = light.transform.position.sub(w_position).unit_vector();

        float NL = Vector3.dot(N, L); // N dot L (scalar)
        Vector3 diffuse = f_color.mult(light.intensity).mult(Kd).mult(max(0.0, NL)); // Ip (scalar) * Kd (scalar) * (N dot L) (scalar) 
        
        Vector3 L_prim = N.mult(NL); // (N dot L) (scalar) * N (Vector3)
        Vector3 V = cam.transform.position.sub(w_position).unit_vector();
        Vector3 R = (L_prim.mult(2)).sub(L).unit_vector(); // 2 * L_prime (Vector3) - L (Vector3)
        float RV = Vector3.dot(R,V); // R dot V (scalar)
        Vector3 specular = light.light_color.mult(light.intensity).mult(Ks).mult(pow(max(0.0, RV), m)); // Ip (scalar) * Ks (scalar) * (R dot V)^m (scalar)
        
        Vector3 illumination = ambient.add(diffuse).add(specular);

        return new Vector4(illumination, 1.0);
    }
}
