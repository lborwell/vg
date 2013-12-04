public interface State{
  void ddraw();
  void update();
  void press(int x, int y);
  void release(int x, int y);
}
