import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hollat/login/data/viewmodel/config_viewmodel.dart';
import 'package:hollat/login/network/error_handling.dart';
import 'package:hollat/main/data/repositories/ticket_repository.dart';

class StoreTicketViewModel extends StateNotifier<ConfigState> {
  final TicketRepository repository;

  StoreTicketViewModel({required this.repository}) : super(ConfigInitial());

  Future<void> storeTickets() async {
    state = ConfigLoading();
    try {
      final clientProfile = await repository.storeTickets();
      state = ConfigSuccess(clientProfile);
    } on ApiException catch (e) {
      state = ConfigErrorApi(e.statusCode ?? 0, e.response);
    } on AppException catch (e) {
      state = ConfigError(e.message,e.hashCode);
    }
  }

  void resetSate() {
    state = ConfigInitial();
  }
}
