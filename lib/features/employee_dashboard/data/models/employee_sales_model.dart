class EmployeeSalesModel {
  final bool? success;
  final List<EmployeeSaleData>? data;
  final EmployeeSalesSummary? summary;

  EmployeeSalesModel({
    this.success,
    this.data,
    this.summary,
  });

  factory EmployeeSalesModel.fromJson(Map<String, dynamic> json) {
    return EmployeeSalesModel(
      success: json['success'],
      data: json['sales'] != null
          ? (json['sales'] as List)
          .map((e) => EmployeeSaleData.fromJson(e))
          .toList()
          : null,
      summary: json['summary'] != null
          ? EmployeeSalesSummary.fromJson(json['summary'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'sales': data?.map((e) => e.toJson()).toList(),
      'summary': summary?.toJson(),
    };
  }
}

class EmployeeSaleData {
  final int? id;
  final String? saleDate;
  final String? saleNo;
  final String? customerName;
  final String? customerNameBn;
  final String? branchName;
  final int? itemCount;
  final double? grandTotal;
  final double? paidAmount;
  final double? dueAmount;
  final String? status;

  EmployeeSaleData({
    this.id,
    this.saleDate,
    this.saleNo,
    this.customerName,
    this.customerNameBn,
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
      customerNameBn: json['customer_name_bn'],
      branchName: json['branch_name'],
      itemCount: json['item_count'],
      grandTotal: (json['grand_total'] as num?)?.toDouble(),
      paidAmount: (json['paid_amount'] as num?)?.toDouble(),
      dueAmount: (json['due_amount'] as num?)?.toDouble(),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sale_date': saleDate,
      'sale_no': saleNo,
      'customer_name': customerName,
      'customer_name_bn': customerNameBn,
      'branch_name': branchName,
      'item_count': itemCount,
      'grand_total': grandTotal,
      'paid_amount': paidAmount,
      'due_amount': dueAmount,
      'status': status,
    };
  }
}

class EmployeeSalesSummary {
  final int? totalQuantity;
  final double? totalAmount;
  final int? totalSales;

  EmployeeSalesSummary({
    this.totalQuantity,
    this.totalAmount,
    this.totalSales,
  });

  factory EmployeeSalesSummary.fromJson(Map<String, dynamic> json) {
    return EmployeeSalesSummary(
      totalQuantity: json['total_quantity'],
      totalAmount: (json['total_amount'] as num?)?.toDouble(),
      totalSales: json['total_sales'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_quantity': totalQuantity,
      'total_amount': totalAmount,
      'total_sales': totalSales,
    };
  }
}
