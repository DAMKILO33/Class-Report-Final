class Formatters {
  static String formatPrice(double price) {
    return 'S/. ${price.toStringAsFixed(2)}';
  }

  static String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
