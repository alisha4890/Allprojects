import 'package:flutter/material.dart';
import './transacttin_item.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deletetx;

  TransactionList(this.transactions ,this.deletetx);
  @override
  Widget build(BuildContext context) {
    print('build () TransactionList');
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (ctx,constraints){
            return Column(
              children: <Widget>[
                Text(
                  'ADD TRANSACTION!!',
                  //   style: Theme.of(context),textTheme.title,
                ),
                const SizedBox(
                  height: 20,  // an empty box(space) provided btw image nad text
                ),
                Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/Images/budget.jpg',fit: BoxFit.cover,   // for getting the proper size of img acc to screen
                    )
                ),
              ],
            );
      })
          :ListView(
        children: transactions
          .map((tx) => TransactionItem(
          key: ValueKey(tx.id),
          deletetx: deletetx,
      )).toList(),
        ),
      );

    }
  }

