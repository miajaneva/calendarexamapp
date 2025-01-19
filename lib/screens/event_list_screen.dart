import 'package:flutter/material.dart';
import 'add_event_screen.dart';
import 'map_screen.dart';
import '../models/event.dart';

class EventListScreen extends StatefulWidget {
  @override
  _EventListScreenState createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  List<Event> events = [];

  void _addEvent(Event event) {
    setState(() {
      events.add(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exam Schedule'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              final newEvent = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddEventScreen()),
              );
              if (newEvent != null) _addEvent(newEvent);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return ListTile(
            title: Text(event.title),
            subtitle: Text('${event.date} - ${event.location}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MapScreen(
                    latitude: event.latitude,
                    longitude: event.longitude,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}