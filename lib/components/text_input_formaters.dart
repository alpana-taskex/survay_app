import 'package:flutter/services.dart';

TextInputFormatter digitAndPeriodFormatter = FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'));

