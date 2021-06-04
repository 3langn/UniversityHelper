import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:university_helper/app/providers/university_provider.dart';
import 'package:university_helper/app/screens/home/components/search/search_appbar.dart';
import 'package:university_helper/app/utils/constants.dart';

import 'components/list/list_university.dart';
import 'components/slider_bar.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late TabController _tabController;
  final _animatedDuration = const Duration(milliseconds: 200);

  bool isLoading = false;
  bool isSearchByMajors = true;
  bool isScroll = false;
  var _scrollPosition = 0.0;
  int _selectedIndex = 0;

  @override
  void initState() {
    final provider = Provider.of<UniversityProvider>(context, listen: false);
    provider.fetchAndSetData(orderBy: kTabBarOptions[0]);

    super.initState();

    _scrollController = ScrollController();
    _tabController = TabController(length: 4, vsync: this);

    _scrollController.addListener(() {
      final scrollPosition = _scrollController.position;
      if (scrollPosition.pixels == scrollPosition.maxScrollExtent)
        provider.fetchAndSetData(orderBy: kTabBarOptions[_selectedIndex]);

      if (scrollPosition.pixels <= 130) {
        setState(() {
          _scrollPosition = -(scrollPosition.pixels / 2);
        });
      }
    });

    _tabController.addListener(() {
      _selectedIndex = _tabController.index;
      setState(() {
        _scrollPosition = 0.0;
      });
      provider.reset();
      provider.fetchAndSetData(
        count: 6,
        orderBy: kTabBarOptions[_selectedIndex],
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: SearchAppBar(hintText: 'Tìm trường'),
          bottom: TabBar(
            controller: _tabController,
            tabs: List.generate(4, (index) {
              return Tab(
                text: kSliderBarOptions[index],
              );
            }),
          ),
        ),
        body: Stack(
          children: [
            TabBarView(
              controller: _tabController,
              children: List.generate(
                4,
                (index) => ListUniversity(
                  isSearchByMajors: isSearchByMajors,
                  scrollController: _scrollController,
                ),
              ),
            ),
            AnimatedPositioned(
              top: _scrollPosition,
              duration: _animatedDuration,
              child: SliderBar(),
            ),
          ],
        ),
      ),
    );
  }
}