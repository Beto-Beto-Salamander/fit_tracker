import 'package:fit_tracker/lib.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    return ScaffoldWrapper(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
        ),
        body: CustomScrollView(
          slivers: [SliverBoxPadding(child: child)],
        ),
      ),
    );
  }
}
