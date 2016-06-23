//Projection Work
//World Map Projection Function
float[] mercatorProjectionQ(float lon, float lat) {
  float[] p = new float[2];
  p[0] = mod((lon+180)*width/360, width) ;
  p[1] = height/2 - log(tan((lat+90)*PI/360))*width/(2*PI);
  return p;
}

private float mod(float x, float y)
{
  float result = x % y;
  if (result < 0)
  {
    result += y;
  }
  return result;
}
