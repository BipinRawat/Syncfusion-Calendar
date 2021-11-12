import 'package:chef_syncfusion/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'event.dart';
import 'event_provider.dart';

class EventEditingPage extends StatefulWidget {
  final Event event;

  const EventEditingPage({Key key, this.event}) : super(key: key);
  @override
  _EventEditingPageState createState() => _EventEditingPageState();
}

class _EventEditingPageState extends State<EventEditingPage> {
  DateTime fromDate;
  DateTime toDate;
  final titleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.event == null) {
      fromDate = DateTime.now();
      toDate = DateTime.now().add(Duration(hours: 2));
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          leading: CloseButton(),
          actions: buildEditignActions(),
        ),
        body: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildTitle(),
                  SizedBox(height: 12),
                  buildDateTimePickers(),
                ],
              )
          ),
        ),
      );

  List<Widget> buildEditignActions() =>
      [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            shadowColor: Colors.transparent
          ),
            onPressed: saveForm,
            icon: Icon(Icons.done),
            label: Text("Save"))
      ];

  ///////////////////////////////Title /////////////
  Widget buildTitle() =>
      TextFormField(
          decoration: InputDecoration(
              border: UnderlineInputBorder(),
              hintText: "Add Title"
          ),
          style: TextStyle(fontSize: 24),
          // onFieldSubmitted: (_) => saveForm(),
          controller: titleController,
          validator: (title) =>
          title != null && title.isEmpty ? 'Title can not be empty' : null
      );

  Widget buildDateTimePickers() =>
      Column(
        children: [
          buildFrom(),
          buildTo()
        ],
      );

  /////////////////////////// from /////////////////////
  Widget buildFrom() =>
      buildHeader(
          header: 'FROM',
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: buildDropdownField(
                    text: Utils.toDate(fromDate),
                    onClicked: () => pickFromDateTime(pickDate: true),
                  )
              ),
              Expanded(child: buildDropdownField(
                text: Utils.toTime(fromDate),
                onClicked: () => pickFromDateTime(pickDate: false),
              )
              )
            ],
          )
      );

  /////////////////// to///////////////////////////////

  Widget buildTo() =>
      buildHeader(
          header: 'To',
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: buildDropdownField(
                    text: Utils.toDate(toDate),
                    onClicked: () => pickToDateTime(pickDate: true),
                  )
              ),
              Expanded(child: buildDropdownField(
                text: Utils.toTime(toDate),
                onClicked: () => pickToDateTime(pickDate: false),
              )
              )
            ],
          )
      );

  //////////////////////////////////////////////////////////

  Future pickFromDateTime({@required bool pickDate}) async {
    final date = await pickDateTime(fromDate, pickDate: pickDate);
    if (date == null) return;

    if (date.isAfter(toDate)) {
      toDate =
          DateTime(date.year, date.month, date.day, toDate.hour, toDate.minute);
    }

    setState(() => fromDate = date);
  }

  Future pickToDateTime({@required bool pickDate}) async {
    final date = await
    pickDateTime(toDate,
      pickDate: pickDate,
      firstDate: pickDate ? fromDate : null,
    );
    if (date == null) return;

    // if(date.isAfter(toDate)) {
    //   toDate =
    //       DateTime(date.year,date.month,date.day , toDate.hour , toDate.minute);
    // }

    setState(() => toDate = date);
  }

/////////////////////////////////////////////////////

  Future<DateTime> pickDateTime(DateTime initialDate, {
    @required bool pickDate,
    DateTime firstDate,
  }) async {
    if (pickDate) {
      final date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate ?? DateTime(2015, 8),
        lastDate: DateTime(2101),
      );
      if (date == null)
        return null;

      final time = Duration(
          hours: initialDate.hour, minutes: initialDate.minute);

      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );

      if (timeOfDay == null)
        return null;

      final date = DateTime(
          initialDate.year, initialDate.month, initialDate.day);
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);

      return date.add(time);
    }
  }

  Widget buildDropdownField({
    @required String text,
    @required VoidCallback onClicked,
  }) =>
      ListTile(
        title: Text(text),
        trailing: Icon(Icons.arrow_drop_down),
        onTap: onClicked,
      );

  Widget buildHeader({
    @required String header,
    @required Widget child,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(header, style: TextStyle(fontWeight: FontWeight.bold),),
          child,
        ],
      );

  ///to save event

  Future saveForm() async{
    final isValid = _formKey.currentState.validate();
    if(isValid)
    {
      final event = Event(
        title:titleController.text,
        description: 'Description',
        from : fromDate,
        to: toDate,
        isAllDay: false,
      );

      final provider =
      Provider.of<EventProvider>(context,listen:false);
      provider.addEvent(event);
      Navigator.of(context).pop();
    }
  }
}
