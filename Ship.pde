public class Ship extends Shooter {
    static final int m_xVelocity        = 6;
    static final int m_bulletCooldownMS = 500;
    
    int m_prevFireTimeMS;
    
    PShape m_shape;
    
    final int[] KEY_LOOKUP;
    boolean[] m_keyStates;
    boolean m_prevFireKeyState;
    ArrayList<Bullet> m_bullets;

    Ship(int x) {
        // 100 = Width and 100 = height
        super(x, height - 100, 100, 100, -6, color(0, 255, 0));
        m_width = 100;
        
        m_x = x;
        m_y = height - m_height;
        
        m_prevFireTimeMS = 0;
        
        m_shape = loadShape("ship.svg");
       
        KEY_LOOKUP = new int[]{LEFT, RIGHT, ' '};
        m_keyStates = new boolean[]{false, false, false};
        m_prevFireKeyState = false;
        m_bullets = new ArrayList<Bullet>();
    }

    // This function, which updates the current status of a command key,
    // is called every time a key is pressed or released
    void UpdateKeyStates(boolean state) {
        for (int i = 0; i < KEY_LOOKUP.length; i++) {
            if (keyCode == KEY_LOOKUP[i] || key == KEY_LOOKUP[i]) {
                m_keyStates[i] = state;
            }
        }
        
        if(m_keyStates[0] && m_keyStates[1]) {
            if(key == ' ') {}
        }
        
        if(ShouldCreateNewBullet(state)) {
            m_prevFireTimeMS = millis();
            CreateNewBullet(m_x + m_width / 2 - 2, m_y);
        }
        
        m_prevFireKeyState = m_keyStates[2];
    }
    
    @Override
    boolean ShouldCreateNewBullet(boolean state) {
        // If the space key was just pressed (not held down)
        if(key == ' ' && !m_prevFireKeyState && state) {
            if(millis() - m_prevFireTimeMS > m_bulletCooldownMS) {
                return true;
            }
            else {
                return false;    
            }
        } else {
            return false;    
        }
    }

    // Changes the location of the spaceship based on the keys currently being pressed
    void Relocate() {
        int deltaX = GetDeltaX();
        if(IsInBounds(deltaX)) {
            m_x += deltaX;
        }
    }

    void Display() {
        shape(m_shape, m_x, m_y, m_width, m_height);
    }

    void Update() {
        Relocate();
        Display();
        UpdateBullets();
    }
    
    int GetLeftX() {
        return m_x;    
    }
    
    int GetRightX() {
        return m_x + m_width;
    }
    
    int GetDeltaX() {
        return ((m_keyStates[0] ? -1 : 0) + (m_keyStates[1] ? 1: 0)) * m_xVelocity;
    }
    
    boolean IsInBounds(int deltaX) {
        return GetLeftX() + deltaX > 0 && GetRightX() + deltaX < width;    
    }
    
    void CheckForCollisions() {
        if(true) {
                
        }
    }
};
