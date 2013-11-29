HashMap<String, State> menus  = new HashMap<String, State>();
State state;

void setup() {
  size(displayWidth, displayHeight);
  orientation(LANDSCAPE);
  init();
  ellipseMode(RADIUS);
}

void init() {
  noStroke();
  createMenus();
  menus.put("rift",new Rift(this));
  state = menus.get("main");
}

void createMenus(){
  Menu mainMenu = new Menu("Building Legends", this);
  mainMenu.addItem(new MenuItem("Begin",this){
    public void click(){
      Rift r = (Rift)m.menus.get("rift");
      r.initRift();
      m.state = menus.get("rift");
    }
  });
  
  Menu pauseMenu = new Menu("Motherfucking Menu", this);
  pauseMenu.addItem(new MenuItem("Resume",this){
    public void click(){
      m.state = menus.get("rift");
    }
  });
  pauseMenu.addItem(new MenuItem("Exit",this){
    public void click(){
      m.state = menus.get("main");
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

