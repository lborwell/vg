import java.util.HashSet;
import java.util.Arrays;
import java.util.Collections;

public abstract class Rift implements State{
  Main m;
  Champion c;

  ArrayList<Minion> minions          = new ArrayList<Minion>();
  ArrayList<AttackParticle> attacks  = new ArrayList<AttackParticle>();
  HashSet<Integer> removeAttacks     = new HashSet<Integer>();
  HashSet<Integer> removeMinions     = new HashSet<Integer>();
  
  abstract void init();
  abstract void addMinions();
  abstract void update();
  abstract void ddraw();
  abstract void finish();
  
  void updateMinions(){
    synchronized(minions){
      for (Minion m : minions)
        m.update();
      
      if(removeMinions.size() > 0){
        Integer[] mins = (new ArrayList<Integer>(removeMinions)).toArray(new Integer[removeMinions.size()]);
        Arrays.sort(mins, Collections.reverseOrder());
        for (int i : mins)
          minions.remove(i);
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
  
  void drawMinions(){
    synchronized(minions){
      for (Minion min : minions)
        min.ddraw();
    }
  }
  
  void drawAttacks(){
    for (AttackParticle atk : attacks)
      atk.ddraw(); 
  }
  
  void press(int x, int y){
    if (mouseX <= 50)
      if (mouseY <= 50) {
        m.state = m.menus.get("pause");
        return;
      }
  
    boolean attack=false;
    for (Minion min : minions) {
      if (Utils.inEntity(x, y, min)) {
        if(min.state != 1){
          c.attack(min);
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
