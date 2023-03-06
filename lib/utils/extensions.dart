extension Capitalize on String {
  String capitalizeFirstLetter() {
    return '${substring(0, 1).toUpperCase()}${substring(1)}';
  }
}
