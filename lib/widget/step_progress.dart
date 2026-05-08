import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dynamic_tabbar/enums/refund_tracking_status_enum.dart';
import 'package:flutter_dynamic_tabbar/extensions/refund_tracking_status_extension.dart';

class ERefundProgressSection extends StatelessWidget {
  // final RefundTrackingStatusEnum status;
  final String customerName;
  final String submittedDate;
  final String rejectedDate;
  final int status;
  final String shopName;

  const ERefundProgressSection({
    super.key,
    required this.status,
    required this.customerName,
    required this.submittedDate,
    required this.rejectedDate,
    required this.shopName,
  });

  RefundTrackingStatusEnum get refundStatus => RefundTrackingStatusEnum.fromCode(status);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/icons/refund_verified_badge.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                width: 2,
                height: 35,
                color: Colors.green,
              ),
              refundStatus == RefundTrackingStatusEnum.checking ?  Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
           
                ),
                child: Image.network('https://cdn.iconscout.com/icon/free/png-256/free-instore-icon-svg-download-png-6982.png'),
              ): Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: refundStatus.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(width: 12),

          /// RIGHT CONTENT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// CUSTOMER NAME
                Text(
                  customerName,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                /// DATE
                Text(
                  submittedDate,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 12),

                /// DIVIDER
                Container(
                  height: 1,
                  color: Colors.grey.withValues(alpha: 0.2),
                ),

                const SizedBox(height: 12),

                /// SHOP NAME
                Text(
                  shopName,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.blue[800],
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 6),

                /// STATUS
                refundStatus == RefundTrackingStatusEnum.checking
                    ? Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: refundStatus.backgroundColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      refundStatus == RefundTrackingStatusEnum.checking ? Container(
                  width: 16,
                    height: 16,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/icons/pending_refund_outline.png',
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ) : SizedBox.shrink(),

                      const SizedBox(width: 4),

                      Text(
                        refundStatus.title,
                        style: TextStyle(
                          fontSize: 12,
                          color: refundStatus.badgeTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ) : Text(
                  rejectedDate,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}