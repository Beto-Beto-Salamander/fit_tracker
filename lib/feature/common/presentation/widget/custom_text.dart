import 'dart:io';

import 'package:fit_tracker/feature/feature.dart';
import 'package:flutter/cupertino.dart';

class Hyperlink extends StatelessWidget {
  const Hyperlink(
    String label, {
    Key? key,
    required Function() onTap,
    Color labelColor = ButtonColors.primary,
    FontWeight fontWeight = AppFontWeight.bold,
    bool isUnderlined = false,
    bool isItalic = false,
    double fontSize = AppFontSize.normal,
  })  : _onTap = onTap,
        _label = label,
        _labelColor = labelColor,
        _fontWeight = fontWeight,
        _isUnderlined = isUnderlined,
        _isItalic = isItalic,
        _fontSize = fontSize,
        super(key: key);

  final Function() _onTap;
  final String _label;
  final Color _labelColor;
  final FontWeight _fontWeight;
  final bool _isUnderlined;
  final bool _isItalic;
  final double _fontSize;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    if (Platform.isAndroid) {
      return GestureDetector(
        onTap: _onTap,
        child: Container(
          height: responsive.getResponsiveSize(
            AppButtonSize.small,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: AppGap.extraSmall,
            horizontal: AppGap.small,
          ),
          child: Text(
            _label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _labelColor,
              fontSize: responsive.getResponsiveFontSize(
                _fontSize,
              ),
              fontWeight: _fontWeight,
              decoration: _isUnderlined
                  ? TextDecoration.underline
                  : TextDecoration.none,
              fontStyle: _isItalic ? FontStyle.italic : FontStyle.normal,
              decorationColor: _labelColor,
            ),
          ),
        ),
      );
    } else {
      return SizedBox(
        height: responsive.getResponsiveSize(
          AppButtonSize.small,
        ),
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _onTap,
          child: Text(
            _label,
            style: TextStyle(
              color: _labelColor,
              fontSize: responsive.getResponsiveFontSize(
                _fontSize,
              ),
              fontWeight: _fontWeight,
              decoration: _isUnderlined
                  ? TextDecoration.underline
                  : TextDecoration.none,
              fontStyle: _isItalic ? FontStyle.italic : FontStyle.normal,
              decorationColor: _labelColor,
            ),
          ),
        ),
      );
    }
  }
}

class LongHyperlink extends StatelessWidget {
  const LongHyperlink({
    Key? key,
    required Function() onTap,
    required String label,
    required String link,
    double fontSize = AppFontSize.normal,
    Color linkColor = ButtonColors.secondary,
    bool isUnderlined = false,
  })  : _onTap = onTap,
        _label = label,
        _link = link,
        _linkColor = linkColor,
        _isUnderlined = isUnderlined,
        _fontSize = fontSize,
        super(key: key);

  final Function() _onTap;
  final String _label;
  final String _link;
  final Color _linkColor;
  final bool _isUnderlined;
  final double _fontSize;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    return Text.rich(
      TextSpan(
          text: _label,
          style: AppTextStyle.regular.copyWith(
            fontSize: responsive.getResponsiveFontSize(
              _fontSize,
            ),
            color: TextColors.primary,
          ),
          children: [
            const WidgetSpan(
              child: Gap(),
            ),
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Hyperlink(
                _link,
                onTap: _onTap,
                labelColor: _linkColor,
                isUnderlined: _isUnderlined,
                fontSize: _fontSize,
              ),
            )
          ]),
    );
  }
}
