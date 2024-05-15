class Task {
  String description;
  String title;
  String date;
  String time;
  String lat;
  String lon;
  bool edit;
  String cep;
  String num;

  Task({
    required this.title,
    required this.description,
    this.date = '',
    this.time = '',
    this.lat = '',
    this.lon = '',
    this.edit = false,
    this.cep = '',
    this.num = '',
  });
}
