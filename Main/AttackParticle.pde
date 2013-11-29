class AttackParticle extends GameEntity {
  Minion target;
  Creature source;
  int damage;

  public AttackParticle(PVector pos, Minion target, int damage, Rift r, Creature s) {
    super(pos.x, pos.y, 0f, 0, 0, new int[] {0, 0, 0}, 7.5, r);
    this.target = target;
    this.damage = damage;
    this.source = s;
  }

  public void update() {
    if(target.currHealth <= 0){
      r.removeAttacks.add(r.attacks.indexOf(this));
      return;
    }
    integrate(new PVector(target.position.x, target.position.y));

    if (Utils.circToCircColl(position, rad, target.position, target.rad)) {
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

