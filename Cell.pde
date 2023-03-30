public class Cell {
  private boolean isAlive;
  private int x;
  private int y;
  private int age;
  
  public Cell(int x, int y, boolean isAlive) {
    this.x = x;
    this.y = y;
    this.isAlive = isAlive;
    age = 0;
  }
  
  public Cell(int x, int y, boolean isAlive, int age) {
    this.x = x;
    this.y = y;
    this.isAlive = isAlive;
    this.age = age;
  }
  
  public int getAge() { return age; }
  
  public void flipStatus() { isAlive = !isAlive; }
  
  public void render() {
    if (isAlive) {
      fill(age * 8);
    } else {
      fill(255);
    }
    rect(x * 8, y * 8, 8, 8);
  }
  
  public boolean isAlive() {
    return this.isAlive;
  }
}
