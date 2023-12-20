import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:selling_food_store/models/user_info.dart';
import 'package:selling_food_store/modules/cart/cart_page.dart';
import 'package:selling_food_store/modules/change_password/change_password_page.dart';
import 'package:selling_food_store/modules/change_payment/change_payment_page.dart';
import 'package:selling_food_store/modules/confirm_order/confirm_order_page.dart';
import 'package:selling_food_store/modules/detail/product_detail_page.dart';
import 'package:selling_food_store/modules/edit_profile/edit_profile_page.dart';
import 'package:selling_food_store/modules/forgotPassword/forgot_password_page.dart';
import 'package:selling_food_store/modules/home/home_page.dart';
import 'package:selling_food_store/modules/notification/notification_page.dart';
import 'package:selling_food_store/modules/order_list/order_list_page.dart';
import 'package:selling_food_store/modules/profile/profile_page.dart';
import 'package:selling_food_store/modules/order/order_page.dart';
import 'package:selling_food_store/modules/signIn/sign_in_page.dart';
import 'package:selling_food_store/modules/splash/splash_page.dart';
import 'package:selling_food_store/modules/signUp/signUp_page.dart';

import 'models/product.dart';
import 'modules/tracking_order/tracking_order_page.dart';

final GoRouter appRouter = GoRouter(
  routes: <RouteBase>[
    //Splash Page
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashPage();
      },
      routes: <RouteBase>[
        //Home Page
        GoRoute(
            path: 'home',
            name: 'home',
            builder: (BuildContext context, GoRouterState state) {
              return const HomePage();
            },
            routes: [
              //Notification Page
              GoRoute(
                  path: 'home/notifications',
                  name: 'notifications',
                  builder: (BuildContext context, GoRouterState state) {
                    return const NotificationPage();
                  }),
              //Cart Page
              GoRoute(
                path: 'home/cart',
                name: 'cart',
                builder: (BuildContext context, GoRouterState state) {
                  return const CartPage();
                },
              ),
              //Profile Page
              GoRoute(
                  path: 'home/profile',
                  name: 'profile',
                  builder: (BuildContext context, GoRouterState state) {
                    return const ProfilePage();
                  },
                  routes: [
                    GoRoute(
                        path: 'profile/cart',
                        name: 'profileCart',
                        builder: (BuildContext context, GoRouterState state) {
                          return const CartPage();
                        }),
                    //Edit Profile Page
                    GoRoute(
                      path: 'profile/editProfile',
                      name: 'editProfile',
                      builder: (BuildContext context, GoRouterState state) {
                        final dataValue = state.extra as UserInfo;
                        return EditProfilePage(userInfo: dataValue);
                      },
                    ),
                    //Order List Page
                    GoRoute(
                        path: 'profile/orderList',
                        name: 'orderList',
                        builder: (BuildContext context, GoRouterState state) {
                          return const OrderListPage();
                        },
                        routes: [
                          GoRoute(
                            path: 'profile/requestOrder',
                            name: 'orderListRequestOrder',
                            builder:
                                (BuildContext context, GoRouterState state) {
                              final dataValue =
                                  state.extra as Map<String, dynamic>;
                              final cartList = dataValue['cartList'];
                              final isBuyNow = dataValue['isBuyNow'];
                              return RequestOrderPage(
                                  carts: cartList, isBuyNow: isBuyNow);
                            },
                          ),
                        ]),
                    //Change Password Page
                    GoRoute(
                      path: 'profile/changePassword',
                      name: 'changePassword',
                      builder: (BuildContext context, GoRouterState state) {
                        return const ChangePasswordPage();
                      },
                    ),
                    //Change Payment Page
                    GoRoute(
                      path: 'profile/changePayment',
                      name: 'changePayment',
                      builder: (BuildContext context, GoRouterState state) {
                        return const ChangePaymentPage();
                      },
                    ),
                  ]),
              //SignIn Page
              GoRoute(
                  path: 'home/signIn',
                  name: 'signIn',
                  builder: (BuildContext context, GoRouterState state) {
                    return const SignInPage();
                  },
                  routes: [
                    //Forgot Password Page
                    GoRoute(
                        path: 'signIn/forgotPassword',
                        name: 'forgotPassword',
                        builder: (BuildContext context, GoRouterState state) {
                          return const ForgotPasswordPage();
                        }),
                    //SignUp Page
                    GoRoute(
                        path: 'signIn/signUp',
                        name: 'signUp',
                        builder: (BuildContext context, GoRouterState state) {
                          return const SignUpPage();
                        }),
                  ]),
              //Request Order Page
              GoRoute(
                  path: 'home/requestOrder',
                  name: 'requestOrder',
                  builder: (BuildContext context, GoRouterState state) {
                    final dataValue = state.extra as Map<String, dynamic>;
                    final cartList = dataValue['cartList'];
                    final isBuyNow = dataValue['isBuyNow'];
                    return RequestOrderPage(
                        carts: cartList, isBuyNow: isBuyNow);
                  },
                  routes: [
                    GoRoute(
                      path: 'requestOrder/editProfile',
                      name: 'requestOrderEditProfile',
                      builder: (BuildContext context, GoRouterState state) {
                        final dataValue = state.extra as UserInfo;
                        return EditProfilePage(userInfo: dataValue);
                      },
                    ),
                  ]),
              //Product Detail Page
              GoRoute(
                  path: 'home/productDetail',
                  name: 'productDetail',
                  builder: (BuildContext context, GoRouterState state) {
                    final data = state.extra as Product;
                    return ProductDetailPage(product: data);
                  }),
              GoRoute(
                path: 'productDetail/requestOrder',
                name: 'productDetailRequestOrder',
                builder: (BuildContext context, GoRouterState state) {
                  final dataValue = state.extra as Map<String, dynamic>;
                  final cartList = dataValue['cartList'];
                  final isBuyNow = dataValue['isBuyNow'];
                  return RequestOrderPage(carts: cartList, isBuyNow: isBuyNow);
                },
              ),
              //Tracking Order
              GoRoute(
                path: 'requestOrder/trackingOrder',
                name: 'trackingOrder',
                builder: (BuildContext context, GoRouterState state) {
                  final dataValue = state.extra as Map<String, String>;
                  final trackingId = dataValue['trackingId'] as String;
                  final idAccount = dataValue['idAccount'] as String;
                  return TrackingOrderPage(
                      id: trackingId, idAccount: idAccount);
                },
              ),
            ]),
        //Confirm Order Page
        GoRoute(
            path: 'confirmOrder',
            name: 'confirmOrder',
            builder: (BuildContext context, GoRouterState state) {
              return const ConfirmOrderPage();
            }),
      ],
    ),
  ],
);
