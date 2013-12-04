public abstract class Creature extends GameEntity {
  long atkTimer;
  int atkStallCounter = 0;
  boolean stalled = false;
  int atkDamage;
  int atkRange;
  int atkSpeed;
  int team;
  int maxHealth;
  int currHealth;
  int state = 0; // 0 == alive, 1 == dead

  float atkTargetDist=Float.MAX_VALUE;
  boolean attacking=false;
  //Minion atkTarget;
  Creature atkTarget;

  Creature(PVector pos, float or, int[] colour, int atkDamage, int atkRange, int atkSpeed, Rift r) {
    super(pos, or, colour, 50, r);
    this.atkDamage = atkDamage;
    this.atkRange = atkRange;
    this.atkSpeed = atkSpeed;
    atkTimer = System.currentTimeMillis();
  }

  public void attack(Creature target) {
    if (target.team != team) {
      attacking = true;
      atkTarget = target;
    }
  }

  void move() {
    if (!stalled)
      integrate(targetLoc.get());
    else if (stalled) {
      if (atkStallCounter == 10) {
        stalled = false;
        atkStallCounter = -1;
      }
      atkStallCounter++;
    }
  }
  
  public void checkTarget() {
    if(atkTarget == null || atkTarget.state == 1)
      atkTargetDist = Float.MAX_VALUE;
    for (Creature cr : r.creatures) {
      if (cr == this) continue;

      if (cr.team != team)
        if (atkTarget != null) {
          float dist = (float)Utils.distanceSqr(position, cr.position);
          if (dist < atkTargetDist) {
            atkTargetDist = dist;
            attack(cr);
          }
        }
        else
          attack(cr);
    }
  }

  void checkCollisions() {
    for (Creature cr : r.creatures) {
      if (cr == this) continue;
      if (Utils.circToCircColl(position, rad, cr.position, cr.rad)) {
        double moveDist = ((rad+cr.rad) - sqrt((float)Utils.distanceSqr(cr.position, position)) + 1)/2;
        PVector c = PVector.sub(position, cr.position);
        position = PVector.add(c.setMag(null, (float)moveDist), position);
        
        //try move to side of collided
        //position = findFreePos(min);
      }
    }
  }
  
  /*PVector findFreePos(Minion m){
    int i=1;
    PVector pos;
    while(true){
      if((pos = checkUp(m,i)) != null)
        return pos;
      if((pos = checkDown(m,i)) != null)
        return pos;
        
      i++;
    }
  }
  
  PVector checkUp(Minion m, int i){
    PVector pos = new PVector(m.position.x,m.position.y+m.rad*2*i+3);
    return isFree(pos,m) ? pos : null;
  }
  
  PVector checkDown(Minion m, int i){
    PVector pos = new PVector(m.position.x,m.position.y-m.rad*2*i-3);
    return isFree(pos,m) ? pos : null;
  }
  
  boolean isFree(PVector pos, Minion m){
    for(Minion min : r.minions){
      if(min == m) continue;
      if(Utils.circToCircColl(min.position,min.rad, pos,m.rad))
        return false;
    }
    return true;
  }*/

  void moveToAttackRange() {
    float vX = position.x - atkTarget.position.x;
    float vY = position.y - atkTarget.position.y;
    float magV = (float)Math.sqrt(vX*vX + vY*vY);
    targetLoc = new PVector(atkTarget.position.x + vX / magV * atkRange, atkTarget.position.y + vY / magV * atkRange);
  }

  void processAttack(){
    if (attacking) {
      if (atkTarget.state == 1) {
        attacking = false;
        return;
      } 
      if (Utils.distanceSqr(position, atkTarget.position) >= Math.pow(atkRange, 2)+1) {
        moveToAttackRange();
        return;
      }
      targetLoc = position;
      long cTime = System.currentTimeMillis();
      if (cTime - atkTimer > atkSpeed) {
        atkTimer = cTime; 
        launchAttack();
      }
    }
  }

  void launchAttack() {
    stalled = true;
    r.attacks.add(new AttackParticle(position.get(), atkTarget, atkDamage, r, this));
  }
  
  abstract void kill(Creature c);
}

