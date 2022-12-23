import 'package:flutter/material.dart';

class ResultField extends StatefulWidget {
  final String lable;

  const ResultField({super.key, required this.lable});

  @override
  State<ResultField> createState() => _ResultFieldState();
}

class _ResultFieldState extends State<ResultField> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: SizedBox(
          width: width * 0.95,
          height: 75,
          child: TextFormField(
              maxLines: 3,
              initialValue: widget.lable,
              style: const TextStyle(color: Colors.black, fontSize: 16),
              enabled: false,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(width: 0, color: Colors.white),
                ),
              ))),
    );
  }
}
