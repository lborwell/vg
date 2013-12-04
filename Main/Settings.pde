/*
* Settings stored in the menu.
*/
public class Settings{
  int atkRange;
  int atkDamage;
  int atkSpeed;
  boolean showRange;
  
  public Settings(){
    atkRange = 600;
    atkDamage = 75;
    atkSpeed = 1000;
    showRange = true;
  }
  
}

/*
* Settings menu. Displays and allows the user to change various options.
*/
public class SettingsMenu implements State{
  Settings s;
  Main m;
  TriButton[] butts = new TriButton[8];
  
  float minWidth = displayWidth/8;
  float ypos = displayHeight/2;
  float yoffset = 100;
  
  public SettingsMenu(Main m){
    this.m = m;
    s = new Settings();
    
    butts[0] = new TriButton(true, minWidth, ypos+yoffset, s){
      void click(){
        s.atkRange -= 25;
      }
    };
    butts[1] = new TriButton(false, minWidth, ypos-yoffset, s){
      void click(){
        s.atkRange += 25;
      }
    };
    
    butts[2] = new TriButton(true, displayWidth/2-minWidth, ypos+yoffset, s){
      void click(){
        s.atkDamage -= 25;
      }
    };
    butts[3] = new TriButton(false, displayWidth/2-minWidth, ypos-yoffset, s){
      void click(){
        s.atkDamage += 25;
      }
    };
    
    butts[4] = new TriButton(true, displayWidth/2+minWidth, ypos+yoffset, s){
      void click(){
        s.atkSpeed -= 100;
      }
    };
    butts[5] = new TriButton(false, displayWidth/2+minWidth, ypos-yoffset, s){
      void click(){
        s.atkSpeed += 100;
      }
    };
    
    butts[6] = new TriButton(true, displayWidth-minWidth, ypos+yoffset, s){
      void click(){
        s.showRange = true;
      }
    };
    butts[7] = new TriButton(false, displayWidth-minWidth, ypos-yoffset, s){
      void click(){
        s.showRange = false;
      }
    };
  }
    
  void ddraw(){
    background(0);
    
    fill(100, 0, 100);
    rect(0, 0, 50, 50);
    
    fill(255);
    textSize(100);
    textAlign(CENTER,CENTER);
    text("Settings",displayWidth/2,110);
    textSize(32);
    
    text(s.atkRange,minWidth,ypos);
    text(s.atkDamage,displayWidth/2-minWidth,ypos);
    text(s.atkSpeed,displayWidth/2+minWidth,ypos);
    text(s.showRange? "True" : "False",displayWidth-minWidth,ypos);
    text("Attack Range",minWidth,ypos+300);
    text("Attack Damage",displayWidth/2-minWidth,ypos+300);
    text("Attack Speed",displayWidth/2+minWidth,ypos+300);
    text("Show Range?",displayWidth-minWidth,ypos+300);
    
    for(int i=0; i<butts.length; i++)
      butts[i].ddraw();
  }
  
  void release(int x, int y){
    if (x <= 50)
      if (y <= 50) {
        m.state = m.menus.get("main");
        return;
      }
    
    for(TriButton tb : butts)
      if(Utils.inTriangle(new PVector(x,y), tb.v1, tb.v2, tb.v3))
        tb.click();
  } 
  
  void update(){}
  void press(int x, int y){}
 
 
 abstract class TriButton{
   boolean up;
   PVector v1,v2,v3;
   Settings s;
   public TriButton(boolean up, float x, float y, Settings sm){
     this.up = up;
     this.s = sm;
     v1 = new PVector(x-50,y);
     v2 = new PVector(x+50,y);
     if(up)
       v3 = new PVector(x,y+100);
     else
       v3 = new PVector(x,y-100);
   }
   
   public void ddraw(){
     fill(255);
     triangle(v1.x,v1.y,v2.x,v2.y,v3.x,v3.y);
   }
   
   abstract void click();
 }
  
}
