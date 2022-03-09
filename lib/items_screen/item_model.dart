class ItemsModel {
  late String id, image, title, detailsId;
  late int totalPrice, sellPrice;

  //initialisation through classconstructor
  ItemsModel(
      {required this.id,
      required this.image,
      required this.title,
      required this.sellPrice,
      required this.totalPrice,
      required this.detailsId});
  ItemsModel.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    image = map['img'];
    title = map['title'];
    detailsId = map['details_id'] ?? " ";
    sellPrice = map['sell_price'];
    totalPrice = map['total_price'];
  }
}
