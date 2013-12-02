abstract class GameEntity {
  Rift r;

  final float ORIENTATION_INCREMENT = PI/16 ;
  float MAX_SPEED = 7f;
  final float SAT_RADIUS = 0.1f ;

  public PVector position ;
  public float orientation ;
  public PVector velocity ;

  PVector targetLoc;
  int[] colour;
  float rad;


  public GameEntity(PVector pos, float or, int[] colour, float rad, Rift r) {
    position = pos;
    orientation = or ;
    velocity = new PVector(0,0) ;
    this.colour = colour;
    targetLoc = pos.get();

    this.r = r;
    this.rad = rad;
  }


  // update position and orientation
  void integrate(PVector targetVel) {
    targetVel.x = targetVel.x - position.x ;
    targetVel.y = targetVel.y - position.y ;
    float distance = targetVel.mag() ;

    // If close enough, done.
    if (distance < SAT_RADIUS) return ;

    velocity = targetVel.get() ;
    if (distance > MAX_SPEED) {
      velocity.normalize() ;
      velocity.mult(MAX_SPEED) ;
    }

    position.add(velocity) ;
    // Apply an impulse to bounce off the edge of the screen
    if ((position.x < 0) || (position.x > width)) velocity.x = -velocity.x ;
    if ((position.y < 0) || (position.y > height)) velocity.y = -velocity.y ;

    //move a bit towards velocity:
    // turn vel into orientation
    float targetOrientation = atan2(velocity.y, velocity.x) ;

    // Will take a frame extra at the PI boundary
    if (abs(targetOrientation - orientation) <= ORIENTATION_INCREMENT) {
      orientation = targetOrientation ;
      return ;
    }

    // if it's less than me, then how much if up to PI less, decrease otherwise increase
    if (targetOrientation < orientation) {
      if (orientation - targetOrientation < PI) orientation -= ORIENTATION_INCREMENT ;
      else orientation += ORIENTATION_INCREMENT ;
    }
    else {
      if (targetOrientation - orientation < PI) orientation += ORIENTATION_INCREMENT ;
      else orientation -= ORIENTATION_INCREMENT ;
    }

    // Keep in bounds
    if (orientation > PI) orientation -= 2*PI ;
    else if (orientation < -PI) orientation += 2*PI ;
  }

  abstract void update();
  abstract void ddraw();
}

