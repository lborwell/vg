final int MY_WIDTH = 300 ;
final int MY_HEIGHT = 300 ;
Champion eno ;
RangedMinion rm;
ArrayList<Minion> minions = new ArrayList<Minion>();
ArrayList<AttackParticle> attacks = new ArrayList<AttackParticle>();
ArrayList<Integer> removeAttacks = new ArrayList<Integer>();
ArrayList<Integer> removeMinions = new ArrayList<Integer>();

void setup() {
  size(displayWidth, displayHeight);
  orientation(LANDSCAPE);
  init();
  
  ellipseMode(RADIUS);
}

void init() {
  noStroke();
  eno = new Champion(MY_WIDTH/2, MY_HEIGHT/2, 0f, this);
  addMinions();
}

void addMinions() {
  for (int i=1; i<=5; i++)
    minions.add(new RangedMinion(i*150, i*150, 2f, this));
}

void draw() {
  background(128) ;

  fill(100, 0, 100);
  rect(0, 0, 50, 50);

  eno.ddraw();
  for (Minion m : minions)
    m.ddraw();
  for (AttackParticle atk : attacks)
    atk.ddraw();
  for (AttackParticle atk : attacks)
    atk.update();
  for (int i : removeAttacks)
    attacks.remove(i);

  for (Minion m : minions)
    m.update();
  for (int i : removeMinions)
    minions.remove(i);
  eno.update();

  removeAttacks.clear();
  removeMinions.clear();
}

void checkPress(int x, int y) {
  boolean attack=false;
  for (Minion m : minions) {
    if (Utils.inEntity(x, y, m)) {
      if(m.state != 1){
        eno.attack(m);
        attack = true;
      }
      break;
    }
  }


  if (!attack) {
    eno.targetX = x;
    eno.targetY = y;
    eno.attacking = false;
    eno.atkTarget = null;
  }
}

void mousePressed() {
  if (mouseX <= 50)
    if (mouseY <= 50) {
      addMinions();
      return;
    }
  checkPress(mouseX, mouseY);
}

void mouseDragged() {
  mousePressed();
}

