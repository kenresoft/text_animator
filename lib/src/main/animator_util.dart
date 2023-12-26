import 'package:flutter/widgets.dart';

/// Type definition for the value builder function used in [CounterTextAnimator].
typedef ValueBuilder = Widget Function(BuildContext context, String value);

typedef RecordBuilder = Widget Function(BuildContext context, ({int start, int current, int end}) record);
