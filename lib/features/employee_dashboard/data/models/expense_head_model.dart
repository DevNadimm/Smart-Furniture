class ExpenseHeadModel {
  final bool? success;
  final List<ExpenseHeadData>? data;

  ExpenseHeadModel({this.success, this.data});

  factory ExpenseHeadModel.fromJson(Map<String, dynamic> json) {
    return ExpenseHeadModel(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ExpenseHeadData.fromJson(e))
          .toList(),
    );
  }
}

class ExpenseHeadData {
  final int? id;
  final String? head;
  final String? nameBn; // ✅ NEW
  final String? description;

  ExpenseHeadData({
    this.id,
    this.head,
    this.nameBn,
    this.description,
  });

  factory ExpenseHeadData.fromJson(Map<String, dynamic> json) {
    return ExpenseHeadData(
      id: json['id'] as int?,
      head: json['head'] as String?,
      nameBn: json['name_bn'] as String?,
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'head': head,
      'name_bn': nameBn,
      'description': description,
    };
  }
}
