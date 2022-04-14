// To parse this JSON data, do
//
//     final transactionHistoryModel = transactionHistoryModelFromJson(jsonString);

import 'dart:convert';

TransactionHistoryModel transactionHistoryModelFromJson(String str) =>
    TransactionHistoryModel.fromJson(json.decode(str));

String transactionHistoryModelToJson(TransactionHistoryModel data) =>
    json.encode(data.toJson());

class TransactionHistoryModel {
  TransactionHistoryModel({
    this.status,
    this.code,
    this.message,
    this.transactionHistory,
  });

  bool status;
  int code;
  String message;
  TransactionHistory transactionHistory;

  factory TransactionHistoryModel.fromJson(Map<String, dynamic> json) =>
      TransactionHistoryModel(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        transactionHistory:
            TransactionHistory.fromJson(json["transaction_history"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "transaction_history": transactionHistory.toJson(),
      };
}

class TransactionHistory {
  TransactionHistory({
    this.userId,
    this.bonusAmount,
    this.prizeAmount,
    this.referralAmount,
    this.depositAmount,
    this.transaction,
  });

  int userId;
  double bonusAmount;
  double prizeAmount;
  int referralAmount;
  double depositAmount;
  List<Transaction> transaction;

  factory TransactionHistory.fromJson(Map<String, dynamic> json) =>
      TransactionHistory(
        userId: json["user_id"],
        bonusAmount: json["bonus_amount"].toDouble(),
        prizeAmount: json["prize_amount"].toDouble(),
        referralAmount: json["referral_amount"],
        depositAmount: json["deposit_amount"].toDouble(),
        transaction: List<Transaction>.from(
            json["transaction"].map((x) => Transaction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "bonus_amount": bonusAmount,
        "prize_amount": prizeAmount,
        "referral_amount": referralAmount,
        "deposit_amount": depositAmount,
        "transaction": List<dynamic>.from(transaction.map((x) => x.toJson())),
      };
}

class Transaction {
  Transaction({
    this.userId,
    this.amount,
    this.paymentMode,
    this.paymentStatus,
    this.transactionId,
    this.paymentType,
    this.debitCreditStatus,
    this.date,
  });

  dynamic userId;
  double amount;
  PaymentMode paymentMode;
  PaymentStatus paymentStatus;
  String transactionId;
  String paymentType;
  DebitCreditStatus debitCreditStatus;
  String date;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        userId: json["user_id"],
        amount: json["amount"].toDouble(),
        paymentMode: paymentModeValues.map[json["payment_mode"]],
        paymentStatus: paymentStatusValues.map[json["payment_status"]],
        transactionId: json["transaction_id"],
        paymentType: json["payment_type"],
        debitCreditStatus:
            debitCreditStatusValues.map[json["debit_credit_status"]],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "amount": amount,
        "payment_mode": paymentModeValues.reverse[paymentMode],
        "payment_status": paymentStatusValues.reverse[paymentStatus],
        "transaction_id": transactionId,
        "payment_type": paymentType,
        "debit_credit_status":
            debitCreditStatusValues.reverse[debitCreditStatus],
        "date": date,
      };
}

enum DebitCreditStatus { EMPTY, DEBIT_CREDIT_STATUS }

final debitCreditStatusValues = EnumValues(
    {"+": DebitCreditStatus.DEBIT_CREDIT_STATUS, "-": DebitCreditStatus.EMPTY});

enum PaymentMode { ONLINE, SF, FANPRZ, FANREFUNDED_A, PAYTM }

final paymentModeValues = EnumValues({
  "FANPRZ": PaymentMode.FANPRZ,
  "FANREFUNDED_A": PaymentMode.FANREFUNDED_A,
  "Online": PaymentMode.ONLINE,
  "paytm": PaymentMode.PAYTM,
  "sf": PaymentMode.SF
});

enum PaymentStatus { SUCCESS, PAYMENT_STATUS_SUCCESS }

final paymentStatusValues = EnumValues({
  "success": PaymentStatus.PAYMENT_STATUS_SUCCESS,
  "Success": PaymentStatus.SUCCESS
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
