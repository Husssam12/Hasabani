import 'package:flutter/material.dart';

import 'member_avatar.dart';

class AvatarTile extends StatelessWidget {
  final String title;
  final String? subTitle;
  final String? title2;
  final String? subTitle2;
  final IconData trailingIcon;
  final int imageId;
  final void Function()? onTap;

  const AvatarTile(
      {Key? key,
      required this.title,
      required this.imageId,
      this.onTap,
      this.subTitle,
      this.title2,
      this.subTitle2,
      required this.trailingIcon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              MemberAvatar(
                imageId: imageId,
                radius: 30,
              ),
              if (title2 != null)
                Expanded(
                    child: Center(
                        child: Column(
                  children: [
                    Text(title2!),
                    if (subTitle2 != null)
                      Text(
                        subTitle2!,
                        style: theme.textTheme.overline,
                      ),
                  ],
                ))),
              Expanded(
                  child: Center(
                      child: Column(
                children: [
                  Text(title),
                  if (subTitle != null)
                    Text(
                      subTitle!,
                      style: theme.textTheme.overline,
                    ),
                ],
              ))),
              Icon(
                trailingIcon,
                size: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
