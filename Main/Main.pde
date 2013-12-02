HashMap<String, State> menus  = new HashMap<String, State>();
State state;
State currRift;

void setup() {
  size(displayWidth, displayHeight);
  orientation(LANDSCAPE);
  init();
  ellipseMode(RADIUS);
}

void init() {
  noStroke();
  createMenus();
  menus.put("endless",new Endless(this));
  menus.put("endlessturr",new SymEndlessTurret(this));
  state = menus.get("main");
}

void createMenus(){
  Menu mainMenu = new Menu("Building Legends", this);
  mainMenu.addItem(new MenuItem("Endless",this){
    public void click(){
      Rift r = (Rift)m.menus.get("endless");
      r.init();
      m.state = r;
      m.currRift = r;
    }
  });
  mainMenu.addItem(new MenuItem("Endless w/ Turret",this){
    public void click(){
      Rift r = (Rift)m.menus.get("endlessturr");
      r.init();
      m.state = r;
      m.currRift = r;
    }
  });
  
  Menu pauseMenu = new Menu("Motherfucking Menu", this);
  pauseMenu.addItem(new MenuItem("Resume",this){
    public void click(){
      m.state = currRift;
    }
  });
  pauseMenu.addItem(new MenuItem("Exit",this){
    public void click(){
      m.state = menus.get("main");
      m.currRift = null;
    }
  });
  
  menus.put("main",mainMenu);
  menus.put("pause",pauseMenu);
}

void draw() {
  state.update();
  state.ddraw();
}

void mousePressed() {
  state.press(mouseX, mouseY);
}

void mouseDragged() {
  mousePressed();
}

