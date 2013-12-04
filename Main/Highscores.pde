import java.util.Collections;
import java.util.Comparator;

import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

/*
* Leaderboard table. Reads csv file //sdcard//scores.csv.
* Currently only works with one leaderboard, for some reason couldn't get multiple files
* to load. This kinda sucks.
*/
class Highscores implements State{
  Main m;
  Table t;
  ArrayList<TableRow> trows = new ArrayList<TableRow>();
  String file;
  
  void ddraw(){
    background(0);
    fill(100, 0, 100);
    rect(0, 0, 50, 50);
    
    textSize(64);
    textAlign(CENTER);
    fill(128,128,128);
    
    getTable();
    drawTitle();
    drawValues();
  }
  
  public Highscores(Main m){
    this.m = m;
    file = "//sdcard//scores.csv";
  }
  
  void addScore(int score){
    getTable();
    DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
    DateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
    Date date = new Date();
    
    TableRow nr = t.addRow();
    nr.setString("date",dateFormat.format(date));
    nr.setString("time",timeFormat.format(date));
    nr.setString("score",Integer.toString(score));
    
    saveTable(t, file);
  }
  
  void getTable(){
    /*File f = new File(file);
    if(!(new File(file)).exists()){
      f.mkdirs();
      try{
        f.createNewFile();
      }catch(Exception e){ e.printStackTrace(); }
      saveStrings(f, new String[]{"date,time,score"});
    }*/
    
    trows.clear();
    t = loadTable(file, "header");
    for(int i=0; i<t.getRowCount(); i++)
      trows.add(t.getRow(i));
  }
  
  void drawTitle(){
    text("Highscores",displayWidth/2,75);
  }
  
  void drawValues(){
    Collections.sort(trows, new RowComparator());
    for(int i=0; i<trows.size(); i++){
      TableRow tr = trows.get(i);
      text(tr.getString("date"),displayWidth/2-500,200+i*100);
      text(tr.getString("time"),displayWidth/2,200+i*100);
      text(tr.getString("score"),displayWidth/2+500,200+i*100);
    }
  }
  
  void update(){}
  void press(int x, int y){}
  
  void release(int x, int y){
    if (x <= 50)
      if (y <= 50) {
        m.state = m.menus.get("main");
        return;
      }
  }
  
  class RowComparator implements Comparator<TableRow>{
    public int compare(TableRow t1, TableRow t2){
      return t2.getInt("score") - t1.getInt("score");
    }
  }
}
