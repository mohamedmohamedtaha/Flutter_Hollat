import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hollat/login/data/viewmodel/config_viewmodel.dart';
import 'package:hollat/main/data/repositories/ticket_repository.dart';
import 'package:hollat/main/data/viewmodel/ticket/old_ticket_view_model.dart';
import 'package:hollat/main/riverpod/dio_providers.dart';

final ticketRepositoryProvider = Provider<TicketRepository>(
        (ref) => TicketRepository(ref.read(apiClientProvider)));

final oldTicketProvide =
StateNotifierProvider.autoDispose<OldTicketViewModel, ConfigState>((ref) {
  return OldTicketViewModel(repository: ref.read(ticketRepositoryProvider));
});
