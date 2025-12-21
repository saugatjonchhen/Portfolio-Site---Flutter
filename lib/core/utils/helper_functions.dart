import 'dart:developer';

DateTime parseDate(String dateStr) {
  final cleanStr = dateStr.trim().toLowerCase();
  if (cleanStr == 'present') return DateTime.now();

  final parts = cleanStr.split(' ');
  if (parts.length < 2) return DateTime.now();

  final months = {
    'january': 1,
    'february': 2,
    'march': 3,
    'april': 4,
    'may': 5,
    'june': 6,
    'july': 7,
    'august': 8,
    'september': 9,
    'october': 10,
    'november': 11,
    'december': 12
  };

  final month = months[parts[0]] ?? 1;
  final year = int.tryParse(parts[1]) ?? DateTime.now().year;

  return DateTime(year, month);
}

String getScreenshotUrl(String demoUrl) {
  log("Demo url:" + demoUrl);
  final targetUrl =
      'https://free.pagepeeker.com/v2/thumbs.php?size=l&url=${Uri.encodeComponent(demoUrl)}';
  log('$targetUrl');
  // Use a public CORS proxy (useful for testing/portfolio)
  return 'https://corsproxy.io/?${Uri.encodeComponent(targetUrl)}';
}

String getThumbnail(String demoUrl) {
  final screenshotUrl = 'https://api.microlink.io/?url=${Uri.encodeComponent(demoUrl)}&screenshot=true&embed=screenshot.url';

  // wsrv.nl is a dedicated image proxy that fixes CORS for CanvasKit
  return 'https://wsrv.nl/?url=${Uri.encodeComponent(screenshotUrl)}&default=error';
}
