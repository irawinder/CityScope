boolean drawNodes = true;

Nodes useCloud;
float[][][] solutionCloud;

public class Nodes {
  
  // Allocates memory for all the land use "nodes" we would ever need, input from "Legotizer"
  private int[][][] nodes;
      // nodes is a voxel-based data structure that describes a cloud of nodes in 3D space.
      //
      // int[][][0] represents the ground plan
      // int[][][1+] represents built landuse above ground level 
      //
      // Legend:
      //
      // 0 = Ground: Open
      // 1 = Ground: Street
      // 2 = Ground: Park
      // 3 = Building: Live
      // 4 = Building: Work
      // -1 = Open air (allows voids)
      // -2 = Water
      
  public Nodes(int maxPieces, int maxLU_W, int maxLU_H) {
    
    // maxPieces: Maximum Number of Building structure pieces in one dimension, U or V
    // maxLU_W: Maximum Width of a Building structure piece, in nodes/Lego Units
    // maxLU_H: Maximum Height of a Building structure piece, in nodes/Lego Units
  
    nodes = new int[maxLU_W*maxPieces][maxLU_W*maxPieces][maxLU_H];
    
    wipeNodes();
  }
  
  // Sets all node values to be "-1" Open Air/Void
  private void wipeNodes() {
    for (int i=0; i<nodes.length; i++) {
      for (int j=0; j<nodes[0].length; j++) {
        for (int k=0; k<nodes[0][0].length; k++) {
          nodes[i][j][k] = -1;
        }
      }
    }
  }
  
  // Sets all node values at u, v to be "-1" Open Air/Void
  private void deleteNodes(int u, int v, int LU) {
    
    // u: u position
    // v: v position
    // LU: width of piece, in Lego units
    
    for (int i=0; i<LU; i++) {
      for (int j=0; j<LU; j++) {
        for (int k=0; k<nodes[0][0].length; k++) {
          if (k == 0) {
            nodes[LU*u + j][LU*v + i][k] = 0;
          } else {
            nodes[LU*u + j][LU*v + i][k] = -1;
          }
        }
      }
    }
  }
  
  // updates nodes if NxN piece type is used, where N is greater than 1
  private void updateNodes(int u, int v, int LU, Table type, int rot) {
    
    // u: u position
    // v: v position
    // LU: width of piece, in Lego units
    // type: building type to set nodes to
    // rot: rotation of building
    
    deleteNodes(u, v, LU);
    
    for (int i=0; i<LU; i++) {
      for (int j=0; j<LU; j++) {
        if ((4 - rot + pieceRotation)%4 == 0) {
          for (int k=0; k<type.getColumnCount()/4; k++) {
            nodes[LU*u + i][LU*v + j][k] = type.getInt(j, k*4+i);
          }
        } else if ((4 - rot + pieceRotation)%4 == 1) {
          for (int k=0; k<type.getColumnCount()/4; k++) {
            nodes[LU*u + (LU-1-j)][LU*v + i][k] = type.getInt(j, k*4+i);
          }
        } else if ((4 - rot + pieceRotation)%4 == 2) {
          for (int k=0; k<type.getColumnCount()/4; k++) {
            nodes[LU*u + (LU-1-i)][LU*v + (LU-1-j)][k] = type.getInt(j, k*4+i);
          }
        } else if ((4 - rot + pieceRotation)%4 == 3) {
          for (int k=0; k<type.getColumnCount()/4; k++) {
            nodes[LU*u + j][LU*v + (LU-1-i)][k] = type.getInt(j, k*4+i);
          }
        }
      }
    }
  }
  
  // updates nodes if 1x1 piece type is used
  private void updateNodes(int u, int v, TableRow type) {
    
    // u: u position
    // v: v position
    // type: building type to set nodes to
    
    int rd, pk, ret, off, ins, res;
    
    rd = type.getInt(2);
    pk = type.getInt(3);
    res = type.getInt(4);
    off = type.getInt(5);
    ret = type.getInt(6);
    ins = type.getInt(7);
    
    deleteNodes(u, v, 1);
    
    // Automatics stackes uses in the following order, from ground-most to top-most:
    // Road, Park, Retail, Office, Institutional, then Residential
      
    // populates ground plane
    if (rd == 1) { 
      nodes[u][v][0] = 1; // road
    } else if (pk == 1) { 
      nodes[u][v][0] = 2; // park
    } else {
      nodes[u][v][0] = 0; // open
    }
      
    if (ret > 0) {
      for (int i=0; i<ret; i++) {
        nodes[u][v][1+i] = 4; // "work"
      }
    }
    if (off > 0) {
      for (int i=0; i<off; i++) {
        nodes[u][v][1+ret+i] = 4; // "work"
      }
    }
    if (ins > 0) {
      for (int i=0; i<ins; i++) {
        nodes[u][v][1+ret+off+i] = 4; // "work"
      }  
    }
    if (res > 0) {
      for (int i=0; i<res; i++) {
        nodes[u][v][1+ret+off+ins+i] = 3; // "live"
      }  
    }
  }
  
}

void initializeNodes() {
  
  useCloud = new Nodes(maxPieces, maxLU_W, maxLU_H);
  
  solutionCloud = new float[maxLU_W*maxPieces][maxLU_W*maxPieces][maxLU_H];
  wipeCloud(solutionCloud);
  
}

void updateAllNodes() {
  
  int LU;

  for (int u=0; u<UMax; u++) {
    for (int v=0; v<VMax; v++) {
      
        if (structureMode == 0) { //1x1 pieces
          if (codeArray[u][v][0] >= 0 && codeArray[u][v][0] < NPieces && (siteInfo.getInt(u,v) == 1 || overrideStatic) ) { //is site
            useCloud.updateNodes(u,v, structures1x1.getRow(codeArray[u][v][0]));
          } else {
            useCloud.deleteNodes(u,v,1);
          }
        } else if (structureMode == 1) { //4x4 pieces
          if (codeArray[u][v][0] >= 0 && codeArray[u][v][0] < NPieces && (siteInfo.getInt(u,v) == 1 || overrideStatic) ) { //is site
            useCloud.updateNodes(u,v,4, structures4x4.get(codeArray[u][v][0]), codeArray[u][v][1]);
          } else {
            useCloud.deleteNodes(u,v,4);
          }
        }

    }
  }
}

void updateSolution(JSONArray solution) {
  wipeCloud(solutionCloud);
  for (int i=0; i<solution.size(); i++) {
    JSONObject pt = solution.getJSONObject(i);
    solutionCloud[pt.getInt("u")][pt.getInt("v")][pt.getInt("z")] = pt.getFloat(scoreNames[scoreIndex]);
  }
  println(solution.size() + " solution nodes loaded");
}

void wipeCloud(float[][][] array) {
  for (int i=0; i<array.length; i++) {
    for (int j=0; j<array[0].length; j++) {
      for (int k=0; k<array[0][0].length; k++) {
        array[i][j][k] = -1;
      }
    }
  }
}
