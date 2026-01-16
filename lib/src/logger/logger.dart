import 'package:logger/logger.dart';

Logger getLogger(bool printLogs) {
  return Logger(
    level: printLogs ? Level.debug : Level.off,
  );
}
