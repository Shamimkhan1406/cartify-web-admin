import 'dart:convert';

class Buyer {
  // define fields
  final String id;
  final String fullName;
  final String email;
  final String state;
  final String city;
  final String locality;
  final String password;
  final String token;

  Buyer({
    required this.id,
    required this.fullName,
    required this.email,
    required this.state,
    required this.city,
    required this.locality,
    required this.password,
    required this.token,
  });
  // serialization: convert Buyer object to a map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "fullName": fullName,
      "email": email,
      "state": state,
      "city": city,
      "locality": locality,
      "password": password,
      "token": token,
    };
  }

  // convert map to json string
  String toJson() => json.encode(toMap());
  // deserialization: convert json string to Buyer object
  // so it can be easily manipulated and use within the app
  // the factory constructor takes map (usually comes from a json string)
  // and returns a Buyer object
  // it is useful when you already have the data in map format
  factory Buyer.fromMap(Map<String, dynamic> map) {
    return Buyer(
      id: map["_id"] as String? ?? "",
      fullName: map["fullName"] as String? ?? "",
      email: map["email"] as String? ?? "",
      state: map["state"] as String? ?? "",
      city: map["city"] as String? ?? "",
      locality: map["locality"] as String? ?? "",
      password: map["password"] as String? ?? "",
      token: map["token"] as String? ?? "",
    );
  }
  // fromJson: this factory constructor takes a json string and decode into a Map<String, dynamic> object
  // then uses fromMap to convert the map into Buyer object
  // factory Buyer.fromJson(String source) => Buyer.fromMap(json.decode(source) as Map<String, dynamic>);
}
