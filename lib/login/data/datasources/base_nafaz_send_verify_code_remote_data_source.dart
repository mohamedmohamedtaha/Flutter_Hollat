import 'package:hollat/login/data/models/response/response_model.dart';
import 'package:hollat/login/domain/usecases/nafaz_send_verify_code_reposetory_use_case.dart';

abstract class BaseNafazSendVerifyCodeRemoteDataSource{
  Future<ResponseModel> nafazSendVerifyCode(ResponseParameters parameters);
}