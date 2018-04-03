public class Shooter {
    int m_x;
    int m_y;
    int m_width;
    int m_height;
    int m_health;
    float m_maxHealth;

    float m_bulletSpeed;
    color m_bulletColor;
    int m_bulletDamage;
    ArrayList<Bullet> m_bullets;
    
    ArrayList<RectCollider> m_hitBoxes;

    Shooter(int x, int y, int _width, int _height, int health, float bulletSpeed, color bulletColor, int bulletDamage) {
        m_x = x;
        m_y = y;
        m_width = _width;
        m_height = _height;
        m_maxHealth = health;
        m_health = health;
        m_bulletSpeed = bulletSpeed;
        m_bulletColor = bulletColor;
        m_bulletDamage = bulletDamage;
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
        m_bullets.add(new Bullet(xStart, yStart, m_bulletSpeed, m_bulletColor, m_bulletDamage));
    }
    
    void RemoveBullet(Bullet bullet) {
        m_bullets.remove(bullet);
    }
    
    void HandleCollisionWith(Shooter bulletSource, Bullet bullet) {       
        m_health -= bullet.GetDamage();
        bulletSource.RemoveBullet(bullet); //<>//
    }
    
    void HandleCollisionWith(Shooter bulletSource, ArrayList<Bullet> bullets) {
        for(Bullet bullet : bullets) {
            HandleCollisionWith(bulletSource, bullet);
        }
    }
    
    void DetectCollisionsWith(Shooter otherShip) {
        ArrayList<Bullet> collidedBullets = new ArrayList<Bullet>();

        for (RectCollider hitBox : m_hitBoxes) {
            for (Bullet bullet : otherShip.GetBulletList()) {
                if (hitBox.CollidedWith(bullet)) {
                    collidedBullets.add(bullet);
                }
            }
        }
        
        // Have to do this after the fact to prevent from iterating over an empty array list
        HandleCollisionWith(otherShip, collidedBullets);
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
