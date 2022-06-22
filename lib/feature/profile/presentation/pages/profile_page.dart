import 'package:fit_tracker/feature/common/presentation/widget/dialog/dialog_confirmation.dart';
import 'package:fit_tracker/feature/profile/presentation/cubit/firestore_cubit.dart';
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
    return BlocProvider(
      create: (context) => FirestoreCubit(),
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

class _ProfilePageWrapperState extends State<ProfilePageWrapper> {
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
  }

  void _initTextField() async {
    if (await FirestoreServices().isExist()) {
      final user = await FirestoreServices().get();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _textFieldlist[0].textController.text =
            FirebaseServices.currentUser() ?? "";
        _textFieldlist[1].textController.text = user.name ?? "-";
        _textFieldlist[2].textController.text =
            DateTime.parse(user.dateOfBirth ?? "")
                .getDateFullFormat()
                .toString();
        _textFieldlist[3].textController.text = user.height.toString();
        _isMale = user.gender == "male";
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _textFieldlist[0].textController.text =
            FirebaseServices.currentUser() ?? "";
      });
    }
    setState(() {});
  }

  void _handleBirthDate() {
    FocusUtils(context).unfocus();
    context.selectDate(
      initialDate: DateTime.now(),
      first: DateTime(1930),
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
    context.read<FirestoreCubit>().store(
          StoreParams(
            user: UserEntity(
              email: FirebaseServices.currentUser() ?? "",
              name: _textFieldlist[1].textController.text,
              dateOfBirth:
                  (_birthDate ?? DateTime.now()).getDateOnly().toString(),
              gender: _isMale ? "male" : "female",
              height: int.parse(_textFieldlist[3].textController.text),
              weightRecords: const [
                
              ],
            ),
          ),
        );
  }

  void _handleLogout() {
    BasePopup(context).dialog(
      child: DialogConfirmation(
        title: "Hi,",
        message: "Do you want to logout?",
        positiveButtonText: "Yes, logout",
        negativeButtonText: "No, cancel",
        positiveButtonAction: () async {
          await FirebaseServices().logOut();
          Navigator.pushNamedAndRemoveUntil(
            context,
            PagePath.signIn,
            (route) => false,
          );
        },
        negativeButtonAction: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    return ScaffoldWrapper(
      child: Scaffold(
        backgroundColor: WrapperColors.white,
        appBar: AppBarSecondary(
          "Profile Page",
          onTapBack: () {
            Navigator.pop(context);
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
        body: BlocListener<FirestoreCubit, FirestoreState>(
          listener: (context, state) {
            if (state is FirestoreLoading) {
              BasePopup(context).dialog(
                child: const DialogLoading(),
              );
            } else {
              Navigator.popUntil(
                context,
                ModalRoute.withName(PagePath.profile),
              );
            }
            if (state is FirestoreLoaded) {
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
            } else if (state is FirestoreError) {
              BasePopup(context).dialog(
                child: DialogError(
                  message: state.message,
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
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      AppBorderRadius.medium,
                    ),
                    color: WrapperColors.white,
                  ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
