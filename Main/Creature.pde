public abstract class Creature extends GameEntity {

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
  }

  public void attack(Minion target) {
    if(target.team != team){
      attacking = true;
      atkTarget = target;
    }
  }
}

