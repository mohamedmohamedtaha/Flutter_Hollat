import 'package:easy_localization/easy_localization.dart';
import 'package:hollat/core/global/reg.dart';

class Validation{

  static bool checkEmailAddress(String text) => RegExp(RegException.emailPattern).hasMatch(text);

  static bool checkPhone(String text)=>  RegExp(RegException.phonePattern).hasMatch(text);
static String formatBirthDate(DateTime date)=> DateFormat('yyyy-MM-dd').format(date);

}