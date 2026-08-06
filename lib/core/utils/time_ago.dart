String timeAgo(DateTime dateTime, {DateTime? now}) {
  final currentTime = now ?? DateTime.now();
  final difference = currentTime.difference(dateTime);

  if (difference.isNegative || difference.inSeconds < 5) {
    return 'Just now';
  }

  if (difference.inSeconds < 60) {
    return '${difference.inSeconds}s ago';
  }

  if (difference.inMinutes < 60) {
    return '${difference.inMinutes}m ago';
  }

  if (difference.inHours < 24) {
    return '${difference.inHours}h ago';
  }

  if (difference.inDays < 7) {
    return '${difference.inDays}d ago';
  }

  if (difference.inDays < 30) {
    return '${difference.inDays ~/ 7}w ago';
  }

  if (difference.inDays < 365) {
    return '${difference.inDays ~/ 30}mo ago';
  }

  return '${difference.inDays ~/ 365}y ago';
}
