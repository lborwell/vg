abstract class MenuItem{
  String opt;
  Main m;
  
  PVector p;
  
  public MenuItem(String s, Main m){
    this.opt = s;
    this.m = m;
  }
  
  public void setPosition(PVector p){
    this.p = p;
  }
  
  public abstract void click();
}
