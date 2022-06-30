import 'package:fit_tracker/di_container.dart';
import 'package:fit_tracker/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
    required String args,
  })  : _args = args,
        super(key: key);

  final String _args;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<ProfileCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<WeightRecordCubit>(),
        ),
      ],
      child: HomePageWrapper(args: _args),
    );
  }
}

class HomePageWrapper extends StatefulWidget {
  const HomePageWrapper({
    Key? key,
    required String args,
  })  : _args = args,
        super(key: key);

  final String _args;

  @override
  State<HomePageWrapper> createState() => _HomePageWrapperState();
}

class _HomePageWrapperState extends State<HomePageWrapper>
    with AutomaticKeepAliveClientMixin {
  //Form
  final List<TextFieldEntity> _textFieldlist = TextFieldEntity.weightRecord;
  final GlobalKey _formKey = GlobalKey<FormState>();

  //Date
  DateTime? _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    // for (final i in _textFieldlist) {
    //   i.textController = TextEditingController();
    // }

    sl<UserCubit>().get(widget._args);
    sl<ProfileCubit>().get();
    
    _textFieldlist[0].textController.text =
        DateTime.now().getDateFullFormat().toString();
  }

  void _handleDate() {
    FocusUtils(context).unfocus();
    context.selectDate(
      initialDate: DateTime.now(),
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
    context.read<WeightRecordCubit>().store(
          WeightRecordEntity(
            weight: int.tryParse(_textFieldlist[1].textController.text) ?? 0,
            recordedDate:
                (_selectedDate ?? DateTime.now()).getDateOnly().toString(),
            location: const LocationCoordinateEntity(latitude: 0, longitude: 0),
          ),
        );
    _textFieldlist[1].textController.text = "";
    FocusUtils(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final responsive = ResponsiveUtils(context);

    return ScaffoldWrapper(
      child: Scaffold(
        backgroundColor: WrapperColors.white,
        appBar: AppBarPrimary(
          "Dashboard",
          isBackButtonVisible: false,
          onTapBack: () {},
          action: ButtonIcon(
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
        ),
        body: CustomScrollView(
          slivers: [
            const SliverGap(
              height: AppGap.big,
            ),
            BlocListener<WeightRecordCubit, WeightRecordState>(
              listener: (context, state) {
                if (state is WeightRecordLoading) {
                  BasePopup(context).dialog(
                    child: const DialogLoading(),
                  );
                } else {
                  Navigator.popUntil(
                    context,
                    ModalRoute.withName(PagePath.home),
                  );
                }
                if (state is WeightRecordLoaded) {
                  BasePopup(context).dialog(
                    child: DialogSuccess(
                      message: "You're weight has been recorded successfully!",
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  );
                } else if (state is WeightRecordError) {
                  BasePopup(context).dialog(
                    child: DialogError(
                      message: state.failure?.message ?? "",
                    ),
                  );
                }
              },
              child: BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoading) {
                    return const SliverToBoxAdapter(
                      child: ScreenSizeLoadingIndicator(),
                    );
                  } else if (state is ProfileLoaded) {
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
                  } else if (state is ProfileError) {
                    return CardCompleteYourProfile(
                      onPress: () {
                        Navigator.pushNamed(
                          context,
                          PagePath.profile,
                        );
                      },
                    );
                  } else {
                    return CardCompleteYourProfile(
                      onPress: () {
                        Navigator.pushNamed(
                          context,
                          PagePath.profile,
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class CardCompleteYourProfile extends StatelessWidget {
  const CardCompleteYourProfile({
    Key? key,
    required Function() onPress,
  })  : _onPress = onPress,
        super(key: key);

  final Function() _onPress;

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
              onPressed: _onPress,
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
