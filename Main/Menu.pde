class Menu implements State{
  ArrayList<MenuItem> options = new ArrayList<MenuItem>();
  String title;
  Main m;
  
  public Menu(String title, Main m){
    this.title = title; 
    this.m = m;
  }
  
  void press(int x, int y){
    for(MenuItem mi : options)
      if(Utils.inRect(new PVector(x,y), new PVector(mi.p.x, mi.p.y-64), textWidth(mi.opt), 64f)){
        mi.click();
        return;
      }
  }
  
  float textX(String s){
    return ((float)displayWidth/2) - (textWidth(s)/2);
  }
  
  float textY(int i){
    return 200+ i*100;
  }
  
  void update(){}
  
  void addItem(MenuItem a){
    options.add(a);
    a.setPosition(new PVector(textX(a.opt), textY(options.size())));
  }
  
  void ddraw(){
    background(0);
    textSize(64);
    drawText(title,0-1);
    for(MenuItem mi : options)
      drawText(mi);
  }
  
  void drawText(String s, int i){
    text(s,textX(s),textY(i+1));
  }
  
  void drawText(MenuItem mi){
    text(mi.opt, mi.p.x, mi.p.y);
  }
}
