import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app5/common/const.dart';
import 'package:flutter_svg/svg.dart';

class ImageSelectSheet extends StatefulWidget {
  final int selectedImage;

  const ImageSelectSheet({Key? key, this.selectedImage = 0}) : super(key: key);

  @override
  _ImageSelectSheetState createState() => _ImageSelectSheetState();
}

class _ImageSelectSheetState extends State<ImageSelectSheet> {
  late int selectedImage;
  late final cacheSelectedImage;

  @override
  void initState() {
    cacheSelectedImage = widget.selectedImage == -1 ? -1 : widget.selectedImage;
    selectedImage = widget.selectedImage - 1;
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _pop(context, cacheSelected: cacheSelectedImage);
        return true;
      },
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Stack(
          fit: StackFit.loose,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 30),
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GridView.builder(
                    padding: const EdgeInsets.all(32),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 1,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: 12,
                    itemBuilder: (_, index) {
                      return TweenAnimationBuilder<double>(
                        tween: Tween<double>(begin: 0.0, end: 1.0),
                        duration: Duration(
                          milliseconds: 150,
                        ),
                        builder: (_, animation, __) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedImage = index;
                              });
                            },
                            child: Opacity(
                              opacity: animation,
                              child: Stack(
                                children: [
                                  SvgPicture.asset(
                                    getSvgPath(index + 1),
                                  ),
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 250),
                                    decoration: BoxDecoration(
                                      color: index == selectedImage
                                          ? Colors.black38
                                          : Colors.transparent,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  if (selectedImage == index)
                                    Align(
                                        alignment: Alignment.bottomRight,
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                              color: index == selectedImage
                                                  ? Colors.black
                                                  : Colors.transparent,
                                              shape: BoxShape.circle),
                                          child: Icon(
                                            Icons.check,
                                            size: 20,
                                            color: Colors.greenAccent,
                                          ),
                                        )),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: FloatingActionButton(
                onPressed: () => _pop(context),
                elevation: 0,
                child: Icon(Icons.check),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _pop(BuildContext context, {int? cacheSelected}) {
    final selectedImage = cacheSelected ?? this.selectedImage + 1;
    Navigator.pop(context, [selectedImage == -1 ? -1 : selectedImage]);
  }


}
