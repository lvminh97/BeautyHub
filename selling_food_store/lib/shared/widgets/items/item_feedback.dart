import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:selling_food_store/models/review.dart';
import 'package:selling_food_store/models/user_info.dart';
import 'package:selling_food_store/shared/services/firebase_service.dart';
import 'package:selling_food_store/shared/widgets/general/avatar_profile.dart';

import '../../utils/app_color.dart';

class ItemFeedback extends StatefulWidget {
  final Review review;
  const ItemFeedback({super.key, required this.review});

  @override
  State<ItemFeedback> createState() => _ItemFeedbackState();
}

class _ItemFeedbackState extends State<ItemFeedback> {
  UserInfo? userInfo;
  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ItemFeedback oldWidget) {
    if (oldWidget.review.idUser != widget.review.idUser) {
      initData();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return userInfo != null
        ? Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AvatarProfile(
                      avatar: userInfo!.fullName,
                      width: 30.0,
                      height: 30.0,
                      textSize: 12.0,
                      isEdit: false,
                      padding: 8.0,
                    ),
                    const SizedBox(width: 12.0),
                    Text(
                      userInfo!.fullName,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: AppColor.blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                RatingBar.builder(
                    itemCount: 5,
                    initialRating: widget.review.rating,
                    allowHalfRating: true,
                    unratedColor: AppColor.shimmerColor,
                    itemSize: 12.0,
                    itemBuilder: (context, index) =>
                        const Icon(Icons.star, color: Colors.amber),
                    onRatingUpdate: (newValue) {}),
                widget.review.content != null
                    ? Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Text(
                          widget.review.content!,
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                        ),
                      )
                    : const SizedBox(),
                const SizedBox(height: 16.0),
              ],
            ),
          )
        : const SizedBox();
  }

  void initData() {
    FirebaseService.getUserInfoByID(widget.review.idUser, (info) {
      setState(() {
        userInfo = info;
      });
    }, (error) => log('Error: $error'));
  }
}
