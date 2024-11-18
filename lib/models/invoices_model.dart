class InvoicesModel {
  final num id;
  final num amount;
  final String date;
  final String companyName;

  InvoicesModel(
      {required this.id,
      required this.amount,
      required this.date,
      required this.companyName});
  factory InvoicesModel.fromJson(json) {
    return InvoicesModel(
        id: json['id'],
        amount: json['amount'],
        date: json['date'],
        companyName: json['company']['name']);
  }
}
