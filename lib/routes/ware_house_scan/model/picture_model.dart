
class PictureModel{
  String id;
  String orderNumber;
  bool isOnlineSync;
  String? localPath;
  String? url;
  String? ackId;
  String? capturedAt;
  String? imageType;
  String? picTitle;

  PictureModel(this.id, this.orderNumber, this.isOnlineSync);
}