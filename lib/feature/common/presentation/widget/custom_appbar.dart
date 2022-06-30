import 'package:fit_tracker/lib.dart';
import 'package:flutter/material.dart';

class AppBarPrimary extends StatelessWidget with PreferredSizeWidget {
  const AppBarPrimary(
    String title, {
    Key? key,
    required VoidCallback onTapBack,
    bool isCentered = false,
    bool isBackButtonVisible = true,
    Widget? action,
  })  : _title = title,
        _onTapBack = onTapBack,
        _isCentered = isCentered,
        _isBackButtonVisible = isBackButtonVisible,
        _action = action,
        super(key: key);

  final String _title;
  final VoidCallback _onTapBack;
  final bool _isCentered;
  final bool _isBackButtonVisible;
  final Widget? _action;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    return AppBar(
      elevation: 0,
      centerTitle: _isCentered,
      automaticallyImplyLeading: false,
      leading: _isBackButtonVisible
          ? ButtonIcon(
              onTap: () {
                _onTapBack.call();
              },
              child: Icon(
                Icons.arrow_back_rounded,
                color: ButtonColors.tertiary,
                size: responsive.getResponsiveSize(
                  AppIconSize.medium,
                ),
              ),
            )
          : null,
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
