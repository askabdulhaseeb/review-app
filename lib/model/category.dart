class Category {
  String image;
  String id;
  String title;
  bool isSelected = false;

  Category({this.image, this.title, this.isSelected, this.id});

  factory Category.fromDocument(doc) {
    return Category(
      id: doc.data()['id'] ?? '',
      title: doc.data()['category_name'] ?? '',
      image: doc.data()['image'] ?? '',
    );
  }
}
