import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  NationalTypesResponse? _nationalTypes;
  NationalTypes? _selectedType;
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(
          () {
        ref.read(normalLoginViewModelProvider.notifier).reloadCaptcha();
        ref.read(getAllNationalTypesViewModelProvider.notifier).getAllNationalTypes();
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
                            final fullName =
                                '${_selectedCountry
                                .dialCode}${controllerPhoneNumber.text}';
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
                        controller: controllerUserName,
                        labelText: 'User name',
                        hintText: 'Enter your user name',
                        keyboardType: TextInputType.text,
                        prefixIcon: const Icon(Icons.person),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Your user name required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                  Consumer(
                      builder: (context, ref, child) {
                        final state = ref.watch(getAllNationalTypesViewModelProvider);
                        return switch(state){
                          ConfigInitial() => const SizedBox.shrink(),
                          ConfigLoading() => const Center(child: CircularProgressIndicator()),
                          ConfigSuccess(:final data) => CustomDropdown<NationalTypes>(
                            items: data.data,
                            selectedValue: _selectedType,
                            onChanged: (NationalTypes? newValue) {
                              setState(() {
                                _selectedType = newValue;
                              });
                            },
                            displayText: (item) => item.titleAr,
                            hintText: 'Select national type',
                          ),
                          ConfigError(:final message) => Text('Error: $message'),
                          // TODO: Handle this case.
                          NormalLoginRepository() => throw UnimplementedError(),
                        };
                      }),
                  SizedBox(
                  height: 20,
                  ),
                  CustomTextField(
                  controller: controllerIdNumber,
                  labelText: 'Id Number',
                  hintText: 'Enter your Id',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                  if (value == null || value.isEmpty) {
                  return 'Your id required';
                  }
                  return null;
                  },
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                  controller: controllerEmail,
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                  if (value == null || value.isEmpty) {
                  return 'Your user name required';
                  }
                  return null;
                  },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                  style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 30.0),
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
                  mainAxisSize: MainAxisSize.max,
                  children: [
                  Icon(Icons.date_range),
                  SizedBox(width: 5),
                  Text('Select birth date'),
                  SizedBox(width: 5),
                  Text(
                  _selectedDate != null
                  ? ' ${DateFormat.yMd().format(_selectedDate!)}'
                      : '',
                  style: TextStyle(fontSize: 16),
                  )
                  ],
                  )),
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
                  CustomElevatedButton(
                  text: 'Create an account',
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
