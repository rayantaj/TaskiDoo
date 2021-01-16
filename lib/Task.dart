class Task {
  String title;
  String description;
  String date;
  bool flag;
  int id;
  bool completed = false;

  Task(this.title, this.description, this.date, this.flag, this.id);

  getInfo() {
    return id.toString() +
        " , " +
        title +
        " , " +
        description +
        " , " +
        date.toString() +
        " , " +
        flag.toString();
  }
}
