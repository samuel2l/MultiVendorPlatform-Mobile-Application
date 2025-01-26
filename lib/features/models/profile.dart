// ignore_for_file: public_member_api_docs, sort_constructors_first

class Profile {
  final String name;
    final String img;

  final String gender;
  final String street;
  final String postalCode;
  final String city;
  final String country;
  final String about;

  Profile({
    required this.name,
    required this.img,
    required this.gender,
    required this.street,
    required this.postalCode,
    required this.city,
    required this.country,
    required this.about,
  });

  Profile copyWith({
    String? name,
    String? img,
    String? gender,
    String? street,
    String? postalCode,
    String? city,
    String? country,
        String? about
  }) {
    return Profile(
      name: name ?? this.name,
      img: img ?? this.img,
      gender: gender ?? this.gender,
      street: street ?? this.street,
      postalCode: postalCode ?? this.postalCode,
      city: city ?? this.city,
      country: country ?? this.country,
      about: about ?? this.about,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'img': img,
      'gender': gender,
      'street': street,
      'postalCode': postalCode,
      'city': city,
      'country': country,
      'about':about
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      name: map['name'] as String,
      img: map['img'] as String,
      gender: map['gender'] as String,
      street: map['street'] as String,
      postalCode: map['postalCode'] as String,
      city: map['city'] as String,
      country: map['country'] as String,
      about: map['about'] as String,
    );
  }


}
