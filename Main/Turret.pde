class Turret extends Creature{
  
  /*
  * param PVector pos Spawning position.
  * param int team Team we are on
  * param Rift r Game we are part of.
  */
  public Turret(PVector pos, int team, Rift r){
    super(pos,2f,new int[]{0,128,0},100,700,1000,r);
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
  
  void kill(Creature c){}
}
