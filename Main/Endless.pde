import java.util.concurrent.TimeUnit;

class Endless extends Rift{
  ArrayList<Turret> turrets          = new ArrayList<Turret>();
  long startTime;
  
  public Endless(Main m){
    this.m = m;
  }
  
  void init(){
    startTime = System.currentTimeMillis();
    minions.clear();
    attacks.clear();
    removeAttacks.clear();
    removeMinions.clear();
    
    c = new Champion(new PVector(displayWidth/2, displayHeight/2), 0f, this);
    addMinions();
  }
  
  void update(){
    background(128) ;

    fill(100, 0, 100);
    rect(0, 0, 50, 50);
  
    updateAttacks();
  
    updateMinions();
     
    c.update();

    clearRemovals();
  }
  
  void ddraw(){
    textSize(30);
    
    text(c.score,150,150);
    long mill = System.currentTimeMillis() - startTime;
    String s = String.format("%d:%s", TimeUnit.MILLISECONDS.toMinutes(mill),TimeUnit.MILLISECONDS.toSeconds(mill) -  TimeUnit.MINUTES.toSeconds(TimeUnit.MILLISECONDS.toMinutes(mill)));
    text(s, displayWidth-100,displayHeight-100);
    
    c.ddraw();
    
    drawMinions();
    drawAttacks();
  }
  
  void addMinions() {
    MinionSpawner ms = new MinionSpawner(this,0);
    ms.start();
  }
  
  void finish(){}
}
