import 'dart:math';
import 'package:flutter/material.dart';
import 'package:test_flutter_wip/ui/Range_slider.dart';
import 'package:test_flutter_wip/ui/checkbox.dart';

class CheckboxType {
  int typeState;
  Color color;
  CheckboxType({required this.typeState, required this.color});
}

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  final ScrollController _scrollController = ScrollController();
  var random = Random();

  List<CheckboxType> elements = [];

  double durationSlider = 100;

  bool typeState1 = false;
  Color typeColor1 = Colors.lightGreen;

  bool typeState2 = false;
  Color typeColor2 = Colors.pink;

  bool typeState3 = false;
  Color typeColor3 = Colors.deepPurple;

  @override
  void initState() {
    super.initState();
    elements = [
      CheckboxType(
        color: typeColor1,
        typeState: 1,
      )
    ];
    setState(() {});
  }

  void toggleCheckbox(int typeState) {
    switch (typeState) {
      case 1:
        typeState1 = !typeState1;
        typeState2 = false;
        typeState3 = false;
        break;
      case 2:
        typeState2 = !typeState2;
        typeState1 = false;
        typeState3 = false;
        break;
      case 3:
        typeState3 = !typeState3;
        typeState1 = false;
        typeState2 = false;

        break;
      default:
    }

    setState(() {});
  }

  bool setTypeCheckbox(int type) {
    switch (type) {
      case 1:
        return typeState1;
      case 2:
        return typeState2;
      case 3:
        return typeState3;
      default:
        return typeState1;
    }
  }

  CheckboxType randomCheckBox(int type) {
    switch (type) {
      case 1:
        return CheckboxType(
          color: typeColor1,
          typeState: 1,
        );
      case 2:
        return CheckboxType(
          color: typeColor2,
          typeState: 2,
        );
      case 3:
        return CheckboxType(
          color: typeColor3,
          typeState: 3,
        );
      default:
        return CheckboxType(
          color: typeColor1,
          typeState: 1,
        );
    }
  }

  void addCheckboxes() {
    elements = [
      ...elements,
      ...(List<CheckboxType>.generate(10, (int index) {
        int randomNumber = random.nextInt(3) + 1;
        return randomCheckBox(randomNumber);
      }))
    ];
    setState(() {});
  }

  void setValueDuration(double value) {
    durationSlider = value;
    setState(() {});
  }

  void clearCheckboxes() {
    elements.length = 1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: Container(
            constraints:
                BoxConstraints(minHeight: MediaQuery.of(context).size.height),
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Wrap(
                      spacing: 20.0,
                      runSpacing: 15.0,
                      children: [
                        ...elements.map((e) {
                          return CustomCheckbox(
                            color: e.color,
                            isChecked: setTypeCheckbox(e.typeState),
                            toggleChange: () => toggleCheckbox(e.typeState),
                            duration: durationSlider.round(),
                          );
                        })
                      ],
                    ),
                    SizedBox(height: 20,),
                    RangeSliderExample(
                        setValue: setValueDuration,
                        valueSlider: durationSlider),
                    Text(durationSlider.round().toString() + ' ms'),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
                _buildBtns()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildBtns() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                addCheckboxes();
              },
              child: const Text('Add checkboxes')),
          SizedBox(
            width: 10,
          ),
          OutlinedButton(
              onPressed: () => clearCheckboxes(), child: const Text('Clear'))
        ],
      ),
    );
  }
}
