class RangedMinion extends Minion {

  public RangedMinion(int x, int y, float or, Rift r, int team) {
    super(100, 100, new int[]{0,0,0}, x, y, or, 0, 0, 10, 10, 10, team, r);
    if(team==0)
      colour = new int[]{0,0,128};
    else
      colour = new int[]{128,0,0};
   
  }
}

