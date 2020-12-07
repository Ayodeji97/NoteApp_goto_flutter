import 'package:flutter/material.dart';

class NoteDetail extends StatefulWidget {

  // Note : WillPopScope will allow you to control the back button of your user device


  // used in changing the appBar dynamically;
  String appBarTitle;

  NoteDetail(this.appBarTitle);

  @override
  _NoteDetailState createState() => _NoteDetailState(this.appBarTitle);
}

class _NoteDetailState extends State<NoteDetail> {

  String appBarTitle;
  static var _priorities = ['High', 'Normal', 'Low'];
  // used to control what the user enter into the text field

  var _currentItemSelected = '';

  _NoteDetailState(this.appBarTitle);

  @override
  void initState() {
    super.initState();
    _currentItemSelected = _priorities[0];
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final _minimumPadding = 5.0;

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.title;
    return WillPopScope (
      // define what will happen when the user click on the back button
      onWillPop: () {
        // control the back navigation on your user device
        moveToLastScreen();
      },
        child : Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        leading: IconButton(icon: Icon(
          Icons.arrow_back),
          onPressed: () {
            // control the back navigation on your user device
            moveToLastScreen();
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0, right: 10.0, left: 10.0),
        child: ListView(
          children: <Widget>[

            ListTile(
              title: DropdownButton(
                items : _priorities.map((String value) => DropdownMenuItem <String>(
                    value: value,
                    child: Text(value),
                )).toList(),
                style: textStyle,
                value: _currentItemSelected,
                onChanged: (valueSelectedByUser) {
                  setState(() {
                    debugPrint('User Selected $valueSelectedByUser');
                  });
                },
              ),
            ),

            // second element which is a form field
            Padding (
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextFormField(
                controller: titleController,
                style: textStyle,
                onChanged: (value) {
                  debugPrint('Something something I love doing...');
                },
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: textStyle,
                  hintText: 'Enter note title...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )
                ),
              ),
            ),

            Padding (
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextFormField(
                controller: descriptionController,
                style: textStyle,
                onChanged: (value) {
                  debugPrint('Description...');
                },
                decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: textStyle,
                    hintText: 'Enter note title...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Save',
                        textScaleFactor: 1.5,
                      ),

                      onPressed: () {
                        // do something here
                        setState(() {
                          debugPrint('Great');
                        });
                      },
                    ),
                  ),

                  Container(width: _minimumPadding * 5),

                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Delete',
                        textScaleFactor: 1.5,
                      ),

                      onPressed: () {
                        // do something here
                        debugPrint('Cancel');
                      },
                    ),
                  ),


                ],
              ),
            )
          ],
        ),
      ),

    ));
  }

  void moveToLastScreen () {
    Navigator.pop(context);
  }
}
