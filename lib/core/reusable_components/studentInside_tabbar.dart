// lib/core/reusable_components/golden_tab_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../colors_Manager.dart';

/// Simple model for a tab item
class TabItem {
  final String title;
  final IconData icon;

  /// optional image provider (useful if you want a photo instead of icon)
  final ImageProvider? image;
  const TabItem({required this.title, required this.icon, this.image});
}

class GoldenTabBar extends StatefulWidget {
  const GoldenTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTap,
    this.controller,
    this.tabWidth = 88,
    this.iconSize = 28,
  });

  final List<TabItem> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTap;
  final ScrollController? controller;
  final double tabWidth;
  final double iconSize;

  @override
  State<GoldenTabBar> createState() => _GoldenTabBarState();
}

class _GoldenTabBarState extends State<GoldenTabBar> {
  late final ScrollController _internalController;

  ScrollController get _controller => widget.controller ?? _internalController;

  @override
  void initState() {
    super.initState();
    _internalController = ScrollController();
  }

  @override
  void dispose() {
    _internalController.dispose();
    super.dispose();
  }

  void _centerTab(int index) {
    final double tabWidth = widget.tabWidth.w;
    final double spacing = 12.w;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double target =
        (index * (tabWidth + spacing)) - (screenWidth / 2) + (tabWidth / 2);
    final double max =
    _controller.hasClients ? _controller.position.maxScrollExtent : 0.0;
    final double offset = target.clamp(0.0, max);
    if (_controller.hasClients) {
      _controller.animateTo(
        offset,
        duration: const Duration(milliseconds: 340),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void didUpdateWidget(covariant GoldenTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _centerTab(widget.selectedIndex));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    // Joyful palette
    final Color primaryBlue = isLight
        ? ColorsManager.primaryGradientStart
        : ColorsManager.primaryGradientStartDark;
    final Color primaryBlueEnd = isLight
        ? ColorsManager.primaryGradientEnd
        : ColorsManager.primaryGradientEndDark;
    final Color accentMint = ColorsManager.accentMint;
    final Color accentSun = ColorsManager.accentSun;
    final Color accentSky = ColorsManager.accentSky;
    final Color accentPurple = ColorsManager.accentPurple;

    return TweenAnimationBuilder<double>(
      // ✅ animate 0 → 1 and clamp
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        final double t = value.clamp(0.0, 1.0);
        return Opacity(
          opacity: t,
          child: Transform.translate(
            offset: Offset(0, (1 - t) * 8),
            child: child,
          ),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 🔧 slightly taller strip to avoid tiny overflows
          SizedBox(
            height: 96.h,
            child: ListView.separated(
              controller: _controller,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 2.h),
              itemCount: widget.tabs.length,
              separatorBuilder: (_, __) => SizedBox(width: 12.w),
              itemBuilder: (context, index) {
                final item = widget.tabs[index];
                final bool selected = index == widget.selectedIndex;

                return GestureDetector(
                  onTap: () {
                    widget.onTap(index);
                    _centerTab(index);
                  },
                  child: _buildTabItem(
                    context: context,
                    item: item,
                    index: index,
                    selected: selected,
                    primaryBlue: primaryBlue,
                    primaryBlueEnd: primaryBlueEnd,
                    accentMint: accentMint,
                    accentSun: accentSun,
                    accentSky: accentSky,
                    accentPurple: accentPurple,
                  ),
                );
              },
            ),
          ),

          SizedBox(height: 4.h),

          // small moving multicolor indicator
          _buildIndicator(
            primaryBlue: primaryBlue,
            primaryBlueEnd: primaryBlueEnd,
            accentMint: accentMint,
            accentSun: accentSun,
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem({
    required BuildContext context,
    required TabItem item,
    required int index,
    required bool selected,
    required Color primaryBlue,
    required Color primaryBlueEnd,
    required Color accentMint,
    required Color accentSun,
    required Color accentSky,
    required Color accentPurple,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutBack,
      width: widget.tabWidth.w,
      // 🔧 a bit less vertical padding
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        gradient: selected
            ? LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            primaryBlue.withOpacity(0.18),
            accentSky.withOpacity(0.18),
            accentMint.withOpacity(0.16),
          ],
        )
            : LinearGradient(
          colors: [
            Theme.of(context).colorScheme.surface.withOpacity(0.06),
            Theme.of(context).colorScheme.surface.withOpacity(0.02),
          ],
        ),
        border: Border.all(
          color: selected ? primaryBlue : Colors.transparent,
          width: selected ? 1.4 : 0,
        ),
        boxShadow: selected
            ? [
          BoxShadow(
            color: primaryBlue.withOpacity(0.18),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ]
            : [
          BoxShadow(
            color: Colors.black.withOpacity(
              Theme.of(context).brightness == Brightness.light
                  ? 0.02
                  : 0.25,
            ),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // 🔧 let it hug content
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // circular icon/photo with joyful ring
          TweenAnimationBuilder<double>(
            tween: Tween(
              begin: selected ? 0.9 : 1.0,
              end: selected ? 1.0 : 1.0,
            ),
            duration: const Duration(milliseconds: 240),
            curve: Curves.easeOutBack,
            builder: (context, value, iconChild) {
              return Transform.scale(
                scale: value,
                child: iconChild,
              );
            },
            child: Container(
              padding: EdgeInsets.all(selected ? 7.r : 5.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: selected
                    ? SweepGradient(
                  colors: [
                    primaryBlue,
                    accentSky,
                    accentMint,
                    accentSun,
                    primaryBlue,
                  ],
                )
                    : null,
                color: selected
                    ? null
                    : Theme.of(context).colorScheme.surface,
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected ? Colors.white : Colors.transparent,
                ),
                padding: EdgeInsets.all(selected ? 4.r : 0),
                child: _buildIconOrImage(
                  context: context,
                  item: item,
                  selected: selected,
                  selectedColor: primaryBlueEnd,
                  unselectedColor: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withOpacity(0.85),
                ),
              ),
            ),
          ),

          SizedBox(height: 6.h), // 🔧 slightly smaller gap

          // label under icon
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 240),
            style: TextStyle(
              fontSize: selected ? 13.sp : 12.sp,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
              color: selected
                  ? accentPurple
                  : Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withOpacity(0.85),
            ),
            child: Text(
              item.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator({
    required Color primaryBlue,
    required Color primaryBlueEnd,
    required Color accentMint,
    required Color accentSun,
  }) {
    final int tabCount = widget.tabs.length;
    double xAlign = 0;

    if (tabCount > 1) {
      xAlign = (widget.selectedIndex / (tabCount - 1)) * 2 - 1;
    }

    return AnimatedAlign(
      alignment: Alignment(xAlign, 0),
      duration: const Duration(milliseconds: 360),
      curve: Curves.easeOutQuad,
      child: Container(
        width: 26.w,
        height: 4.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999.r),
          gradient: LinearGradient(
            colors: [
              primaryBlue,
              primaryBlueEnd,
              accentMint,
              accentSun,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: primaryBlue.withOpacity(0.28),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconOrImage({
    required BuildContext context,
    required TabItem item,
    required bool selected,
    required Color selectedColor,
    required Color unselectedColor,
  }) {
    if (item.image != null) {
      return ClipOval(
        child: Image(
          image: item.image!,
          width: widget.iconSize.r,
          height: widget.iconSize.r,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return Icon(
        item.icon,
        size: widget.iconSize.r,
        color: selected ? selectedColor : unselectedColor,
      );
    }
  }
}