MotherShip ship;
ArrayList<Enemy> enemies;
color bgColor = color(0, 0, 25);

void setup() {
    size(1000, 500);
    frameRate(60);
    background(bgColor);

    ship = new MotherShip(50);
    enemies = new ArrayList<Enemy>();
    enemies.add(new Enemy(50, 50, 0, color(255)));
}

void draw() {
    background(bgColor);
    ship.Update();
    ship.DetectHitBoxCollisions(enemies);
    updateEnemies();
}

void updateEnemies() {
    for(Enemy enemy : enemies) {
        enemy.Update();
        enemy.DetectHitBoxCollisions(ship);
    }
}

void keyPressed() {
    ship.UpdateKeyStates(true);
}

void keyReleased() {
    ship.UpdateKeyStates(false);
}
