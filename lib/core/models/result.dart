class Result<int, String, T> {
  final int code;
  final String message;
  final String? id;
  final T? data;

  Result({required this.code, required this.message, this.id, this.data});
}
