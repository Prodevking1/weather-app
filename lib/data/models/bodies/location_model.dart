class Location {
  String country;
  String city;
  String state;
  String code;

  Location({this.country, this.city, this.code, this.state});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
        country: json["country"],
        city: json["city"],
        state: json["state"],
        code: json["code"]);
  }
}
