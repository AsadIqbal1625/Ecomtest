class ItemDetailsModel {
  late String id, title, image, description, banners;
  late int sellPrice, totalPrice;

  ItemDetailsModel(
      {required this.id,
      required this.banners,
      required this.description,
      required this.image,
      required this.title,
      required this.sellPrice,
      required this.totalPrice});
  ItemDetailsModel.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    banners = map['banners'];
    image = map['img'];
    title = map['title'];
    description = map['des'];
    sellPrice = map['sell_price'];
    totalPrice = map['total_price'];
  }
}
