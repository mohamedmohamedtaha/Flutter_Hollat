import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hollat/login/Navigator.dart';
import 'package:hollat/login/data/viewmodel/config_viewmodel.dart';
import 'package:hollat/login/network/repositores/normal_login_repository.dart';
import 'package:hollat/login/presentation/widgets/custom_country_code_number.dart';
import 'package:hollat/login/presentation/widgets/custom_elevated_button.dart';
import 'package:hollat/login/presentation/widgets/custom_text_field.dart';
import 'package:hollat/login/views/login/register_page.dart';
import 'package:hollat/login/presentation/widgets/custom_captcha.dart';
import 'package:hollat/main/riverpod/providers.dart';

class NormalLoginPage extends ConsumerStatefulWidget {
  const NormalLoginPage({super.key});

  @override
  ConsumerState<NormalLoginPage> createState() => _NormalLoginPageState();
}

class _NormalLoginPageState extends ConsumerState<NormalLoginPage> {
  TextEditingController controllerPhoneNumber = TextEditingController();
  TextEditingController controllerCheckCode = TextEditingController();
  CountryCode _selectedCountry = CountryCode.fromCountryCode('SA');
  TextEditingController controllerIdNumber = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(
          () {
            ref.read(normalLoginViewModelProvider.notifier).reloadCaptcha();
        // Provider.of<NormalLoginViewModel>(context, listen: false)
        //     .reloadCaptcha();
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controllerCheckCode.dispose();
    controllerIdNumber.dispose();
    controllerPhoneNumber.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // f you want to hide back button
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
                        CircleAvatar(
                            radius: 50.0,
                            backgroundImage: AssetImage(
                                'assets/images/hollatksa_logo.jpeg')),
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
                                  '${_selectedCountry.dialCode}${controllerPhoneNumber.text}';
                              print(' fullName: ${fullName}');
                            });
                          },
                          hintText: 'EnterYour phone number',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Phone number is required';
                            }
                            if (!RegExp(r'^[0-9]{6,15}$').hasMatch(value) ||
                                value.length != 10) {
                              return 'Invalid phone number';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          controller: controllerIdNumber,
                          labelText: 'Id Number',
                          hintText: 'Enter your Id',
                          keyboardType: TextInputType.number,
                          prefixIcon: const Icon(Icons.person),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Your id required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: CustomTextField(
                                controller: controllerCheckCode,
                                hintText: 'Check Code',
                                labelText: 'Check Code',
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.length < 5) {
                                    return 'Check code is required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(width: 10),
                            Consumer(
                                builder: (context, ref, child) {
                                  final state = ref.watch(normalLoginViewModelProvider);
                                  return switch (state) {
                                    ConfigInitial() => const SizedBox.shrink(),
                                    ConfigLoading() => const Center(child: CircularProgressIndicator()),
                                    ConfigSuccess(:final data) => CustomCaptcha(captcha: data),
                                    ConfigError(:final message) => Text('Error: $message'),

                                  // TODO: Handle this case.
                                    NormalLoginRepository() => throw UnimplementedError(),
                                  };
                                }),
                            SizedBox(width: 10),
                            InkWell(
                              onTap: () {
                                ref.read(normalLoginViewModelProvider.notifier).reloadCaptcha();
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
                        CustomElevatedButton(
                          text: 'Login',
                          enabled: true,
                          onPressed: () {},
                        ),
                        SizedBox(height: 10),
                        CustomElevatedButton(
                          text: 'Create an account',
                          textStyle:
                          const TextStyle(fontSize: 18, letterSpacing: 1.2),
                          enabled: true,
                          onPressed: () {
                            navigatorControllerPush(context, RegisterPage());
                          },
                        )
                      ],
                    ),
                  );
                },
              )),
        ),
      ),
    );
  }
}
// FutureBuilder<Captcha>(future: Provider.of<NormalLoginViewModel>(context, listen: false).loadConfig(),
// builder: (context, snapshot) {
// if(snapshot.hasData){
// return CustomCaptcha(captcha: snapshot.data!);
// }else if(snapshot.hasError){
// return Text('Error: ${snapshot.error}');
// }
// return const CircularProgressIndicator();
// }, )
