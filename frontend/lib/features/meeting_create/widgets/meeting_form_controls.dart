import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';

class MeetingTimeButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final Color color;

  const MeetingTimeButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 18, color: AppColors.dark),
        label: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          side: const BorderSide(color: AppColors.brandMint, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}

class MemberCountSelector extends StatelessWidget {
  final int count;
  final ValueChanged<int> onChanged;
  final int minCount;

  const MemberCountSelector({
    super.key,
    required this.count,
    required this.onChanged,
    this.minCount = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.brandMint, width: 1.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: count > minCount ? () => onChanged(count - 1) : null,
            icon: const Icon(Icons.remove, size: 22, color: Colors.black87),
          ),
          Text(
            '$count명',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () => onChanged(count + 1),
            icon: const Icon(Icons.add, size: 22, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
