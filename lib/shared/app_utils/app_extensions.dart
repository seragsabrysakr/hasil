import 'app_constants.dart';

extension NonNullString on String? {
  String orEmpty() {
    if (this == null) {
      return AppConstants.empty;
    } else {
      return this!;
    }
  }
}

extension NonNullInteger on int? {
  int orZero() {
    if (this == null) {
      return AppConstants.zero;
    } else {
      return this!;
    }
  }
}

extension NonNullBool on bool? {
  bool orFalse() {
    if (this == null) {
      return false;
    } else {
      return this!;
    }
  }
}
