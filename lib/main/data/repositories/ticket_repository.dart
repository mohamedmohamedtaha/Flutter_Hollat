import 'package:hollat/core/global/url.dart';
import 'package:hollat/login/network/repositores/parse_response.dart';
import 'package:hollat/main/data/models/client_profile_model.dart';
import 'package:hollat/main/data/models/ticket/old_ticket/data_ticket_model.dart';
import 'package:hollat/main/data/models/ticket/old_ticket/tickets_model.dart';
import 'package:hollat/main/riverpod/api_client.dart';

class TicketRepository{
  final ApiClient _apiClient;
  TicketRepository(this._apiClient);
  Future<TicketsModel> oldTickets(int perPage) async {
    final Map<String,dynamic> requestBody ={'per_page':perPage};
    final response = await _apiClient.request(
        path: Url.oldTickets, method : 'GET',isAuthorize: true,queryParameters: requestBody);
    return parseResponse<TicketsModel>(response,TicketsModel.fromJon);
  }

  Future<DataTicketModel> storeTickets() async {
    final response = await _apiClient.request(
        path: Url.storeTicket, method : 'POST',isAuthorize: true);
    return parseResponse<DataTicketModel>(response,DataTicketModel.fromJson);
  }

  Future<DataTicketModel> searchTicket(String ticketId) async {
    final Map<String,dynamic> requestBody= {
      'ticket_id':ticketId
    };
    final response = await _apiClient.request(
        path: Url.searchTicket, method : 'POST',isAuthorize: true,queryParameters: requestBody);
    return parseResponse<DataTicketModel>(response,DataTicketModel.fromJson);
  }
}