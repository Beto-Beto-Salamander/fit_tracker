import 'package:fit_tracker/di_container.dart';
import 'package:fit_tracker/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeightDisplayPage extends StatelessWidget {
  const WeightDisplayPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeightRecordCubit(sl()),
      child: const WeightDisplayPageWrapper(),
    );
  }
}

class WeightDisplayPageWrapper extends StatefulWidget {
  const WeightDisplayPageWrapper({Key? key}) : super(key: key);

  @override
  State<WeightDisplayPageWrapper> createState() =>
      _WeightDisplayPageWrapperState();
}

class _WeightDisplayPageWrapperState extends State<WeightDisplayPageWrapper>
    with AutomaticKeepAliveClientMixin {
  final TextFieldEntity _textFieldEntity = TextFieldEntity.weight;

  void _handleDeleteWeight(WeightRecordEntity params) {
    BasePopup(context).dialog(
      child: DialogConfirmation(
        title: "Delete this one ?",
        message: "This action cannot be undone",
        positiveButtonText: "Yes, delete",
        negativeButtonText: "No, cancel",
        positiveButtonAction: () async {
          context.read<WeightRecordCubit>().delete(params);
          Navigator.pop(context, true);
        },
        negativeButtonAction: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  void _handleUpdateWeight(WeightRecordEntity data) {
    BasePopup(context).dialog(
      child: DialogTextField(
        title: "Update this one ?",
        message: "Please enter the new value",
        positiveButtonText: "Submit",
        negativeButtonText: "Cancel",
        textFieldEntity: _textFieldEntity,
        positiveButtonAction: () async {
          context.read<WeightRecordCubit>().update(
                oldValue: WeightRecordEntity(
                  weight: data.weight,
                  recordedDate: data.recordedDate,
                  location: data.location,
                ),
                newValue: WeightRecordEntity(
                  weight: int.parse(_textFieldEntity.textController.text),
                  recordedDate: data.recordedDate,
                  location: data.location,
                ),
              );
          _textFieldEntity.textController.clear();
          Navigator.pop(context, true);
        },
        negativeButtonAction: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<WeightRecordCubit>().get();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ScaffoldWrapper(
      child: Scaffold(
        backgroundColor: WrapperColors.white,
        appBar: AppBarPrimary(
          "Weight records",
          onTapBack: () {
            Navigator.pop(context, true);
          },
        ),
        body: CustomScrollView(
          slivers: [
            const SliverGap(
              height: AppGap.big,
            ),
            const SliverToBoxAdapter(),
            BlocBuilder<WeightRecordCubit, WeightRecordState>(
              builder: (context, state) {
                if (state is WeightRecordLoading) {
                  return const SliverToBoxAdapter(
                    child: ScreenSizeLoadingIndicator(),
                  );
                } else if (state is WeightRecordLoaded) {
                  if (state.weightRecords?.isEmpty ?? true) {
                    return SliverColumnPadding(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "😱",
                          style: AppTextStyle.bold.copyWith(
                            fontSize: AppFontSize.extraBig,
                          ),
                        ),
                        Text(
                          "No data found",
                          textAlign: TextAlign.center,
                          style: AppTextStyle.bold.copyWith(
                            fontSize: AppFontSize.large,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return SliverToBoxAdapter(
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: state.weightRecords?.length ?? 0,
                        separatorBuilder: (context, index) => const Divider(
                          height: 0,
                          color: AppColors.oxfordBlue,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          state.weightRecords?.sort(
                            (a, b) => b.recordedDate.compareTo(a.recordedDate),
                          );
                          final record = state.weightRecords?[index];
                          return WeightDisplayRow(
                            weightRecord: record,
                            index: index,
                            onTapDelete: () {
                              _handleDeleteWeight(
                                record!,
                              );
                            },
                            onTapEdit: () {
                              _handleUpdateWeight(
                                record!,
                              );
                            },
                          );
                        },
                      ),
                    );
                  }
                } else if (state is WeightRecordError) {
                  return SliverToBoxAdapter(
                    child: Text(
                      "No data found",
                      style: AppTextStyle.bold.copyWith(
                        fontSize: AppFontSize.large,
                      ),
                    ),
                  );
                } else {
                  return SliverToBoxAdapter(
                    child: Text(
                      "No data found",
                      style: AppTextStyle.bold.copyWith(
                        fontSize: AppFontSize.large,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
