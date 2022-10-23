class Utils {
  static String getCurrentDate() {
    var now = DateTime.now();
    return now.toString().substring(0, 10);
  }
}
