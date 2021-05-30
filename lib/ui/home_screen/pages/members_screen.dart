import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app5/database/app_database.dart';
import 'package:flutter_app5/database/daos/persons_dao.dart';
import 'package:flutter_app5/widgets/avatar_tile.dart';
import 'package:provider/provider.dart';

class MembersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PersonsDao>(
      builder: (_, dao, __) => StreamBuilder<List<Person>>(
        stream: dao.watchAll(),
        builder: (_, snap) {
          if (snap.connectionState == ConnectionState.waiting)
            return const SizedBox();
          final personsList = snap.data!;
          if (personsList.isEmpty)
            return Icon(
              Icons.group_outlined,
              size: 35,
            );
          return ListView.separated(
            itemCount: personsList.length,
            padding: const EdgeInsets.all(16),
            separatorBuilder: (_, __) {
              return const SizedBox(
                height: 8,
              );
            },
            itemBuilder: (_, index) {
              final person = personsList[index];
              return AvatarTile(
                title: person.name,
                imageId: person.imageID,
                trailingIcon: Icons.chevron_right_outlined,
                onTap: () {
                  Beamer.of(context).beamToNamed(
                    '/add_persons',
                    data: {
                      'imageId': person.imageID,
                      'name': person.name,
                      'personId': person.id,
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
