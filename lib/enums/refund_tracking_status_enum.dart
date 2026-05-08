enum RefundTrackingStatusEnum {
  checking,
  approved,
  rejected;

  static RefundTrackingStatusEnum fromCode(int code) {
    switch (code) {
      case 2:
        return RefundTrackingStatusEnum.approved;

      case -1:
        return RefundTrackingStatusEnum.rejected;

      case 1:
        return RefundTrackingStatusEnum.checking;

      default:
        return RefundTrackingStatusEnum.checking;
    }
  }
}
