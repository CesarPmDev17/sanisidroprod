part of 'utils.dart';

class ApiException implements IOException {
  final String message;
  final DioError? dioError;

  const ApiException(this.message, {this.dioError});

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
