// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entities/user.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel extends User {
  UserModel({
    super.id,
    super.firstName,
    super.lastName,
    super.maidenName,
    super.age,
    super.gender,
    super.email,
    super.phone,
    super.username,
    super.password,
    super.birthDate,
    super.image,
    super.bloodGroup,
    super.height,
    super.weight,
    super.eyeColor,
    HairModel? super.hair,
    super.domain,
    super.ip,
    AddressModel? super.address,
    super.macAddress,
    super.university,
    BankModel? super.bank,
    CompanyModel? super.company,
    super.ein,
    super.ssn,
    super.userAgent,
    CryptoModel? super.crypto,
  });

  UserModel copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? maidenName,
    int? age,
    String? gender,
    String? email,
    String? phone,
    String? username,
    String? password,
    DateTime? birthDate,
    String? image,
    String? bloodGroup,
    int? height,
    double? weight,
    String? eyeColor,
    HairModel? hair,
    String? domain,
    String? ip,
    AddressModel? address,
    String? macAddress,
    String? university,
    BankModel? bank,
    CompanyModel? company,
    String? ein,
    String? ssn,
    String? userAgent,
    CryptoModel? crypto,
  }) =>
      UserModel(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        maidenName: maidenName ?? this.maidenName,
        age: age ?? this.age,
        gender: gender ?? this.gender,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        username: username ?? this.username,
        password: password ?? this.password,
        birthDate: birthDate ?? this.birthDate,
        image: image ?? this.image,
        bloodGroup: bloodGroup ?? this.bloodGroup,
        height: height ?? this.height,
        weight: weight ?? this.weight,
        eyeColor: eyeColor ?? this.eyeColor,
        hair: hair ?? this.hair as HairModel,
        domain: domain ?? this.domain,
        ip: ip ?? this.ip,
        address: address ?? this.address as AddressModel,
        macAddress: macAddress ?? this.macAddress,
        university: university ?? this.university,
        bank: bank ?? this.bank as BankModel,
        company: company ?? this.company as CompanyModel,
        ein: ein ?? this.ein,
        ssn: ssn ?? this.ssn,
        userAgent: userAgent ?? this.userAgent,
        crypto: crypto ?? this.crypto as CryptoModel,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        maidenName: json["maidenName"],
        age: json["age"],
        gender: json["gender"],
        email: json["email"],
        phone: json["phone"],
        username: json["username"],
        password: json["password"],
        birthDate: json["birthDate"] == null
            ? null
            : DateTime.parse(json["birthDate"]),
        image: json["image"],
        bloodGroup: json["bloodGroup"],
        height: json["height"],
        weight: json["weight"]?.toDouble(),
        eyeColor: json["eyeColor"],
        hair: json["hair"] == null ? null : HairModel.fromJson(json["hair"]),
        domain: json["domain"],
        ip: json["ip"],
        address: json["address"] == null
            ? null
            : AddressModel.fromJson(json["address"]),
        macAddress: json["macAddress"],
        university: json["university"],
        bank: json["bank"] == null ? null : BankModel.fromJson(json["bank"]),
        company: json["company"] == null
            ? null
            : CompanyModel.fromJson(json["company"]),
        ein: json["ein"],
        ssn: json["ssn"],
        userAgent: json["userAgent"],
        crypto: json["crypto"] == null
            ? null
            : CryptoModel.fromJson(json["crypto"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "maidenName": maidenName,
        "age": age,
        "gender": gender,
        "email": email,
        "phone": phone,
        "username": username,
        "password": password,
        "birthDate":
            "${birthDate!.year.toString().padLeft(4, '0')}-${birthDate!.month.toString().padLeft(2, '0')}-${birthDate!.day.toString().padLeft(2, '0')}",
        "image": image,
        "bloodGroup": bloodGroup,
        "height": height,
        "weight": weight,
        "eyeColor": eyeColor,
        "hair": (hair as HairModel).toJson(),
        "domain": domain,
        "ip": ip,
        "address": (address as AddressModel).toJson(),
        "macAddress": macAddress,
        "university": university,
        "bank": (bank as BankModel).toJson(),
        "company": (company as CompanyModel).toJson(),
        "ein": ein,
        "ssn": ssn,
        "userAgent": userAgent,
        "crypto": (crypto as CryptoModel).toJson(),
      };
}

class AddressModel extends Address {
  AddressModel({
    super.address,
    super.city,
    CoordinatesModel? super.coordinates, // Ensuring the right type is used
    super.postalCode,
    super.state,
  });

  AddressModel copyWith({
    String? address,
    String? city,
    CoordinatesModel? coordinates,
    String? postalCode,
    String? state,
  }) =>
      AddressModel(
        address: address ?? this.address,
        city: city ?? this.city,
        coordinates: coordinates ?? this.coordinates as CoordinatesModel,
        postalCode: postalCode ?? this.postalCode,
        state: state ?? this.state,
      );

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        address: json["address"],
        city: json["city"],
        coordinates: json["coordinates"] == null
            ? null
            : CoordinatesModel.fromJson(json["coordinates"]),
        postalCode: json["postalCode"],
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "city": city,
        "coordinates": (coordinates as CoordinatesModel).toJson(),
        "postalCode": postalCode,
        "state": state,
      };
}

class CoordinatesModel extends Coordinates {
  CoordinatesModel({
    super.lat,
    super.lng,
  });

  CoordinatesModel copyWith({
    double? lat,
    double? lng,
  }) =>
      CoordinatesModel(
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
      );

  factory CoordinatesModel.fromJson(Map<String, dynamic> json) =>
      CoordinatesModel(
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}

class BankModel extends Bank {
  BankModel({
    super.cardExpire,
    super.cardNumber,
    super.cardType,
    super.currency,
    super.iban,
  });

  BankModel copyWith({
    String? cardExpire,
    String? cardNumber,
    String? cardType,
    String? currency,
    String? iban,
  }) =>
      BankModel(
        cardExpire: cardExpire ?? this.cardExpire,
        cardNumber: cardNumber ?? this.cardNumber,
        cardType: cardType ?? this.cardType,
        currency: currency ?? this.currency,
        iban: iban ?? this.iban,
      );

  factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(
        cardExpire: json["cardExpire"],
        cardNumber: json["cardNumber"],
        cardType: json["cardType"],
        currency: json["currency"],
        iban: json["iban"],
      );

  Map<String, dynamic> toJson() => {
        "cardExpire": cardExpire,
        "cardNumber": cardNumber,
        "cardType": cardType,
        "currency": currency,
        "iban": iban,
      };
}

class CompanyModel extends Company {
  CompanyModel({
    AddressModel? super.address,
    super.department,
    super.name,
    super.title,
  });

  CompanyModel copyWith({
    AddressModel? address,
    String? department,
    String? name,
    String? title,
  }) =>
      CompanyModel(
        address: address ?? this.address as AddressModel,
        department: department ?? this.department,
        name: name ?? this.name,
        title: title ?? this.title,
      );

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
        address: json['address'] != null
            ? AddressModel.fromJson(json['address'])
            : null,
        department: json["department"],
        name: json["name"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        'address': (address as AddressModel).toJson(),
        "department": department,
        "name": name,
        "title": title,
      };
}

class CryptoModel extends Crypto {
  CryptoModel({
    super.coin,
    super.wallet,
    super.network,
  });

  CryptoModel copyWith({
    String? coin,
    String? wallet,
    String? network,
  }) =>
      CryptoModel(
        coin: coin ?? this.coin,
        wallet: wallet ?? this.wallet,
        network: network ?? this.network,
      );

  factory CryptoModel.fromJson(Map<String, dynamic> json) => CryptoModel(
        coin: json["coin"],
        wallet: json["wallet"],
        network: json["network"],
      );

  Map<String, dynamic> toJson() => {
        "coin": coin,
        "wallet": wallet,
        "network": network,
      };
}

class HairModel extends Hair {
  HairModel({
    super.color,
    super.type,
  });

  HairModel copyWith({
    String? color,
    String? type,
  }) =>
      HairModel(
        color: color ?? this.color,
        type: type ?? this.type,
      );

  factory HairModel.fromJson(Map<String, dynamic> json) => HairModel(
        color: json["color"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "color": color,
        "type": type,
      };
}
