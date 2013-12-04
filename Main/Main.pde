/*
* Main class. Holds, updates and draws current state.
*/


HashMap<String, State> menus  = new HashMap<String, State>();  // List of states
State state;     //Current state
State currRift;  //Current ``game'' state, used to resume after pausing the game

void setup() {
  size(displayWidth, displayHeight);
  orientation(LANDSCAPE);  //Lock screen sideways (game resets upon rotation if omitted)
  init();
  ellipseMode(RADIUS);
}

void init() {
  noStroke(); //don't draw outlines around shapes
  createMenus();
  menus.put("endlessnoturr",new Endless(this));
  menus.put("symendlessturr",new SymEndlessTurret(this));
  menus.put("asymendlessturr",new AsymEndlessTurret(this));
  
  menus.put("timednoturr",new Timed(this));
  menus.put("symtimedturr",new SymTimedTurret(this));
  menus.put("asymtimedturr",new AsymTimedTurret(this));
  
  menus.put("settings",new SettingsMenu(this));
  menus.put("highscores",new Highscores(this));
  state = menus.get("main");
}

/*
* Creates ``sub-menus'': menus for endless and timed game modes, highscores, and settings
*/
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
  mainMenu.addItem(new MenuItem("Settings",this){
    public void click(){
      State st = m.menus.get("settings");
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

/*
* Main game loop, (hopefully) called at 60fps. 
* Calls update and draw methods for current state.
*/
void draw() {
  state.update();
  state.ddraw();
}

/*
* Delegate mouse press to current state.
* Generally used by ``real-time'' states as user input.
*/ 
void mousePressed() {
  state.press(mouseX, mouseY);
}

/*
* Delegate mouse release to current state.
* Generally used by menu states as user input, as mousePressed will be called 
* repeatedly. Using mouseReleased saves the user from having to lift their finger
* off a menu option within 1/60 of a second.
*/ 
void mouseReleased(){
  state.release(mouseX, mouseY);
}

/*
* For convenience.
*/
void mouseDragged() {
  mousePressed();
}

