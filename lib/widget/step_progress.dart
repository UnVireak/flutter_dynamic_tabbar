import 'package:flutter/material.dart';
import '../../enums/refund_tracking_status_enum.dart';
import '../../extensions/refund_tracking_status_extension.dart';

class ERefundProgressSection extends StatelessWidget {
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
      height: 138,
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
                height: 38,
                color: Colors.green,
              ),
              refundStatus == RefundTrackingStatusEnum.checking ?  Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTEhhPFi5Fm0hKhK0y3K0uuPjqR9qaBV4I_-15-rdKIbw&s', fit: BoxFit.cover,)),
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // CUSTOMER NAME
                Flexible(
                  child: Text(
                    customerName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
               SizedBox(height: 4),
                // DATE
                Text(
                  submittedDate,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                // DIVIDER
                Container(
                  height: 1,
                  color: Colors.grey.withValues(alpha: 0.2),
                ),
                const SizedBox(height: 12),
                // SHOP NAME
                Flexible(
                  child: Text(
                    shopName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                // STATUS
                refundStatus == RefundTrackingStatusEnum.checking ? Container(
                  height: 23,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
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
                    Text('Checking',
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