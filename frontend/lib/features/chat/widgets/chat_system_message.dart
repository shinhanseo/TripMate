import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class ChatSystemMessage extends StatelessWidget {
  final String content;

  const ChatSystemMessage({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            color: AppColors.gray100,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.gray600,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
