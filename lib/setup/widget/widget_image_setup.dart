import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../common/constant.dart';
import '../../common/extension/extension_context.dart';
import '../../common/widget/widget_sizedbox.dart';
import '../../common/widget/widget_tap.dart';
import '../../provider/provider_user.dart';
import '../screen/screen_teacher_setup.dart';

import 'dart:ui' as ui;

class ImageSetup extends ConsumerStatefulWidget {
  const ImageSetup(
    this.buttonPageController, {
    super.key,
  });

  final PageController buttonPageController;

  @override
  ConsumerState<ImageSetup> createState() => _ImageSetupState();
}

class _ImageSetupState extends ConsumerState<ImageSetup> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  Uint8List? imageData;
  XFile? image;

  @override
  Widget build(BuildContext context) {
    final availHeight = MediaQuery.of(context).size.height -
        appBarHeight -
        MediaQueryData.fromView(ui.PlatformDispatcher.instance.implicitView!)
            .padding
            .top -
        MediaQueryData.fromView(ui.PlatformDispatcher.instance.implicitView!)
            .padding
            .bottom;
    return Container(
      height: availHeight,
      padding: const EdgeInsets.all(24),
      color: context.appColors.backgroundColor,
      child: Column(children: [
        const Align(
          alignment: Alignment.center,
          child: Text(
            '학생들에게 보여질\n프로필 이미지를 설정해주세요.',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ),
        const Height(24),
        Align(
          alignment: Alignment.center,
          child: Tap(
            onTap: () async {
              final ImagePicker picker = ImagePicker();
              image = await picker.pickImage(source: ImageSource.gallery);
              //print("${image?.name},${image?.path}");
              imageData = await image?.readAsBytes();
              setState(() {});
            },
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                  color: context.appColors.cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: context.appColors.primaryColor),
                  boxShadow: [context.appShadows.cardShadow]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: imageData == null
                    ? Center(
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: context.appColors.primaryColor),
                          child: Icon(
                            Icons.add,
                            color: context.appColors.inverseText,
                          ),
                        ),
                      )
                    : Image.memory(
                        imageData!,
                        fit: BoxFit.fill,
                      ),
              ),
            ),
          ),
        ),
        const Spacer(),
        MaterialButton(
          onPressed: () {
            ref.read(indexStateProvider.notifier).state++;

            addSetup();

            context.go('/');
          },
          height: 48,
          minWidth: double.infinity,
          color: context.appColors.primaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Text(
            '설정 완료하기',
            style: TextStyle(
                color: context.appColors.inverseText,
                fontSize: 19,
                fontWeight: FontWeight.w700),
          ),
        )
      ]),
    );
  }

  Future<Uint8List> imageCompressList(Uint8List list) async {
    var result = FlutterImageCompress.compressWithList(list, quality: 50);
    return result;
  }

  Future addSetup() async {
    final userCredential = ref.watch(userCredentialProvider);
    final setupList = ref.read(setupProvider);
    String? downloadLink;

    if (imageData != null) {
      final storageRef = storage.ref().child(
          "${DateTime.now().millisecondsSinceEpoch}_${image?.name ?? "??"}.jpg");
      final compressedData = await imageCompressList(imageData!);
      await storageRef.putData(compressedData);
      downloadLink = await storageRef.getDownloadURL();
    }
    await db
        .collection('users')
        .doc(userCredential?.user?.email)
        .collection('type')
        .doc('teacher')
        .set({
      'displayName': setupList[0][0].toString(),
      'univ':
          setupList[1][0].toString() != '' ? setupList[1][0].toString() : null,
      'major':
          setupList[1][1].toString() != '' ? setupList[1][1].toString() : null,
      'studentID':
          setupList[1][2].toString() != '' ? setupList[1][2].toString() : null,
      'subjects': setupList[2],
      'budget':
          setupList[3][0].toString() != '' ? setupList[3][0].toString() : null,
      'profileImagePath': downloadLink,
    });

    await db
        .collection('users')
        .doc(userCredential?.user?.email)
        .update({'initialSetup': true});
  }
}
