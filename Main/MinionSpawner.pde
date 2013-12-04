class MinionSpawner extends Thread{
  public MinionSpawner(Rift r, int mode){
    this.r = r;
    this.mode = mode;
  }
  
  int wavesSpawned = 0;
  int mode; // 0 == symmetric, 1 == enemies only
  Rift r;
  long minionspawnShort;
  long minionspawnLong;
  int minCount = 0;
  boolean spawning = true;
  boolean active = true;
  boolean quit = false;
  
  void start(){
    wavesSpawned=0;
    minionspawnShort = System.currentTimeMillis();
    minionspawnLong = System.currentTimeMillis()+30000;
    super.start();
  }
  
  void run(){
    while(true){
      if(!active) continue;
      if(quit) return;
      if(spawning){
        if(minCount == 6){
          minCount = 0;
          spawning = false;
          continue;
        }
        try{
          Thread.sleep((long)(minionspawnShort-System.currentTimeMillis()));
        }catch(Exception e){}
        if(minCount < 3){
          synchronized(r.creatures){
            if(mode == 0)
              r.creatures.add(new MeleeMinion(new PVector(0,displayHeight/2+minCount),2f,r,0));
            r.creatures.add(new MeleeMinion(new PVector(displayWidth-1,displayHeight/2+minCount),2f,r,1));
          }
        }else{
          synchronized(r.creatures){
            if(mode == 0)
              r.creatures.add(new RangedMinion(new PVector(0,displayHeight/2+minCount),2f,r,0));
            r.creatures.add(new RangedMinion(new PVector(displayWidth-1,displayHeight/2+minCount),2f,r,1));
          }
        }
        minCount++;
        minionspawnShort = System.currentTimeMillis() + 750;
      }else{
        try{
          wavesSpawned++;
          Thread.sleep((long)(minionspawnLong - System.currentTimeMillis()));
          minionspawnLong  = System.currentTimeMillis() + 30000;
        }catch(Exception e){}
        spawning = true;
      }
    }
  }
}
