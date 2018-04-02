public class Enemy extends Shooter {
    float m_fallSpeed;
    color m_bodyColor;
    int i = 0;
    
    ArrayList<Bullet> m_bullets;
    
    Enemy(int x, int y, float fallSpeed, color bodyColor) {
        super(x, y, 50, 50, 3, color(255, 0, 0));
        m_fallSpeed = fallSpeed;
        m_bodyColor = bodyColor;
    }
    
    void Display() {
        pushStyle();
        fill(m_bodyColor);
        rect(m_x, m_y, m_width, m_height);
        popStyle();
    }
    
    void Update() {
        ++i;
        if (i % 60 == 0) {
            CreateNewBullet(m_x + m_width / 2 - 2, m_y + m_height);
        }
        Display();
        UpdateBullets();    
    }
}
