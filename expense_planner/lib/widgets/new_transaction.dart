import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addtx;
  NewTransaction(this.addtx)
  {
    print('Constructor NewTransaction Widget');
 }

  @override
  _NewTransactionState createState() {
    print('CreateState NewTransaction Widget');
    return _NewTransactionState();
  }

}
class _NewTransactionState extends State<NewTransaction> {
  final _titlecontroller = TextEditingController();
  final _amountcontroller = TextEditingController();
  DateTime _selectedDate;
  _NewTransactionState(){
    print('Constructor NewTransaction State');

  }

  @override
  void initState()
  {
    print('initState()');
    super.initState();
  }

  @override
  void didUpdateWidget(NewTransaction oldWidget) {

    print('didUpdateWidget()');
    super.didUpdateWidget(oldWidget);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    print('dispose()');
    super.dispose();
  }
  void _submitData(){
    if(_amountcontroller.text.isEmpty)
      {
        return;
      }

    final enteredTitle = _titlecontroller.text;
    final enteredAmount = double.parse(_amountcontroller.text);

    if(enteredTitle.isEmpty || enteredAmount <= 0||_selectedDate==null)
      {
        return;
      }



     widget.addtx(
      enteredTitle,
      enteredAmount,
     _selectedDate,
     );//double.parse will take a string and will convert into double

     Navigator.of(context).pop();         //auto - close after entering
   }

   void _presentDatePicker() {
    showDatePicker(                    // datepicker
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019) ,
       lastDate: DateTime.now(),
    ).then((pickedDate) {
      if(pickedDate == null)
        {
          return;
        }
      setState(() {
        _selectedDate = pickedDate;
      });

     });   //once the user chose a dat ,then future will processs
   }
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(    //scrolling keyboard
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(decoration: InputDecoration(labelText: 'Title'),
                controller: _titlecontroller,
                onSubmitted: (_) => _submitData(),
                //onChanged: (val) {
                //titleInput = val;
              ),
              TextField(decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountcontroller,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),   // a method of not passing the argument in func submitDta
                //onChanged: (val) => amountInput = val,
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                  Text(_selectedDate == null ? 'No Date Choosen'
                      : DateFormat.yMd().format(_selectedDate)),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text('Choose Date',
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    onPressed: _presentDatePicker ,
                  ),
                ],),
              ),
              RaisedButton(
                child: Text('Add Transaction'),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: _submitData,
              )
            ],
          ),
        ),
      ),
    );
  }
}
