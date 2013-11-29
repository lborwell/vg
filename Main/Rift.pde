import java.util.HashSet;
import java.util.Arrays;
import java.util.Collections;

public class Rift implements State{
  Main m;
  Champion c;
  final int MY_WIDTH = 300 ;
  final int MY_HEIGHT = 300 ;
  
  ArrayList<Minion> minions          = new ArrayList<Minion>();
  ArrayList<AttackParticle> attacks  = new ArrayList<AttackParticle>();
  HashSet<Integer> removeAttacks     = new HashSet<Integer>();
  HashSet<Integer> removeMinions     = new HashSet<Integer>();
  
  public Rift(Main m){
    this.m = m;
  }
  
  void initRift(){
    minions.clear();
    attacks.clear();
    removeAttacks.clear();
    removeMinions.clear();
    
    c = new Champion(MY_WIDTH/2, MY_HEIGHT/2, 0f, this);
    addMinions();
  }
  
  void update(){
    background(128) ;

    fill(100, 0, 100);
    rect(0, 0, 50, 50);
  
    for (AttackParticle atk : attacks)
      atk.update();
      
    if(removeAttacks.size() > 0){
      Integer[] atks = (new ArrayList<Integer>(removeAttacks)).toArray(new Integer[removeAttacks.size()]);
      Arrays.sort(atks, Collections.reverseOrder());
      for (int i : atks)
        attacks.remove(i);
    }
  
    for (Minion m : minions)
      m.update();
      
    if(removeMinions.size() > 0){
      Integer[] mins = (new ArrayList<Integer>(removeMinions)).toArray(new Integer[removeMinions.size()]);
      Arrays.sort(mins, Collections.reverseOrder());
      for (int i : mins)
        minions.remove(i);
    }
      
    c.update();

    removeAttacks.clear();
    removeMinions.clear();
  }
  
  void ddraw(){
    textSize(30);
    text(minions.size(),100,100);
    
    c.ddraw();
    for (Minion min : minions)
      min.ddraw();
    for (AttackParticle atk : attacks)
      atk.ddraw();
  }
  
  void addMinions() {
    /*for (int i=1; i<=5; i++){
      minions.add(new RangedMinion(i*150, i*150, 2f, this, 0));
      minions.add(new MeleeMinion(i*200, i*200, 2f, this, 1));
    }*/
    minions.add(new MeleeMinion((displayWidth/2)+400, (displayHeight/2)-100, 2f, this, 0));
    
    //minions.add(new RangedMinion((displayWidth/2)+400, (displayHeight/2)-100, 2f, this, 0));
    minions.add(new RangedMinion((displayWidth/2)-150, (displayHeight/2)-150, 2f, this, 1));
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
      c.targetX = x;
      c.targetY = y;
      c.attacking = false;
      c.atkTarget = null;
    }
  }
}
