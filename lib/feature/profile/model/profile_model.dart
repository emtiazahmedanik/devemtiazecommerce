class AddressModel {
  String? street;
  int? number;
  String? city;
  String? zipcode;
  GeolocationModel? geolocation;

  AddressModel({
    this.street,
    this.number,
    this.city,
    this.zipcode,
    this.geolocation,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      street: json['street'] as String?,
      number: json['number'] as int?,
      city: json['city'] as String?,
      zipcode: json['zipcode'] as String?,
      geolocation: json['geolocation'] != null
          ? GeolocationModel.fromJson(json['geolocation'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'number': number,
      'city': city,
      'zipcode': zipcode,
      'geolocation': geolocation?.toJson(),
    };
  }
}

class GeolocationModel {
  String? latitude;
  String? longitude;

  GeolocationModel({
    this.latitude,
    this.longitude,
  });

  factory GeolocationModel.fromJson(Map<String, dynamic> json) {
    return GeolocationModel(
      latitude: json['lat'] as String?,
      longitude: json['long'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': latitude,
      'long': longitude,
    };
  }
}

class NameModel {
  String? firstname;
  String? lastname;

  NameModel({
    this.firstname,
    this.lastname,
  });

  factory NameModel.fromJson(Map<String, dynamic> json) {
    return NameModel(
      firstname: json['firstname'] as String?,
      lastname: json['lastname'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'lastname': lastname,
    };
  }

  String get fullName => '${firstname ?? ''} ${lastname ?? ''}'.trim();
}

class ProfileModel {
  int? id;
  String? email;
  String? username;
  String? password;
  String? phone;
  NameModel? name;
  AddressModel? address;
  int? version;

  ProfileModel({
    this.id,
    this.email,
    this.username,
    this.password,
    this.phone,
    this.name,
    this.address,
    this.version,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] as int?,
      email: json['email'] as String?,
      username: json['username'] as String?,
      password: json['password'] as String?,
      phone: json['phone'] as String?,
      name: json['name'] != null ? NameModel.fromJson(json['name']) : null,
      address: json['address'] != null
          ? AddressModel.fromJson(json['address'])
          : null,
      version: json['__v'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'password': password,
      'phone': phone,
      'name': name?.toJson(),
      'address': address?.toJson(),
      '__v': version,
    };
  }
}
