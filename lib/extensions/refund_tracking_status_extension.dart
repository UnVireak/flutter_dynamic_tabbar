
import 'package:flutter/material.dart';

import '../enums/refund_tracking_status_enum.dart';

extension RefundTrackingStatusEnumExt on RefundTrackingStatusEnum {
  bool get isChecking => this == RefundTrackingStatusEnum.checking;

  String get title {
    switch (this) {
      case RefundTrackingStatusEnum.checking:
        return "Checking";

      case RefundTrackingStatusEnum.approved:
        return "Approved";

      case RefundTrackingStatusEnum.rejected:
        return "Rejected";

    }
  }
  ImageProvider  get image {
    switch (this) {
      case RefundTrackingStatusEnum.rejected:
        return AssetImage('assets/icons/refund_rejected_badge.png');

      case RefundTrackingStatusEnum.approved:
        return AssetImage('assets/icons/refund_verified_badge.png');

      case RefundTrackingStatusEnum.checking:
        return NetworkImage('');
    }
  }

  Color get color {
    switch (this) {
      case RefundTrackingStatusEnum.checking:
        return Colors.blue;

      case RefundTrackingStatusEnum.approved:
        return Colors.green;

      case RefundTrackingStatusEnum.rejected:
        return Colors.red;
    }
  }

  Color get backgroundColor {
    switch (this) {
      case RefundTrackingStatusEnum.checking:
        return const Color(0xFFE0ECFF);

      case RefundTrackingStatusEnum.approved:
        return const Color(0xFFD1FAE5);

      case RefundTrackingStatusEnum.rejected:
        return const Color(0xFFFFE5E5);
    }
  }

  Color get badgeTextColor {
    switch (this) {
      case RefundTrackingStatusEnum.checking:
        return Colors.blue;

      case RefundTrackingStatusEnum.approved:
        return Colors.green;

      case RefundTrackingStatusEnum.rejected:
        return Colors.red;

    }
  }
  Color get iconColor {
    switch (this) {
      case RefundTrackingStatusEnum.checking:
        return Colors.white;

      case RefundTrackingStatusEnum.approved:
        return Colors.green;

      case RefundTrackingStatusEnum.rejected:
        return Colors.red;

    }
  }
}

