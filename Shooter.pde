public class Shooter {
    int m_x;
    int m_y;
    int m_width;
    int m_height;
    
    public float m_bulletSpeed;
    public color m_bulletColor;
    public ArrayList<Bullet> m_bullets;
    
    Shooter(int x, int y, int _width, int _height, float speed, color bulletColor) {
        m_x = x;
        m_y = y;
        m_width = _width;
        m_height = _height;
        m_bulletSpeed = speed;
        m_bulletColor = bulletColor;
        m_bullets = new ArrayList<Bullet>();
    }
    
    // Should be overridden
    boolean ShouldCreateNewBullet(boolean state) {
        return false;
    }
    
    // Should be overridden
    boolean ShouldCreateNewBullet() {
        return false;
    }
    
    void CreateNewBullet(int xStart, int yStart) {
        m_bullets.add(new Bullet(xStart, yStart, m_bulletSpeed, m_bulletColor));
    }
    
    void UpdateBullets() {
        for (int bulletIndex = 0; bulletIndex < m_bullets.size(); bulletIndex++) {
            Bullet bullet = m_bullets.get(bulletIndex);

            if (bullet.getHeight() + bullet.getYPos() < 0 || bullet.getYPos() > height) {
                m_bullets.remove(bulletIndex);
            } else {                    
                bullet.Update();
            }
        }
     }
}
