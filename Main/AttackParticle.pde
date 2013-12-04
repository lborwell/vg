/*
* Attack particle. Spawned when one creature attacks another. Moves directly towards target 
* until collision.
*/

class AttackParticle extends GameEntity {
  Creature target;
  Creature source;
  int damage;

  /*
  * param PVector pos Starting location
  * param Creature target Target to ``attack''. Can be any creature.
  * param int damage Amount of damage to do to target after colliding
  * param Creature s Source. Creature that spawned this attack.
  */
  public AttackParticle(PVector pos, Creature target, int damage, Rift r, Creature s) {
    super(pos, 0f, new int[] {0, 0, 0}, 7.5, r);
    this.target = target;
    this.damage = damage;
    this.source = s;
  }

  /*
  * Update this. Call once every frame. Moves attack then checks for collision.
  */
  public void update() {
    //If our target is already dead, remove this (mid-flight).
    if(target instanceof Minion)
      if(target.currHealth <= 0){
        r.removeAttacks.add(r.attacks.indexOf(this));
        return;
      }
    
    //Standard movement.
    integrate(new PVector(target.position.x, target.position.y));

    //Check to see if we've reached our target.
    if (Utils.circToCircColl(position, rad, target.position, target.rad)) {
      //If it's a champion or turret it has no health value, so simply remove this.
      if(target instanceof Champion || target instanceof Turret){
        r.removeAttacks.add(r.attacks.indexOf(this));
        return;
      }
      
      //If source is champion, must check if this will last hit target.
      if(source instanceof Champion)
        if(target.currHealth - damage <= 0)
          ((Champion)source).score++;
          
      //Do damage
      target.currHealth -= damage;
      //Kill target if needed
      if (target.currHealth <= 0) {
        target.kill(source);
      }
      r.removeAttacks.add(r.attacks.indexOf(this));
    }
  }

  /*
  * Draw this. 
  */
  public void ddraw() {
    fill(colour[0], colour[1], colour[2]);
    ellipse(position.x, position.y, rad, rad);
  }
}

