import 'package:fit_tracker/lib.dart';
import 'package:flutter/material.dart';

class AppBarSecondary extends StatelessWidget with PreferredSizeWidget {
  const AppBarSecondary(
    String title, {
    Key? key,
    required VoidCallback onTapBack,
    bool isCentered = false,
    Widget? action,
  })  : _title = title,
        _onTapBack = onTapBack,
        _isCentered = isCentered,
        _action = action,
        super(key: key);

  final String _title;
  final VoidCallback _onTapBack;
  final bool _isCentered;
  final Widget? _action;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    return AppBar(
      elevation: 0,
      centerTitle: _isCentered,
      leading: ButtonIcon(
        onTap: () {
          _onTapBack.call();
        },
        child: Icon(
          Icons.arrow_back_rounded,
          color: ButtonColors.tertiary ,
          size: responsive.getResponsiveSize(
            AppIconSize.medium,
          ),
        ),
      ),
      title: Text(
        _title,
        style: AppTextStyle.bold.copyWith(
          fontSize: responsive.getResponsiveSize(
            AppFontSize.medium,
          ),
          color: TextColors.tertiary,
        ),
      ),
      actions: [_action ?? const SizedBox()],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
