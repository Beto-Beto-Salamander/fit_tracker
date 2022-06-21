import 'dart:io';

import 'package:fit_tracker/lib.dart';
import 'package:flutter/material.dart';

class BaseAuthCard extends StatelessWidget {
  const BaseAuthCard({
    Key? key,
    required String title,
    required String subtitle,
    required GlobalKey<State<StatefulWidget>> formKey,
    required List<Widget> children,
  })  : _title = title,
        _subtitle = subtitle,
        _formKey = formKey,
        _children = children,
        super(key: key);

  final String _title;
  final String _subtitle;
  final GlobalKey<State<StatefulWidget>> _formKey;
  final List<Widget> _children;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    return Container(
      margin: EdgeInsets.only(
        top: responsive.getResponsiveSize(151 - (Platform.isAndroid ? 4 : 0)),
      ),
      padding: EdgeInsets.all(
        responsive.getResponsiveSize(
          AppGap.large,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(
            AppBorderRadius.medium,
          ),
        ),
        padding: EdgeInsets.only(
          top: responsive.getResponsiveSize(86),
          left: responsive.getResponsiveSize(
            AppGap.large,
          ),
          bottom: responsive.getResponsiveSize(
            AppGap.large,
          ),
          right: responsive.getResponsiveSize(
            AppGap.large,
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _title,
                style: AppTextStyle.bold.copyWith(
                  fontSize: responsive.getResponsiveSize(AppFontSize.big),
                ),
              ),
              Text(
                _subtitle,
                style: AppTextStyle.medium.copyWith(
                  fontSize: responsive.getResponsiveSize(AppFontSize.normal),
                ),
              ),
              ..._children,
            ],
          ),
        ),
      ),
    );
  }
}
