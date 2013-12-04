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
  menus.put("endlessnoturr",new Endless(this));
  menus.put("symendlessturr",new SymEndlessTurret(this));
  menus.put("asymendlessturr",new AsymEndlessTurret(this));
  
  menus.put("timednoturr",new Timed(this));
  menus.put("symtimedturr",new SymTimedTurret(this));
  menus.put("asymtimedturr",new AsymTimedTurret(this));
  
  menus.put("highscores",new Highscores(this));
  state = menus.get("main");
}

void createMenus(){
  Menu mainMenu = new Menu("Building Legends", this);
  mainMenu.addItem(new MenuItem("Endless",this){
    public void click(){
      State st = m.menus.get("endless");
      st.update();
      m.state = st;
    }
  });
  mainMenu.addItem(new MenuItem("Timed",this){
    public void click(){
      State st = m.menus.get("timed");
      st.update();
      m.state = st;
    }
  });
  mainMenu.addItem(new MenuItem("Highscores",this){
    public void click(){
      State st = m.menus.get("highscores");
      m.state = st;
    }
  });
  
  Menu endlessMenu = new Menu("Endless modes", this);
  endlessMenu.addItem(new MenuItem("No Turrets",this){
    public void click(){
      Rift r = (Rift)m.menus.get("endlessnoturr");
      r.init();
      m.state = r;
      m.currRift = r;
    }
  });
  endlessMenu.addItem(new MenuItem("Sym w/ Turret",this){
    public void click(){
      Rift r = (Rift)m.menus.get("symendlessturr");
      r.init();
      m.state = r;
      m.currRift = r;
    }
  });
  endlessMenu.addItem(new MenuItem("Aym w/ Turret",this){
    public void click(){
      Rift r = (Rift)m.menus.get("asymendlessturr");
      r.init();
      m.state = r;
      m.currRift = r;
    }
  });
  endlessMenu.addItem(new MenuItem("Exit",this){
    public void click(){
      State st = m.menus.get("main");
      m.state = st;
    }
  });
  
  Menu timedMenu = new Menu("Timed modes", this);
  timedMenu.addItem(new MenuItem("No Turrets",this){
    public void click(){
      Rift r = (Rift)m.menus.get("timednoturr");
      r.init();
      m.state = r;
      m.currRift = r;
    }
  });
  timedMenu.addItem(new MenuItem("Sym w/ Turret",this){
    public void click(){
      Rift r = (Rift)m.menus.get("symtimedturr");
      r.init();
      m.state = r;
      m.currRift = r;
    }
  });
  timedMenu.addItem(new MenuItem("Aym w/ Turret",this){
    public void click(){
      Rift r = (Rift)m.menus.get("asymtimedturr");
      r.init();
      m.state = r;
      m.currRift = r;
    }
  });
  timedMenu.addItem(new MenuItem("Exit",this){
    public void click(){
      State st = m.menus.get("main");
      m.state = st;
    }
  });
  
  Menu pauseMenu = new Menu("Motherfucking Menu", this);
  pauseMenu.addItem(new MenuItem("Resume",this){
    public void click(){
      m.state = currRift;
      ((Rift)m.state).unpause();
    }
  });
  pauseMenu.addItem(new MenuItem("Exit",this){
    public void click(){
      m.state = menus.get("main");
      ((Rift)m.currRift).ms.quit = true;
      m.currRift = null;
    }
  });
  
  menus.put("main",mainMenu);
  menus.put("pause",pauseMenu);
  menus.put("endless",endlessMenu);
  menus.put("timed",timedMenu);
}

void draw() {
  state.update();
  state.ddraw();
}

void mousePressed() {
  state.press(mouseX, mouseY);
}

void mouseReleased(){
  state.release(mouseX, mouseY);
}

void mouseDragged() {
  mousePressed();
}

