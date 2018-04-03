public class MotherShip extends Shooter {
    static final int m_xVelocity        = 6;
    static final int m_bulletCooldownMS = 500;

    int m_prevFireTimeMS;

    PShape m_shape;

    HashMap<Integer, Boolean> m_keyStates;
    boolean m_prevFireKeyState;

    MotherShip(int x) {
        super(x, height - 100, 100, 100, 100, -6, color(0, 255, 0), 5);
        m_width = 100;

        m_x = x;
        m_y = height - int(1.5 * m_height);

        m_prevFireTimeMS = 0;

        m_shape = loadShape("ship.svg");

        m_keyStates = new HashMap<Integer, Boolean>();
        m_keyStates.put(LEFT, false);
        m_keyStates.put(RIGHT, false);
        m_keyStates.put(int(' '), false);

        m_prevFireKeyState = false;

        m_hitBoxes.add(new RectCollider(m_x + int(0.1 * m_width), m_y + int(0.45 * m_height), int(0.8 * m_width), int(0.45 * m_height)));
        m_hitBoxes.add(new RectCollider(m_x + int(0.375 * m_width), m_y + int(0.125 * m_height), m_width / 4, m_height / 3));
    }

    // This function, which updates the current status of a command key,
    // is called every time a key is pressed or released
    void UpdateKeyStates(boolean state) {
        if (m_keyStates.containsKey(int(key))) {
            m_keyStates.put(int(key), state);
        } else if (m_keyStates.containsKey(keyCode)) {
            m_keyStates.put(keyCode, state);
        }

        if (ShouldCreateNewBullet(state)) {
            m_prevFireTimeMS = millis();
            CreateNewBullet(m_x + m_width / 2 - 2, m_y);
        }

        m_prevFireKeyState = m_keyStates.get(int(' '));
    }

    @Override
        boolean ShouldCreateNewBullet(boolean state) {
        // If the space key was just pressed (not held down)
        if (key == ' ' && !m_prevFireKeyState && state) {
            if (millis() - m_prevFireTimeMS > m_bulletCooldownMS) {
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }

    // Changes the location of the spaceship based on the keys currently being pressed
    void Relocate() {
        int deltaX = GetDeltaX();
        if (IsInBounds(deltaX)) {
            m_x += deltaX;
            RelocateHitboxes(deltaX);
        }
    }

    void RelocateHitboxes(int deltaX) {
        for (Collider hitBox : m_hitBoxes) {
            hitBox.IncrementX(deltaX);
        }
    }

    void Display() {
        shape(m_shape, m_x, m_y, m_width, m_height);
    }

    void DisplayHitBoxes() {
        for (Collider hitBox : m_hitBoxes) {
            hitBox.Outline();
        }
    }

    void DetectCollisionsWith(ArrayList<Enemy> enemyList) {
        for (Enemy enemy : enemyList) {
            DetectCollisionsWith(enemy);
        }
    }

    void UpdateHealthBar() {
        final int MAX_HEALTH_BAR_WIDTH = 200;
        final int HEALTH_BAR_HEIGHT = 30;

        // Draw outline
        pushStyle();
        noFill();
        stroke(255);
        strokeWeight(2);
        rect(width - int(1.125 * MAX_HEALTH_BAR_WIDTH), height - int(1.5 * HEALTH_BAR_HEIGHT), MAX_HEALTH_BAR_WIDTH, HEALTH_BAR_HEIGHT);

        // Draw health bar %
        noStroke();
        fill(GetHealthBarRGB());
        
        rect(width - int(1.125 * MAX_HEALTH_BAR_WIDTH), height - int(1.5 * HEALTH_BAR_HEIGHT), int(m_health / m_maxHealth * MAX_HEALTH_BAR_WIDTH), HEALTH_BAR_HEIGHT);
        text("Health " + m_health, width - int(1.9 * MAX_HEALTH_BAR_WIDTH), height - int(0.8 * HEALTH_BAR_HEIGHT));

        popStyle();
    }
    
    color GetHealthBarRGB() {
        int red, green;
        if(m_health > 0.5 * m_maxHealth) {
            // Red goes from 0 --> 255 as m_health goes from m_maxHealth --> 1/2*m_maxHealth
            red   = int(255 * 2 * (m_maxHealth - float(m_health)) / m_maxHealth); 
            green = 255;
        } else {
            red   = 255;
            green = int(255 * 2 * m_health / m_maxHealth); ;
        }
        
        System.out.printf("(R, G, B): (%d, %d, %d)\n", red, green, 0);
        
        return color(red, green, 0);
    }

    void Update() {
        Relocate();
        Display();
        UpdateBullets();
        UpdateHealthBar();
    }

    // Returns the change in pixels that occurs during the current frame
    int GetDeltaX() {
        return ((m_keyStates.get(LEFT) ? -1 : 0) + (m_keyStates.get(RIGHT) ? 1: 0)) * m_xVelocity;
    }

    int GetLeftX() {
        return m_x;
    }

    int GetRightX() {
        return m_x + m_width;
    }

    boolean IsInBounds(int deltaX) {
        return GetLeftX() + deltaX > 0 && GetRightX() + deltaX < width;
    }
};
