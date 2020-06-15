

import 'package:flutter/material.dart';
import './widgets/transactin_list.dart';
import './widgets/new_transaction.dart';
import 'package:flutter/services.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

void main(){
  //WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setPreferredOrientations([
    ///DeviceOrientation.portraitUp,
    //DeviceOrientation.portraitDown,
 /// ]);
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expense Planner',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.lime,
        errorColor: Colors.red,
        //fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(
            //fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
            button: TextStyle(color: Colors.white),
        ),
        appBarTheme: AppBarTheme(
        )
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> _userTransactions = [
    /*Transaction(
      id:'t1',
      title: 'New Watch',
      amount: 78.93 ,
      date: DateTime.now(),
    ),
    Transaction(
      id:'t2',
      title: 'New Shoes',
      amount: 108.93 ,
      date: DateTime.now(),
    )*/
  ];
  bool _showchart = false;
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.removeObserver(this);
    super.initState();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state){//this method is called whenever app changes its lifecycle i.e whnevr app reaches a new state
    print(state);
  }
  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  List<Transaction> get _recentTransactions{

    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7),
       ),
      );
     }).toList();
  }

  void _addNewTransaction(String txtitle, double txAmount,DateTime chosenDate){
    final newTx= Transaction(
      title: txtitle,
      amount: txAmount,
      date:chosenDate,
      id: DateTime.now().toString(),

    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddnewTransaction(BuildContext ctx){               //it starts the process of adding new transaction
   showModalBottomSheet(
       context: ctx,
       builder: (_) {
     return GestureDetector(
       onTap: () {},
       child: NewTransaction(_addNewTransaction),
       behavior: HitTestBehavior.opaque ,);
     }
   );
  }

  void _deleteTransaction(String id){
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });

    });
  }

  List<Widget> _buildLandscapeContent(MediaQueryData mediaquery,AppBar appBar, Widget txlistwidget)  {
    return [Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Show Chart'),
        Switch(
            value: _showchart,
            onChanged: (val){
              setState(() {
                _showchart=val;
              });
            }),
      ],
    ), _showchart
    ? Container(
      height: (mediaquery.size.height - appBar.preferredSize.height- mediaquery.padding.top) * 0.7,
      child: Chart(_recentTransactions),
      )
      : txlistwidget];
  }
  List<Widget> _buildPortaitContent(MediaQueryData mediaquery,AppBar appBar, Widget txlistwidget)  {
    return [Container(
      height: (
          mediaquery.size.height - appBar.preferredSize.height -mediaquery.padding.top) * 0.3,
      child: Chart(_recentTransactions),),txlistwidget];
  }
  @override
  Widget build(BuildContext context) {
    print('build () My HomepageState');
    final mediaquery = MediaQuery.of(context);
    final isLandscape = mediaquery.orientation == Orientation.landscape;
    final appBar= AppBar(
      //backgroundColor: Colors.red,
      title: Text('Personal Expense Planner'),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.add),
          onPressed: () =>_startAddnewTransaction(context),
        ),
      ],
    );
    final txlistwidget = Container(
        height: (
            mediaquery.size.height - appBar.preferredSize.height) * 0.7,
        child: TransactionList(_userTransactions,_deleteTransaction),
     );
     return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
         //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              ..._buildLandscapeContent( mediaquery,appBar, txlistwidget),
            if(!isLandscape)
                  ..._buildPortaitContent(mediaquery , appBar,txlistwidget),         // ... (spread operator) means to pull all the elements out of list and  merge them as single elements into the surrounding list
              ]

        ),
      ),
      floatingActionButtonLocation:  FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed:  () =>_startAddnewTransaction(context),
      ),
    );
  }
}
