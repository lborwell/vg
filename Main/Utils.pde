static class Utils {
  /*
  * Distance between two points squared
  */
  static double distanceSqr(PVector v1, PVector v2) {
    return Math.pow(v1.x - v2.x, 2) + Math.pow(v1.y-v2.y, 2);
  }

  /*
  * Are two circles colliding?
  * param PVector c1 Center of first circle
  * param float r1 Radius of first circle
  * param PVector c2 Center of second circle
  * param float r2 Radius of second circle
  */
  static boolean circToCircColl(PVector c1, float r1, PVector c2, float r2) {
    return distanceSqr(c1, c2) < Math.pow(r1+r2, 2);
  }

  /*
  * Is point inside Creature? Assumes input creature is a circle.
  * param float x X-coord of point
  * param float y Y-coord of point
  * param Creature c Creature to test
  */
  static boolean inEntity(float x, float y, Creature c) {
    return distanceSqr(new PVector(x, y), c.position) < Math.pow((float)c.rad, 2);
  }
  
  /*
  * Is point inside rectangle?
  * param PVector p Point to test
  * param PVector rect Top left corner of rectangle
  * param float w Width of rectangle
  * param float h Height of rectangle
  */
  static boolean inRect(PVector p, PVector rect, float w, float h){
    if(p.x >= rect.x && p.x <= rect.x + w)
      if(p.y >= rect.y && p.y <= rect.y + h)
        return true;
    return false;
  }
  
  /*
  * Are three points in a straight line?
  */
  static boolean inLine(PVector p1, PVector p2, PVector p3){
    //area of triangle == 0?
    return p1.x * (p2.y - p3.y) + p2.x * (p3.y - p1.y) + p3.x * (p1.y - p2.y) == 0 ? true : false;
  }
  
  /*
  * Is point inside triangle?
  * param PVector p Point to test
  * param PVector v* Vertices of triangle
  */
  static boolean inTriangle(PVector p, PVector v1, PVector v2, PVector v3){
    boolean b1, b2, b3;
  
    b1 = sign(p, v1, v2) < 0.0f;
    b2 = sign(p, v2, v3) < 0.0f;
    b3 = sign(p, v3, v1) < 0.0f;

    return ((b1 == b2) && (b2 == b3));
  }
  
  static float sign(PVector p1, PVector p2, PVector p3){
    return (p1.x - p3.x) * (p2.y - p3.y) - (p2.x - p3.x) * (p1.y - p3.y);
  }
}

