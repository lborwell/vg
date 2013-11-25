class Champion extends Creature {
  long atkTimer;
  

  
  int atkStallCounter = 0;
  boolean stalled = false;

  public Champion(int x, int y, float or, Rift r) {
    super(x, y, or, 0, 0, new int[] {0, 0, 255}, 25, 600, 1000, r);
    atkTimer = System.currentTimeMillis();
    team = 0;
  }

  public void ddraw() {
    fill(colour[0], colour[1], colour[2]);
    ellipse(position.x, position.y, rad, rad);

    int eyerad = 10;
    int newxe = (int)(position.x + (rad - eyerad) * cos(orientation)) ;
    int newye = (int)(position.y + (rad - eyerad) * sin(orientation)) ;
    fill(0);
    ellipse(newxe, newye, eyerad, eyerad) ;
    
    stroke(0,250);
    fill(0,0);
    ellipse(position.x, position.y, atkRange, atkRange);
    noStroke();
  }

  void update() {
    if(!stalled)
      integrate(new PVector(targetX, targetY));
    else if(stalled){
      if(atkStallCounter == 10){
        stalled = false;
        atkStallCounter = -1;
      }
      atkStallCounter++;     
    }

    if (attacking) {
      if (Utils.distanceSqr(position, atkTarget.position) >= Math.pow(atkRange, 2)+1) {
        moveToAttackRange();
        return;
      }
      targetX = position.x;
      targetY = position.y;
      long cTime = System.currentTimeMillis();
      if (cTime - atkTimer > atkSpeed) {
        atkTimer = cTime; 
        launchAttack();
      }
    }
  }
  
  void launchAttack(){
    stalled = true;
    r.attacks.add(new AttackParticle(position, atkTarget, atkDamage, r));
  }

  void moveToAttackRange() {
    float vX = position.x - atkTarget.position.x;
    float vY = position.y - atkTarget.position.y;
    float magV = (float)Math.sqrt(vX*vX + vY*vY);
    targetX = atkTarget.position.x + vX / magV * atkRange;
    targetY = atkTarget.position.y + vY / magV * atkRange;
  }
}

