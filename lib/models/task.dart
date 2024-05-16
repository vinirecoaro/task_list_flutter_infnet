class Task {
  int id;
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
    required this.id,
    required this.description,
    required this.title,
    this.date = '',
    this.time = '',
    this.lat = '',
    this.lon = '',
    this.edit = false,
    this.cep = '',
    this.num = '',
  });
}
