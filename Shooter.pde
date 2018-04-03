public class Shooter {
    int m_x;
    int m_y;
    int m_width;
    int m_height;

    float m_bulletSpeed;
    color m_bulletColor;
    ArrayList<Bullet> m_bullets;
    
    ArrayList<RectCollider> m_hitBoxes;

    Shooter(int x, int y, int _width, int _height, float speed, color bulletColor) {
        m_x = x;
        m_y = y;
        m_width = _width;
        m_height = _height;
        m_bulletSpeed = speed;
        m_bulletColor = bulletColor;
        m_bullets = new ArrayList<Bullet>();
        
        m_hitBoxes = new ArrayList<RectCollider>();
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
        // The index of the new bullet is the previous size of the bullets array list
        m_bullets.add(new Bullet(xStart, yStart, m_bulletSpeed, m_bulletColor));
    }
    
    void RemoveBullet(Bullet bullet) {
        m_bullets.remove(bullet);
    }
    
    
    void HandleCollisionWith(Shooter bulletSource, Bullet bullet) {
        bulletSource.RemoveBullet(bullet); //<>//
        // m_health -= bullet.GetDamage();
    }
    
    void HandleCollisionWith(Shooter bulletSource, ArrayList<Bullet> bullets) {
        for(Bullet bullet : bullets) {
            HandleCollisionWith(bulletSource, bullet);
        }
    }

    void UpdateBullets() {
        for (int bulletIndex = 0; bulletIndex < m_bullets.size(); bulletIndex++) {
            Bullet bullet = m_bullets.get(bulletIndex);

            if (bullet.GetHeight() + bullet.GetYPos() < 0 || bullet.GetYPos() > height) {
                m_bullets.remove(bulletIndex);
            } else {                    
                bullet.Update();
            }
        }
    }
    
    ArrayList<Bullet> GetBulletList() {
        return m_bullets;
    }
}
