/*
* Top-level creature class. Currently extended by Champion, Minion and Turret. 
*/

public abstract class Creature extends GameEntity {
  long atkTimer;  //When we last attacked.
  int atkStallCounter = 0;  //Stops movement when less than threshhold.
  boolean stalled = false;  //Are we stalling from attack?
  int atkDamage;  //Damage to do per attack.
  int atkRange;  //Radius around position, can only attack within this.
  int atkSpeed;  //Number of milliseconds between attacks. 
  int team;  //Are we friends or allies of player-controlled champion? 
  int maxHealth;  //Maximum health value.
  int currHealth; //Current health value.
  int state = 0; // 0 == alive, 1 == dead

  float atkTargetDist=Float.MAX_VALUE;  //Distance to current attack target.
  boolean attacking=false;  //Are we attacking anything right now?
  Creature atkTarget;  //This is what we are attacking.

  /*
  * param PVector pos Spawning location.
  * param float or Spawning orientation.
  * param int[] colour 3-tuple RGB colour value.
  * param int atkDamage Damage to do per attack.
  * param int atkRange Maximum attack distance.
  * param int atkSpeed Milliseconds between attacks.
  * param Rift r Game we are part of.
  */
  Creature(PVector pos, float or, int[] colour, int atkDamage, int atkRange, int atkSpeed, Rift r) {
    super(pos, or, colour, 50, r);
    this.atkDamage = atkDamage;
    this.atkRange = atkRange;
    this.atkSpeed = atkSpeed;
    atkTimer = System.currentTimeMillis();
  }

  /*
  * Set creature as current attack target, and attacking to true.
  * param Creature target Creature to attack.
  */
  public void attack(Creature target) {
    if (target.team != team) {
      attacking = true;
      atkTarget = target;
    }
  }

  /*
  * Standard movement. If we are stalling after attack, do not move.
  */
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
  
  /*
  * Search for closest enemy creature, set it as attack target.
  * Currently does not attack champions, as this caused some problems.
  */
  public void checkTarget() {
    if(atkTarget == null || atkTarget.state == 1)
      atkTargetDist = Float.MAX_VALUE;
    for (Creature cr : r.creatures) {
      if (cr == this || cr instanceof Champion) continue;

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

  /*
  * Check and resolve collisions with other creatures.
  */
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
  
  /*
  * Commented-out alternate collision resolution code. Would search for space next to creature collided with,
  * then move there. Was too specific to one collision pattern to work.
  */
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

  /*
  * Find closest point between current location and attack target, then set that as target location.
  */
  void moveToAttackRange() {
    float vX = position.x - atkTarget.position.x;
    float vY = position.y - atkTarget.position.y;
    float magV = (float)Math.sqrt(vX*vX + vY*vY);
    targetLoc = new PVector(atkTarget.position.x + vX / magV * atkRange, atkTarget.position.y + vY / magV * atkRange);
  }

  /*
  * If we are set to attacking and have waited our attack speed since our last attack,
  * launch attack at current target.
  */
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

  /*
  * Spawn new attack, from me to current target.
  */
  void launchAttack() {
    stalled = true;
    r.attacks.add(new AttackParticle(position.get(), atkTarget, atkDamage, r, this));
  }
  
  /*
  * param Creature c The creature that killed us.
  */
  abstract void kill(Creature c);
}

