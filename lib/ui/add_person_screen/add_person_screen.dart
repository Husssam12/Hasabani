import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_app5/common/const.dart';
import 'package:flutter_app5/database/daos/persons_dao.dart';
import 'package:flutter_app5/provider/add_persons_provider.dart';
import 'package:flutter_app5/widgets/member_avatar.dart';
import 'package:flutter_app5/widgets/my_text_from_field.dart';
import 'package:provider/provider.dart';

import 'components/image_select_sheet.dart';

class AddPersonScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('إضافة أعضاء'),
      ),
      body: ChangeNotifierProvider(
        create: (_) => AddPersonsProvider(
            Provider.of<PersonsDao>(context, listen: false), context),
        builder: (context, _) => Consumer<AddPersonsProvider>(
          builder: (_, provider, __) {
            final imageId = provider.imageId;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 64,
                    ),
                    Center(
                      child: Stack(
                        fit: StackFit.loose,
                        alignment: Alignment.bottomRight,
                        children: [
                          MemberAvatar(
                            radius: 100,
                            imageId: imageId,
                          ),
                          Visibility(
                            visible: imageId != -1,
                            child: SvgPicture.asset(
                              getSvgPath(provider.imageId),
                              width: 200,
                            ),
                            replacement: CircleAvatar(
                              radius: 100,
                              child: Icon(
                                Icons.person_outline,
                                size: 100,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(
                                (math.sqrt(math.pow(100, 2).toDouble() * 2) -
                                        100) /
                                    4),
                            child: CircleAvatar(
                              backgroundColor: theme.primaryColor,
                              child: IconButton(
                                icon: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white70,
                                ),
                                onPressed: () =>
                                    _onPressImageButton(context, imageId),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 64,
                    ),
                    MyTextFromField(
                      onChange: provider.onNameChange,
                      label: 'الاسم',
                      prefixIconData: Icons.person_outline,
                      initValue: provider.name,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    OutlinedButton(
                      onPressed: provider.enableAddButton
                          ? () {
                              provider.addOrUpdatePerson();
                              Navigator.pop(context);
                            }
                          : null,
                      child: Text(provider.isEdit ? 'تعديل' : 'إضافة'),
                    ),
                    const SizedBox(
                      height: 64,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _onPressImageButton(BuildContext context, int selectedImage) async {
    FocusScope.of(context).requestFocus(FocusNode());
    final data = await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return ImageSelectSheet(
          selectedImage: selectedImage,
        );
      },
    );
    Provider.of<AddPersonsProvider>(context, listen: false).imageId =
        (data as List).first;
  }
}
