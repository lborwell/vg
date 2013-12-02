static class Utils {
  static double distanceSqr(PVector v1, PVector v2) {
    return Math.pow(v1.x - v2.x, 2) + Math.pow(v1.y-v2.y, 2);
  }

  static boolean circToCircColl(PVector c1, float r1, PVector c2, float r2) {
    return distanceSqr(c1, c2) < Math.pow(r1+r2, 2);
  }

  static boolean inEntity(float x, float y, Creature c) {
    return distanceSqr(new PVector(x, y), c.position) < Math.pow((float)c.rad, 2);
  }
  
  static boolean inRect(PVector p, PVector rect, float w, float h){
    if(p.x >= rect.x && p.x <= rect.x + w)
      if(p.y >= rect.y && p.y <= rect.y + h)
        return true;
    return false;
  }
  
  static boolean inLine(PVector p1, PVector p2, PVector p3){
    //area of triangle == 0?
    return p1.x * (p2.y - p3.y) + p2.x * (p3.y - p1.y) + p3.x * (p1.y - p2.y) == 0 ? true : false;
  }
}

