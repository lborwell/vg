abstract class Minion extends Creature {
  int maxHealth;
  int currHealth;
  PVector[] targets;
  int currTarget=0;

  int deathTicks = 0;
  int state = 0; // 0 == alive, 1 == dead

  public Minion(int health, int range, int[] colour, int x, int y, float or, float xVel, float yVel, int atkDamage, int atkRange, int atkSpeed, int team, Rift r) {

    super(x, y, or, xVel, yVel, colour, atkDamage, atkRange, atkSpeed, r);
    this.team = team;
    this.atkRange = range;   
    currHealth = maxHealth = health; 

    MAX_SPEED = 5f;
    //setTargets(new PVector[]{new PVector(30,y),new PVector(displayWidth-rad,y)});
    setTargets(new PVector[] {
      new PVector(x, y)
    });
    changeTarget();
  }

  public void setTargets(PVector[] targets) {
    this.targets = targets;
  }

  public void changeTarget() {
    currTarget = (currTarget+1) % targets.length;
    targetX = targets[currTarget].x;
    targetY = targets[currTarget].y;
  }

  public void update() {
    integrate(new PVector(targetX, targetY));
    if (position.x == targetX && position.y == targetY)
      changeTarget();
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
    fill(0, 255, 0);
    float hp = ((float)currHealth / (float)maxHealth) * (rad*2+10);
    rect(position.x-(float)rad-5, position.y-(float)rad-12, hp, 10);
  }

  public void removethis() {
    r.removeMinions.add(r.minions.indexOf(this));
  }

  public void kill() {
    state = 1;
    r.c.attacking = false;
    r.c.atkTarget = null;
  }
}

