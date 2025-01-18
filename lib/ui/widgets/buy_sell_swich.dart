import 'package:flutter/material.dart';

class BuySellSwitch extends StatefulWidget {
  bool isBuySelected;

  BuySellSwitch({super.key, required this.isBuySelected});

  @override
  _BuySellSwitchState createState() => _BuySellSwitchState();
}

class _BuySellSwitchState extends State<BuySellSwitch> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              widget.isBuySelected = true;
              setState(() {});
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: widget.isBuySelected == true
                    ? Colors.amber
                    : Colors.amber.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  'Buy',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: GestureDetector(
            onTap: () {
              widget.isBuySelected = false;
              setState(() {});
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: widget.isBuySelected == true
                    ? Colors.amber.shade100
                    : Colors.amber,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  'Sell',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
