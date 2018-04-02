import processing.sound.*;

public class Bullet {
    int m_x;
    int m_y;
    float m_ySpeed;
    int m_height;
    int m_width;
    color m_bulletColor;
    SoundFile laserSound;
    
    Bullet(int x, int y, float speed, color temp_color) {
        m_x = x;
        m_y = y;
        m_ySpeed = speed; 
        
        m_height = 8;
        m_width = 4;
        
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
    
    int getYPos() {
        return m_y;    
    }
    
    int getHeight() {
        return m_height;    
    }
};
