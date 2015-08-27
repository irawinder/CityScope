// Camera Settings //

int camMode = 0; //0 is normal cam, 1 is openGL cam
int camRotation = 4; // 0,1,2,3,4,5,6, or 7 that describes ortho rotation

void initCam() {
  initializeNormalCam();
  initialize_OpenGLCamera();
}

void camPerspective(float standardU, float standardV) {
  if (camMode == 0) {
    //Processing's Built-In Camera Controls (Position, Rotation, Orientation, Field of View, and Aspect Ratio)
    normalCam(standardU, standardV);
  } else if (camMode ==1) {
    // OpenGL Camera Mode
    openGLCam();
  }
}

// Normal Camera Mode //

float fov, cameraZ, standard;
float focus, eye;
int lightA, lightB;

void initializeNormalCam() {
  fov = 1*PI/5.0;
  cameraZ = (height/2.0) / tan(fov/2.0);
  focus = 0.6;    // fraction of board to place one's focus
  eye = 1.0;       // Distance of camera from board's center
  lightA = 255;    // Brigthness of Primary Light
  lightB = 100;     // Brigthness of Secondary Light
}

void normalCam(float standardU, float standardV) {
  
  colorMode(RGB);
  
  standard = max(standardU, standardV);
  
  // Sets "Eye" Coordinates, "Scene Center" Coordinates, and X,Y,Z Directions
  if (camRotation == 0) {
    camera((0.5+eye)*standard, eye*standard, (0.5+eye)*standard, focus*standardU, 0, focus*standardV, 0, -1, 0);
    noLights();
    pointLight(lightA,lightA,lightA, (0.5+eye)*standard, eye*standard, (0.5-eye)*standard);
    pointLight(lightB,lightB,lightB, (0.5-eye)*standard, eye*standard, (0.5+eye)*standard);
  } else if (camRotation == 1) {
    camera((0.5-eye)*standard, eye*standard, (0.5+eye)*standard, (1-focus)*standardU, 0, focus*standardV, 0, -1, 0);
    noLights();
    pointLight(lightA,lightA,lightA, (0.5+eye)*standard, eye*standard, (0.5+eye)*standard);
    pointLight(lightB,lightB,lightB, (0.5-eye)*standard, eye*standard, (0.5-eye)*standard);
  } else if (camRotation == 2) {
    camera((0.5-eye)*standard, eye*standard, (0.5-eye)*standard, (1-focus)*standardU, 0, (1-focus)*standardV, 0, -1, 0);
    noLights();
    pointLight(lightA,lightA,lightA, (0.5-eye)*standard, eye*standard, (0.5+eye)*standard);
    pointLight(lightB,lightB,lightB, (0.5+eye)*standard, eye*standard, (0.5-eye)*standard);
  } else if (camRotation == 3) {
    camera((0.5+eye)*standard, eye*standard, (0.5-eye)*standard, focus*standardU, 0, (1-focus)*standardV, 0, -1, 0);
    noLights();
    pointLight(lightA,lightA,lightA, (0.5-eye)*standard, eye*standard, (0.5-eye)*standard);
    pointLight(lightB,lightB,lightB, (0.5+eye)*standard, eye*standard, (0.5+eye)*standard);
  } else if (camRotation == 4) {
    camera((0.5+eye)*standard, (0.5+eye)*standard, (eye)*standard/2, 0.5*standardU, 0, 0.5*standardV, 0, -1, 0);
    noLights();
    pointLight(lightA,lightA,lightA, (eye)*standard, eye*standard, (0.5-eye)*standard);
    pointLight(lightB,lightB,lightB, (0.5-eye)*standard, eye*standard, (0.5+eye)*standard);
  } else if (camRotation == 5) {
    camera((eye)*standard/2, (0.5+eye)*standard, (0.5+eye)*standard, 0.5*standardU, 0, 0.5*standardV, 0, -1, 0);
    noLights();
    pointLight(lightA,lightA,lightA, (eye)*standard, eye*standard, (0.5-eye)*standard);
    pointLight(lightB,lightB,lightB, (0.5-eye)*standard, eye*standard, (0.5+eye)*standard);
  } else if (camRotation == 6) {
    camera((0.5-eye)*standard, (0.5+eye)*standard, (eye)*standard/2, 0.5*standardU, 0, 0.5*standardV, 0, -1, 0);
    noLights();
    pointLight(lightA,lightA,lightA, (eye)*standard, eye*standard, (0.5-eye)*standard);
    pointLight(lightB,lightB,lightB, (0.5-eye)*standard, eye*standard, (0.5+eye)*standard);
  } else if (camRotation == 7) {
    camera((eye)*standard/2, (0.5+eye)*standard, (0.5-eye)*standard, 0.5*standardU, 0, 0.5*standardV, 0, -1, 0);
    noLights();
    pointLight(lightA,lightA,lightA, (eye)*standard, eye*standard, (0.5-eye)*standard);
    pointLight(lightB,lightB,lightB, (0.5-eye)*standard, eye*standard, (0.5+eye)*standard);
  }
  
  // Sets "Field of View" and "Aspect Ratio"
  perspective(fov, float(width)/float(height), cameraZ/100.0, cameraZ*1000.0);
   
}
  
// OpenGL Camera Mode //

// Generally not used unless you have otherwise generated intrinsic and extrinsic
// projection matrices for projection mapping purposes.  Works in tandem with "flip" and "coordMode" parameters

import javax.media.opengl.GL2;

GL2 gl; 
float[] intMatrix;
float[] extMatrix;

Table extMatrixTSV;
Table intMatrixTSV;

void initialize_OpenGLCamera() {
  intMatrix = new float[16];
  extMatrix = new float[16];
  
  extMatrixTSV = loadTable("extMatrix.tsv");
  intMatrixTSV = loadTable("intMatrix.tsv");
  
  loadCamera();
}

void openGLCam() {
  // SETS INTRINSIC CAMERA PARAMETERS (AKA specification internal to camera)
  gl = ((PJOGL)beginPGL()).gl.getGL2();
  loadMatrix();  
  endPGL();
  
  // SETS EXTRINSIC CAMERA PARAMETERS (AKA where the camera is in space)
  beginCamera();
  resetMatrix();
  applyMatrix(extMatrix[0],  extMatrix[1],  extMatrix[2],    extMatrix[3],
              extMatrix[4],  extMatrix[5],  extMatrix[6],    extMatrix[7],
              extMatrix[8],  extMatrix[9],  extMatrix[10],   extMatrix[11],
              extMatrix[12], extMatrix[13], extMatrix[14],   extMatrix[15]); 
  endCamera();
}


void loadMatrix() { // SETS INTRINSIC CAMERA PARAMETERS (AKA specification internal to camera)
  PGraphicsOpenGL pg = (PGraphicsOpenGL)g;
  
  // INTRINSIC PARAMETERS
  gl.glMatrixMode(GL2.GL_PROJECTION);
  
  pg.projection.m00 = intMatrix[0]; // "alpha" x focal length
  pg.projection.m01 = intMatrix[1]; 
  pg.projection.m02 = intMatrix[2];
  pg.projection.m03 = intMatrix[3];
 
  pg.projection.m10 = intMatrix[4]; // Axis Skew
  pg.projection.m11 = intMatrix[5]; // "beta" y focal length
  pg.projection.m12 = intMatrix[6];
  pg.projection.m13 = intMatrix[7];
 
  pg.projection.m20 = intMatrix[8]; // X Principal point offset
  pg.projection.m21 = intMatrix[9]; // Y Principal point offset
  pg.projection.m22 = intMatrix[10]; //Z NEAR (?)
  pg.projection.m23 = intMatrix[11];
 
  pg.projection.m30 = intMatrix[12];
  pg.projection.m31 = intMatrix[13];
  pg.projection.m32 = intMatrix[14]; //Z FAR (?)
  pg.projection.m33 = intMatrix[15];
  
  gl.glLoadMatrixf(intMatrix, 0);
}

// Save and Load Camera Information

void loadCamera() {
  for (int i = 0; i<16; i++) {
    extMatrix[i] = extMatrixTSV.getFloat(0, i);
    intMatrix[i] = intMatrixTSV.getFloat(0, i);
  }
}

void cam2D() {
  camera();
  perspective();
  lights();
}

// Visualization may be rendered using various types of cameras
// Unless you are messing around with projection mapping, keep it set to 0
// 0 is screen mode, 1 is projection mapping mode
int displayMode = 0;

void changeDisplayMode() {
  if (displayMode == 1) {
    displayMode = 0;
    screenMode();
  } else {
    displayMode = 1;
    projectionMode();
  }
}

void projectionMode() {
  coordMode = 1;
  camMode = 1;
  flip = 1;
  println("OpenGL Camera Mode, compatible with projection mapping routines in OpenCV.  Generally not used unless you" + 
  " have otherwise generated intrinsic and extrinsic projection matrices for projection mapping purposes");
}

void screenMode() {
  coordMode = 0;
  camMode = 0;
  flip = 1;
  println("Typical Processing Camera Mode, used for traditional 'onscreen' display.");
}

void rotateCamera() {
  if (camRotation < 7) {
    camRotation ++;
  } else {
    camRotation = 0;
  }
}
