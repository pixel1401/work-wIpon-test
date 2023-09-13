import 'dart:math';
import 'package:flutter/material.dart';
import 'package:test_flutter_wip/model/checkbox.dart';
import 'package:test_flutter_wip/ui/Range_slider.dart';
import 'package:test_flutter_wip/ui/checkbox.dart';


class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  var random = Random();

  List<CheckboxType> elements = [];

  double durationSlider = 100;

  CheckboxModel model = CheckboxModel(checkboxType: [
    CheckboxType(color: Colors.lightGreen, state: true, index: 1),
    CheckboxType(color: Colors.pink, state: false, index: 2),
    CheckboxType(color: Colors.deepPurple, state: false, index: 3),
  ]);

  @override
  void initState() {
    super.initState();
    model.initCheckbox();
    setState(() {});
  }


  void addCheckboxes() {
    model.addCheckboxes();
    setState(() {});
  }

  void clearCheckboxes() {
    model.clearCheckboxes();
    setState(() {});
  }

  void setValueDuration(double value) {
    durationSlider = value;
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
                BoxConstraints(minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Wrap(
                      spacing: 20.0,
                      runSpacing: 15.0,
                      children: [
                        ...model.checkboxes.map((e) {
                          return CustomCheckbox(
                            color: e.color,
                            isChecked: e.state,
                            toggleChange: () {
                              model.toggleCheckbox(e.index);
                              setState(() {});
                            },
                            duration: durationSlider.round(),
                          );
                        })
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: const Text('Animation duration'),
                    ),
                    RangeSliderExample(
                        setValue: setValueDuration,
                        valueSlider: durationSlider),
                    Text('${durationSlider.round()} ms'),
                    const SizedBox(
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
          const SizedBox(
            width: 10,
          ),
          OutlinedButton(
              onPressed: () => clearCheckboxes(), child: const Text('Clear'))
        ],
      ),
    );
  }
}
