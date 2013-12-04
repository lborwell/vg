class AttackParticle extends GameEntity {
  Creature target;
  Creature source;
  int damage;

  public AttackParticle(PVector pos, Creature target, int damage, Rift r, Creature s) {
    super(pos, 0f, new int[] {0, 0, 0}, 7.5, r);
    this.target = target;
    this.damage = damage;
    this.source = s;
  }

  public void update() {
    if(target instanceof Minion)
      if(target.currHealth <= 0){
        r.removeAttacks.add(r.attacks.indexOf(this));
        return;
      }
    integrate(new PVector(target.position.x, target.position.y));

    if (Utils.circToCircColl(position, rad, target.position, target.rad)) {
      if(target instanceof Champion || target instanceof Turret){
        r.removeAttacks.add(r.attacks.indexOf(this));
        return;
      }
      if(source instanceof Champion)
        if(target.currHealth - damage <= 0)
          ((Champion)source).score++;
      target.currHealth -= damage;
      if (target.currHealth <= 0) {
        target.kill(source);
      }
      r.removeAttacks.add(r.attacks.indexOf(this));
    }
  }

  public void ddraw() {
    fill(colour[0], colour[1], colour[2]);
    ellipse(position.x, position.y, rad, rad);
  }
}

