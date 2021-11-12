// import 'package:chef_syncfusion/event.dart';
// import 'package:chef_syncfusion/event_editing_page.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import 'event_provider.dart';
//
//
// class EventViewPage extends StatelessWidget {
//   final Event event;
//
//   const EventViewPage({Key key, this.event}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) => Scaffold(
//    appBar: AppBar(
//      leading: CloseButton(),
//      actions: buildViewingActions(context, event),
//    ),
//    body: ListView(
//      padding: EdgeInsets.all(32),
//      children: [
//        buildDateTIme(event),
//        SizedBox(
//          height: 32,
//        ),
//        Text(event.title,
//        style: TextStyle(fontSize: 24,
//        fontWeight: FontWeight.bold
//        ),
//        ),
//        const SizedBox(height: 24,),
//        Text(event.description,
//        style: TextStyle(color: Colors.white,fontSize: 18),)
//      ],
//    ),
//   );
//
//   Widget buildDateTime(Event event) {
//     return Column(
//       children: [
//         buildDate(event.isAllDay)  ? 'ALl Day' : 'From', event.from,
//       if(event.isAllday) buildDate('To',event.to),
//       ],
//     );
//   }
//   Widget buildDate(String title, DateTime date) {
//
//   }
//
//  List<Widget> buildViewingActions(BuildContext context, Event event){
//
//    IconButton(
//      icon: Icon(Icons.edit),
//      onPressed: ()=> Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => EventEditingPage(event: event,))),
//    );
//    IconButton(icon: Icon(Icons.delete),
//    onPressed: () {
//    final provider = Provider.of<EventProvider>(context,listen: false)
//    provider.deleteEvent(event);
//
//    }
//    );
//
//  }
//
//
//   }
