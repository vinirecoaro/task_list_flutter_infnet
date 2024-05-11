class Task {
  final String description;
  final String title;
  final String date;
  final String time;
  final String lat;
  final String lon;
  final bool edit;

  Task({
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    this.lat = '',
    this.lon = '',
    this.edit = false,
  });
}
