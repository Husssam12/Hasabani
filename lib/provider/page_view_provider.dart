import 'package:flutter/material.dart';

class PageViewProvider extends ChangeNotifier {
  final PageController pageController;
  final GlobalKey<ScaffoldMessengerState> scaffoldKey;
  int _pageIndex = 0;

  PageViewProvider({
    required this.pageController,
    required this.scaffoldKey,
  });

  int get pageIndex => _pageIndex;

  set pageIndex(int value) {
    _pageIndex = value;

    notifyListeners();
  }

  Future<void> nextPage() async {
    await pageController.nextPage(duration: _duration, curve: _curve);
    pageIndex++;
  }

  Future<void> toPage(int index) async {
    await pageController.animateToPage(index,
        duration: _duration, curve: _curve);
    pageIndex = index;
  }

  Future<void> previousPage() async {
    await pageController.previousPage(duration: _duration, curve: _curve);
    pageIndex--;
  }

  showSnackBar({required String message}) {
    scaffoldKey.currentState?.removeCurrentSnackBar();
    scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(message)));
  }

  final _duration = Duration(milliseconds: 200);
  final _curve = Curves.linear;
}
