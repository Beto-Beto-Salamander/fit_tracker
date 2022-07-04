import 'package:fit_tracker/lib.dart';
import 'package:flutter/material.dart';

class WeightDisplayRow extends StatelessWidget {
  const WeightDisplayRow({
    Key? key,
    WeightRecordEntity? weightRecord,
    required int index,
    required Function() onTapDelete,
    required Function() onTapEdit,
  })  : _weightRecord = weightRecord,
        _index = index,
        _onTapDelete = onTapDelete,
        _onTapEdit = onTapEdit,
        super(key: key);

  final WeightRecordEntity? _weightRecord;
  final int _index;
  final Function() _onTapDelete;
  final Function() _onTapEdit;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    return RowPadding(
      background: AppColors.lightPeriwinkle.withOpacity(0.3),
      padding: EdgeInsets.symmetric(
        horizontal: responsive.getResponsiveSize(
          AppGap.medium,
        ),
        vertical: responsive.getResponsiveSize(
          AppGap.normal,
        ),
      ),
      children: [
        Expanded(
          child: Center(
            child: Text(
              "${_index + 1}.",
              style: AppTextStyle.regular.copyWith(
                fontSize: AppFontSize.normal,
              ),
            ),
          ),
        ),
        const Gap(),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateTime.parse(_weightRecord?.recordedDate ?? "")
                    .getDateFullFormat(withDay: false)
                    .toString(),
                textAlign: TextAlign.center,
                style: AppTextStyle.regular.copyWith(
                  fontSize: AppFontSize.small,
                ),
              ),
              Text(
                "${_weightRecord?.weight ?? 0} kg",
                style: AppTextStyle.medium.copyWith(
                  fontSize: AppFontSize.normal,
                ),
              ),
            ],
          ),
        ),
        const Gap(),
        Expanded(
          flex: 2,
          child: ButtonPrimary(
            "Location",
            height: AppButtonSize.small,
            fontSize: AppFontSize.small,
            paddingHorizontal: AppGap.extraSmall,
            onPressed: () {},
          ),
        ),
        const Gap(),
        Expanded(
          flex: 1,
          child: ButtonIcon(
            onTap: _onTapDelete,
            buttonSize: AppButtonSize.small,
            child: Icon(
              Icons.delete,
              color: AppColors.red,
              size: responsive.getResponsiveSize(
                AppIconSize.medium,
              ),
            ),
          ),
        ),
        const Gap(),
        Expanded(
          flex: 1,
          child: ButtonIcon(
            onTap: _onTapEdit,
            buttonSize: AppButtonSize.small,
            child: Icon(
              Icons.edit_rounded,
              color: AppColors.manatee,
              size: responsive.getResponsiveSize(
                AppIconSize.medium,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
