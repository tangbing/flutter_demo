

import 'package:get/get.dart';
import 'package:getx/two/view.dart';
import '../counter/binding.dart';
import '../counter/view.dart';
import '../two/binding.dart';


class RouteGet {
  ///root page
  static const String main = "/";
  static const String two = "/two";

  ///pages map
  static final List<GetPage> getPages = [
    GetPage(
        name: main,
        page: () => CounterPage(),
        binding: CounterBinding()
    ),
    GetPage(
        name: two,
        page: () => TwoPage(),
        binding: TwoBinding()
    ),
    // GetPage(
    //     name: articleDetails,
    //     page: () => ArticleDetailsPage(),
    //     binding: ArticleDetailsBinding()
    // ),
  ];
}