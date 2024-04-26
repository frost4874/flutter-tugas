import 'package:flutter/material.dart';

class WidgetDemo extends StatefulWidget {
  const WidgetDemo({super.key});

  @override
  State<WidgetDemo> createState() => _WidgetDemoState();
}

class _WidgetDemoState extends State<WidgetDemo> {
  bool _isChecked = false;
  bool isChecked = false;
  double _sliderValue = 0;
  int _selectedRadio = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Widgets Demo'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CheckboxListTile(
              title: Text('Belajar Dasar Flutter'),
              subtitle: Text('Dart, widget, http'),
              value: _isChecked,
              activeColor: Colors.deepPurpleAccent,
              onChanged: (bool? value) {
                setState(() {
                  _isChecked = value!;
                });
              },
            ),
            SwitchListTile(
              title: Text('Backend Programming'),
              subtitle: Text('Dart, Nodejs, PHP, Java, dll'),
              value: isChecked,
              activeTrackColor: Colors.pink[100],
              activeColor: Colors.red,
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value!;
                });
              },
            ),
            Slider(
              value: _sliderValue,
              min: 0,
              max: 100,
              divisions: 100,
              label: _sliderValue.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _sliderValue = value;
                });
              },
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List<Widget>.generate(3, (int index) {
                return ListTile(
                  title: Text('Pilih ${index + 1}'),
                  leading: Radio<int>(
                    value: index,
                    groupValue: _selectedRadio,
                    onChanged: (int? value) {
                      setState(() {
                        _selectedRadio = value!;
                      });
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
