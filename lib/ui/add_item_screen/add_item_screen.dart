import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app5/common/helper.dart';
import 'package:flutter_app5/database/app_database.dart';
import 'package:flutter_app5/provider/add_item_provider/add_Item_provider.dart';
import 'package:flutter_app5/provider/add_item_provider/add_item_helper.dart';
import 'package:flutter_app5/widgets/member_avatar.dart';
import 'package:flutter_app5/widgets/my_text_from_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:provider/provider.dart';

class AddItemScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (_) => AddItemProvider(
        AddItemHelper(Provider.of<AppDatabase>(context, listen: false)),
        _formKey,
        context,
      ),
      builder: (__, _) => Scaffold(
        appBar: AppBar(
          title: Text('إضافة مادة'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Form(
              key: _formKey,
              child: Consumer<AddItemProvider>(
                builder: (_, provider, __) {
                  final List<Person> persons = provider.persons;
                  final addItemModel = provider.addItemModel;
                  if (addItemModel == null) return SizedBox();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 32,
                      ),
                      MyTextFromField(
                        label: 'اسم المادة',
                        key: Key(addItemModel.label.toString() + 'item'),
                        prefixIconData: Icons.shopping_basket_outlined,
                        onChange: provider.onLabelChange,
                        initValue: addItemModel.label,
                        validator: (value) => requiredValidation(value,
                            message: 'يرجى إدخال اسم المادة'),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      MyTextFromField(
                        label: ' السعر',
                        key: Key(addItemModel.price.toString() + 'price'),
                        keyboardType: TextInputType.number,
                        prefixIconData: Icons.monetization_on_outlined,
                        initValue: addItemModel.price,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChange: provider.onPriceChange,
                        validator: (value) => requiredValidation(value,
                            message: 'يرجى إدخال سعر المادة'),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Divider(),
                      const SizedBox(
                        height: 32,
                      ),
                      Row(
                        children: [
                          MemberAvatar(
                            imageId: addItemModel.bayer?.imageID ?? -1,
                            radius: 30,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: DropdownButtonFormField<Person>(
                              items: List.generate(
                                persons.length,
                                (index) {
                                  final person = persons[index];
                                  return DropdownMenuItem(
                                    child: Text(
                                      person.name,
                                      style: TextStyle(height: 1),
                                    ),
                                    value: person,
                                  );
                                },
                              ),
                              value: addItemModel.bayer,
                              isExpanded: true,
                              onTap: () {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              },
                              validator: (value) {
                                if (value != null) return null;
                                return 'فم بتحديد المشتري!';
                              },
                              hint: Text(
                                'فم بتحديد المشتري',
                                style: TextStyle(height: 1),
                              ),
                              onChanged: provider.onBayerChange,
                              icon: Icon(Icons.arrow_downward_sharp),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        key: Key(addItemModel.partners.hashCode.toString()),
                        child: MultiSelectDialogField<Person?>(
                          items: List.generate(
                            persons.length,
                            (index) {
                              return MultiSelectItem(
                                  persons[index], persons[index].name);
                            },
                          ),
                          height: MediaQuery.of(context).size.height / 2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white38)),
                          validator: (list) {
                            if (list?.isNotEmpty ?? false)
                              return null;
                            else
                              return 'قم بتحديد المشتركين!';
                          },
                          initialValue: addItemModel.partners,
                          buttonText: Text('قم بتحيدد المشتركين',
                              style: TextStyle(color: Colors.white54)),
                          title: Text(
                            'إختيار المشتركين',
                            style: TextStyle(
                                color: theme.accentColor, fontSize: 18),
                          ),
                          confirmText: Text('موافق'),
                          cancelText: Text('إلغاء'),
                          onConfirm: (value) {
                            provider.onPartnersChange(value.cast<Person>());
                          },
                          itemsTextStyle: theme.textTheme.subtitle1,
                          selectedItemsTextStyle: theme.textTheme.subtitle1,
                          selectedColor: theme.primaryColorDark,
                          listType: MultiSelectListType.LIST,
                        ),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                  onPressed: () {
                                    provider.addItem();
                                    if (provider.isEdit) Navigator.pop(context);
                                  },
                                  child: Text(
                                      provider.isEdit ? 'تعديل' : 'إضافة')),
                            ),
                            if (provider.isEdit)
                              const SizedBox(
                                width: 16,
                              ),
                            if (provider.isEdit)
                              OutlinedButton(
                                onPressed: () async {
                                  await provider.deleteItem();
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.delete_outline_outlined,
                                  color: Colors.redAccent.withOpacity(0.5),
                                ),
                              ),
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
