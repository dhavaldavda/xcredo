// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  bool? success;
  int? code;
  LoginData? psdata;

  LoginModel({
    this.success,
    this.code,
    this.psdata,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    success: json["success"],
    code: json["code"],
    psdata:
    json["psdata"] == null ? null : LoginData.fromJson(json["psdata"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "code": code,
    "psdata": psdata?.toJson(),
  };
}

class LoginData {
  String? status;
  String? message;
  String? customerId;
  String? customerTokenId;
  int? sessionData;
  int? cartCount;
  LoginUser? user;

  LoginData(
      {this.status,
        this.message,
        this.customerId,
        this.sessionData,
        this.cartCount,
        this.user,
        this.customerTokenId});

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
    status: json["status"],
    message: json["message"],
    customerId: json["customer_id"],
    sessionData: json["session_data"],
    cartCount: json["cart_count"],
    customerTokenId: json["customer_token_id"],
    user: json["user"] == null ? null : LoginUser.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "customer_id": customerId,
    "session_data": sessionData,
    "cart_count": cartCount,
    "user": user?.toJson(),
    "customer_token_id": customerTokenId,
  };
}

class LoginUser {
  String? id;
  String? idShop;
  String? idShopGroup;
  dynamic note;
  String? idGender;
  String? idDefaultGroup;
  String? idLang;
  String? lastname;
  String? firstname;
  String? birthday;
  String? email;
  String? newsletter;
  dynamic ipRegistrationNewsletter;
  DateTime? newsletterDateAdd;
  String? optin;
  dynamic website;
  String? company;
  String? siret;
  String? ape;
  String? outstandingAllowAmount;
  String? showPublicPrices;
  String? idRisk;
  String? maxPaymentDays;
  String? active;
  String? isGuest;
  String? deleted;
  DateTime? dateAdd;
  DateTime? dateUpd;
  dynamic years;
  dynamic days;
  dynamic months;
  dynamic geolocIdCountry;
  dynamic geolocIdState;
  dynamic geolocPostcode;
  int? logged;
  dynamic idGuest;
  dynamic groupBox;
  List<dynamic>? idShopList;
  bool? forceId;
  String? purchaseOrder;

  LoginUser({
    this.id,
    this.idShop,
    this.idShopGroup,
    this.note,
    this.idGender,
    this.idDefaultGroup,
    this.idLang,
    this.lastname,
    this.firstname,
    this.birthday,
    this.email,
    this.newsletter,
    this.ipRegistrationNewsletter,
    this.newsletterDateAdd,
    this.optin,
    this.website,
    this.company,
    this.siret,
    this.ape,
    this.outstandingAllowAmount,
    this.showPublicPrices,
    this.idRisk,
    this.maxPaymentDays,
    this.active,
    this.isGuest,
    this.deleted,
    this.dateAdd,
    this.dateUpd,
    this.years,
    this.days,
    this.months,
    this.geolocIdCountry,
    this.geolocIdState,
    this.geolocPostcode,
    this.logged,
    this.idGuest,
    this.groupBox,
    this.idShopList,
    this.forceId,
    this.purchaseOrder,
  });

  factory LoginUser.fromJson(Map<String, dynamic> json) => LoginUser(
    id: json["id"],
    idShop: json["id_shop"],
    idShopGroup: json["id_shop_group"],
    note: json["note"],
    idGender: json["id_gender"],
    idDefaultGroup: json["id_default_group"],
    idLang: json["id_lang"],
    lastname: json["lastname"],
    firstname: json["firstname"],
    birthday: json["birthday"],
    email: json["email"],
    newsletter: json["newsletter"],
    ipRegistrationNewsletter: json["ip_registration_newsletter"],
    newsletterDateAdd: json["newsletter_date_add"] == null
        ? null
        : DateTime.parse(json["newsletter_date_add"]),
    optin: json["optin"],
    website: json["website"],
    company: json["company"],
    siret: json["siret"],
    ape: json["ape"],
    outstandingAllowAmount: json["outstanding_allow_amount"],
    showPublicPrices: json["show_public_prices"],
    idRisk: json["id_risk"],
    maxPaymentDays: json["max_payment_days"],
    active: json["active"],
    isGuest: json["is_guest"],
    deleted: json["deleted"],
    dateAdd:
    json["date_add"] == null ? null : DateTime.parse(json["date_add"]),
    dateUpd:
    json["date_upd"] == null ? null : DateTime.parse(json["date_upd"]),
    years: json["years"],
    days: json["days"],
    months: json["months"],
    geolocIdCountry: json["geoloc_id_country"],
    geolocIdState: json["geoloc_id_state"],
    geolocPostcode: json["geoloc_postcode"],
    logged: json["logged"],
    idGuest: json["id_guest"],
    groupBox: json["groupBox"],
    idShopList: json["id_shop_list"] == null
        ? []
        : List<dynamic>.from(json["id_shop_list"]!.map((x) => x)),
    forceId: json["force_id"],
    purchaseOrder: json["purchase_order"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_shop": idShop,
    "id_shop_group": idShopGroup,
    "note": note,
    "id_gender": idGender,
    "id_default_group": idDefaultGroup,
    "id_lang": idLang,
    "lastname": lastname,
    "firstname": firstname,
    "birthday": birthday,
    "email": email,
    "newsletter": newsletter,
    "ip_registration_newsletter": ipRegistrationNewsletter,
    "newsletter_date_add": newsletterDateAdd?.toIso8601String(),
    "optin": optin,
    "website": website,
    "company": company,
    "siret": siret,
    "ape": ape,
    "outstanding_allow_amount": outstandingAllowAmount,
    "show_public_prices": showPublicPrices,
    "id_risk": idRisk,
    "max_payment_days": maxPaymentDays,
    "active": active,
    "is_guest": isGuest,
    "deleted": deleted,
    "date_add": dateAdd?.toIso8601String(),
    "date_upd": dateUpd?.toIso8601String(),
    "years": years,
    "days": days,
    "months": months,
    "geoloc_id_country": geolocIdCountry,
    "geoloc_id_state": geolocIdState,
    "geoloc_postcode": geolocPostcode,
    "logged": logged,
    "id_guest": idGuest,
    "groupBox": groupBox,
    "id_shop_list": idShopList == null
        ? []
        : List<dynamic>.from(idShopList!.map((x) => x)),
    "force_id": forceId,
    "purchase_order": purchaseOrder,
  };
}
