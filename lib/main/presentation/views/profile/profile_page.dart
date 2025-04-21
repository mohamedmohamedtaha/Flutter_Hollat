import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hollat/core/global/theme/app_color/app_color_light.dart';
import 'package:hollat/core/global/theme/font/fonts_size.dart';
import 'package:hollat/core/init/gen/translations.g.dart';
import 'package:hollat/core/utils/show_dialog.dart';
import 'package:hollat/core/utils/show_error_message.dart';
import 'package:hollat/login/navigator.dart';
import 'package:hollat/login/data/sharedpreferences/save_token.dart';
import 'package:hollat/login/data/viewmodel/config_viewmodel.dart';
import 'package:hollat/login/network/repositores/normal_login_repository.dart';
import 'package:hollat/login/presentation/widgets/custom_text.dart';
import 'package:hollat/login/presentation/widgets/custom_text_button.dart';
import 'package:hollat/login/views/login/splash_page.dart';
import 'package:hollat/main/presentation/views/change_language/change_language_page.dart';
import 'package:hollat/main/presentation/views/profile/update_client_profile.dart';
import 'package:hollat/main/riverpod/provider_main.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () {
        ref.read(clientProfileViewModelProvider.notifier).getClientProfile();
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColorsLight.moreLightGray,
        body: Consumer(
          builder: (context, ref, child) {
            var clientProfileState = ref.watch(clientProfileViewModelProvider);
            return switch (clientProfileState) {
              ConfigInitial() => const SizedBox.shrink(),
              ConfigLoading() =>
                const Center(child: CircularProgressIndicator()),
              ConfigSuccess(:final data) => SingleChildScrollView(
                  child: Column(
                    children: [
                      Card(
                        color: AppColorsLight.whiteColor,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  // User image
                                  SvgPicture.asset(
                                    'assets/images/account.svg',
                                    // Replace with your image
                                    width: 60,
                                    height: 60,
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: CustomText(
                                      data.name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Padding(
                                  padding: EdgeInsets.only(left: 80),
                                  child: Row(
                                    children: [
                                      CustomText(data.nationalId,
                                          backgroundColor:
                                              AppColorsLight.primaryColor),
                                      SizedBox(width: 8),
                                      CustomText(
                                        'مواطن',
                                        backgroundColor:
                                            AppColorsLight.primaryColor,
                                      ),
                                    ],
                                  )),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.only(left: 80),
                                child: Row(
                                  children: [
                                    // Gender image
                                    SvgPicture.asset(
                                      'assets/images/ic_man.svg',
                                      colorFilter: ColorFilter.mode(
                                          AppColorsLight.primaryColor,
                                          BlendMode.srcIn),
                                      // Replace with your SVG image
                                      width: 20,
                                      height: 20,
                                    ),
                                    SizedBox(width: 8),
                                    CustomText(
                                      data.gender,
                                    ),
                                    SizedBox(width: 15),
                                    Icon(
                                      Icons.date_range,
                                      color: AppColorsLight.primaryColor,
                                    ),
                                    SizedBox(width: 10),
                                    CustomText(
                                      data.birthDate,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Card(
                        color: AppColorsLight.whiteColor,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomText(
                                LocaleKeys.address.tr(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              CustomText(
                                data.address ?? '',
                              ),
                              Divider(),
                              CustomText(
                                LocaleKeys.phoneNumber.tr(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              CustomText(
                                data.mobile,
                              ),
                              Divider(),
                              CustomTextButton(
                                onPressed: () {},
                                text: LocaleKeys.change_password.tr(),
                              ),
                              Divider(),
                              CustomText(
                                LocaleKeys.notification.tr(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              CustomText(
                                'نحن ندرك أهمية خصوصيتك وتجربتك الضخصية...',
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Card(
                        color: AppColorsLight.whiteColor,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: CustomText(
                                  fontSize: FontsSize.font_14,
                                  LocaleKeys.controlInYourData.tr(),
                                  color: AppColorsLight.grayColor,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomTextButton(
                                onPressed: () {
                                  navigatorControllerPush(
                                      context, UpdateClientProfile());
                                },
                                text: LocaleKeys.changeData.tr(),
                              ),
                              Divider(),
                              CustomTextButton(
                                onPressed: () {
                                  showLanguageBottomSheet(context);
                                },
                                text: LocaleKeys.changeLanguage.tr(),
                              ),
                              Divider(),
                              CustomTextButton(
                                onPressed: () {},
                                text: LocaleKeys.contactUs.tr(),
                              ),
                              Divider(),
                              Consumer(
                                builder: (context, ref, child) {
                                  var logoutState =
                                      ref.watch(logoutViewModelProvider);
                                  if (logoutState is ConfigLoading) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }
                                  logoutState.whenOrNull(success: (final data) {
                                    _logout();
                                  }, error: (message, code) {
                                    _resetLogout();
                                    showMessage(context, message);
                                  }, errorApi: (code, data) {
                                    _resetLogout();
                                    showErrorMessageApi(context, code, data);
                                  });
                                  return CustomTextButton(
                                    onPressed: () {
                                      showConfirmationDialog(context, () async {
                                        await ref
                                            .read(logoutViewModelProvider
                                                .notifier)
                                            .logout();
                                      });
                                    },
                                    text: (LocaleKeys.logout.tr()),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  //  ),
                ),
              ConfigError(:final message, :final code) => _error(code, message),
              ConfigErrorApi(:final code, :final data) => _errorApi(code, data),
              NormalLoginRepository() => throw UnimplementedError(),
            };
          },
        ));
  }

  Widget _errorApi(int code, dynamic data) {
    showErrorMessageApi(context, code, data);
    _resetClientProfile();
    return CustomText('Error api');
  }

  Widget _error(int code, String message) {
    showErrorMessage(context, code, message);
    _resetClientProfile();
    return CustomText('Error');
  }

  void _resetClientProfile() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(clientProfileViewModelProvider.notifier).resetSate();
    });
  }

  _logout() async {
    // Navigator.of(context).pop();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _resetLogout();
      await deleteToken();
      if (!mounted) return;
      navigatorControllerPushAndRemoveUntil(context, SplashPage(), false);
    });
  }

  _resetLogout() {
    ref.read(logoutViewModelProvider.notifier).resetSate();
  }
}
