class Weather {
  int id;
  String description;
  String icon;
  String main;
  String cityName;
  double temperature;

  Weather({this.id, this.description, this.icon, this.main, this.cityName, this.temperature});

  static Weather fromJson(Map<String, dynamic> json){
    final weather = json['weather'][0];
    return Weather(
      id: weather['id'],
      description: weather['description'],
      icon: weather['icon'],
      main: weather['main'],
      cityName: json['name'],
      temperature: json['main']['temp']
    );
  }

  double get temperatureAsCelsius {
    return temperature - 273.15;
  }
}