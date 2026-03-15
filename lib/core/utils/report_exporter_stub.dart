Future<void> saveCsvReportImpl({
  required String filename,
  required String csvContent,
}) async {
  throw UnsupportedError('CSV export is not supported on this platform.');
}

Future<void> shareCsvReportImpl({
  required String filename,
  required String csvContent,
}) async {
  throw UnsupportedError('CSV sharing is not supported on this platform.');
}
