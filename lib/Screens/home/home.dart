import 'package:flutter/material.dart';

import 'postCard.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: 8,
          itemBuilder: (BuildContext context, int index) {
            return PostCard(
              ownerImg: 'https://picsum.photos/50/50',
              ownerName: 'Mohamed Magdy',
              img: 'https://picsum.photos/370/200',
              date: '6/3/2021',
              description: 'Lorem ipsum ay kalam',
            );
          }),
    );
  }
}
