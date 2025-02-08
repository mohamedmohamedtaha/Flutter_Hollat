import 'package:equatable/equatable.dart';
import 'package:hollat/login/data/models/configresponse/client_name_ar_model.dart';
import 'package:hollat/login/data/models/configresponse/client_name_model.dart';

class ClientDetails extends Equatable {
  final ClientNameModel clientName;
  final ClientNameArModel clientNameAr;

  const ClientDetails({
    required this.clientName,
    required this.clientNameAr,
  });

  @override
  List<Object> get props => [clientName, clientNameAr];
}
