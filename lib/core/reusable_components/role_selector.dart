import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oasisparents/core/reusable_components/app_colors_extension.dart';
import '../../core/colors_Manager.dart';

enum UserRole { parent, student, teacher, coach, admin, coordinator }

typedef RoleChanged = void Function(UserRole role);

class RoleSelector extends StatefulWidget {
  const RoleSelector({
    super.key,
    this.initialRole,
    required this.onRoleChanged,
    this.crossAxisCount = 2,
    this.childAspectRatio = 1.25,
    this.padding = const EdgeInsets.symmetric(horizontal: 20),
    this.showLabels = true,
  });

  /// Optional currently selected role
  final UserRole? initialRole;

  /// Called when the selection changes
  final RoleChanged onRoleChanged;

  /// Grid columns (default 2)
  final int crossAxisCount;

  /// Aspect ratio for each child
  final double childAspectRatio;

  /// Outer padding around the grid
  final EdgeInsetsGeometry padding;

  /// Show the text labels under icons
  final bool showLabels;

  @override
  State<RoleSelector> createState() => _RoleSelectorState();
}

class _RoleSelectorState extends State<RoleSelector> {
  UserRole? _selectedRole;

  /// Role metadata: label, icon, color.
  /// Colors are now aligned with the web palette:
  /// - Parent   -> blue info
  /// - Student  -> green success
  /// - Teacher  -> yellow/orange
  /// - Coach    -> sky blue
  /// - Admin    -> red
  /// - Coord.   -> purple accent
  static const Map<UserRole, Map<String, dynamic>> _defaultMeta = {
    UserRole.parent: {
      'label': 'Parent',
      'icon': Icons.family_restroom,
      'color': ColorsManager.accentSky,
    },
    UserRole.student: {
      'label': 'Student',
      'icon': Icons.school,
      'color': ColorsManager.accentMint,
    },
    UserRole.teacher: {
      'label': 'Teacher',
      'icon': Icons.menu_book,
      'color': ColorsManager.accentSun,
    },
    UserRole.coach: {
      'label': 'Coach',
      'icon': Icons.sports_handball,
      'color': ColorsManager.accentSky,
    },
    UserRole.admin: {
      'label': 'Admin',
      'icon': Icons.admin_panel_settings,
      'color': ColorsManager.accentCoral,
    },
    UserRole.coordinator: {
      'label': 'Coordinator',
      'icon': Icons.support_agent,
      'color': ColorsManager.accentPurple,
    },
  };

  @override
  void initState() {
    super.initState();
    _selectedRole = widget.initialRole;
  }

  void _select(UserRole role) {
    setState(() => _selectedRole = role);
    widget.onRoleChanged(role);
  }

  Widget _buildCard(UserRole role) {
    final meta = _defaultMeta[role]!;
    final bool isSelected = _selectedRole == role;
    final Color primaryColor = meta['color'] as Color;
    final IconData icon = meta['icon'] as IconData;
    final String label = meta['label'] as String;

    final scheme = Theme.of(context).colorScheme;

    final Color cardBackground = isSelected
        ? primaryColor.withOpacity(0.10)
        : scheme.fields; // white in light mode

    final Color borderColor = isSelected
        ? primaryColor
        : scheme.borders;

    final List<BoxShadow> shadows = [
      BoxShadow(
        color: isSelected
            ? primaryColor.withOpacity(0.16)
            : scheme.shadow.withOpacity(0.03),
        blurRadius: isSelected ? 10 : 6,
        offset: const Offset(0, 3),
      ),
    ];

    return GestureDetector(
      onTap: () => _select(role),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutQuad,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: cardBackground,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: borderColor,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: shadows,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedScale(
              scale: isSelected ? 1.07 : 1.0,
              duration: const Duration(milliseconds: 220),
              child: CircleAvatar(
                radius: 26.r,
                backgroundColor:
                primaryColor.withOpacity(isSelected ? 1.0 : 0.12),
                child: Icon(
                  icon,
                  size: 26.r,
                  color: isSelected ? Colors.white : primaryColor,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            if (widget.showLabels)
              Text(
                label,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                  color: isSelected
                      ? primaryColor
                      : scheme.textMainBlack,
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cards = UserRole.values.map(_buildCard).toList();

    return Padding(
      padding: widget.padding,
      child: GridView.count(
        crossAxisCount: widget.crossAxisCount,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: widget.childAspectRatio,
        children: cards,
      ),
    );
  }
}