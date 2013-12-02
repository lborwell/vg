import java.util.concurrent.LinkedBlockingQueue;

abstract class Minion extends Creature {
  int maxHealth;
  int currHealth;
  //ArrayList<PVector> path;
  LinkedBlockingQueue<PVector> path = new LinkedBlockingQueue<PVector>();
  int currTargetLoc = 0;

  int deathTicks = 0;
  int state = 0; // 0 == alive, 1 == dead
  
  public Minion(int health, int[] colour, PVector pos, float or, int atkDamage, int atkRange, int atkSpeed, int team, Rift r) {
    super(pos, or, colour, atkDamage, atkRange, atkSpeed, r);
    this.team = team;
    this.atkRange = atkRange;   
    currHealth = maxHealth = health; 

    MAX_SPEED = 5f;
  }

  public void update() {
    checkTarget();
    move();
    checkCollisions();
    processAttack();
  }
  
  public void ddraw() {
    if (state == 0) {
      fill(colour[0], colour[1], colour[2]);
      ellipse(position.x, position.y, rad, rad);
      drawHealthBar();
    }
    else {
      if (deathTicks == 40) {
        removethis();
      }
      else {
        fill(colour[0], colour[1], colour[2], 50);
        ellipse(position.x, position.y, rad, rad);
        drawHealthBar();
        deathTicks++;
      }
    }
  }

  public void drawHealthBar() {
    fill(0, 0, 0);
    rect(position.x-(float)rad-5, position.y-(float)rad-12, rad*2+10, 10);
    if(currHealth <= 0) return;
    fill(0, 255, 0);
    float hp = ((float)currHealth / (float)maxHealth) * (rad*2+10);
    rect(position.x-(float)rad-5, position.y-(float)rad-12, hp, 10);
  }

  public void removethis() {
    r.removeMinions.add(r.minions.indexOf(this));
  }

  public void kill(Creature c) {
    state = 1;
    c.attacking = false;
    c.atkTarget = null;
  }
}

