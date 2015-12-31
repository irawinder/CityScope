float maxSpeed = 30.0F; //units: kph


class PEV {
  
  int id; //PEV agent id
  int status; //0 - empty; 1 - psg; 2 - pkg; 3 - psg & pkg; 
  int roadID; //the road the PEV is currently on
  int t; //t location of the current road;
  PVector locationPt; //location coordination on the canvas
  PVector speed; //current speed; units: kph
  PVector acc;
  float r;
  int id;

  Boid(float x, float y, float z, int _id) {
    acc = new PVector(0.0, 0.0, 0.0);
    vel = new PVector(random(-1, 1), random(-1, 1), random(-1, 1));
    loc = new PVector(x, y, z);
    r = 2.0;
    id = _id;
  }

  void run(ArrayList<Boid> boids) {
    flock(boids);
    update();
    borders();
    render();
  }

  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acc.add(force);
  }

  // We accumulate a new acceleration each time based on three rules
  void flock(ArrayList<Boid> boids) {
    PVector agg = aggregate(boids);  // maxAttribute
    // Arbitrarily weight these forces
    agg.mult(aggwt);
    // Add the force vectors to acceleration
    applyForce(agg);
  }

  // Method to update location
  void update() {
    // Update velocity
    vel.add(acc);
    // Limit speed
    vel.limit(maxspeed);
    // Slow down
    float velMag = vel.mag();
    vel.normalize();
    vel.mult(velMag - slowDown);
    // Apply vel to loc
    if (id != 3 || !lock) loc.add(vel);  // lock id 3
    // Reset accelertion to 0 each cycle
    acc.mult(0);
  }

  // A method that calculates and applies a steering force towards a target
  // STEER = DESIRED MINUS VELOCITY
  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, loc);  // A vector pointing from the location to the target

    // Normalize desired and scale to maximum speed
    desired.normalize();
    desired.mult(maxspeed);
    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired, vel);
    steer.limit(maxforce);  // Limit to maximum steering force

    return steer;
  }

  void render() {
    // Draw a triangle rotated in the direction of velocity
    //float theta = vel.heading2D() + radians(90);
    //fill(0,0,0);
    //strokeWeight(10);
    pushMatrix();
    translate(loc.x, loc.y, loc.z);
    rotateX(rotations[0]); //rotates camera to the x
    rotateY(rotations[1]); //rotates camera to the y
    rotateZ(rotations[2]); //rotates camera to the z
    //if (mark % 7 != 0){
    //  if (dataTable[mark % 7 - 1][id-1].equals("Y")) { stroke(255,255,0); strokeWeight(14.0); point(0,0,0); }
    //}//if mark
    //  ID  ROOF  COURTYARD  FACADE  INTERIOR  OTHER   META
    //      Green  Yellow    Red     Blue      Purple  Cyan
    String strType = "";
    if (mark % 7 == 1) {
      if (dataTable[mark%7-1][id-1].equals("Y")) { 
        stroke(0, 255, 0); 
        strokeWeight(14.0); 
        point(0, 0, 0); 
        strType = "ROOF";
      }
    } else if (mark % 7 == 2) {
      if (dataTable[mark%7-1][id-1].equals("Y")) { 
        stroke(255, 255, 0); 
        strokeWeight(14.0); 
        point(0, 0, 0); 
        strType = "COURTYARD";
      }
    } else if (mark % 7 == 3) {
      if (dataTable[mark%7-1][id-1].equals("Y")) { 
        stroke(255, 0, 0); 
        strokeWeight(14.0); 
        point(0, 0, 0); 
        strType = "FACADE";
      }
    } else if (mark % 7 == 4) {
      if (dataTable[mark%7-1][id-1].equals("Y")) { 
        stroke(0, 0, 255); 
        strokeWeight(14.0); 
        point(0, 0, 0); 
        strType = "INTERIOR";
      }
    } else if (mark % 7 == 5) {
      if (dataTable[mark%7-1][id-1].equals("Y")) { 
        stroke(255, 0, 255); 
        strokeWeight(14.0); 
        point(0, 0, 0); 
        strType = "OTHER";
      }
    } else if (mark % 7 == 6) {
      if (dataTable[mark%7-1][id-1].equals("Y")) { 
        stroke(0, 255, 255); 
        strokeWeight(14.0); 
        point(0, 0, 0); 
        strType = "META";
      }
    }//if mark
    strType = cityNameArray[id-1];
    stroke(0, 0, 0, 255); 
    strokeWeight(12.5); 
    point(0, 0, 0);  //main pt black outline
    stroke(150, 150, 150, 255); 
    if (cityNameArray[id-1].equals("New_york")) stroke(180, 50, 30, 255);
    if (cityNameArray[id-1].equals("Boston")) stroke(180, 110, 30, 255);
    if (cityNameArray[id-1].equals("Philadelphia")) stroke(180, 30, 180, 255);
    if (cityNameArray[id-1].equals("Chicago")) stroke(180, 30, 30, 255);
    if (cityNameArray[id-1].equals("Seattle")) stroke(30, 110, 180, 255);
    if (cityNameArray[id-1].equals("Miami")) stroke(30, 180, 110, 255);
    if (cityNameArray[id-1].equals("Los_angeles")) stroke(20, 120, 20, 255);
    if (cityNameArray[id-1].equals("San_Francisco")) stroke(30, 180, 30, 255);
    if (cityNameArray[id-1].equals("San_diego")) stroke(110, 180, 30, 255);
    if (cityNameArray[id-1].equals("San_jose")) stroke(180, 180, 30, 255);
    if (cityNameArray[id-1].equals("150,150,150Las_vegas")) stroke(30, 180, 180, 255);
    strokeWeight(10.0); 
    point(0, 0, 0);  //main pt
    //draw id label
    if (showLabels) {
      //fill(54,166,233,80);
      fill(150, 150, 150, 255);
      if (cityNameArray[id-1].equals("New_york")) fill(180, 50, 30, 255);
      if (cityNameArray[id-1].equals("Boston")) fill(180, 110, 30, 255);
      if (cityNameArray[id-1].equals("Philadelphia")) fill(180, 30, 180, 255);
      if (cityNameArray[id-1].equals("Chicago")) fill(180, 30, 30, 255);
      if (cityNameArray[id-1].equals("Seattle")) fill(30, 110, 180, 255);
      if (cityNameArray[id-1].equals("Miami")) fill(30, 180, 110, 255);
      if (cityNameArray[id-1].equals("Los_angeles")) fill(20, 120, 20, 255);
      if (cityNameArray[id-1].equals("San_Francisco")) fill(30, 180, 30, 255);
      if (cityNameArray[id-1].equals("San_diego")) fill(110, 180, 30, 255);
      if (cityNameArray[id-1].equals("San_jose")) fill(180, 180, 30, 255);
      if (cityNameArray[id-1].equals("Las_vegas")) fill(30, 180, 180, 255);
      textFont(myFont, 12);
      //textSize(12);
      textAlign(LEFT);
      text(str(id)+" "+strType, 17, -17, 0);
      //stroke(54,166,233,80);
      stroke(150, 150, 150, 255);
      strokeWeight(1);
      line(4, -4, 15, -15);
      line(15, -15, 30, -15);
    }
    popMatrix();
  }

  // Wraparound
  void borders() {
    if (boundaryRule) {
      if (loc.x < -axisX/2.0) { 
        vel = new PVector(-1.0 * vel.x, +1.0 * vel.y, +1.0 * vel.z); 
        loc.x = -axisX/2 + r;
      }
      if (loc.x > +axisX/2.0) { 
        vel = new PVector(-1.0 * vel.x, +1.0 * vel.y, +1.0 * vel.z); 
        loc.x = +axisX/2 - r;
      }
      if (loc.y < -axisY/2.0) { 
        vel = new PVector(+1.0 * vel.x, -1.0 * vel.y, +1.0 * vel.z); 
        loc.y = -axisY/2 + r;
      }
      if (loc.y > +axisY/2.0) { 
        vel = new PVector(+1.0 * vel.x, -1.0 * vel.y, +1.0 * vel.z); 
        loc.y = +axisY/2 - r;
      }
      if (loc.z < -axisZ/2.0) { 
        vel = new PVector(+1.0 * vel.x, +1.0 * vel.y, -1.0 * vel.z); 
        loc.z = -axisZ/2 + r;
      }
      if (loc.z > +axisZ/2.0) { 
        vel = new PVector(+1.0 * vel.x, +1.0 * vel.y, -1.0 * vel.z); 
        loc.z = +axisZ/2 - r;
      }
    } else {
      if (loc.x < -axisX/2.0) loc.x = +axisX/2.0;
      if (loc.y < -axisY/2.0) loc.y = +axisY/2.0;
      if (loc.z < -axisZ/2.0) loc.z = +axisZ/2.0;
      if (loc.x > +axisX/2.0) loc.x = -axisX/2.0;
      if (loc.y > +axisY/2.0) loc.y = -axisY/2.0;
      if (loc.z > +axisZ/2.0) loc.z = -axisZ/2.0;
    }
  }

  // maxAttribute
  // Method self orgnize by element data similarity
  PVector aggregate (ArrayList<Boid> boids) {
    PVector steer = new PVector(0.0, 0.0, 0.0);
    int count = 0;
    // For every boid in the system, check if it's too close
    for (Boid other : boids) {
      if (id != other.id) {
        float d = PVector.dist(loc, other.loc);
        // f = K * d - A
        PVector diff = PVector.sub(other.loc, loc);
        float diffMag = diff.mag();
        diff.normalize();
        float S = similarityTable[id-1][other.id-1];
        diff.mult( K * diffMag - A * (1 - S) );        // Weight by similarity
        steer.add(diff);
        count++;            // Keep track of how many
      }//if not oneself
    }
    // Average -- divide by how many
    if (count > 0) {
      steer.div((float)count);
      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalize();
      steer.mult(maxspeed);
      steer.limit(maxforce);
    }
    return steer;
  }
}