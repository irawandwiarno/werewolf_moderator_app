import '../../shared/packages.dart';

class MyText {
  static TextStyle oversize({Color color = Colors.black}) {
    return TextStyle(fontSize: 100, fontWeight: FontWeight.w700, color: color);
  }

  static TextStyle h1({Color color = Colors.black}) {
    return TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: color);
  }

  static TextStyle h2({Color color = Colors.black}) {
    return TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: color);
  }

  static TextStyle h3({Color color = Colors.black}) {
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  static TextStyle h4({Color color = Colors.black}) {
    return TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color);
  }

  static TextStyle h5({Color color = Colors.black}) {
    return TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color);
  }

  static TextStyle title({Color color = Colors.black}) {
    return TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color);
  }

  static TextStyle subtitle({Color color = Colors.black}) {
    return TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: color);
  }
}
