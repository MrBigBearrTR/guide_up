import 'package:flutter/material.dart';

void main() {
  runApp(const KayanAppbarDenemePage());
}
class KayanAppbarDenemePage extends StatelessWidget {
  const KayanAppbarDenemePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scrollable App Bar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const KayanAppbarDenemedartPage(),
    );
  }
}
class KayanAppbarDenemedartPage extends StatelessWidget {
  final double appBarHeight = 56.0;

  const KayanAppbarDenemedartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: const Text('Scrollable App Bar'),
            floating: true,
            pinned: false, // AppBar kaybolacak
            snap: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            expandedHeight: appBarHeight,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Container(
                color: Colors.blue,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) => ListTile(
                title: Text('Item $index'),
              ),
              childCount: 50,
            ),
          ),
        ],
      ),
    );
  }
}