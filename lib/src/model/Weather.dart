class Weather {
  int id;
  String description;
  String icon;
  String main;

  Weather({this.id, this.description, this.icon, this.main});

  static Weather fromJson(Map<String, dynamic> json){
    return Weather(
      id: json['id'],
      description: json['description'],
      icon: json['icon'],
      main: json['main']
    );
  }
}