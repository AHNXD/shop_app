import 'package:get/get.dart';
import 'package:shop_app/views/cart_page/cart_page.dart';
import 'package:shop_app/views/home_page/home_page.dart';
import 'package:shop_app/views/invoices_page/invoices_page.dart';
import 'package:shop_app/views/order_page/order_page.dart';

class NavigationController extends GetxController {
  int selectedIndex = 0;
  List screens = [
     HomePage(),
    OrderPage(),
    InvoicesPage(),
    CartPage()
  ];
}
