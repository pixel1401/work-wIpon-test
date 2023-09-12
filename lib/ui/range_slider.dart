import 'package:flutter/material.dart';

class RangeSliderExample extends StatefulWidget {
  final double valueSlider;
  final Function setValue;
  const RangeSliderExample({super.key , required this.setValue , required this.valueSlider});

  @override
  State<RangeSliderExample> createState() => _RangeSliderExampleState();
}

class _RangeSliderExampleState extends State<RangeSliderExample> {
  @override
  Widget build(BuildContext context) {
    return Slider(
      min: 50,
      max: 2000,
      divisions: 50,
      value: widget.valueSlider, 
      onChanged: (value) {
        widget.setValue(value);
      });
  }
}