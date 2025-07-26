class IAddToDo {
  String? status;
  String? message;
  Data? data;

  IAddToDo({this.status, this.message, this.data});

  IAddToDo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? title;
  String? description;
  int? id;
  bool? completed;
  bool? status;
  String? createdAt;
  String? updatedAt;

  Data({
    this.title,
    this.description,
    this.id,
    this.completed,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    id = json['id'];
    completed = json['completed'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['id'] = this.id;
    data['completed'] = this.completed;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
