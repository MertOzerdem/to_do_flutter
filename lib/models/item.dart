class Item {
  String title;
  bool isCompleted;
  final int id;

  Item({required this.title, required this.isCompleted, required this.id}) {
    assert(id != 0);
    assert(title != "default");
  }
}
