class Task {

  String title;
  String description;
  DateTime date;
  bool flag;

  Task(this.title, this.description, this.date, this.flag);

getInfo(){
  return title +" , " + description + " , " + date.toString() + " , " + flag.toString() ;
}

}
