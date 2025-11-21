// lib/core/reusable_components/student_header.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../colors_Manager.dart';

/// Compact header that shows avatar, name, subtitle and an action button.
/// - `avatar`: ImageProvider (optional)
/// - `name`: student's name
/// - `subtitle`: small secondary text
/// - `onAction`: tap for trailing icon
class StudentHeader extends StatelessWidget {
  const StudentHeader({
    super.key,
    this.avatar,
    required this.name,
    this.subtitle,
    this.onAction,
  });

  final ImageProvider? avatar;
  final String name;
  final String? subtitle;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    final Color primaryBlue = ColorsManager.primaryGradientStart;
    final Color accentMint = ColorsManager.accentMint;
    final Color accentSun = ColorsManager.accentSun;
    final Color accentSky = ColorsManager.accentSky;
    final Color actionColor = ColorsManager.accentPurple;

    final Color nameColor = isLight
        ? ColorsManager.lightText
        : ColorsManager.darkText;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.88, end: 1.0),
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset((1 - value) * -12, 0),
            child: child,
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
        child: Row(
          children: [
            // AVATAR WITH MULTICOLOR RING
            Container(
              padding: EdgeInsets.all(2.5.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: SweepGradient(
                  colors: [
                    primaryBlue,
                    accentSky,
                    accentMint,
                    accentSun,
                    primaryBlue,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: primaryBlue.withOpacity(0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 28.r,
                backgroundColor: Colors.white,
                backgroundImage:
                avatar ?? const AssetImage('assets/images/logo.png'),
              ),
            ),

            SizedBox(width: 12.w),

            // NAME + SUBTITLE
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800,
                      color: nameColor,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  if (subtitle != null)
                    Row(
                      children: [
                        Container(
                          width: 6.w,
                          height: 6.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: accentMint,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Expanded(
                          child: Text(
                            subtitle!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.color
                                  ?.withOpacity(0.8),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),

            // ACTION BUTTON (3-dots) WITH COLORFUL HOVER FEEL
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: actionColor.withOpacity(0.06),
              ),
              child: IconButton(
                onPressed: onAction,
                icon: Icon(
                  Icons.more_vert,
                  size: 22.r,
                  color: actionColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}