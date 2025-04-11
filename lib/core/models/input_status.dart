
class InputStatus<T> {

  bool edited;
  bool valid;
  T? value;

  InputStatus({
    required this.edited,
    required this.valid,
    required this.value
  });
}