import 'package:fit_tracker/feature/profile/presentation/cubit/firestore_cubit.dart';
import 'package:fit_tracker/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/presentation/widget/dialog/dialog_confirmation.dart';

class WeightDisplayPage extends StatelessWidget {
  const WeightDisplayPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FirestoreCubit()..get(),
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

class _WeightDisplayPageWrapperState extends State<WeightDisplayPageWrapper> {
  final TextFieldEntity _textFieldEntity = TextFieldEntity.weight;

  void _handleDeleteWeight(DeleteWeightParams params) {
    BasePopup(context).dialog(
      child: DialogConfirmation(
        title: "Delete this one ?",
        message: "This action cannot be undone",
        positiveButtonText: "Yes, delete",
        negativeButtonText: "No, cancel",
        positiveButtonAction: () async {
          context.read<FirestoreCubit>().deleteWeight(params);
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
          context.read<FirestoreCubit>().updateWeight(
                WeightRecordEntity(
                  weight: data.weight,
                  recordedDate: data.recordedDate,
                  location: data.location,
                ),
                WeightRecordEntity(
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
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      child: Scaffold(
        backgroundColor: WrapperColors.white,
        appBar: AppBarSecondary(
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
            BlocBuilder<FirestoreCubit, FirestoreState>(
              builder: (context, state) {
                if (state is FirestoreLoading) {
                  return const SliverToBoxAdapter(
                    child: ScreenSizeLoadingIndicator(),
                  );
                } else if (state is FirestoreLoaded) {
                  if (state.user?.weightRecords == null) {
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
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: state.user?.weightRecords?.length ?? 0,
                        separatorBuilder: (context, index) => const Divider(
                          height: 0,
                          color: AppColors.oxfordBlue,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          state.user?.weightRecords?.sort(
                            (a, b) => b.recordedDate.compareTo(a.recordedDate),
                          );
                          final record = state.user?.weightRecords?[index];
                          return WeightDisplayRow(
                            weightRecord: record,
                            index: index,
                            onTapDelete: () {
                              _handleDeleteWeight(
                                DeleteWeightParams(data: record!),
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
                } else if (state is FirestoreError) {
                  return SliverToBoxAdapter(
                    child: Text(
                      "No data found",
                      style: AppTextStyle.bold.copyWith(
                        fontSize: AppFontSize.large,
                      ),
                    ),
                  );
                } else {
                  return const SliverToBoxAdapter();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
