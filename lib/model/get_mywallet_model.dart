// To parse this JSON data, do
//
//     final getWalletModel = getWalletModelFromJson(jsonString);

import 'dart:convert';

GetWalletModel getWalletModelFromJson(String str) =>
    GetWalletModel.fromJson(json.decode(str));

String getWalletModelToJson(GetWalletModel data) => json.encode(data.toJson());

class GetWalletModel {
  GetWalletModel({
    this.minDeposit,
    this.pmid,
    this.callUrl,
    this.gPay,
    this.status,
    this.code,
    this.walletInfo,
  });

  String minDeposit;
  String pmid;
  String callUrl;
  String gPay;
  bool status;
  int code;
  WalletInfo walletInfo;

  factory GetWalletModel.fromJson(Map<String, dynamic> json) => GetWalletModel(
        minDeposit: json["min_deposit"],
        pmid: json["pmid"],
        callUrl: json["call_url"],
        gPay: json["g_pay"],
        status: json["status"],
        code: json["code"],
        walletInfo: WalletInfo.fromJson(json["walletInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "min_deposit": minDeposit,
        "pmid": pmid,
        "call_url": callUrl,
        "g_pay": gPay,
        "status": status,
        "code": code,
        "walletInfo": walletInfo.toJson(),
      };
}

class WalletInfo {
  WalletInfo({
    this.userId,
    this.bonusAmount,
    this.prizeAmount,
    this.referralAmount,
    this.depositAmount,
    this.extraCash,
    this.isAccountVerified,
    this.refferalFriendsCount,
    this.affiliateCommission,
    this.bankAccountVerified,
    this.bankAccountNumber,
    this.bankName,
    this.documentVerified,
    this.paytmVerified,
    this.walletAmount,
    this.withdrawalAmount,
    this.pmid,
    this.callUrl,
    this.gPay,
    this.minDeposit,
    this.gatewayRazorpayActive,
    this.gatewayPaytmActive,
  });

  String userId;
  num bonusAmount;
  num prizeAmount;
  num referralAmount;
  num depositAmount;
  num extraCash;
  IsAccountVerified isAccountVerified;
  num refferalFriendsCount;
  num affiliateCommission;
  int bankAccountVerified;
  String bankAccountNumber;
  String bankName;
  int documentVerified;
  int paytmVerified;
  num walletAmount;
  num withdrawalAmount;
  String pmid;
  String callUrl;
  String gPay;
  String minDeposit;
  String gatewayRazorpayActive;
  String gatewayPaytmActive;

  factory WalletInfo.fromJson(Map<String, dynamic> json) => WalletInfo(
        userId: json["user_id"],
        bonusAmount: json["bonus_amount"],
        prizeAmount: json["prize_amount"],
        referralAmount: json["referral_amount"],
        depositAmount: json["deposit_amount"],
        extraCash: json["extra_cash"],
        isAccountVerified:
            IsAccountVerified.fromJson(json["is_account_verified"]),
        refferalFriendsCount: json["refferal_friends_count"],
        affiliateCommission: json["affiliate_commission"],
        bankAccountVerified: json["bank_account_verified"],
        bankAccountNumber: json["bank_account_number"],
        bankName: json["bank_name"],
        documentVerified: json["document_verified"],
        paytmVerified: json["paytm_verified"],
        walletAmount: json["wallet_amount"],
        withdrawalAmount: json["withdrawal_amount"],
        pmid: json["pmid"],
        callUrl: json["call_url"],
        gPay: json["g_pay"],
        minDeposit: json["min_deposit"],
        gatewayRazorpayActive: json["gateway_razorpay_active"],
        gatewayPaytmActive: json["gateway_paytm_active"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "bonus_amount": bonusAmount,
        "prize_amount": prizeAmount,
        "referral_amount": referralAmount,
        "deposit_amount": depositAmount,
        "extra_cash": extraCash,
        "is_account_verified": isAccountVerified.toJson(),
        "refferal_friends_count": refferalFriendsCount,
        "affiliate_commission": affiliateCommission,
        "bank_account_verified": bankAccountVerified,
        "bank_account_number": bankAccountNumber,
        "bank_name": bankName,
        "document_verified": documentVerified,
        "paytm_verified": paytmVerified,
        "wallet_amount": walletAmount,
        "withdrawal_amount": withdrawalAmount,
        "pmid": pmid,
        "call_url": callUrl,
        "g_pay": gPay,
        "min_deposit": minDeposit,
        "gateway_razorpay_active": gatewayRazorpayActive,
        "gateway_paytm_active": gatewayPaytmActive,
      };
}

class IsAccountVerified {
  IsAccountVerified({
    this.emailVerified,
    this.documentsVerified,
    this.addressVerified,
    this.paytmVerified,
  });

  int emailVerified;
  int documentsVerified;
  int addressVerified;
  int paytmVerified;

  factory IsAccountVerified.fromJson(Map<String, dynamic> json) =>
      IsAccountVerified(
        emailVerified: json["email_verified"],
        documentsVerified: json["documents_verified"],
        addressVerified: json["address_verified"],
        paytmVerified: json["paytm_verified"],
      );

  Map<String, dynamic> toJson() => {
        "email_verified": emailVerified,
        "documents_verified": documentsVerified,
        "address_verified": addressVerified,
        "paytm_verified": paytmVerified,
      };
}
