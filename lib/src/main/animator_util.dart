import 'package:flutter/widgets.dart';

typedef ValueBuilder = Widget Function(BuildContext context, String value);

typedef RecordBuilder = Widget Function(BuildContext context, ({int start, int current, int end}) record);
