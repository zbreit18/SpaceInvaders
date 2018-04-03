import processing.sound.*;

public class Bullet extends RectCollider {
    float m_ySpeed;
    color m_bulletColor;
    SoundFile laserSound;
    
    RectCollider hitBox;

    Bullet(int x, int y, float speed, color temp_color) {
        super(x, y, 4, 8);
        m_ySpeed = speed; 

        m_bulletColor = temp_color;

        laserSound = new SoundFile(SpaceInvaders.this, "laser.mp3");
        laserSound.play();
    }

    void Update() {
        pushStyle();
        noStroke();
        fill(m_bulletColor);
        m_y += m_ySpeed;
        rect(m_x, m_y + m_height, m_width, m_height);
        popStyle();
    }
    
    @Override
    boolean HasTopEdgeIn(RectCollider rect) {
        return InRange(rect.GetTopY(), GetTopY() + GetHeight(), rect.GetBottomY());
    }

    @Override
    boolean HasBottomEdgeIn(RectCollider rect) {
        return InRange(rect.GetTopY(), GetBottomY() + GetHeight(), rect.GetBottomY());
    }

    int GetYPos() {
        return m_y;
    }

    int GetHeight() {
        return m_height;
    }
};
