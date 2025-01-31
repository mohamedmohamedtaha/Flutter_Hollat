import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hollat/core/global/reg.dart';
import 'package:hollat/core/init/gen/translations.g.dart';
import 'package:hollat/login/data/models/nationaltypes/NationalTypes.dart';
import 'package:hollat/login/data/models/nationaltypes/national_types_response.dart';
import 'package:hollat/login/data/viewmodel/config_viewmodel.dart';
import 'package:hollat/login/network/repositores/normal_login_repository.dart';
import 'package:hollat/login/presentation/widgets/custom_captcha.dart';
import 'package:hollat/login/presentation/widgets/custom_country_code_number.dart';
import 'package:hollat/login/presentation/widgets/custom_data_picker.dart';
import 'package:hollat/login/presentation/widgets/custom_dropdown.dart';
import 'package:hollat/login/presentation/widgets/custom_elevated_button.dart';
import 'package:hollat/login/presentation/widgets/custom_text_field.dart';
import 'package:hollat/main/riverpod/providers.dart';
import 'package:intl/intl.dart';

class NafazSendVerifyCodePage extends ConsumerStatefulWidget {
  const NafazSendVerifyCodePage({super.key});


  @override
  ConsumerState<NafazSendVerifyCodePage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<NafazSendVerifyCodePage> {
  TextEditingController controllerPhoneNumber = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  CountryCode _selectedCountry = CountryCode.fromCountryCode('SA');
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
          backgroundColor: Colors.transparent,
          elevation: 0,
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
                            final fullName =
                                '${_selectedCountry
                                .dialCode}${controllerPhoneNumber.text}';
                            print(' fullName: ${fullName}');
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return LocaleKeys.phoneRequired.tr();
                          }
                          if (!RegExp(RegException.phonePattern).hasMatch(value) ||
                              value.length != 10) {
                            return LocaleKeys.emailRequired.tr();
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                  CustomTextField(
                  controller: controllerEmail,
                  labelText: LocaleKeys.email.tr(),
                  hintText: LocaleKeys.emailHint.tr(),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                  if (value == null || value.isEmpty) {
                  return LocaleKeys.emailRequired.tr();
                  }
                  if (!RegExp(RegException.emailPattern).hasMatch(value) ||
                      value.length != 10) {
                    return LocaleKeys.errorEmailRequired.tr();
                  }
                  return null;
                  },
                  ),
                  SizedBox(height: 20),
                  CustomElevatedButton(
                  text: LocaleKeys.confirm.tr(),
                  textStyle:
                  const TextStyle(fontSize: 18, letterSpacing: 1.2),
                  enabled: true,
                  onPressed: () {},
                  )
                  ]
                  ,
                  )
                  ,
                  );
                },
              )),
        ),
      ),
    );
  }
}
