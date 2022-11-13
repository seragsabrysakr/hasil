import 'package:flutter/material.dart';

class CustomStepper extends StatefulWidget {
  CustomStepper({
    required this.lowerLimit,
    required this.upperLimit,
    required this.stepValue,
    required this.iconSize,
    required this.value,
    required this.onChanged,
  });

  final int lowerLimit;
  final int upperLimit;
  final int stepValue;
  final double iconSize;
  int value;
  final ValueChanged<dynamic> onChanged;

  @override
  _CustomStepperState createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {
              setState(() {
                widget.value = widget.value == widget.lowerLimit
                    ? widget.lowerLimit
                    : widget.value -= widget.stepValue;

                this.widget.onChanged(widget.value);
              });
            },
          ),
          Container(
            width: widget.iconSize,
            child: Text(
              '${widget.value}',
              style: TextStyle(
                fontSize: widget.iconSize * 0.8,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(
                () {
                  widget.value = widget.value == widget.upperLimit
                      ? widget.upperLimit
                      : widget.value += widget.stepValue;

                  this.widget.onChanged(widget.value);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class CustomViStepper extends StatefulWidget {
  CustomViStepper({
    required this.lowerLimit,
    required this.upperLimit,
    required this.stepValue,
    required this.iconSize,
    required this.value,
    required this.onChanged,
  });

  final int lowerLimit;
  final int upperLimit;
  final int stepValue;
  final double iconSize;
  int value;
  final ValueChanged<dynamic> onChanged;

  @override
  _CustomViStepperState createState() => _CustomViStepperState();
}

class _CustomViStepperState extends State<CustomViStepper> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {
              setState(() {
                widget.value = widget.value == widget.lowerLimit
                    ? widget.lowerLimit
                    : widget.value -= widget.stepValue;

                this.widget.onChanged(widget.value);
              });
            },
          ),
          Container(
            width: widget.iconSize,
            child: Text(
              '${widget.value}',
              style: TextStyle(
                fontSize: widget.iconSize * 0.8,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(
                () {
                  widget.value = widget.value == widget.upperLimit
                      ? widget.upperLimit
                      : widget.value += widget.stepValue;

                  this.widget.onChanged(widget.value);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
