class SafeParse {
  /// Safely converts dynamic value to [int] (handles int, double, String).
  static int? toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value);
    return int.tryParse(value.toString());
  }

  /// Safely converts dynamic value to [String].
  static String? toStringValue(dynamic value) {
    if (value == null) return null;
    return value.toString();
  }

  /// Safely converts dynamic value to [double] (handles int, double, String).
  static double? toDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return double.tryParse(value.toString());
  }

  /// Safely converts dynamic value to [num] (handles int, double, String).
  static num? toNum(dynamic value) {
    if (value == null) return null;
    if (value is num) return value;
    if (value is String) return num.tryParse(value);
    return num.tryParse(value.toString());
  }

  /// Safely converts dynamic value to [bool] (handles bool, int, String).
  static bool? toBool(dynamic value) {
    if (value == null) return null;
    if (value is bool) return value;
    if (value is int) return value != 0;
    if (value is String) {
      final lower = value.toLowerCase();
      if (lower == 'true' || lower == '1') return true;
      if (lower == 'false' || lower == '0') return false;
    }
    return null;
  }
  /// Safely converts dynamic value to [List<String>]
  static List<String>? asStringList(dynamic value) {
    if (value == null) return null;
    if (value is List) {
      return value.map((e) => toStringValue(e)).whereType<String>().toList();
    }
    if (value is String && value.isNotEmpty) {
      return [value];
    }
    return null;
  }
}