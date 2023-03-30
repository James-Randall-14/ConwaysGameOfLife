public class Info {
  private int x;
  private int y;
  private int w;
  private int h;
  private boolean hidden;
  
  public Info() {
    x = 600;
    y = 675;
    w = 300;
    h = 220;
    hidden = false;
    textSize(18);
  }
  
  public void flip() { hidden = !hidden; }
  public void hide() { hidden = true; }
  
  public void render(boolean aging, boolean random) {
    if (hidden) { return; }
    strokeWeight(4);
    fill(255);
    
    rect(x, y, w, h);
    rect(x, y + h + 15, w * 0.75, h / 4);
        
    fill(0);
    text("Press p to spawn a Pentadecathlon.", x + 10, y + 30);
    text("Press g to spawn Gosper's Glider Gun.", x + 10, y + 55);
    text("Press r to randomize all tiles.", x + 10, y + 80);
    text("Press x to close or open this window.", x + 10, y + 105);
    text("Press e to enable random generation", x + 10, y + 130);
    text("Press a to enable cell aging", x + 10, y + 155);
    text("Click or drag anywhere to flip a cell", x + 10, y + 180);
    text("Press space to begin!", x + 10, y + 205);
    
    text("Random Generation: " + random, x + 10, y + h + 38);
    text("Cell Aging: " + aging, x + 10, y + h + 60);
  }
}
