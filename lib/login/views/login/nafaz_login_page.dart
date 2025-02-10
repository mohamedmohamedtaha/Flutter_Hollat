import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hollat/core/global/theme/app_color/app_color_light.dart';
import 'package:hollat/core/global/theme/font/fonts_size.dart';
import 'package:hollat/core/init/gen/translations.g.dart';
import 'package:hollat/core/utils/show_error_message.dart';
import 'package:hollat/easy_localization/app_lang.dart';
import 'package:hollat/login/data/models/nafath/nafath_response.dart';
import 'package:hollat/login/data/viewmodel/config_viewmodel.dart';
import 'package:hollat/login/presentation/widgets/custom_elevated_button.dart';
import 'package:hollat/login/presentation/widgets/custom_text.dart';
import 'package:hollat/login/presentation/widgets/custom_text_field.dart';
import 'package:hollat/login/views/login/nafaz_code_page.dart';
import 'package:hollat/main/riverpod/providers.dart';

class NafazLoginPage extends ConsumerStatefulWidget {
  const NafazLoginPage({super.key});

  @override
  ConsumerState<NafazLoginPage> createState() => _NafazLoginPageState();
}

class _NafazLoginPageState extends ConsumerState<NafazLoginPage> {
  final TextEditingController _idController = TextEditingController();

  @override
  void dispose() {
    _idController.dispose();
    ref.invalidate(nafazLoginViewModelProvider);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // const CustomSamaCareWidget(),
                            const SizedBox(height: 16),
                            Image.asset('assets/images/hollatksa_logo.jpeg'),
                            const SizedBox(height: 16),
                            CustomTextField(
                              maxLength: 10,
                              controller: _idController,
                              labelText: LocaleKeys.idNumber.tr(),
                              hintText: LocaleKeys.enterYourId.tr(),
                              keyboardType: TextInputType.number,
                              prefixIcon: const Icon(Icons.person),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return LocaleKeys.idRequired.tr();
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 12),
                            Consumer(
                              builder: (context, ref, child) {
                                final nafazLoginState =
                                ref.watch(nafazLoginViewModelProvider);
                                if (nafazLoginState.isSuccess) {
                                  nafazLoginState.whenOrNull(
                                    success: (data) {
                                      _navigate(data);
                                    },
                                  );
                                  return const SizedBox.shrink();
                                } else if (nafazLoginState.isError) {
                                  var error =(nafazLoginState as ConfigError);
                                  _resetNafazLogin();
                                    showErrorMessage(context, error.code, error.message);
                                  }
                                else if (nafazLoginState.isErrorApi) {
                                  var error =(nafazLoginState as ConfigErrorApi);
                                  _resetNafazLogin();
                                  showErrorMessageApi(context, error.code, error.data);
                                }
                                return CustomElevatedButton(
                                  text: LocaleKeys.login.tr(),
                                  enabled: !nafazLoginState.isLoading,
                                  onPressed: nafazLoginState.isLoading
                                      ? null
                                      : () {
                                    _login();
                                  },
                                  child: nafazLoginState.isLoading
                                      ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor:
                                      AlwaysStoppedAnimation(
                                          AppColorsLight
                                              .whiteColor),
                                    ),
                                  )
                                      : CustomText(
                                    LocaleKeys.login.tr(),
                                    color: AppColorsLight.whiteColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: FontsSize.font_15,
                                  ),
                                );
                              },
                            ),
                            // Spacer(),
                          ],
                        )))),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                // Center horizontally
                children: [
                  Icon(Icons.language,
                  size: 20.0,),
                  const SizedBox(
                    width: 8,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        AppLang.changeLanguage(context);
                      });
                    },
                    child: CustomText(
                      LocaleKeys.language.tr(),
                      style: TextStyle(
                          fontSize: FontsSize.font_16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  _navigate(NafathResponse data) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _resetNafazLogin();
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => NafazCodePage(
                nationalId: _idController.text,
                randomCode: data.random,
                transId: data.transId),
          ));
    });
  }

  void _login() {
    if (_idController.text.isEmpty) {
      showMessage(context, LocaleKeys
          .idRequired
          .tr());
      return;
    }
    if (_idController.text.length < 10) {
          showMessage(context, LocaleKeys
          .yourIdNotValid
          .tr());
      return;
    }
    ref
        .read(
        nafazLoginViewModelProvider
            .notifier)
        .nafath(_idController.text);
  }
  void _resetNafazLogin(){
    WidgetsBinding.instance.addPostFrameCallback((_){
      ref
          .read(
          nafazLoginViewModelProvider.notifier)
          .restState();
    });
  }
}