import 'dart:math';

import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionListItem extends StatefulWidget {
  const TransactionListItem({
    Key key,
    @required this.transaction,
    @required Function deleteTransaction,
  })  : _deleteTransaction = deleteTransaction,
        super(key: key);

  final Transaction transaction;
  final Function _deleteTransaction;

  @override
  _TransactionListItemState createState() => _TransactionListItemState();
}

class _TransactionListItemState extends State<TransactionListItem> {
  Color _bgColor;

  @override
  void initState() {
    const availableColors = [
      Colors.red,
      Colors.blue,
      Colors.black,
      Colors.purple,
    ];

    _bgColor = availableColors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 0,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                '\$${widget.transaction.amount.toStringAsFixed(2)}',
              ),
            ),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 400
            ? FlatButton.icon(
                textColor: Theme.of(context).errorColor,
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                onPressed: widget._deleteTransaction(widget.transaction.id),
                label: const Text('Delete'),
              )
            : IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                onPressed: () =>
                    widget._deleteTransaction(widget.transaction.id),
              ),
      ),
    );
  }
}
