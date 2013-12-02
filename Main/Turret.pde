class Turret extends Creature{
  
  public Turret(PVector pos, int team, Rift r){
    super(pos,2f,new int[]{0,128,0},45,500,1000,r);
    this.team = team;
    this.rad = 100;
  }
  
  void ddraw(){
    fill(colour[0], colour[1], colour[2]);
    ellipse(position.x,position.y,rad,rad);
  }
  
  void update(){
    checkTarget();
    processAttack();
  }
}
