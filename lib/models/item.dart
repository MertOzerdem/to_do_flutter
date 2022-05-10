class Item {
  String title;
  bool isCompleted;
  final int id;

  Item({required this.title, required this.isCompleted, required this.id}) {
    // assert(id != 0);
    assert(title != "default");
  }

  factory Item.fromMap(Map<String, dynamic> parsedJSON) {
    return Item(
      id: parsedJSON['id'],
      title: parsedJSON['title'],
      isCompleted: parsedJSON['isCompleted'],
    );
  }

  toJSONEncodable() {
    Map<String, dynamic> map = {};

    map['title'] = title;
    map['isCompleted'] = isCompleted;
    map['id'] = id;

    return map;
  }
}

class ItemList {
  List<Item> items = [];

  ItemList(this.items);

  factory ItemList.fromMap(List<dynamic> parsedJSON) {
    return ItemList(
      parsedJSON
          .map(
            (e) => Item.fromMap(e),
          )
          .toList(),
    );
  }

  toJSONEncodable() {
    return items.map((item) {
      return item.toJSONEncodable();
    }).toList();
  }
}
