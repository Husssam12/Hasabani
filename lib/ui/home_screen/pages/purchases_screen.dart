import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app5/database/daos/_export_daos.dart';
import 'package:flutter_app5/models/item_bayer_model.dart';
import 'package:flutter_app5/widgets/avatar_tile.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart';

class PurchasesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ItemsDao>(
      builder: (_, dao, __) => StreamBuilder<List<ItemBayerModel>>(
        stream: dao.watchAllItemsWithBayer(),
        builder: (_, snap) {
          if (snap.connectionState == ConnectionState.waiting)
            return const SizedBox();
          final itemsBayerList = snap.data!;
          if (itemsBayerList.isEmpty)
            return Icon(
              Icons.shopping_cart_outlined,
              size: 35,
            );

          return ListView.separated(
            itemCount: itemsBayerList.length,
            padding: const EdgeInsets.all(16),
            separatorBuilder: (_, __) {
              return const SizedBox(
                height: 8,
              );
            },
            itemBuilder: (_, index) {
              final item = itemsBayerList[index].item;
              final bayer = itemsBayerList[index].person;
              return AvatarTile(
                imageId: bayer.imageID,
                title: item.label,
                subTitle: item.price.toString() + ' ل.س ',
                title2: bayer.name,
                subTitle2: format(item.date, locale: 'ar'),
                trailingIcon: Icons.chevron_right_outlined,
                onTap: () {
                  Beamer.of(context).beamToNamed(
                    '/add_items',
                    data: {
                      'item_id': item.id,
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
