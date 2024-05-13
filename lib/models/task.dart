class Task {
  final String description;
  final String title;
  final String date;
  final String time;
  final String lat;
  final String lon;
  final bool edit;
  final String cep;
  final String num;

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
