public abstract class Creature extends GameEntity {
  long atkTimer;
  int atkStallCounter = 0;
  boolean stalled = false;
  int atkDamage;
  int atkRange;
  int atkSpeed;
  int team;

  boolean attacking=false;
  Minion atkTarget;

  Creature(int x, int y, float or, float xVel, float yVel, int[] colour, int atkDamage, int atkRange, int atkSpeed, Rift r) {
    super(x, y, or, xVel, yVel, colour, 50, r);
    this.atkDamage = atkDamage;
    this.atkRange = atkRange;
    this.atkSpeed = atkSpeed;
    atkTimer = System.currentTimeMillis();
  }

  public void attack(Minion target) {
    if(target.team != team){
      attacking = true;
      atkTarget = target;
    }
  }
  
  void move(){
    if(!stalled)
      integrate(new PVector(targetX, targetY));
    else if(stalled){
      if(atkStallCounter == 10){
        stalled = false;
        atkStallCounter = -1;
      }
      atkStallCounter++;     
    } 
  }
  
  void moveToAttackRange() {
    float vX = position.x - atkTarget.position.x;
    float vY = position.y - atkTarget.position.y;
    float magV = (float)Math.sqrt(vX*vX + vY*vY);
    targetX = atkTarget.position.x + vX / magV * atkRange;
    targetY = atkTarget.position.y + vY / magV * atkRange;
  }
  
  void processAttack(){
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
    r.attacks.add(new AttackParticle(position, atkTarget, atkDamage, r, this));
  }
}

