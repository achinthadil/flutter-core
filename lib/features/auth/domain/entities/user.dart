class User {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? maidenName;
  final int? age;
  final String? gender;
  final String? email;
  final String? phone;
  final String? username;
  final String? password;
  final DateTime? birthDate;
  final String? image;
  final String? bloodGroup;
  final int? height;
  final double? weight;
  final String? eyeColor;
  final Hair? hair;
  final String? domain;
  final String? ip;
  final Address? address;
  final String? macAddress;
  final String? university;
  final Bank? bank;
  final Company? company;
  final String? ein;
  final String? ssn;
  final String? userAgent;
  final Crypto? crypto;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.maidenName,
    this.age,
    this.gender,
    this.email,
    this.phone,
    this.username,
    this.password,
    this.birthDate,
    this.image,
    this.bloodGroup,
    this.height,
    this.weight,
    this.eyeColor,
    this.hair,
    this.domain,
    this.ip,
    this.address,
    this.macAddress,
    this.university,
    this.bank,
    this.company,
    this.ein,
    this.ssn,
    this.userAgent,
    this.crypto,
  });
}

class Address {
  final String? address;
  final String? city;
  final Coordinates? coordinates;
  final String? postalCode;
  final String? state;

  Address({
    this.address,
    this.city,
    this.coordinates,
    this.postalCode,
    this.state,
  });
}

class Coordinates {
  final double? lat;
  final double? lng;

  Coordinates({
    this.lat,
    this.lng,
  });
}

class Bank {
  final String? cardExpire;
  final String? cardNumber;
  final String? cardType;
  final String? currency;
  final String? iban;

  Bank({
    this.cardExpire,
    this.cardNumber,
    this.cardType,
    this.currency,
    this.iban,
  });
}

class Company {
  final Address? address;
  final String? department;
  final String? name;
  final String? title;

  Company({
    this.address,
    this.department,
    this.name,
    this.title,
  });
}

class Crypto {
  final String? coin;
  final String? wallet;
  final String? network;

  Crypto({
    this.coin,
    this.wallet,
    this.network,
  });
}

class Hair {
  final String? color;
  final String? type;

  Hair({
    this.color,
    this.type,
  });
}
