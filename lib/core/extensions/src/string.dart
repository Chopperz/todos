extension StringExtension on String? {
  bool get isNotEmptyOrNull => (this != "" && this != null);
}
