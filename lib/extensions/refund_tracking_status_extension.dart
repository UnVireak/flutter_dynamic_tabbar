
import 'package:flutter/material.dart';

import '../enums/refund_tracking_status_enum.dart';

extension RefundTrackingStatusEnumExt on RefundTrackingStatusEnum {
  // bool get isChecking => this == RefundTrackingStatusEnum.checking;

  ImageProvider  get image {
    switch (this) {
      case RefundTrackingStatusEnum.rejected:
        return AssetImage('assets/icons/refund_rejected_badge.png');

      case RefundTrackingStatusEnum.approved:
        return AssetImage('assets/icons/refund_verified_badge.png');

      case RefundTrackingStatusEnum.checking:
        return AssetImage('assets/icons/pending_refund_outline.png');
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

    ImageProvider  get storeImage {
    switch (this) {
      case RefundTrackingStatusEnum.rejected:
        return AssetImage('assets/icons/reject_refund_outline.png');

      case RefundTrackingStatusEnum.approved:
        return AssetImage('assets/icons/success_refund_outline.png');

      case RefundTrackingStatusEnum.checking:
        return AssetImage('assets/icons/pending_refund_outline.png');
    }
  }

String get titleStatus {
  switch (this) {
    case RefundTrackingStatusEnum.checking:
      return 'Pending Shop Checking';
    case RefundTrackingStatusEnum.approved:
      return 'Refund Successfully';
    case RefundTrackingStatusEnum.rejected:
      return 'Refund has been Rejected';
  }
}
}

