import java.util.HashSet;
import java.util.Arrays;
import java.util.Collections;

public abstract class Rift implements State{
  Main m;
  Champion c;

  ArrayList<Creature> creatures      = new ArrayList<Creature>();
  ArrayList<AttackParticle> attacks  = new ArrayList<AttackParticle>();
  HashSet<Integer> removeAttacks     = new HashSet<Integer>();
  HashSet<Integer> removeMinions     = new HashSet<Integer>();
  MinionSpawner ms;
  long startTime;
  
  abstract void init();
  abstract void addMinions();
  abstract void update();
  abstract void ddraw();
  abstract void finish();
  
  void release(int x, int y){}
  
  public Rift(){
    
  }
  
  long pauseStart;
  
  void pause(){
    pauseStart = System.currentTimeMillis();
    ms.active = false;
  }
  
  void unpause(){
    long pauseTime = System.currentTimeMillis() - pauseStart;
    ms.minionspawnShort += pauseTime;
    ms.minionspawnLong += pauseTime;
    startTime += pauseTime;
    ms.active = true;
  }
  
  void updateCreatures(){
    synchronized(creatures){
      for (Creature c : creatures)
        c.update();
      
      if(removeMinions.size() > 0){
        Integer[] mins = (new ArrayList<Integer>(removeMinions)).toArray(new Integer[removeMinions.size()]);
        Arrays.sort(mins, Collections.reverseOrder());
        for (int i : mins)
          creatures.remove(i);
      }
    }
  }
  
  void clearRemovals(){
    removeAttacks.clear();
    removeMinions.clear(); 
  }
  
  void updateAttacks(){
    for (AttackParticle atk : attacks)
      atk.update();
      
    if(removeAttacks.size() > 0){
      Integer[] atks = (new ArrayList<Integer>(removeAttacks)).toArray(new Integer[removeAttacks.size()]);
      Arrays.sort(atks, Collections.reverseOrder());
      for (int i : atks)
        attacks.remove(i);
    }
  }
  
  void drawCreatures(){
    synchronized(creatures){
      for(Creature c : creatures)
        c.ddraw();
    }
  }

  void drawAttacks(){
    for (AttackParticle atk : attacks)
      atk.ddraw(); 
  }
  
  void drawInfo(){
    textSize(30);
    fill(0);
    
    drawScore();
    drawTime();
  }
  
  void drawTime(){
    long mill = System.currentTimeMillis() - startTime;
    String s = String.format("%d:%s", TimeUnit.MILLISECONDS.toMinutes(mill),TimeUnit.MILLISECONDS.toSeconds(mill) -  TimeUnit.MINUTES.toSeconds(TimeUnit.MILLISECONDS.toMinutes(mill)));
    text(s, displayWidth-100,displayHeight-100);
  }
  
  void drawScore(){
    text(c.score,150,150);
  }
  
  void press(int x, int y){
    if (mouseX <= 50)
      if (mouseY <= 50) {
        pause();
        m.state = m.menus.get("pause");
        return;
      }
  
    boolean attack=false;
    for (Creature cr : creatures) {
      if(cr == c) continue;
      if (Utils.inEntity(x, y, cr)) {
        if(cr instanceof Minion){
          if(((Minion)cr).state != 1){
            c.attack(cr);
            attack = true;
          }
        }else{
          c.attack(cr);
          attack = true;
        }
        break;
      }
    }

    if (!attack) {
      c.targetLoc = new PVector(x,y);
      c.attacking = false;
      c.atkTarget = null;
    }
  }
  
}
