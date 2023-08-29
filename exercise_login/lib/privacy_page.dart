

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrivacyWidget extends StatefulWidget {
  const PrivacyWidget({Key? key, required this.onChanged}) : super(key: key);

  final ValueChanged<bool?> onChanged;


  @override
  _PrivacyWidgetState createState() => _PrivacyWidgetState();
}

class _PrivacyWidgetState extends State<PrivacyWidget> {

  bool? checked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: checked, onChanged: (value) {
              widget.onChanged(value);
              setState(() {
                checked = value;
              });
        }),
        Text('同意',style: TextStyle(fontSize: 14)),
        Text('<服务协议>',style: TextStyle(fontSize: 14, color: Colors.blue)),
        Text('和',style: TextStyle(fontSize: 14)),
        Text('<隐私协议>',style: TextStyle(fontSize: 14, color: Colors.blue)),

      ],
    );
  }
}
