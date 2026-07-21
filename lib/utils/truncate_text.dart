String truncateAbout(String text, int maxChars) {
  if (text.length <= maxChars) return text;

  return "${text.substring(0, maxChars)}...";
}
