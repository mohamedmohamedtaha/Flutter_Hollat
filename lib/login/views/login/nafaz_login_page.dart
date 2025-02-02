import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hollat/core/global/theme/app_color/app_color_light.dart';
import 'package:hollat/core/global/theme/font/fonts_size.dart';
import 'package:hollat/core/init/gen/translations.g.dart';
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
                                final state =
                                ref.watch(nafazLoginViewModelProvider);
                                if (state.isSuccess) {
                                  // Assuming 'state.data' holds the successful response data
                                  state.whenOrNull(
                                    success: (data) {
                                      _navigate(data);
                                    },
                                  );
                                  // Return a placeholder widget
                                  return const SizedBox.shrink();
                                } else {
                                  if (state.isError) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              (state as ConfigError).message),
                                          duration: const Duration(seconds: 2),
                                        ),
                                      );
                                    });
                                  }
                                  // Return the login button
                                  return CustomElevatedButton(
                                    text: LocaleKeys.login.tr(),
                                    enabled: !state.isLoading,
                                    onPressed: state.isLoading
                                        ? null
                                        : () {
                                      if (_idController.text.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            duration:
                                            Duration(seconds: 2),
                                            behavior:
                                            SnackBarBehavior.floating,
                                            content: Text(LocaleKeys
                                                .idRequired
                                                .tr()),
                                          ),
                                        );
                                        return;
                                      }
                                      if (_idController.text.length <
                                          10) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            duration:
                                            Duration(seconds: 2),
                                            behavior:
                                            SnackBarBehavior.floating,
                                            content: Text(LocaleKeys
                                                .yourIdNotValid
                                                .tr()),
                                          ),
                                        );
                                        return;
                                      }
                                      ref
                                          .read(
                                          nafazLoginViewModelProvider
                                              .notifier)
                                          .nafath(_idController.text);
                                    },
                                    child: state.isLoading
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
                                }
                              },
                            ),
                            // Spacer(),
                          ],
                        )))),
            // Fixed bottom widget
            Padding(
              padding: const EdgeInsets.all(16.0),
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
                      // Change to Arabic
                      setState(() {
                        // context.setLocale(AppLang.supportedLocales[1]);
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

}