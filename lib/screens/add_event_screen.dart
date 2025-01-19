import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../main.dart';
import '../models/event.dart';


class AddEventScreen extends StatefulWidget {
  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final _titleController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  final _locationController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime)
      setState(() {
        _selectedTime = picked;
      });
  }

  Future<void> _scheduleNotification(DateTime scheduledDate) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(
      0,
      'Reminder',
      'Event at ${scheduledDate.toLocal()}',
      scheduledDate,
      platformChannelSpecifics,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Event')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(labelText: 'Location'),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "${_selectedDate.toLocal()}".split(' ')[0],
                  ),
                ),
                TextButton(
                  onPressed: () => _selectDate(context),
                  child: Text('Select date'),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "${_selectedTime.hour}:${_selectedTime.minute}",
                  ),
                ),
                TextButton(
                  onPressed: () => _selectTime(context),
                  child: Text('Select time'),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                // Додадете логика за зачувување на настанот
                Navigator.pop(
                  context,
                  Event(
                    title: _titleController.text,
                    date: DateTime(
                      _selectedDate.year,
                      _selectedDate.month,
                      _selectedDate.day,
                      _selectedTime.hour,
                      _selectedTime.minute,
                    ),
                    location: _locationController.text,
                    latitude: 0.0, // Додадете локација
                    longitude: 0.0, // Додадете локација
                  ),
                );
              },
              child: Text('Save Event'),
            ),
          ],
        ),
      ),
    );
  }
}

extension on FlutterLocalNotificationsPlugin {
  schedule(int i, String s, String t, DateTime scheduledDate, NotificationDetails platformChannelSpecifics) {}
}


