class Reports {
  String description;
  String icon;
  String temperature;
  String tempMin;
  String tempMax;
  String pressure;
  String humidity;
  String windSpeed;
  String sunrise;
  String sunset;

  Reports({
    this.description,
    this.icon,
    this.temperature,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
    this.windSpeed,
    this.sunrise,
    this.sunset,
  });
  factory Reports.fromJson(Map<String, dynamic> json) {
    return Reports(
        description: json["description"],
        icon: json["icon"],
        temperature: json["temperature"],
        tempMin: json["tempMin"],
        tempMax: json["tempMax"],
        pressure: json["pressure"],
        humidity: json["humidity"],
        windSpeed: json["windSpeed"],
        sunrise: json["sunrise"],
        sunset: json["sunset"]);
  }
}
