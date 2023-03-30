CA ca;
Info box;

void settings() { size(1000, 1000); }

void setup() {
  ca = new CA(displayHeight / 8, displayWidth / 8);
  box = new Info();
  frameRate(20);
}

void draw() { ca.run(); box.render(ca.getAging(), ca.getRandom()); }

void mouseReleased() { ca.clearCell(); }
  
void keyPressed() {
  if (key == ' ') { ca.start(); box.hide(); } 
  else if (key == 'p') { ca.createShape(ca.penta(), 468, 484); }
  else if (key == 'g') { ca.createShape(ca.gun(), 200, 200); }
  else if (key == 'r') { ca.randomize(); }
  else if (key == 'x') { box.flip(); }
  else if (key == 'e') { ca.setRandom(); }
  else if (key == 'a') { ca.setAging(); }
}
