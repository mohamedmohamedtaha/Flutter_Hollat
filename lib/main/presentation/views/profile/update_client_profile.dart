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
import 'package:hollat/easy_localization/app_lang.dart';
import 'package:hollat/login/Navigator.dart';
import 'package:hollat/login/data/models/client/city_data.dart';
import 'package:hollat/login/data/models/client/country_data.dart';
import 'package:hollat/login/data/models/client/region_data.dart';
import 'package:hollat/login/data/models/nationaltypes/NationalTypes.dart';
import 'package:hollat/login/data/viewmodel/config_viewmodel.dart';
import 'package:hollat/login/network/repositores/normal_login_repository.dart';
import 'package:hollat/login/presentation/widgets/custom_country_code_number.dart';
import 'package:hollat/login/presentation/widgets/custom_data_picker.dart';
import 'package:hollat/login/presentation/widgets/custom_dropdown.dart';
import 'package:hollat/login/presentation/widgets/custom_elevated_button.dart';
import 'package:hollat/login/presentation/widgets/custom_text.dart';
import 'package:hollat/login/presentation/widgets/custom_text_button.dart';
import 'package:hollat/login/presentation/widgets/custom_text_field.dart';
import 'package:hollat/main/domain/entities/client/update_client_profile.dart';
import 'package:hollat/main/riverpod/provider_main.dart';
import 'package:hollat/main/riverpod/providers.dart';

class UpdateClientProfile extends ConsumerStatefulWidget {
  const UpdateClientProfile({super.key});

  @override
  ConsumerState<UpdateClientProfile> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<UpdateClientProfile> {
  TextEditingController controllerPhoneNumber = TextEditingController();
  TextEditingController controllerUserName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerIdNumber = TextEditingController();
  CountryCode _selectedCountry = CountryCode.fromCountryCode('SA');
  NationalTypes? _selectedType;
  int _selectedTypeNationalId = -1;
  CountryData? _countryData;
  int _selectedCountryId = -1;
  RegionData? _regionData;
  int _selectedRegionId = -1;
  CityData? _cityData;
  int _selectedCityId = -1;
  DateTime? _selectedBirthDate;
  DateTime? _selectedIdExpiryDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(
          () {
        ref.read(getAllNationalTypesViewModelProvider.notifier).getAllNationalTypes();
        ref.read(countriesViewModelProvider.notifier).getAllCountries();
      },
    );
  }

  @override
  void dispose() {
    controllerIdNumber.dispose();
    controllerUserName.dispose();
    controllerEmail.dispose();
    controllerPhoneNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true, // If you want to hide back button
        ),
        body: Consumer(builder: (context, ref, child) {
          var clientProfileState = ref.watch(clientProfileViewModelProvider);
          clientProfileState.whenOrNull(errorApi: (code, data) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showErrorMessageApi(context, code, data);
              ref.read(clientProfileViewModelProvider.notifier).resetSate();
            });
          }, success: (final data) {
            controllerUserName.text = data.name;
            controllerPhoneNumber.text = data.mobile;
            controllerEmail.text = data.email;
            controllerIdNumber.text = data.nationalId;
            _selectedTypeNationalId = data.nationalIdTypeId;
            // _countryData = data.nationalIdTypeId.toString();
            if (data.birthDate != null) {
              _selectedBirthDate =
                  Validation.formatStringToDateTime(data.birthDate!);
            }
            if (data.birthDate != null) {
              _selectedIdExpiryDate =
                  Validation.formatStringToDateTime(data.birthDate!);
            }
          });
          return switch (clientProfileState) {
            ConfigInitial() => const SizedBox.shrink(),
            ConfigLoading() =>
            const Center(child: CircularProgressIndicator()),
            ConfigSuccess(:final data) =>
                Center(
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
                                    height: 10.0,
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
                                    height: 10,
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
                                        return LocaleKeys.errorPhoneRequired
                                            .tr();
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Consumer(builder: (context, ref, child) {
                                    final state =
                                    ref.watch(
                                        getAllNationalTypesViewModelProvider);
                                    return switch (state) {
                                      ConfigInitial() =>
                                      const SizedBox.shrink(),
                                      ConfigLoading() =>
                                      const Center(
                                          child: CircularProgressIndicator()),
                                      ConfigSuccess(:final data) =>
                                          CustomDropdown<NationalTypes>(
                                            items: data.data,
                                            selectedValue: _selectedType,
                                            onChanged: (
                                                NationalTypes? newValue) {
                                              setState(() {
                                                _selectedTypeNationalId =
                                                    newValue?.id ?? -1;
                                              });
                                            },
                                            displayText: (item) =>
                                            AppLang.currentLanguage(context) ==
                                                'ar'
                                                ? item.titleAr
                                                : item.titleEn,
                                            hintText: LocaleKeys
                                                .selectNationalType.tr(),
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
                                  Consumer(builder: (context, ref, child) {
                                    final state = ref.watch(
                                        countriesViewModelProvider);
                                    return switch (state) {
                                      ConfigInitial() =>
                                      const SizedBox.shrink(),
                                      ConfigLoading() =>
                                      const Center(
                                          child: CircularProgressIndicator()),
                                      ConfigSuccess(:final data) =>
                                          CustomDropdown<CountryData>(
                                            items: data.data,
                                            selectedValue: _countryData,
                                            onChanged: (CountryData? newValue) {
                                              setState(() {
                                                var holdNewValue = newValue
                                                    ?.id ?? -1;
                                                if (_selectedCountryId !=
                                                    holdNewValue) {
                                                  ref
                                                      .read(
                                                      regionsProfileViewModelProvider
                                                          .notifier)
                                                      .getAllRegions(
                                                      holdNewValue.toString());
                                                }
                                                _selectedCountryId =
                                                    holdNewValue;
                                              });
                                            },
                                            displayText: (item) =>
                                            AppLang.currentLanguage(context) ==
                                                'ar'
                                                ? item.titleAr
                                                : item.titleEn,
                                            hintText: LocaleKeys.selectCountry
                                                .tr(),
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
                                  Consumer(builder: (context, ref, child) {
                                    final state =
                                    ref.watch(regionsProfileViewModelProvider);
                                    return switch (state) {
                                      ConfigInitial() =>
                                      const SizedBox.shrink(),
                                      ConfigLoading() =>
                                      const Center(
                                          child: CircularProgressIndicator()),
                                      ConfigSuccess(:final data) =>
                                          CustomDropdown<RegionData>(
                                            items: data.data,
                                            selectedValue: _regionData,
                                            onChanged: (RegionData? newValue) {
                                              setState(() {
                                                var holdNewValue = newValue
                                                    ?.id ?? -1;
                                                if (_selectedRegionId !=
                                                    holdNewValue) {
                                                  ref
                                                      .read(
                                                      citiesViewModelProvider
                                                          .notifier)
                                                      .getAllCities(
                                                      _selectedCountryId
                                                          .toString(),
                                                      holdNewValue.toString());
                                                }
                                                _selectedRegionId =
                                                    holdNewValue;
                                              });
                                            },
                                            displayText: (item) =>
                                            AppLang.currentLanguage(context) ==
                                                'ar'
                                                ? item.titleAr
                                                : item.titleEn,
                                            hintText: LocaleKeys.selectRegion
                                                .tr(),
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
                                  Consumer(builder: (context, ref, child) {
                                    final state = ref.watch(
                                        citiesViewModelProvider);
                                    return switch (state) {
                                      ConfigInitial() =>
                                      const SizedBox.shrink(),
                                      ConfigLoading() =>
                                      const Center(
                                          child: CircularProgressIndicator()),
                                      ConfigSuccess(:final data) =>
                                          CustomDropdown<CityData>(
                                            items: data.data,
                                            selectedValue: _cityData,
                                            onChanged: (CityData? newValue) {
                                              setState(() {
                                                var holdNewValue = newValue
                                                    ?.id ?? -1;
                                                _selectedCityId = holdNewValue;
                                              });
                                            },
                                            displayText: (item) =>
                                            AppLang.currentLanguage(context) ==
                                                'ar'
                                                ? item.titleAr
                                                : item.titleEn,
                                            hintText: LocaleKeys.selectCity
                                                .tr(),
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
                                  SizedBox(height: 10),
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
                                  SizedBox(height: 10),
                                  CustomTextButton(
                                      text: '',
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColorsLight
                                              .lightGray,
                                          minimumSize: const Size(
                                              double.infinity, 40.0),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius
                                                  .circular(5))),
                                      onPressed: () async {
                                        final date = await CustomDatePicker
                                            .show(
                                            context: context,
                                            firstDate: DateTime(1900),
                                            lastDate: DateTime.now());
                                        if (date != null) {
                                          setState(() =>
                                          _selectedBirthDate = date);
                                        }
                                      },
                                      child: Align(
                                        alignment:
                                        AppLang.currentLanguage(context) == 'ar'
                                            ? Alignment.centerRight
                                            : Alignment.centerLeft,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                                size: FontsSize.font_30,
                                                color: AppColorsLight
                                                    .primaryColor,
                                                Icons.date_range),
                                            SizedBox(width: 5),
                                            CustomText(
                                              _selectedBirthDate != null
                                                  ? '${LocaleKeys.dateOfBirth
                                                  .tr()}: ${Validation
                                                  .formatDateTimeToString(
                                                  _selectedBirthDate!)}'
                                                  : LocaleKeys.dateOfBirth.tr(),
                                              style: TextStyle(fontSize: 16.0),
                                            )
                                          ],
                                        ),
                                      )),
                                  SizedBox(height: 10),
                                  CustomTextButton(
                                      text: '',
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColorsLight
                                              .lightGray,
                                          minimumSize: const Size(
                                              double.infinity, 40.0),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius
                                                  .circular(5))),
                                      onPressed: () async {
                                        final date = await CustomDatePicker
                                            .show(
                                            context: context,
                                            firstDate: DateTime(1900),
                                            lastDate: DateTime(2040));
                                        if (date != null) {
                                          setState(() =>
                                          _selectedIdExpiryDate = date);
                                        }
                                      },
                                      child: Align(
                                        alignment:
                                        AppLang.currentLanguage(context) == 'ar'
                                            ? Alignment.centerRight
                                            : Alignment.centerLeft,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                                size: FontsSize.font_30,
                                                color: AppColorsLight
                                                    .primaryColor,
                                                Icons.date_range),
                                            SizedBox(width: 5),
                                            CustomText(
                                              _selectedIdExpiryDate != null
                                                  ? '${LocaleKeys.idExpiryDate
                                                  .tr()}: ${Validation
                                                  .formatDateTimeToString(
                                                  _selectedIdExpiryDate!)}'
                                                  : LocaleKeys.idExpiryDate
                                                  .tr(),
                                              style: TextStyle(fontSize: 16.0),
                                            )
                                          ],
                                        ),
                                      )),
                                  SizedBox(height: 20),
                                  Consumer(
                                    builder: (context, ref, child) {
                                      final enableButton =
                                      ref.watch(
                                          enableButtonProviderDefaultTrue);
                                      var updateProfileState = ref.watch(updateProfileViewModelProvider);
                                      if (updateProfileState is ConfigLoading) {
                                        return Center(child: CircularProgressIndicator());
                                      }
                                      updateProfileState.whenOrNull(success: (data) {
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) async {
                                          if (mounted) {
                                            showMessage(context, LocaleKeys.updateSuccessfully.tr());
                                            navigatorControllerPup(context);
                                            _resetLogout();
                                          }
                                        });
                                      }, error: (message, code) {
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          showErrorMessage(
                                              context, code, message);
                                          _resetLogout();
                                        });
                                      }, errorApi: (code, data) {
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          showErrorMessageApi(
                                              context, code, data);
                                          _resetLogout();
                                        });
                                      });

                                      return CustomElevatedButton(
                                          text: LocaleKeys.update.tr(),
                                          textStyle: const TextStyle(
                                              fontSize: 18, letterSpacing: 1.2),
                                          enabled: enableButton,
                                          onPressed: enableButton
                                              ? () {
                                            _updateProfile();
                                          }
                                              : null,
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
            ConfigError(:final message) =>
                Center(
                    child: CustomText(
                      'Error: $message',
                    )),
            ConfigErrorApi(:final data) =>
                Center(
                    child: CustomText(
                      'Error: $data',
                    )),
            NormalLoginRepository() => throw UnimplementedError(),
          };
        },)
    );
  }

  void _updateProfile() {
    var phone = Validation.checkPhone(
        controllerPhoneNumber.text);
    if (!phone ||
        controllerPhoneNumber.text.length !=
            9) {
      showMessage(context, LocaleKeys
          .errorPhoneRequired
          .tr());
      return;
    }

    if (controllerUserName.text.isEmpty) {
      showMessage(context, LocaleKeys
          .userNameRequired
          .tr());
      return;
    }
    if (_selectedTypeNationalId == -1) {
      showMessage(context, LocaleKeys
          .selectNationalType
          .tr());
      return;
    }
    if (_selectedCountryId == -1) {
      showMessage(context, LocaleKeys
          .selectCountry
          .tr());
      return;
    }
    if (_selectedRegionId == -1) {
      showMessage(context, LocaleKeys
          .selectRegion
          .tr());
      return;
    }
    if (_selectedCityId == -1) {
      showMessage(context, LocaleKeys
          .selectCity
          .tr());
      return;
    }
    var idNumber = controllerIdNumber.text;
    if (idNumber.isEmpty ||
        idNumber.length != 10) {
      showMessage(context, LocaleKeys
          .yourIdNotValid
          .tr());
      return;
    }
    var email = Validation.checkEmailAddress(
        controllerEmail.text);
    if (!email) {
      showMessage(context, LocaleKeys
          .errorEmailRequired
          .tr());
      return;
    }
    if (_selectedBirthDate == null) {
      showMessage(context, LocaleKeys
          .selectBirthDate
          .tr());
      return;
    }
    if (_selectedIdExpiryDate == null) {
      showMessage(context, LocaleKeys
          .selectIdExpiryDate
          .tr());
      return;
    }
    var parameters = UpdateProfile(name: controllerUserName.text,
        mobile: controllerPhoneNumber.text,
        email: controllerEmail.text,
        nationalId: controllerIdNumber.text,
        countryId: _selectedCountryId.toString(),
        regionId: _selectedRegionId.toString(),
        cityId: _selectedCityId.toString(),
        birthDay: Validation.formatDateTimeToString(_selectedBirthDate!),
        idEndDate: Validation.formatDateTimeToString(_selectedIdExpiryDate!)
    );
    // Call create API Update profile
    ref
        .read(
        updateProfileViewModelProvider.notifier)
        .updateClientProfile(parameters);

    ref
        .read(enableButtonProviderDefaultTrue
        .notifier)
        .state = false;
  }

  void _resetLogout() {
    ref
        .read(
        updateProfileViewModelProvider.notifier)
        .resetSate();
    ref
        .read(
        enableButtonProviderDefaultTrue
            .notifier)
        .state = true;
  }
}
