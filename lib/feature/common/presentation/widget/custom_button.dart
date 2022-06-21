import 'dart:io';
import 'package:fit_tracker/lib.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonIcon extends StatelessWidget {
  const ButtonIcon({
    Key? key,
    required VoidCallback onTap,
    required Widget child,
    Color backgroundColor = Colors.transparent,
    bool isDarkSplash = false,
    bool isCircle = false,
    Color? splashColor,
    Color? highlightColor,
    double? buttonSize,
    double radius = AppBorderRadius.extraSmall,
    EdgeInsetsGeometry? padding,
    double? borderThickness,
    Color? borderColor,
  })  : _onTap = onTap,
        _child = child,
        _backgroundColor = backgroundColor,
        _isDarkSplash = isDarkSplash,
        _splashColor = splashColor,
        _highlightColor = highlightColor,
        _buttonSize = buttonSize,
        _radius = radius,
        _padding = padding,
        _borderThickness = borderThickness,
        _borderColor = borderColor,
        super(key: key);

  final VoidCallback _onTap;
  final Widget _child;
  final Color _backgroundColor;
  final bool _isDarkSplash;
  final Color? _splashColor;
  final Color? _highlightColor;
  final double? _buttonSize;
  final double _radius;
  final EdgeInsetsGeometry? _padding;
  final double? _borderThickness;
  final Color? _borderColor;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);

    if (Platform.isAndroid) {
      return Card(
        color: _backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_radius),
          side: _borderThickness != null
              ? BorderSide(
                  color: _borderColor ?? Colors.white,
                  width: _borderThickness ?? 1,
                )
              : BorderSide.none,
        ),
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        elevation: 0,
        child: InkWell(
          onTap: _onTap,
          splashColor:
              (_splashColor ?? (_isDarkSplash ? Colors.black : Colors.white))
                  .withOpacity(.2),
          highlightColor:
              (_highlightColor ?? (_isDarkSplash ? Colors.black : Colors.white))
                  .withOpacity(.2),
          child: Container(
            constraints: BoxConstraints(
              minWidth: responsive
                  .getResponsiveSize(_buttonSize ?? AppButtonSize.normal),
              minHeight: responsive
                  .getResponsiveSize(_buttonSize ?? AppButtonSize.normal),
            ),
            padding: _padding ??
                (_buttonSize == null
                    ? const EdgeInsets.all(AppGap.extraSmall)
                    : EdgeInsets.zero),
            alignment: Alignment.center,
            child: _child,
          ),
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_radius),
          border: _borderThickness != null
              ? Border.all(
                  color: _borderColor ?? Colors.white,
                  width: _borderThickness ?? 1,
                )
              : null,
        ),
        child: CupertinoButton(
          minSize: AppButtonSize.normal,
          color: _backgroundColor,
          disabledColor: _backgroundColor,
          borderRadius: BorderRadius.circular(_radius),
          padding: _padding ??
              (_buttonSize == null
                  ? const EdgeInsets.all(AppGap.extraSmall)
                  : EdgeInsets.zero),
          onPressed: _onTap,
          child: _child,
        ),
      );
    }
  }
}

class ButtonPrimary extends StatelessWidget {
  const ButtonPrimary(
    String label, {
    Key? key,
    required Function() onPressed,
    bool isButtonDisabled = false,
    FontWeight fontWeight = AppFontWeight.bold,
    Color buttonColor = ButtonColors.primary,
    Color labelColor = ButtonTextColors.primary,
    Color borderColor = Colors.transparent,
    double borderWidth = 1,
    double borderRadius = AppBorderRadius.small,
    double fontSize = AppFontSize.normal,
    double paddingVertical = 0,
    double paddingHorizontal = AppGap.normal,
    double? height,
    double? width,
  })  : _label = label,
        _onPressed = onPressed,
        _fontWeight = fontWeight,
        _buttonColor = buttonColor,
        _labelColor = labelColor,
        _isButtonDisabled = isButtonDisabled,
        _borderColor = borderColor,
        _borderWidth = borderWidth,
        _borderRadius = borderRadius,
        _fontSize = fontSize,
        _paddingVertical = paddingVertical,
        _paddingHorizontal = paddingHorizontal,
        _height = height,
        _width = width,
        super(key: key);

  final String _label;
  final Function() _onPressed;
  final FontWeight _fontWeight;
  final Color _buttonColor;
  final Color? _labelColor;
  final Color _borderColor;
  final double _borderWidth;
  final bool _isButtonDisabled;
  final double _borderRadius;
  final double _fontSize;
  final double _paddingVertical;
  final double _paddingHorizontal;
  final double? _height;
  final double? _width;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);

    if (Platform.isAndroid) {
      return SizedBox(
        height: _height ??
            responsive.getResponsiveSize(
              AppButtonSize.normal,
            ),
        width: _width,
        child: OutlinedButton(
          onPressed: _isButtonDisabled ? null : _onPressed,
          style: OutlinedButton.styleFrom(
            backgroundColor: _buttonColor,
            padding: EdgeInsets.symmetric(
              vertical: _paddingVertical,
              horizontal: _paddingHorizontal,
            ),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            side: BorderSide(color: _borderColor, width: _borderWidth),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                _borderRadius,
              ),
            ),
          ),
          child: Text(
            _label,
            style: TextStyle(
              fontSize: responsive.getResponsiveFontSize(
                _fontSize,
              ),
              color: _labelColor,
              fontWeight: _fontWeight,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    } else {
      return Container(
        height: _height ??
            responsive.getResponsiveSize(
              AppButtonSize.normal,
            ),
        width: _width,
        decoration: BoxDecoration(
          border: Border.all(color: _borderColor),
          borderRadius: BorderRadius.circular(_borderRadius + 2),
        ),
        child: CupertinoButton(
          onPressed: _isButtonDisabled ? null : _onPressed,
          color: _buttonColor,
          disabledColor: _buttonColor,
          padding: EdgeInsets.symmetric(
            vertical: _paddingVertical,
            horizontal: _paddingHorizontal,
          ),
          pressedOpacity: 0.8,
          borderRadius: BorderRadius.circular(_borderRadius),
          child: Text(
            _label,
            style: TextStyle(
              fontSize: responsive.getResponsiveFontSize(
                _fontSize,
              ),
              color: _labelColor,
              fontWeight: _fontWeight,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    }
  }
}

class ButtonPrimaryWithIcon extends StatelessWidget {
  const ButtonPrimaryWithIcon(
    String label, {
    Key? key,
    required VoidCallback onPressed,
    required Widget icon,
    double height = AppButtonSize.normal,
    double? width,
    double paddingVertical = 0,
    double paddingHorizontal = AppGap.extraLarge,
    bool isCenterLabel = true,
    FontWeight fontWeight = AppFontWeight.semiBold,
    Color buttonColor = ButtonColors.primary,
    Color labelColor = ButtonTextColors.primary,
    bool isButtonDisabled = false,
    Color borderColor = Colors.transparent,
    double borderRadius = AppBorderRadius.extraSmall,
    double fontSize = AppFontSize.normal,
  })  : _label = label,
        _onPressed = onPressed,
        _icon = icon,
        _height = height,
        _width = width,
        _paddingVertical = paddingVertical,
        _paddingHorizontal = paddingHorizontal,
        _isCenterLabel = isCenterLabel,
        _fontWeight = fontWeight,
        _buttonColor = buttonColor,
        _labelColor = labelColor,
        _isButtonDisabled = isButtonDisabled,
        _borderColor = borderColor,
        _borderRadius = borderRadius,
        _fontSize = fontSize,
        super(key: key);

  final String _label;
  final VoidCallback _onPressed;
  final Widget _icon;
  final double _height;
  final double? _width;
  final double _paddingVertical;
  final double _paddingHorizontal;
  final bool _isCenterLabel;
  final FontWeight _fontWeight;
  final Color _buttonColor;
  final Color? _labelColor;
  final Color _borderColor;
  final bool _isButtonDisabled;
  final double _borderRadius;
  final double _fontSize;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);

    if (Platform.isAndroid) {
      return SizedBox(
        height: responsive.getResponsiveSize(_height),
        width: _width,
        child: OutlinedButton(
          onPressed: _isButtonDisabled ? null : _onPressed,
          style: OutlinedButton.styleFrom(
            backgroundColor: _buttonColor,
            padding: EdgeInsets.symmetric(
              vertical: _paddingVertical,
              horizontal: _paddingHorizontal,
            ),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            side: BorderSide(color: _borderColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                _borderRadius,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _icon,
              const Gap(),
              Text(
                _label,
                style: TextStyle(
                  fontSize: responsive.getResponsiveFontSize(
                    _fontSize,
                  ),
                  color: _labelColor,
                  fontWeight: _fontWeight,
                ),
                textAlign: _isCenterLabel ? TextAlign.center : TextAlign.start,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(
        height: responsive.getResponsiveSize(_height),
        width: _width,
        decoration: BoxDecoration(
          border: Border.all(color: _borderColor),
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        child: CupertinoButton(
          onPressed: _isButtonDisabled ? null : _onPressed,
          color: _buttonColor,
          disabledColor: _buttonColor,
          padding: EdgeInsets.symmetric(
            vertical: _paddingVertical,
            horizontal: _paddingHorizontal,
          ),
          pressedOpacity: 0.8,
          borderRadius: BorderRadius.circular(_borderRadius),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _icon,
              const Gap(),
              Text(
                _label,
                style: TextStyle(
                  fontSize: responsive.getResponsiveFontSize(
                    _fontSize,
                  ),
                  color: _labelColor,
                  fontWeight: _fontWeight,
                ),
                textAlign: _isCenterLabel ? TextAlign.center : TextAlign.start,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      );
    }
  }
}
