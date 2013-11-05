public abstract class Creature extends GameEntity {

  int atkDamage;
  int atkRange;
  int atkSpeed;

  boolean attacking=false;
  Minion atkTarget;

  Creature(int x, int y, float or, float xVel, float yVel, int[] colour, int atkDamage, int atkRange, int atkSpeed, Main m) {
    super(x, y, or, xVel, yVel, colour, 50, m);
    this.atkDamage = atkDamage;
    this.atkRange = atkRange;
    this.atkSpeed = atkSpeed;
  }

  public void attack(Minion target) {
    attacking = true;
    atkTarget = target;
  }
}
