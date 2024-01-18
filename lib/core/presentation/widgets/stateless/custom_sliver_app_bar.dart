import 'package:flutter/material.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      pinned: true,
      title: CustomText(
        text: title,
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      centerTitle: true,
      floating: false,
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: const Color(0xffD9D9D9),
            height: 1,
          )),
    );
  }
}
