class Response {
  String? status;
  String? message;
  List<IToDoItem>? data;

  Response({this.status, this.message, this.data});

  Response.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <IToDoItem>[];
      json['data'].forEach((v) {
        data!.add(IToDoItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class IToDoItem {
  int? id;
  String? title;
  String? description;
  bool? completed;
  bool? status;
  String? createdAt;
  String? updatedAt;

  IToDoItem(
    String title,
    String description, {
    this.id,
    this.completed,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  IToDoItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    completed = json['completed'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['completed'] = this.completed;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
