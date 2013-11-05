class AttackParticle extends GameEntity {
  Minion target;
  int damage;

  public AttackParticle(PVector pos, Minion target, int damage, Main m) {
    super(pos.x, pos.y, 0f, 0, 0, new int[] {0, 0, 0}, 7.5, m);
    this.target = target;
    this.damage = damage;
  }

  public void update() {
    integrate(new PVector(target.position.x, target.position.y));

    if (Utils.circToCircColl(position, rad, target.position, target.rad)) {
      target.currHealth -= damage;
      if (target.currHealth <= 0) {
        target.kill();
      }
      m.removeAttacks.add(m.attacks.indexOf(this));
    }
  }

  public void ddraw() {
    fill(colour[0], colour[1], colour[2]);
    ellipse(position.x, position.y, rad, rad);
  }
}

