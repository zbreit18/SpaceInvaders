public class Enemy extends Shooter {
    float m_fallSpeed;
    color m_bodyColor;
    int i = 0;

    Enemy(int x, int y, float fallSpeed, int health, color bodyColor, int bulletDamage) {
        super(x, y, 50, 50, health, 3, color(255, 0, 0), bulletDamage);
        m_fallSpeed = fallSpeed;
        m_bodyColor = bodyColor;

        m_hitBoxes.add(new RectCollider(m_x, m_y, m_width, m_height));
    }

    void Display() {
        pushStyle();
        fill(m_bodyColor);
        noStroke();
        rect(m_x, m_y, m_width, m_height);
        popStyle();
    }

    void DisplayHitboxes() {
        for (RectCollider hitBox : m_hitBoxes) {
            hitBox.Outline();
        }
    }

    void Update() {
        i++;
        if (i % 60 == 0) {
            CreateNewBullet(m_x + m_width / 2 - 2, m_y + m_height);
        }
        Display();
        UpdateBullets();
    }

    void DetectHitBoxCollisions(MotherShip player) {
        ArrayList<Bullet> collidedBullets = new ArrayList<Bullet>();

        for (RectCollider hitBox : m_hitBoxes) {
            for (Bullet bullet : player.GetBulletList()) {
                if (hitBox.CollidedWith(bullet)) {
                    collidedBullets.add(bullet);
                }
            }
        }

        HandleCollisionWith(player, collidedBullets);
    }
}
