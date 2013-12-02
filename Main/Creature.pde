public abstract class Creature extends GameEntity {
  long atkTimer;
  int atkStallCounter = 0;
  boolean stalled = false;
  int atkDamage;
  int atkRange;
  int atkSpeed;
  int team;

  float atkTargetDist=Float.MAX_VALUE;
  boolean attacking=false;
  Minion atkTarget;

  Creature(PVector pos, float or, int[] colour, int atkDamage, int atkRange, int atkSpeed, Rift r) {
    super(pos, or, colour, 50, r);
    this.atkDamage = atkDamage;
    this.atkRange = atkRange;
    this.atkSpeed = atkSpeed;
    atkTimer = System.currentTimeMillis();
  }

  public void attack(Minion target) {
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
    for (Minion min : r.minions) {
      if (min == this) continue;

      if (min.team != team)
        if (atkTarget != null) {
          float dist = (float)Utils.distanceSqr(position, min.position);
          if (dist < atkTargetDist) {
            atkTargetDist = dist;
            attack(min);
          }
        }
        else
          attack(min);
    }
  }

  void checkCollisions() {
    for (Minion min : r.minions) {
      if (min == this) continue;
      if (Utils.circToCircColl(position, rad, min.position, min.rad)) {
        double moveDist = ((rad+min.rad) - sqrt((float)Utils.distanceSqr(min.position, position)) + 1)/2;
        PVector c = PVector.sub(position, min.position);
        position = PVector.add(c.setMag(null, (float)moveDist), position);
        
        //try move to side of collided
        //position = findFreePos(min);
      }
    }
  }
  
  PVector findFreePos(Minion m){
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
  }

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
}

