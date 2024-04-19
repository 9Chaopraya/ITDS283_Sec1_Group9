
class Item_model {
  String name;
  String date;
  // TimeOfDay start_time;
  // TimeOfDay end_time;
  String description;
  String category;

  Item_model(
      {required this.name,
      required this.date,
      required this.description,
      required this.category});

  static List<Item_model> getItem() {
    List<Item_model> Items = [];
    Items.add(Item_model(
        name: "Meeting with P Tim",
        date: "1944-06-06",
        description: "a",
        category: "Meeting"));
    Items.add(Item_model(
        name: "Meeting with P Sub",
        date: "1944-06-06",
        description: "b",
        category: "Meeting"));
    Items.add(Item_model(
        name: "Meeting with P Saw",
        date: "1944-06-06",
        description: "c",
        category: "Meeting"));

    return Items;
  }
}
