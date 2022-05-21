class Maintenance {
  String? id;
  String? description;
  bool? status;
  String? userId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Maintenance(
      {this.id,
      this.description,
      this.status,
      this.userId,
      this.createdAt,
      this.updatedAt});

  String get statusText => status == true ? "Manutenção em execução"
    : "Manutenção Finalizada"; 

  Maintenance.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    status = json['status'];
    userId = json['userId'];
    createdAt = DateTime.tryParse(json['createdAt'] ?? "");
    updatedAt = DateTime.tryParse(json['updatedAt'] ?? "");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    data['status'] = status;
    data['userId'] = userId;
    data['createdAt'] = createdAt.toString();
    data['updatedAt'] = updatedAt.toString();
    return data;
  }
}