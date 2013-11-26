class Champion extends Creature {


  public Champion(int x, int y, float or, Rift r) {
    super(x, y, or, 0, 0, new int[] {0, 0, 255}, 25, 600, 1000, r);
    
    team = 0;
  }

  public void ddraw() {
    fill(colour[0], colour[1], colour[2]);
    ellipse(position.x, position.y, rad, rad);

    int eyerad = 10;
    int newxe = (int)(position.x + (rad - eyerad) * cos(orientation)) ;
    int newye = (int)(position.y + (rad - eyerad) * sin(orientation)) ;
    fill(0);
    ellipse(newxe, newye, eyerad, eyerad) ;
    
    stroke(0,250);
    fill(0,0);
    ellipse(position.x, position.y, atkRange, atkRange);
    noStroke();
  }

  void update() {
    move();
    processAttack();
  }
  



}

