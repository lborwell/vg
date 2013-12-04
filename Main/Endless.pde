import java.util.concurrent.TimeUnit;

class Endless extends Rift{
  public Endless(Main m){
    this.m = m;
  }
  
  void init(){
    startTime = System.currentTimeMillis();
    creatures.clear();
    attacks.clear();
    removeAttacks.clear();
    removeMinions.clear();
    
    c = new Champion(new PVector(displayWidth/2, displayHeight/2), 0f, this);
    creatures.add(c);
    addMinions();
  }
  
  void update(){  
    updateAttacks();
    updateCreatures();

    clearRemovals();
  }
  
  void ddraw(){
    background(128) ;

    fill(100, 0, 100);
    rect(0, 0, 50, 50);
    
    drawInfo();
    drawCreatures();
    drawAttacks();
  }
  
  void addMinions() {
    ms = new MinionSpawner(this,0);
    ms.start();
  }
  
  void finish(){}
}

abstract class EndlessTurret extends Endless{
  public EndlessTurret(Main m){
    super(m);
  }
  
  void init(){
    super.init();
    addTurrets();
  }
  
  void addTurrets(){
    creatures.add(new Turret(new PVector(75,displayHeight-200),0,this));
    creatures.add(new Turret(new PVector(displayWidth-75,displayHeight-200),1,this));
  }
}

/*
* Asymmetrical with turrets
*/
class AsymEndlessTurret extends EndlessTurret{
  public AsymEndlessTurret(Main m){
    super(m);
  }
  
  void addMinions(){
    ms = new MinionSpawner(this,1);
    ms.start();
  }
}


/*
* Symmetrical with turrets
*/
class SymEndlessTurret extends EndlessTurret{
  public SymEndlessTurret(Main m){
    super(m);
  }
  
  void addMinions(){
    ms = new MinionSpawner(this,0);
    ms.start();
  }
}
