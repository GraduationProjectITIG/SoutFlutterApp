import 'package:flutter/material.dart';
import 'package:sout/Screens/discover/talentTab.dart';
import 'package:sout/models/models.dart';
// import 'package:intl/intl.dart';
// import 'package:sout/models/models.dart';
// import 'postCard.dart';

class Discover extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  TalentModel talentModel = new TalentModel();
  List<TalentModel> talents = [];

  PostModel postModel = new PostModel();
  List<PostModel> posts = [];

  @override
  void initState() {
    super.initState();
    getAllTalents();
  }

  getAllTalents() async {
    talents = await talentModel.getAllTalents();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: talents.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[700],
          bottom: TabBar(
            labelStyle: TextStyle(
                fontSize: 18.0, fontFamily: 'Family Name'), //For Selected tab
            unselectedLabelStyle:
                TextStyle(fontSize: 15.0, fontFamily: 'Family Name'),
            isScrollable: true,
            tabs: [
              for (var talent in talents) Tab(text: talent.name),
            ],
          ),
          centerTitle: true,
          title: Text(
            "Discover",
            style: TextStyle(fontSize: 23),
          ),
        ),
        body: TabBarView(
          children: [
            for (var talent in talents) TalentTab(talent.id),
          ],
        ),
      ),
    );
  }
}
