import 'dart:ui';

import 'package:flame/components.dart';

/// Helpers for checking component positions against the visible world bounds.
class ViewportBounds {
  ViewportBounds(this.rect);

  final Rect rect;

  /// Returns true when a position is outside the visible rect by [margin].
  bool isOutsidePosition(Vector2 position, {double margin = 0}) {
    return position.x < rect.left - margin ||
        position.x > rect.right + margin ||
        position.y < rect.top - margin ||
        position.y > rect.bottom + margin;
  }

  /// Returns true when a component is outside the visible rect by [margin].
  bool isOutsideComponent(PositionComponent component, {double margin = 0}) {
    final halfSize = component.size / 2;
    return component.position.x - halfSize.x < rect.left - margin ||
        component.position.x + halfSize.x > rect.right + margin ||
        component.position.y - halfSize.y < rect.top - margin ||
        component.position.y + halfSize.y > rect.bottom + margin;
  }
}
