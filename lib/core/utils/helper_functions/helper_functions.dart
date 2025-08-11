class HelperFunctions {
  static String cleanErrorMessage(String error) {
    const prefix = 'Exception: ';
    if (error.startsWith(prefix)) {
      return error.substring(prefix.length);
    }
    return error;
  }
}
