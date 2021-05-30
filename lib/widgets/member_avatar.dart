import 'package:flutter/material.dart';
import 'package:flutter_app5/common/const.dart';
import 'package:flutter_svg/svg.dart';

class MemberAvatar extends StatelessWidget {
  final int imageId;
  final double radius;

  const MemberAvatar({Key? key, this.imageId = -1, required this.radius})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: imageId != -1,
      child: SvgPicture.asset(
        getSvgPath(imageId),
        width: radius * 2,
      ),
      replacement: CircleAvatar(
        radius: radius,
        child: Icon(
          Icons.person_outline,
          size: radius,
        ),
      ),
    );
  }
}
