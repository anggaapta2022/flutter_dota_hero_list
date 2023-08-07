import 'package:flutter/material.dart';

var baseUrl = "https://api.opendota.com";

class NoWaveScroll extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
