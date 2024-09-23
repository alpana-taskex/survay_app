class NotificationModel {
  String? sId;
  String? sender;
  String? title;
  String? content;
  String? url;
  String? urlText;
  bool? unread;
  String? icon;
  String? receivedAt;
  String? createdAt;
  String? updatedAt;

  NotificationModel(
      {this.sId,
        this.sender,
        this.title,
        this.content,
        this.url,
        this.urlText,
        this.unread,
        this.icon,
        this.receivedAt,
        this.createdAt,
        this.updatedAt});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sender = json['sender'];
    title = json['title'];
    content = json['content'];
    url = json['url'];
    urlText = json['urlText'];
    unread = json['unread'];
    icon = json['icon'];
    receivedAt = json['receivedAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['sender'] = sender;
    data['title'] = title;
    data['content'] = content;
    data['url'] = url;
    data['urlText'] = urlText;
    data['unread'] = unread;
    data['icon'] = icon;
    data['receivedAt'] = receivedAt;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
