abstract class WidgetSize {
  final double _height;
  final double _width;

  const WidgetSize(this._height, this._width);

  double get height => _height;
  double get width => _width;
}

class RatioSize extends WidgetSize {
  final double ratio;
  final double size;

  const RatioSize({required this.ratio, required this.size})
      : super(size / ratio, size);
}

class SquareSize extends RatioSize {
  const SquareSize({required super.size}) : super(ratio: 1.0);
}

class S169Size extends RatioSize {
  const S169Size({required super.size}) : super(ratio: 16.0 / 9.0);
}

class ExpandSize extends WidgetSize {
  const ExpandSize() : super(double.maxFinite, double.maxFinite);
}
