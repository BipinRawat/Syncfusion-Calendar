import 'package:chef_syncfusion/event_data_source.dart';
import 'package:chef_syncfusion/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class TaskWidget extends StatefulWidget {

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context);
    final selectedEvents = provider.eventsOfSelectedDate;

    if(selectedEvents.isEmpty)  {
      return Center(
        child: Text(
          'No Events found !',
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
      );
    }
      return SfCalendarTheme(
          data: SfCalendarThemeData(
            timeTextStyle: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold)
          ),
          child: SfCalendar(
            view: CalendarView.timelineDay,
            dataSource: EventDataSource(provider.events),
            initialDisplayDate: provider.selectedDate,
            appointmentBuilder: appointmentBuilder,
            headerHeight: 0,
            todayHighlightColor: Colors.black,
            // onTap: (details){
            //   if(details.appointments == null) return;
            //
            //   final event = details.appointments.first;
            //
            //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => EventViewingPage(event:event)))
            // },
          )
      );
  }

  Widget appointmentBuilder(
      BuildContext context,
      CalendarAppointmentDetails details,) {
 final event = details.appointments.first;

 return Container(
   width: details.bounds.width,
   height: details.bounds.height,
   decoration: BoxDecoration(
     color: Colors.redAccent,
     borderRadius: BorderRadius.circular(12),
   ),
   child: Center(
     child: Text(
       event.title,
       maxLines: 2,
       overflow: TextOverflow.ellipsis,
       style: TextStyle(
         color: Colors.black,
         fontSize: 16,
         fontWeight: FontWeight.bold
       ),
     ),
   ),
 );

  }
}
