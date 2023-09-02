import 'package:flutter/material.dart';

class SearchContainer extends StatelessWidget {
  const SearchContainer({
    super.key,
    required this.controllerSearch,
    required this.height,
    required this.width,
    required this.top,
  });
  final TextEditingController controllerSearch;
  final double width;
  final double height;
  final double top;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.only(top: top),
      decoration: const BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: TextFormField(
          controller: controllerSearch,
          style: const TextStyle(color: Colors.white),
          showCursor: false,
          decoration: const InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
            suffixIcon: Icon(Icons.search_rounded),
            suffixIconColor: Colors.black,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
