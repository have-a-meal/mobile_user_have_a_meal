class TimeParse {
  static String getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    int timeValue;
    String timeUnit;

    if (difference.inDays >= 365) {
      timeValue = (difference.inDays / 365).floor();
      timeUnit = '년';
    } else if (difference.inDays >= 30) {
      timeValue = (difference.inDays / 30).floor();
      timeUnit = '개월';
    } else if (difference.inDays >= 7) {
      timeValue = (difference.inDays / 7).floor();
      timeUnit = '주';
    } else if (difference.inDays >= 1) {
      timeValue = difference.inDays;
      timeUnit = '일';
    } else if (difference.inHours >= 1) {
      timeValue = difference.inHours;
      timeUnit = '시간';
    } else if (difference.inMinutes >= 1) {
      timeValue = difference.inMinutes;
      timeUnit = '분';
    } else {
      return '방금 전';
    }

    return '$timeValue$timeUnit 전';
  }
}
