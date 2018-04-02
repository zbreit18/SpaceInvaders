Ship ship;
Enemy enemy;
color bgColor = color(0, 0, 25);

void setup() {
    size(1000, 500);
    frameRate(60);
    background(bgColor);
    
    ship = new Ship(50);
    enemy = new Enemy(50, 50, 0, color(255));
}

void draw() {
    background(bgColor);
    ship.Update();
    enemy.Update();
    System.out.println(frameRate);
}

void keyPressed() {
    ship.UpdateKeyStates(true);
}

void keyReleased() {
    ship.UpdateKeyStates(false);
}
