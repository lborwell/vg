public class Timed extends Endless{
  public Timed(Main m){
    super(m);
  }
  
  public void init(){
    super.init();
    //((Highscores)m.menus.get("highscores")).file = "//sdcard//noturr.csv";
  }
  
  public void update(){
    super.update();
    if(ms.wavesSpawned == 2)
      fuckingQuit();
  }
  
  public void fuckingQuit(){
    ms.quit = true;
    ((Highscores)m.menus.get("highscores")).addScore(c.score);
    m.state = m.menus.get("highscores");
    m.currRift = null;
  }
}

class AsymTimedTurret extends AsymEndlessTurret{
  public AsymTimedTurret(Main m){
    super(m);
  }
  
  public void init(){
    super.init();
    //((Highscores)m.menus.get("highscores")).file = "//sdcard//asymturr.csv";
  }
  
  void addMinions(){
    ms = new MinionSpawner(this,1);
    ms.start();
  }
  
  public void update(){
    super.update();
    if(ms.wavesSpawned == 2)
      fuckingQuit();
  }
  
  public void fuckingQuit(){
    ms.quit = true;
    ((Highscores)m.menus.get("highscores")).addScore(c.score);
    m.state = m.menus.get("highscores");
    m.currRift = null;
  }
}


/*
* Symmetrical with turrets
*/
class SymTimedTurret extends SymEndlessTurret{
  public SymTimedTurret(Main m){
    super(m);
  }
  
  public void init(){
    super.init();
    //((Highscores)m.menus.get("highscores")).file = "//sdcard//symturr.csv";
  }
  
  void addMinions(){
    ms = new MinionSpawner(this,0);
    ms.start();
  }
  
  public void update(){
    super.update();
    if(ms.wavesSpawned == 2)
      fuckingQuit();
  }
  
  public void fuckingQuit(){
    ms.quit = true;
    ((Highscores)m.menus.get("highscores")).addScore(c.score);
    m.state = m.menus.get("highscores");
    m.currRift = null;
  }
}
