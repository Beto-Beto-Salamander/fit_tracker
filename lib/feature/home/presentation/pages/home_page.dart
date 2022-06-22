import 'package:fit_tracker/feature/profile/presentation/cubit/firestore_cubit.dart';
import 'package:fit_tracker/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FirestoreCubit()..get(),
      child: const HomePageWrapper(),
    );
  }
}

class HomePageWrapper extends StatefulWidget {
  const HomePageWrapper({Key? key}) : super(key: key);

  @override
  State<HomePageWrapper> createState() => _HomePageWrapperState();
}

class _HomePageWrapperState extends State<HomePageWrapper> {
  //Form
  final List<TextFieldEntity> _textFieldlist = TextFieldEntity.weightRecord;
  final GlobalKey _formKey = GlobalKey<FormState>();

  //Date
  DateTime? _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    for (final i in _textFieldlist) {
      i.textController = TextEditingController();
    }

    _textFieldlist[0].textController.text =
        DateTime.now().getDateFullFormat().toString();
  }

  void _handleDate() {
    FocusUtils(context).unfocus();
    context.selectDate(
      initialDate: DateTime.now(),
      first: DateTime(1930),
      onPicked: (value) {
        if (value != null) {
          _selectedDate = value;
          _textFieldlist[0].textController.text =
              value.getDateFullFormat().toString();
          setState(() {});
        }
      },
    );
  }

  void _handleSubmit() {
    context.read<FirestoreCubit>().storeWeight(
          StoreWeightParams(
            data: WeightRecordEntity(
              weight: int.parse(_textFieldlist[1].textController.text),
              recordedDate:
                  (_selectedDate ?? DateTime.now()).getDateOnly().toString(),
              location:
                  const LocationCoordinateEntity(latitude: 0, longitude: 0),
            ),
          ),
        );
    _textFieldlist[1].textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);

    return ScaffoldWrapper(
      child: Scaffold(
        backgroundColor: WrapperColors.white,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
        ),
        body: CustomScrollView(
          slivers: [
            SliverRowPadding(
              padding: EdgeInsets.symmetric(
                horizontal: responsive.getResponsiveSize(
                  AppGap.medium,
                ),
                vertical: responsive.getResponsiveSize(
                  AppGap.large,
                ),
              ),
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              background: WrapperColors.background,
              children: [
                Text(
                  "Dashboard",
                  style: AppTextStyle.bold.copyWith(
                    color: TextColors.tertiary,
                    fontSize: responsive.getResponsiveSize(
                      AppFontSize.large,
                    ),
                  ),
                ),
                ButtonIcon(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      PagePath.profile,
                    );
                  },
                  buttonSize: AppButtonSize.small,
                  child: Icon(
                    Icons.person_rounded,
                    color: ButtonColors.tertiary,
                    size: responsive.getResponsiveSize(
                      AppIconSize.extraLarge,
                    ),
                  ),
                ),
              ],
            ),
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
                  if (state.user == null) {
                    return SliverToBoxAdapter(
                      child: Text(
                        "No user found",
                        style: AppTextStyle.bold.copyWith(
                          fontSize: AppFontSize.large,
                        ),
                      ),
                    );
                  } else {
                    return Form(
                      key: _formKey,
                      child: SliverColumnPadding(
                        padding: EdgeInsets.symmetric(
                          horizontal: responsive.getResponsiveSize(
                            AppGap.medium,
                          ),
                        ),
                        children: [
                          Text.rich(
                            TextSpan(
                                text: "Hello, ",
                                style: AppTextStyle.bold.copyWith(
                                  color: TextColors.quarternary,
                                  fontSize: responsive.getResponsiveSize(
                                    AppFontSize.large,
                                  ),
                                ),
                                children: [
                                  TextSpan(
                                    text: "${state.user?.name ?? "NN"} !",
                                    style: AppTextStyle.bold.copyWith(
                                      color: TextColors.primary,
                                      fontSize: responsive.getResponsiveSize(
                                        AppFontSize.large,
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                          Text(
                            "Let's start tracking!",
                            style: AppTextStyle.bold.copyWith(
                              fontSize: responsive
                                  .getResponsiveSize(AppFontSize.medium),
                            ),
                          ),
                          const Gap(),

                          //Date
                          GestureDetector(
                            onTap: _handleDate,
                            child: CustomTextFormField(
                              textFieldEntity: _textFieldlist[0],
                              backgroundDisable: TextFieldColors.enable,
                            ),
                          ),

                          const Gap(
                            height: AppGap.medium,
                          ),
                          //Weight
                          CustomTextFormField(
                            textFieldEntity: _textFieldlist[1],
                            formatter: [
                              FilteringTextInputFormatter.allow(
                                  RegExp("[0-9]")),
                            ],
                          ),
                          const Gap(
                            height: AppGap.medium,
                          ),
                          ButtonPrimary(
                            "Submit ",
                            width: double.infinity,
                            onPressed: _handleSubmit,
                          ),
                          const Gap(
                            height: AppGap.medium,
                          ),
                          Hyperlink(
                            "See all your records here",
                            labelColor: TextColors.quarternary,
                            onTap: () {
                              FocusUtils(context).unfocus();
                              Navigator.pushNamed(
                                context,
                                PagePath.weightDisplay,
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  }
                } else if (state is FirestoreError) {
                  return const CardCompleteYourProfile();
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

class CardCompleteYourProfile extends StatelessWidget {
  const CardCompleteYourProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    return SliverBoxPadding(
      padding: EdgeInsets.symmetric(
        horizontal: responsive.getResponsiveSize(
          AppGap.medium,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            AppBorderRadius.medium,
          ),
          color: WrapperColors.card,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: responsive.getResponsiveSize(
            AppGap.medium,
          ),
        ),
        child: Column(
          children: [
            const Gap(
              height: AppGap.large,
            ),
            Text(
              "🧐",
              style: AppTextStyle.bold.copyWith(
                color: TextColors.tertiary,
                fontSize: responsive.getResponsiveSize(
                  AppFontSize.extraBig,
                ),
              ),
            ),
            const Gap(
              height: AppGap.medium,
            ),
            Text(
              "One more step to go!",
              style: AppTextStyle.bold.copyWith(
                color: TextColors.tertiary,
                fontSize: responsive.getResponsiveSize(
                  AppFontSize.big,
                ),
              ),
            ),
            Text(
              "Let's complete your profile information",
              style: AppTextStyle.bold.copyWith(
                color: TextColors.tertiary,
                fontSize: responsive.getResponsiveSize(
                  AppFontSize.normal,
                ),
              ),
            ),
            const Gap(
              height: AppGap.big,
            ),
            ButtonPrimary(
              "Click here to complete your profile",
              width: double.infinity,
              buttonColor: ButtonColors.secondary,
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  PagePath.profile,
                );
              },
            ),
            const Gap(
              height: AppGap.large,
            ),
          ],
        ),
      ),
    );
  }
}
