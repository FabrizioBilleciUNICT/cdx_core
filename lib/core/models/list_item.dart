class ListItem {
  String? id;
  String title;
  String subtitle;
  Function func;
  bool hasSwitch;
  bool? selected;
  bool showSubtitle;
  Map metadata = {};

  ListItem(
      {this.id,
      required this.title,
      this.subtitle = '',
      required this.func,
      this.hasSwitch = false,
      this.selected,
      this.showSubtitle = false,
      this.metadata = const {}});
}
