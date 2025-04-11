class DropdownItem {
  final String title;
  final dynamic value;

  DropdownItem({required this.title, required this.value});

  @override
  bool operator ==(Object other) =>
      other is DropdownItem && other.value == value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value.toString();
}
