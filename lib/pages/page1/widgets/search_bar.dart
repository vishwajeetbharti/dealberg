import 'package:flutter/material.dart';

import '../../../Utils/constants.dart';

class SearchContainer extends StatelessWidget {
  const SearchContainer({
    super.key,
    required this.onChange,
    required this.height,
    required this.top,
    required this.width,
  });
  final Function(String) onChange;
  final double height;
  final double width;
  final double top;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.only(top: top),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: TextFormField(
          style: const TextStyle(color: Colors.white),
          showCursor: false,
          decoration: InputDecoration(
            hintText: Strings.search,
            hintStyle: TextStyle(
              fontSize: width * 0.041,
              color: Colors.grey,
            ),
            suffixIcon: const Icon(Icons.search_rounded),
            suffixIconColor: Colors.black,
            border: InputBorder.none,
          ),
          onChanged: onChange,
        ),
      ),
    );
  }
}
