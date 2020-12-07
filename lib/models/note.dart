
class Note {

  int _id;
  String _title;
  String _description;
  String _date;
  int _priority;

  // Creating a constructor that will help us create our note object : placing description inside a square bracket makes it optional
  Note(this._title, this._date, this._priority, [this._description]);

  Note.withId(this._id, this._title, this._date, this._priority, [this._description]);

  // Get the getter for all fields
  int get id => id;

  String get title => _title;

  String get description => _description;

  String get date => _date;

  int get priority => _priority;

  // Defining the setter
  set title (String newTitle) {
      if(newTitle.length <= 255) {
        this._title = newTitle;
      }
  }

  set description (String newTitle) {
    if(newTitle.length <= 255) {
      this._description = newTitle;
    }
  }

  set priority (int newPriority) {
    if(newPriority >= 1 && newPriority <= 3) {
      this._priority = newPriority;
    }
  }

  set date (String newDate) {
    this._date = newDate;
  }


  // Function to convert a note object into a map object
  Map <String, dynamic> toMap () {

    // initiate an empty map object
    var map = Map<String, dynamic> ();

    // insert each note object into the map with their respective key

    if(id == null) {
      map['id'] == _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['priority'] = _priority;
    map['date'] = _date;

    return map;
  }

  // A function that will convert a map object back to a note object


}