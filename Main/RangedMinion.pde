class RangedMinion extends Minion {

  public RangedMinion(PVector pos, float or, Rift r, int team) {
    super(250, new int[]{0,0,0}, pos, or, 50, 500, 2000, team, r);
    if(team==0)
      colour = new int[]{0,0,128}; //if friendly, dark blue
    else
      colour = new int[]{128,0,0}; //if enemy, dark red
  }

}

