import java.util.concurrent.TimeUnit;

class SymEndlessTurret extends Rift{
  ArrayList<Turret> turrets          = new ArrayList<Turret>();
  long startTime;
  
  public SymEndlessTurret(Main m){
    this.m = m;
  }
  
  void init(){
    startTime = System.currentTimeMillis();
    minions.clear();
    attacks.clear();
    turrets.clear();
    removeAttacks.clear();
    removeMinions.clear();
    
    c = new Champion(new PVector(displayWidth/2, displayHeight/2), 0f, this);
    addMinions();
  }
  
  void update(){
    background(128) ;

    fill(100, 0, 100);
    rect(0, 0, 50, 50);
  
    for(Turret t : turrets)
      t.update();
  
    updateAttacks();
  
    updateMinions();
     
    c.update();

    clearRemovals();
  }
  
  void ddraw(){
    textSize(30);
    
    for(Turret t : turrets)
      t.ddraw();
    
    text(c.score,150,150);
    long mill = System.currentTimeMillis() - startTime;
    String s = String.format("%d:%s", TimeUnit.MILLISECONDS.toMinutes(mill),TimeUnit.MILLISECONDS.toSeconds(mill) -  TimeUnit.MINUTES.toSeconds(TimeUnit.MILLISECONDS.toMinutes(mill)));
    text(s, displayWidth-100,displayHeight-100);
    
    c.ddraw();
    
    drawMinions();
    drawAttacks();
  }
  
  void addMinions() {
    turrets.add(new Turret(new PVector(75,displayHeight-200),0,this));
    turrets.add(new Turret(new PVector(displayWidth-75,displayHeight-200),1,this));
    MinionSpawner ms = new MinionSpawner(this,0);
    ms.start();
  }
  
  void finish(){}
}
