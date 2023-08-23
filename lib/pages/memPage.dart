import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:table_calendar/table_calendar.dart';

class MemdiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalendarPage()),
                );
              },
              child: Text('Calendar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddContentPage()),
                );
              },
              child: Text('Add Content'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotesPage()),
                );
              },
              child: Text('Add Notes'),
            ),
          ],
        ),
      ),
    );
  }
}

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<Map<String, dynamic>>> _events = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar Page'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DatePage(selectedDay, _events[selectedDay] ?? [])),
              );
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
        ],
      ),
    );
  }
}

class DatePage extends StatefulWidget {
  final DateTime date;
  final List<Map<String, dynamic>> content;

  DatePage(this.date, this.content);

  @override
  _DatePageState createState() => _DatePageState();
}

class _DatePageState extends State<DatePage> {
  List<Map<String, dynamic>> get content => widget.content;

  Widget buildContent(Map<String, dynamic> content) {
    switch (content['type']) {
      case 'text':
        return ListTile(
          title: Text(content['content']),
        );
      case 'image':
        return ListTile(
          title: Image.file(content['content']),
        );
      case 'video':
        return ListTile(
          title: Text('Video'),
          subtitle:
          Text(content['content'].toString().split('/').last.toString()),
        );
      default:
        return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        Text('${widget.date.day}/${widget.date.month}/${widget.date.year}'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(8.0),
        reverse: true,
        itemBuilder: (_, int index) => buildContent(content[index]),
        itemCount: content.length,
      ),
    );
  }
}

class AddContentPage extends StatefulWidget {
  @override
  _AddContentPageState createState() => _AddContentPageState();
}

class _AddContentPageState extends State<AddContentPage> {
  final TextEditingController _textController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  void _handleSubmitted(String text) {
    setState(() {});
    _textController.clear();
    Navigator.pop(context);
  }

  Future<void> _pickImage() async {
    final XFile? image =
    await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {}
    Navigator.pop(context);
  }

  Future<void> _pickVideo() async {
    final XFile? video =
    await _picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {}
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Content Page'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _textController,
            onSubmitted: _handleSubmitted,
            decoration: InputDecoration.collapsed(hintText: "Add text"),
          ),
          ElevatedButton(
            onPressed: _pickImage,
            child: Text('Add Image'),
          ),
          ElevatedButton(
            onPressed: _pickVideo,
            child: Text('Add Video'),
          ),
        ],
      ),
    );
  }
}

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final TextEditingController _textController = TextEditingController();
  final List<Map<String, dynamic>> _notes = [];

  void _handleSubmitted(String text) {
    setState(() {
      _notes.insert(0, {
        'content': text,
        'timestamp': DateTime.now(),
      });
    });
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes Page'),
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => ListTile(
                title: Text(_notes[index]['content']),
                subtitle:
                Text(_notes[index]['timestamp'].toString().split('.').first),
              ),
              itemCount: _notes.length,
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration:
            BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: TextField(
                    controller: _textController,
                    onSubmitted: _handleSubmitted,
                    decoration:
                    InputDecoration.collapsed(hintText: "Add note"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  child: IconButton(
                      icon: Icon(Icons.send),
                      onPressed:
                          () => _handleSubmitted(_textController.text)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



