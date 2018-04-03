class RectCollider extends Collider {

    RectCollider(int x, int y, int _width, int _height) {
        super(x, y, _width, _height);
    }

    // Override this function if other types of colliders are implemented
    boolean CollidedWith(RectCollider collider) {
        // If the bottom or top edge of the collider are inside the other collider AND the left or right edge is also inside, then there has been a collision
        if ((collider.HasBottomEdgeIn(this) || collider.HasTopEdgeIn(this)) && collider.HasLeftOrRightEdgeIn(this)) {
            return true;
        }
        return false;
    }

    boolean HasTopEdgeIn(RectCollider rect) {
        return InRange(rect.GetTopY(), GetTopY(), rect.GetBottomY());
    }

    boolean HasBottomEdgeIn(RectCollider rect) {
        return InRange(rect.GetTopY(), GetBottomY(), rect.GetBottomY());
    }

    boolean HasLeftOrRightEdgeIn(RectCollider rect) {
        return InRange(rect.GetLeftX(), GetRightX(), rect.GetRightX()) ||
            InRange(rect.GetLeftX(), GetLeftX(), rect.GetRightX());
    }

    boolean InRange(int min, int n, int max) {
        return (min < n && n < max);
    }
}
