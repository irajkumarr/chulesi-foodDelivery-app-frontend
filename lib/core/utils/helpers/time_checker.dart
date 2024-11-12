class TimeChecker {
  static bool isServiceAvailable() {
    final currentTime = DateTime.now();
    final hour = currentTime.hour;

    // Check if current time is between 10 PM (22:00) and 12 AM (00:00)
    return !(hour >= 23 || hour < 8); // Service is unavailable after 10 PM
  }
}
