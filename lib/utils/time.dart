String getTimeStr(String date) {
  final DateTime postedDate = DateTime.parse(date);
  final Duration difference = DateTime.now().difference(postedDate);

  if (difference.inDays > 0) {
    return 'Il y a ${difference.inDays} jours';
  } else {
    return 'Il y a ${difference.inHours} heures';
  }
}