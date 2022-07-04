import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_tracker/di_container.dart';
import 'package:fit_tracker/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProfileCubit(sl()),
        ),
        BlocProvider(
          create: (context) => AuthCubit(sl()),
        ),
      ],
      child: const ProfilePageWrapper(),
    );
  }
}

class ProfilePageWrapper extends StatefulWidget {
  const ProfilePageWrapper({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilePageWrapper> createState() => _ProfilePageWrapperState();
}

class _ProfilePageWrapperState extends State<ProfilePageWrapper>
    with AutomaticKeepAliveClientMixin {
  //Form
  final List<TextFieldEntity> _textFieldlist = TextFieldEntity.profile;
  final GlobalKey _formKey = GlobalKey<FormState>();

  //BirthDate
  DateTime? _birthDate = DateTime.now();

  //Gender
  bool _isMale = false;

  @override
  void initState() {
    super.initState();
    for (final i in _textFieldlist) {
      i.textController = TextEditingController();
    }

    _initTextField();

    setState(() {});
  }

  void _initTextField() async {
    final userCubit = sl<UserCubit>().state;

    if (userCubit.user != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _textFieldlist[0].textController.text = userCubit.user?.email ?? "";
        _textFieldlist[1].textController.text = userCubit.user?.name ?? "-";
        _textFieldlist[2].textController.text =
            (userCubit.user?.dateOfBirth.toString().trim().isEmpty ?? true)
                ? "-"
                : DateTime.parse(userCubit.user?.dateOfBirth ?? "")
                    .getDateFullFormat()
                    .toString();
        _textFieldlist[3].textController.text =
            (userCubit.user?.height ?? 0).toString();
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _textFieldlist[0].textController.text = userCubit.email ?? "-";
      });
    }
  }

  void _handleBirthDate() {
    FocusUtils(context).unfocus();
    context.selectDate(
      initialDate: DateTime.now(),
      onPicked: (value) {
        if (value != null) {
          _birthDate = value;
          _textFieldlist[2].textController.text =
              value.getDateFullFormat().toString();
          setState(() {});
        }
      },
    );
  }

  void _handleSubmit() {
    FocusUtils(context).unfocus();
    final user = sl<UserCubit>().state.user;
    if (user?.dateOfBirth.toString().trim().isNotEmpty ?? true) {
      context.read<ProfileCubit>().update(
            UserEntity(
              email: user?.email ?? "-",
              name: _textFieldlist[1].textController.text,
              dateOfBirth:
                  (_birthDate ?? DateTime.now()).getDateOnly().toString(),
              gender: _isMale ? "male" : "female",
              height: int.parse(_textFieldlist[3].textController.text),
            ),
          );
    } else {
      context.read<ProfileCubit>().store(
            UserEntity(
              email: user?.email ?? "-",
              name: _textFieldlist[1].textController.text,
              dateOfBirth:
                  (_birthDate ?? DateTime.now()).getDateOnly().toString(),
              gender: _isMale ? "male" : "female",
              height: int.parse(_textFieldlist[3].textController.text),
              weightRecords: const [],
            ),
          );
    }
  }

  void _handleLogout() {
    BasePopup(context).dialog(
      child: DialogConfirmation(
        title: "Hi,",
        message: "Do you want to logout?",
        positiveButtonText: "Yes, logout",
        negativeButtonText: "No, cancel",
        positiveButtonAction: () async {
          context
              .read<AuthCubit>()
              .logout()
              .then((value) => Navigator.pushNamedAndRemoveUntil(
                    context,
                    PagePath.signIn,
                    (route) => false,
                  ));
        },
        negativeButtonAction: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final responsive = ResponsiveUtils(context);
    return ScaffoldWrapper(
      child: Scaffold(
        backgroundColor: WrapperColors.white,
        appBar: AppBarPrimary(
          "Profile Page",
          onTapBack: () {
            Navigator.pop(context, true);
          },
          action: Padding(
            padding: EdgeInsets.symmetric(
              vertical: responsive.getResponsiveSize(
                AppGap.small,
              ),
              horizontal: responsive.getResponsiveSize(
                AppGap.medium,
              ),
            ),
            child: ButtonPrimary(
              "Logout",
              buttonColor: AppColors.red,
              paddingHorizontal: responsive.getResponsiveSize(
                AppGap.medium,
              ),
              onPressed: _handleLogout,
            ),
          ),
        ),
        body: BlocListener<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileLoading) {
              BasePopup(context).dialog(
                child: const DialogLoading(),
              );
            } else {
              Navigator.popUntil(
                context,
                ModalRoute.withName(PagePath.profile),
              );
            }
            if (state is ProfileLoaded) {
              BasePopup(context).dialog(
                child: DialogSuccess(
                  message: "Let's start recording your weight!",
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      PagePath.home,
                      (route) => false,
                    );
                  },
                ),
              );
            } else if (state is ProfileError) {
              BasePopup(context).dialog(
                child: DialogError(
                  message: state.failure?.message ?? "",
                ),
              );
            }
          },
          child: CustomScrollView(
            slivers: [
              SliverBoxPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: responsive.getResponsiveSize(
                    AppGap.medium,
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(
                        height: AppGap.large,
                      ),
                      //Email
                      CustomTextFormField(
                        textFieldEntity: _textFieldlist[0],
                        backgroundDisable: TextFieldColors.disable,
                      ),
                      const Gap(
                        height: AppGap.medium,
                      ),
                      //Name
                      CustomTextFormField(
                        textFieldEntity: _textFieldlist[1],
                        backgroundDisable: AppColors.white,
                      ),
                      const Gap(
                        height: AppGap.medium,
                      ),
                      //BirthDate
                      GestureDetector(
                        onTap: _handleBirthDate,
                        child: CustomTextFormField(
                          textFieldEntity: _textFieldlist[2],
                          backgroundDisable: AppColors.white,
                        ),
                      ),
                      const Gap(
                        height: AppGap.medium,
                      ),
                      //Height
                      CustomTextFormField(
                        textFieldEntity: _textFieldlist[3],
                        formatter: [
                          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                        ],
                      ),
                      const Gap(
                        height: AppGap.medium,
                      ),
                      Text(
                        "Gender",
                        style: AppTextStyle.semiBold.copyWith(),
                      ),
                      const Gap(
                        height: AppGap.normal,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ButtonPrimary(
                              "Male",
                              buttonColor: _isMale
                                  ? ButtonColors.secondary
                                  : ButtonColors.tertiary,
                              borderColor: _isMale
                                  ? ButtonColors.secondary
                                  : ButtonColors.primary,
                              labelColor: _isMale
                                  ? TextColors.tertiary
                                  : TextColors.primary,
                              onPressed: () {
                                setState(() {
                                  FocusUtils(context).unfocus();
                                  _isMale = true;
                                });
                              },
                            ),
                          ),
                          const Gap(),
                          Expanded(
                            child: ButtonPrimary(
                              "Female",
                              buttonColor: _isMale
                                  ? ButtonColors.tertiary
                                  : ButtonColors.secondary,
                              borderColor: _isMale
                                  ? ButtonColors.primary
                                  : ButtonColors.secondary,
                              labelColor: _isMale
                                  ? TextColors.primary
                                  : TextColors.tertiary,
                              onPressed: () {
                                setState(() {
                                  FocusUtils(context).unfocus();
                                  _isMale = false;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const Gap(
                        height: AppGap.big,
                      ),
                      ButtonPrimary(
                        "Submit",
                        width: double.infinity,
                        buttonColor: ButtonColors.primary,
                        onPressed: _handleSubmit,
                      ),
                      const Gap(
                        height: AppGap.large,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
