// import 'package:flutter/src/widgets/navigator.dart';
// import 'package:get/get.dart';
// import 'package:shop_app/main.dart';

// class AuthMiddleware extends GetMiddleware {
//   @override
//   RouteSettings? redirect(String? route) {
//     // TODO: implement redirect

//     if (userInfo.getString('token') != null) {
//       if (userInfo.getString('role') == 'customer') {
//         return const RouteSettings(name: "/mainPage");
//       } else if (userInfo.getString('role') == 'salesman') {
//         return const RouteSettings(name: "/tripsPage");
//       }
//     } else {
//       return const RouteSettings(name: '/');
//     }
//     return super.redirect(route);
//   }
// }
