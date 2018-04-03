public class Collider {
    int m_x;
    int m_y;
    int m_width;
    int m_height;
    
    Collider(int x, int y, int _width, int _height) {
        m_x = x;
        m_y = y;
        m_width = _width;
        m_height = _height;
    }
    
    void Outline() {
        pushMatrix();
        noFill();
        stroke(0, 255, 255);
        rect(m_x, m_y, m_width, m_height);
        popMatrix();
    }
    
    int GetTopY() {
        return m_y;
    }
    
    int GetBottomY() {
        return m_y + m_height;
    }
    
    int GetLeftX() {
        return m_x;
    }

    int GetRightX() {
        return m_x + m_width;
    }
    
    void IncrementX(int x) {
        m_x += x;
    }
    
    void IncrementY(int y) {
        m_y += y;
    }
}
