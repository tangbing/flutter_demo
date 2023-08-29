

import 'package:flutter_route/main.dart';
import 'package:flutter_route/second_page.dart';

class Routes {
  static const initialRoute = '/';
  static const routeSecondPage = '/secondPage';


  static final routes = {
    initialRoute: (context) =>  MyFirstPage(),
    routeSecondPage: (context) =>  SecondPage()
};


}