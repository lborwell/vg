/*
* Player-controlled champion.
*/

class Champion extends Creature {
  int score;  //Current number of minions last-hit.
  boolean showRange=false;  //Do we draw attack range around champion?
  
  /*
  * param PVector pos Spawning location.
  * param float or Orientation. Starting facing direction.
  * param Rift r Game this champion is part of. 
  */
  public Champion(PVector pos, float or, Rift r) {
    super(pos, or, new int[] {0, 0, 255}, 25, 600, 1000, r);
    score = 0;
    team = 0;
    getSettings();
  }

  /*
  * Read settings from settings menu. This is not necessarily good form.
  */
  public void getSettings(){
    Settings s = ((SettingsMenu)r.m.menus.get("settings")).s;
    atkDamage = s.atkDamage;
    atkRange = s.atkRange;
    atkSpeed = s.atkSpeed;
    showRange = s.showRange;
  }

  /*
  * Draw this.
  */
  public void ddraw() {
    fill(colour[0], colour[1], colour[2]);
    ellipse(position.x, position.y, rad, rad);

    //Draw ``eye''
    int eyerad = 10;
    int newxe = (int)(position.x + (rad - eyerad) * cos(orientation)) ;
    int newye = (int)(position.y + (rad - eyerad) * sin(orientation)) ;
    fill(0);
    ellipse(newxe, newye, eyerad, eyerad) ;
    
    if(showRange){
      stroke(0,250);
      fill(0,0);
      ellipse(position.x, position.y, atkRange, atkRange);
      noStroke();
    }
  }

  /*
  * Standard update. Move then attack.
  */
  void update() {
    move();
    processAttack();
  }
  
  /*
  * Champion cannot die, this should never be called.
  */
  void kill(Creature c){}
}

