import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hollat/login/data/viewmodel/config_viewmodel.dart';
import 'package:hollat/login/network/error_handling.dart';
import 'package:hollat/main/data/repositories/client_profile_repositories.dart';
import 'package:hollat/main/data/repositories/ticket_repository.dart';
import 'package:hollat/main/domain/entities/client/update_client_profile.dart';

class OldTicketViewModel extends StateNotifier<ConfigState> {
  final TicketRepository repository;

  OldTicketViewModel({required this.repository}) : super(ConfigInitial());

  Future<void> searchTicket(String ticketId) async {
    state = ConfigLoading();
    try {
      final clientProfile = await repository.searchTicket(ticketId);
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
