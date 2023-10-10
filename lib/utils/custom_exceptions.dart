part of 'utils.dart';

class BusinessException implements IOException {
  final String message;
  final String devError;

  const BusinessException(this.message, {this.devError = ''});

  String toString() {
    // print('ApiException: $message');
    StringBuffer sb = new StringBuffer();
    // sb.write("ApiException");
    if (message.isNotEmpty) {
      sb.write("$message");
    }
    return sb.toString();
  }
}
