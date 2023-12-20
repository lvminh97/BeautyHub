import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:selling_food_store/shared/utils/app_utils.dart';

import '../../utils/app_color.dart';

import 'package:badges/badges.dart' as badges;

class AvatarProfile extends StatefulWidget {
  final String avatar;
  final double? width;
  final double? height;
  final bool? isEdit;
  final double? textSize;
  final double? padding;
  final Function(File)? onEdit;

  const AvatarProfile({
    super.key,
    required this.avatar,
    this.width,
    this.height,
    this.isEdit,
    this.textSize,
    this.padding,
    this.onEdit,
  });

  @override
  State<AvatarProfile> createState() => _AvatarProfileState();
}

class _AvatarProfileState extends State<AvatarProfile> {
  File? imageFile;
  String? avatar;

  @override
  void initState() {
    avatar = widget.avatar;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      position: badges.BadgePosition.topEnd(top: 4, end: 4),
      showBadge: widget.isEdit ?? true,
      badgeContent: InkWell(
        onTap: () {
          chooseImageFile();
        },
        splashColor: AppColor.transparentColor,
        highlightColor: AppColor.transparentColor,
        focusColor: AppColor.transparentColor,
        hoverColor: AppColor.transparentColor,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColor.whiteColor,
          ),
          child: const Icon(
            Icons.edit,
            size: 16.0,
            color: AppColor.blackColor,
          ),
        ),
      ),
      badgeStyle: const badges.BadgeStyle(padding: EdgeInsets.zero),
      child: imageFile != null
          ? Container(
              width: widget.width ?? 100.0,
              height: widget.height ?? 100.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
                image: DecorationImage(
                  image: FileImage(imageFile!),
                  fit: BoxFit.cover,
                ),
              ))
          : avatar != null && avatar!.contains('https')
              ? CachedNetworkImage(
                  width: widget.width ?? 100.0,
                  height: widget.height ?? 100.0,
                  imageUrl: avatar!,
                  imageBuilder: (context, imageProvider) => Container(
                      margin: const EdgeInsets.only(top: 4.0, right: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      )),
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.error, color: AppColor.hintGreyColor),
                )
              : _buildAvatarProfileFromName(avatar!),
    );
  }

  Widget _buildAvatarProfileFromName(String input) {
    return Container(
      width: widget.width ?? 100.0,
      height: widget.height ?? 100.0,
      decoration: const BoxDecoration(
        color: AppColor.baseColor,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.all(widget.padding ?? 0),
      child: Text(
        AppUtils.generateNameAvatar(input),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: widget.textSize ?? 16.0,
          color: AppColor.whiteColor,
        ),
      ),
    );
  }

  Future<void> chooseImageFile() async {
    ImagePicker().pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        File file = File(value.path);
        setState(() {
          imageFile = file;
          if (imageFile != null) {
            if (widget.onEdit != null) {
              widget.onEdit!(imageFile!);
            }
          }
        });
      }
    });
  }
}
