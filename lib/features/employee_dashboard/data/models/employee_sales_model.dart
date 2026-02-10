class EmployeeSalesModel {
  final bool? success;
  final List<EmployeeSaleData>? data;

  EmployeeSalesModel({
    this.success,
    this.data,
  });

  factory EmployeeSalesModel.fromJson(Map<String, dynamic> json) {
    return EmployeeSalesModel(
      success: json['success'],
      data: json['sales'] != null
          ? (json['sales'] as List)
              .map((e) => EmployeeSaleData.fromJson(e))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'sales': data?.map((e) => e.toJson()).toList(),
    };
  }
}

class EmployeeSaleData {
  final int? id;
  final String? saleDate;
  final String? saleNo;
  final String? customerName;
  final String? branchName;
  final int? itemCount;
  final num? grandTotal;
  final num? paidAmount;
  final num? dueAmount;
  final String? status;

  EmployeeSaleData({
    this.id,
    this.saleDate,
    this.saleNo,
    this.customerName,
    this.branchName,
    this.itemCount,
    this.grandTotal,
    this.paidAmount,
    this.dueAmount,
    this.status,
  });

  factory EmployeeSaleData.fromJson(Map<String, dynamic> json) {
    return EmployeeSaleData(
      id: json['id'],
      saleDate: json['sale_date'],
      saleNo: json['sale_no'],
      customerName: json['customer_name'],
      branchName: json['branch_name'],
      itemCount: json['item_count'],
      grandTotal: json['grand_total'],
      paidAmount: json['paid_amount'],
      dueAmount: json['due_amount'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sale_date': saleDate,
      'sale_no': saleNo,
      'customer_name': customerName,
      'branch_name': branchName,
      'item_count': itemCount,
      'grand_total': grandTotal,
      'paid_amount': paidAmount,
      'due_amount': dueAmount,
      'status': status,
    };
  }
}
