import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hollat/core/global/theme/app_color/app_color_light.dart';
import 'package:hollat/core/global/theme/font/fonts_size.dart';
import 'package:hollat/core/global/validation/validation.dart';
import 'package:hollat/core/init/gen/translations.g.dart';
import 'package:hollat/core/utils/show_error_message.dart';
import 'package:hollat/login/Navigator.dart';
import 'package:hollat/login/data/models/nationaltypes/NationalTypes.dart';
import 'package:hollat/login/data/models/reloadcaptcha/captcha.dart';
import 'package:hollat/login/data/viewmodel/config_viewmodel.dart';
import 'package:hollat/login/domain/entities/create_account/create_account.dart';
import 'package:hollat/login/network/repositores/normal_login_repository.dart';
import 'package:hollat/login/presentation/widgets/custom_captcha.dart';
import 'package:hollat/login/presentation/widgets/custom_country_code_number.dart';
import 'package:hollat/login/presentation/widgets/custom_data_picker.dart';
import 'package:hollat/login/presentation/widgets/custom_dropdown.dart';
import 'package:hollat/login/presentation/widgets/custom_elevated_button.dart';
import 'package:hollat/login/presentation/widgets/custom_text.dart';
import 'package:hollat/login/presentation/widgets/custom_text_field.dart';
import 'package:hollat/main/riverpod/providers.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  TextEditingController controllerPhoneNumber = TextEditingController();
  TextEditingController controllerUserName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerIdNumber = TextEditingController();
  TextEditingController controllerCheckCode = TextEditingController();
  CountryCode _selectedCountry = CountryCode.fromCountryCode('SA');

  // NationalTypesResponse? _nationalTypes;
  NationalTypes? _selectedType;
  int _selectedTypeNationalId = -1;

  final bool _isLoading = true;
  String key = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(
          () {
        ref.read(normalLoginViewModelProvider.notifier).reloadCaptcha();
        ref
            .read(getAllNationalTypesViewModelProvider.notifier)
            .getAllNationalTypes();
        //     Provider.of<NormalLoginViewModel>(context, listen: false)
        //     .reloadCaptcha();
        // Provider.of<NormalLoginViewModel>(context, listen: false)
        //     .getAllNationalTypes();
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controllerCheckCode.dispose();
    controllerIdNumber.dispose();
    controllerUserName.dispose();
    controllerEmail.dispose();
    controllerPhoneNumber.dispose();
  }

  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery
        .of(context)
        .size
        .width;
    final state = ref.watch(normalLoginViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true, // If you want to hide back button
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return FractionallySizedBox(
                    widthFactor: widthScreen > 500 ? 0.5 : 1.0,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50.0,
                        ),
                        PhoneNumberField(
                          controller: controllerPhoneNumber,
                          initialCountry: _selectedCountry,
                          onCountryChanged: (country) {
                            setState(() {
                              _selectedCountry = country;
                              // final fullName =
                              //     '${_selectedCountry
                              //     .dialCode}${controllerPhoneNumber.text}';
                              // print(' fullName: ${fullName}');
                            });
                          },
                          hintText: LocaleKeys.phoneHint.tr(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return LocaleKeys.phoneRequired.tr();
                            }
                            var phone = Validation.checkPhone(
                                controllerPhoneNumber.text);
                            if (!phone || value.length != 10) {
                              return LocaleKeys.errorPhoneRequired.tr();
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          controller: controllerUserName,
                          labelText: LocaleKeys.userName.tr(),
                          hintText: LocaleKeys.userNameHint.tr(),
                          keyboardType: TextInputType.text,
                          prefixIcon: const Icon(Icons.person),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return LocaleKeys.userNameRequired.tr();
                            }
                            return null;
                          },
                          maxLength: 50,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Consumer(builder: (context, ref, child) {
                          final state =
                          ref.watch(getAllNationalTypesViewModelProvider);
                          return switch (state) {
                            ConfigInitial() => const SizedBox.shrink(),
                            ConfigLoading() =>
                            const Center(child: CircularProgressIndicator()),
                            ConfigSuccess(:final data) =>
                                CustomDropdown<NationalTypes>(
                                  items: data.data,
                                  selectedValue: _selectedType,
                                  onChanged: (NationalTypes? newValue) {
                                    setState(() {
                                      _selectedTypeNationalId =
                                          newValue?.id ?? -1;
                                    });
                                  },
                                  displayText: (item) => item.titleAr,
                                  hintText: LocaleKeys.selectNationalType.tr(),
                                ),
                            ConfigError(:final message) =>
                                Text('Error: $message'),
                            ConfigErrorApi(:final data) =>
                                Text('Error: $data'),
                            NormalLoginRepository() =>
                            throw UnimplementedError(),
                          };
                        }),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          controller: controllerIdNumber,
                          labelText: LocaleKeys.idNumber.tr(),
                          hintText: LocaleKeys.enterYourId.tr(),
                          keyboardType: TextInputType.number,
                          prefixIcon: const Icon(Icons.person),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return LocaleKeys.yourIdNotValid.tr();
                            }
                            return null;
                          },
                          maxLength: 10,
                        ),
                        SizedBox(height: 20),
                        CustomTextField(
                          controller: controllerEmail,
                          labelText: LocaleKeys.email.tr(),
                          hintText: LocaleKeys.emailHint.tr(),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return LocaleKeys.emailRequired.tr();
                            }
                            return null;
                          },
                          maxLength: 50,
                        ),
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(FontsSize.font_40, 30.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5))),
                              onPressed: () async {
                                final date = await CustomDatePicker.show(
                                    context: context,
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now());
                                if (date != null) {
                                  setState(() => _selectedDate = date);
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(size: FontsSize.font_30,
                                      color: AppColorsLight.primaryColor,
                                      Icons.date_range),
                                  SizedBox(width: 5),
                                  CustomText('',
                                    style: TextStyle(fontWeight:
                                    FontWeight.bold),fontSize: FontsSize.font_16,),
                                  SizedBox(width: 5),
                                  CustomText(
                                    _selectedDate != null
                                        ? ' ${Validation.formatDateTimeToString(
                                        _selectedDate!)}'
                                        : '',
                                    style: TextStyle(fontSize: 16.0),
                                  )
                                ],
                              )),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: CustomTextField(
                                controller: controllerCheckCode,
                                hintText: LocaleKeys.checkCode.tr(),
                                labelText: LocaleKeys.checkCodeHint.tr(),
                                keyboardType: TextInputType.number,
                                maxLength: 5,
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.length < 5) {
                                    return LocaleKeys.checkCodeRequired.tr();
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(width: 10),
                            Consumer(builder: (context, ref, child) {
                              final state =
                              ref.watch(normalLoginViewModelProvider);
                              return switch (state) {
                                ConfigInitial() => const SizedBox.shrink(),
                                ConfigLoading() =>
                                const Center(
                                    child: CircularProgressIndicator()),
                                ConfigSuccess(:final data) => _capatcha(data),
                                ConfigErrorApi(:final data) => Text('Error: $data'),
                              ConfigError(:final message)=>
                              Text('Error: $message'),
                              NormalLoginRepository() =>
                              throw UnimplementedError(),
                              // TODO: Handle this case.
                              };
                            }),
                            SizedBox(width: 10),
                            InkWell(
                              onTap: () {
                                ref
                                    .read(normalLoginViewModelProvider.notifier)
                                    .reloadCaptcha();
                                // context
                                //     .read<NormalLoginViewModel>()
                                //     .reloadCaptcha();
                              },
                              splashColor: Colors.teal,
                              // borderRadius: BorderRadius.circular(12),
                              child: SvgPicture.asset(
                                'assets/images/reload.svg',
                                width: 24,
                                height: 24,
                                colorFilter: ColorFilter.mode(
                                    Colors.green.withValues(alpha: 1.0),
                                    BlendMode.srcIn),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        Consumer(
                          builder: (context, ref, child) {
                            var state = ref.watch(
                                createAccountViewModelProvider);
                            final enableButton = ref.watch(
                                enableButtonProviderDefaultTrue);
                            state.whenOrNull(success: (data) {
                              WidgetsBinding.instance
                                  .addPostFrameCallback((_) async {
                                if (mounted) {
                                  showMessage(context, data.message);
                                  ref
                                      .read(
                                      enableButtonProviderDefaultTrue.notifier)
                                      .state = true;
                                  ref.read(
                                      createAccountViewModelProvider.notifier)
                                      .restState();
                                  navigatorControllerPup(context);
                                }
                              });
                            }, error: (message, code) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                showErrorMessage(context, code, message);
                                ref
                                    .read(
                                    enableButtonProviderDefaultTrue.notifier)
                                    .state = true;
                                ref.read(
                                    createAccountViewModelProvider.notifier)
                                    .restState();
                              });
                            },errorApi:(code,data)  {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                showErrorMessageApi(context, code, data);
                                ref
                                    .read(
                                    enableButtonProviderDefaultTrue.notifier)
                                    .state = true;
                                ref.read(
                                    createAccountViewModelProvider.notifier)
                                    .restState();
                              });
                            });

                            return CustomElevatedButton(
                              text: LocaleKeys.createAccount.tr(),
                              textStyle: const TextStyle(
                                  fontSize: 18, letterSpacing: 1.2),
                              enabled: enableButton,
                              onPressed: enableButton ? () {
                                var phone = Validation.checkPhone(
                                    controllerPhoneNumber.text);
                                if (!phone ||
                                    controllerPhoneNumber.text.length != 9) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: Duration(seconds: 2),
                                      behavior: SnackBarBehavior.floating,
                                      content: Text(
                                          LocaleKeys.errorPhoneRequired.tr()),
                                    ),
                                  );
                                  return;
                                }

                                if (controllerUserName.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: Duration(seconds: 2),
                                      behavior: SnackBarBehavior.floating,
                                      content: Text(
                                          LocaleKeys.userNameRequired.tr()),
                                    ),
                                  );
                                  return;
                                }
                                if (_selectedTypeNationalId == -1) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: Duration(seconds: 2),
                                      behavior: SnackBarBehavior.floating,
                                      content: Text(
                                          LocaleKeys.selectNationalType.tr()),
                                    ),
                                  );
                                  return;
                                }
                                var idNumber = controllerIdNumber.text;
                                if (idNumber.isEmpty || idNumber.length != 10) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: Duration(seconds: 2),
                                      behavior: SnackBarBehavior.floating,
                                      content:
                                      Text(LocaleKeys.yourIdNotValid.tr()),
                                    ),
                                  );
                                  return;
                                }
                                var email = Validation.checkEmailAddress(
                                    controllerEmail.text);
                                if (!email) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: Duration(seconds: 2),
                                      behavior: SnackBarBehavior.floating,
                                      content: Text(
                                          LocaleKeys.errorEmailRequired.tr()),
                                    ),
                                  );
                                  return;
                                }
                                if (_selectedDate == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: Duration(seconds: 2),
                                      behavior: SnackBarBehavior.floating,
                                      content:
                                      Text(LocaleKeys.selectBirthDate.tr()),
                                    ),
                                  );
                                  return;
                                }
                                var checkCode = controllerCheckCode.text;
                                if (checkCode.isEmpty || checkCode.length < 5) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: Duration(seconds: 2),
                                      behavior: SnackBarBehavior.floating,
                                      content: Text(
                                          LocaleKeys.checkCodeRequired.tr()),
                                    ),
                                  );
                                  return;
                                }
                                // Call create API create account
                                var createAccountModel = CreateAccount(
                                    key: key,
                                    capatchaCode: controllerCheckCode.text,
                                    nationalId:
                                    controllerIdNumber.text,
                                    name: controllerUserName.text,
                                    mobile: controllerPhoneNumber.text,
                                    email: controllerEmail.text,
                                    birthDay: Validation.formatDateTimeToString(_selectedDate!),
                                    nationalIdTypeId:
                                    _selectedTypeNationalId.toString());
                                ref
                                    .read(
                                    createAccountViewModelProvider.notifier)
                                    .createClient(createAccountModel);

                                ref
                                    .read(
                                    enableButtonProviderDefaultTrue.notifier)
                                    .state = false;
                              } : null,
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              )),
        ),
      ),
    );
  }

  Widget _capatcha(Captcha data) {
    key = data.key;
    return CustomCaptcha(captcha: data);
  }
}
