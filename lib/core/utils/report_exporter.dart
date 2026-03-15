import 'report_exporter_stub.dart'
    if (dart.library.io) 'report_exporter_io.dart'
    if (dart.library.html) 'report_exporter_web.dart';

Future<void> saveCsvReport({
  required String filename,
  required String csvContent,
}) {
  return saveCsvReportImpl(
    filename: filename,
    csvContent: csvContent,
  );
}

Future<void> shareCsvReport({
  required String filename,
  required String csvContent,
}) {
  return shareCsvReportImpl(
    filename: filename,
    csvContent: csvContent,
  );
}
