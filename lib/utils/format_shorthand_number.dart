String formatShorthandNumber(int number) {
  if (number >= 1000000) {
    return '${(number / 1000000).toStringAsFixed(2).replaceAll(RegExp(r'\.?0+$'), '')}M';
  }

  if (number >= 1000) {
    return '${(number / 1000).toStringAsFixed(1).replaceAll(RegExp(r'\.?0+$'), '')}K';
  }

  return number.toString();
}
