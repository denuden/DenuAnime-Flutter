import 'package:intl/intl.dart';

/// A helper class for formatting DateTime dynamically.
class DateTimeFormatter {
  /// Formats a given [dateTime] using the provided [pattern].
  /// Example patterns: 'yyyy-MM-dd', 'MMM d, yyyy', 'EEEE, MMM d'
  static String format(DateTime dateTime, String pattern, {String? locale}) {
    final formatter = DateFormat(pattern, locale);
    return formatter.format(dateTime);
  }

  /// Parses an ISO8601 string into DateTime and formats it.
  static String formatFromIso(
    String isoString,
    String pattern, {
    String? locale,
    String fallback = "---",
  }) {
    try {
      final dateTime = DateTime.parse(isoString);
      return format(dateTime, pattern, locale: locale);
    } catch (_) {
      return fallback;
    }
  }
}
