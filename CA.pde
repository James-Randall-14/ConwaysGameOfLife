public class CA {
  private Cell[][] current;
  private Cell c;
  private boolean status;
  private boolean random;
  private boolean aging;

  public CA(int x, int y) {
    current = new Cell[x][y];
    status = false;
    random = false;
    aging = false;
    c = null;

    for (int i = 0; i < current.length; i++) {
      for (int j = 0; j < current[i].length; j++) {
        current[i][j] = new Cell(j, i, false);
      }
    }
  }
  
  public void start() { status = true; }
  
  public Cell getCell(int x, int y) { return current[y / 8][x / 8]; }
  
  public void editTile() {
    if (c != ca.getCell(mouseX, mouseY)) {
      ca.getCell(mouseX, mouseY).flipStatus();
      c = ca.getCell(mouseX, mouseY);
    }
  }
  
  public void randomize(){
    for (int i = 0; i < current.length; i++) {
      for (int j = 0; j < current[i].length; j++) {
        if (Math.random() < 0.5) { current[i][j].flipStatus(); }
      }
    }
  }
  
  public void clearCell() { c = null; }
  
  public boolean getAging() { return aging; }
  public boolean getRandom() { return random; }
  public void setAging() { aging = !aging; }
  public void setRandom() { random = !random; }
  
  public void run() {
    if (mousePressed) { ca.editTile(); }
    strokeWeight(1);
    fill(255);
    renderCells();
    if (!status) { return; }
    if (!random) { calculateNextGeneration(); }
    else { calculateNextRandomGeneration(); }
  }

  private void renderCells() {
    for (int i = 0; i < current.length; i++) {
      for (int j = 0; j < current[i].length; j++) {
        current[i][j].render();
      }
    }
  }

  private void calculateNextGeneration() {
    Cell[][] next = new Cell[current.length][current[0].length];
    
    for (int i = 0; i < current.length; i++) {
      for (int j = 0; j < current[i].length; j++) {
        int neighbors = countLivingNeighbors(i, j);
        if(current[i][j].getAge() <= 25) {
          if (current[i][j].isAlive()) {
            if (neighbors == 2 || neighbors == 3) {
              next[i][j] = new Cell(j, i, true, current[i][j].getAge() + 1);
            } else {
              next[i][j] = new Cell(j, i, false);
            }
          } else {
            if (neighbors == 3) {
              next[i][j] = new Cell(j, i, true);
            } else {
              next[i][j] = new Cell(j, i, false);
            }
          }
        } else { next[i][j] = new Cell(j, i, false); }
      }
    }
    current = next;
  }
  
  private void calculateNextRandomGeneration() {
    Cell[][] next = new Cell[current.length][current[0].length];
    
    for (int i = 0; i < current.length; i++) {
      for (int j = 0; j < current[i].length; j++) {
        int neighbors = countLivingNeighbors(i, j);
        if (current[i][j].getAge() <= 25){
          if (current[i][j].isAlive()) {
            if (neighbors == 2 || neighbors == 3) {
              next[i][j] = new Cell(j, i, true, current[i][j].getAge() + 1);
            } else if (neighbors <= 1 && Math.random() < 0.6) {
              next[i][j] = new Cell(j, i, false);
            } else if (neighbors >= 4 && Math.random() < 0.8) {
              next[i][j] = new Cell(j, i, false);
            } else { next[i][j] = new Cell(j, i, true); }
          }  else {
            if (neighbors == 3) {
              next[i][j] = new Cell(j, i, true);
            } else {
              next[i][j] = new Cell(j, i, false);
            }
          }
        } else { next[i][j] = new Cell(j, i, false); }
      }
    }
    current = next;
  }

  private int countLivingNeighbors(int r, int c) {
    int count = 0;

    // upper-left
    if (r >= 1 && c >= 1 && current[r - 1][c - 1].isAlive()) {
      count++;
    }
    // top
    if (r >= 1 && current[r - 1][c].isAlive()) {
      count++;
    }
    // upper-right
    if (r >= 1 && c < current[0].length - 1 && current[r - 1][c + 1].isAlive()) {
      count++;
    }
    // left
    if (c >= 1 && current[r][c - 1].isAlive()) {
      count++;
    }
    // right
    if (c < current[0].length - 1 && current[r][c + 1].isAlive()) {
      count++;
    }
    // lower-left
    if (r < current.length - 1 && c >= 1 && current[r + 1][c - 1].isAlive()) {
      count++;
    }
    // lower
    if (r < current.length - 1 && current[r + 1][c].isAlive()) {
      count++;
    }
    // lower-right
    if (r < current.length - 1 && c < current[0].length - 1 && current[r + 1][c + 1].isAlive()) {
      count++;
    }

    return count;
  }
  
  // Custom setups
  public void createShape(int[][] cords, int x, int y) {
    for (int cord = 0; cord < cords.length; cord++) {
      getCell(x + cords[cord][0] * 8, y + cords[cord][1] * 8).flipStatus();
    }
  }
  
  // Custom shapes
  private int[][] p = {{0,0},{0,1},{0,2},{1,0},{1,2},{2,0},{2,1},{2,2},{3,0},{3,1},{3,2},{4,0},{4,1},{4,2},{5,0},{5,1},{5,2},{6,0},{6,2},{7,0},{7,1},{7,2}};
  public int[][] penta() { return p; }
  
  private int[][] g = {{1,5},{2,5},{1,6},{2,6},{11,5},{11,6},{11,7},{12,4},{12,8},{13,3},{13,9},{14,3},{14,9},{15,6},{16,4},{16,8},{17,5},{17,6},{17,7},{18,6},{21,3},{21,4},{21,5},{22,3},{22,4},{22,5},{23,2},{23,6},{25,1},{25,2},{25,6},{25,7},{35,3},{35,4},{36,3},{36,4}};
  public int[][] gun() { return g; }
}
