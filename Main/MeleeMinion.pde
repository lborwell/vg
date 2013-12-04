class MeleeMinion extends Minion {
  public MeleeMinion(PVector pos, float or, Rift r, int team) {
    super(425, new int[]{0,0,0},pos, or, 10, 110, 1000, team, r);
    if(team==0)
      colour = new int[]{0,0,255}; //if friend, bright blue
    else
      colour = new int[]{255,0,0}; //if enemy, bright red
  }
}

