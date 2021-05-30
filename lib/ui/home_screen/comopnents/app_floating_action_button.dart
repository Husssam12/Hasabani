import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app5/database/app_database.dart';
import 'package:flutter_app5/provider/page_view_provider.dart';
import 'package:provider/provider.dart';

class AppFloatingActionButton extends StatelessWidget {
  final _icons = [
    Icons.person_add_alt,
    Icons.add_shopping_cart_outlined,
  ];
  @override
  Widget build(BuildContext context) {
    final pageIndex =
        context.select<PageViewProvider, int>((value) => value.pageIndex);
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 200),
      transitionBuilder: (child, animation) {
        return ScaleTransition(
          scale: animation,
          child: child,
        );
      },
      child: pageIndex < 2
          ? FloatingActionButton(
              key: Key('floating' + pageIndex.toString()),
              onPressed: () {
                if (pageIndex == 0) {
                  _onAddPerson(context);
                } else {
                  _onAddItem(context);
                }
              },
              child: Icon(_icons[pageIndex]),
            )
          : SizedBox(),
    );
  }

  _onAddPerson(BuildContext context) {
    Beamer.of(context).beamToNamed(
      '/add_persons',
      data: {
        'imageId': -1,
        'name': '',
      },
    );
  }

  _onAddItem(BuildContext context) async {
    final canAdd = await Provider.of<AppDatabase>(context, listen: false)
        .personsDao
        .getAll()
        .then((value) => value.length != 0);
    if (canAdd)
      Beamer.of(context).beamToNamed(
        '/add_items',
      );
    else {
      final provider = Provider.of<PageViewProvider>(context, listen: false);
      provider.showSnackBar(
        message: ' قم بإضافة أعضاء أولاً!',
      );
      provider.toPage(0);
    }
  }
}
