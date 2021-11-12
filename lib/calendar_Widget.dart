import 'package:chef_syncfusion/event_provider.dart';
import 'package:chef_syncfusion/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'event_data_source.dart';

class CalenderWidget extends StatelessWidget {
  const CalenderWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final events =
        Provider.of<EventProvider>(context).events;
    return SfCalendar(
      view: CalendarView.month,
      dataSource: EventDataSource(events),
      initialSelectedDate: DateTime.now(),
      onLongPress: (details) {
        final provider = Provider.of<EventProvider>(context,listen: false );
        provider.setDate(details.date);
        showModalBottomSheet(context: context,
            builder: (context) => TaskWidget());
      },
    );
  }
}