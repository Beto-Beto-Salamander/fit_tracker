import 'package:fit_tracker/lib.dart';
import 'package:flutter/material.dart';

class BaseDialogCard extends StatelessWidget {
  const BaseDialogCard({Key? key, required List<Widget> children})
      : _children = children,
        super(key: key);

  final List<Widget> _children;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaleFactor: 1,
      ),
      child: Dialog(
        backgroundColor: AppColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.large),
        ),
        insetPadding: EdgeInsets.symmetric(
          horizontal: responsive.getResponsiveSize(AppGap.big),
        ),
        child: ColumnPadding(
          padding: EdgeInsets.symmetric(
            horizontal: responsive.getResponsiveSize(AppGap.large),
            vertical: responsive.getResponsiveSize(AppGap.extraLarge),
          ),
          mainAxisSize: MainAxisSize.min,
          children: _children,
        ),
      ),
    );
  }
}

class BaseDialogIcon extends StatelessWidget {
  const BaseDialogIcon(
    IconData icon, {
    Key? key,
    required Color color,
  })  : _icon = icon,
        _color = color,
        super(key: key);

  final IconData _icon;
  final Color _color;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    return Icon(
      _icon,
      color: _color,
      size: responsive.getResponsiveSize(
        AppIconSize.dialog,
      ),
    );
  }
}

class BaseDialogTitle extends StatelessWidget {
  const BaseDialogTitle(String title, {Key? key})
      : _title = title,
        super(key: key);

  final String _title;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    return Text(
      _title.toUpperCase(),
      textAlign: TextAlign.center,
      style: AppTextStyle.bold.copyWith(
        fontSize: responsive.getResponsiveSize(
          AppFontSize.extraLarge,
        ),
      ),
    );
  }
}

class BaseDialogMessage extends StatelessWidget {
  const BaseDialogMessage(String message, {Key? key})
      : _message = message,
        super(key: key);

  final String _message;
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    return Text(
      _message.toUpperCase(),
      textAlign: TextAlign.center,
      style: AppTextStyle.regular.copyWith(
        color: TextColors.secondary,
        fontSize: responsive.getResponsiveSize(
          AppFontSize.normal,
        ),
      ),
    );
  }
}