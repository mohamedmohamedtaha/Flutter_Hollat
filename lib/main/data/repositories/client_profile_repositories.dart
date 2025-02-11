import 'package:hollat/core/global/url.dart';
import 'package:hollat/login/data/models/response/response_model.dart';
import 'package:hollat/login/network/repositores/parse_response.dart';
import 'package:hollat/main/data/models/cities/cities_model.dart';
import 'package:hollat/main/data/models/client_profile_model.dart';
import 'package:hollat/main/data/models/countries/countries_model.dart';
import 'package:hollat/main/data/models/regions/regions_model.dart';
import 'package:hollat/main/domain/entities/client/update_client_profile.dart';
import 'package:hollat/main/riverpod/api_client.dart';

class ClientProfileRepository{
  final ApiClient _apiClient;
  ClientProfileRepository(this._apiClient);

  Future<ClientProfileModel> getClientProfile() async {
    final response = await _apiClient.request(
        path: Url.clientProfile, method : 'GET',isAuthorize: true);
    return parseResponse<ClientProfileModel>(response,ClientProfileModel.fromJson);
  }
  Future<ResponseModel>  updateClientProfile(UpdateProfile parameters) async {
    final Map<String, dynamic> requestBody = {
      'name':parameters.name,
      'national_id':parameters.nationalId,
      'country_id':parameters.countryId,
      'region_id':parameters.regionId,
      'city_id':parameters.cityId,
      'mobile':parameters.mobile,
      'email':parameters.email,
      'birthdate':parameters.birthDay,
      'id_endDate':parameters.idEndDate,
      // Add other parameters if needed
    };
    final response = await _apiClient.request(
        path: Url.updateProfile, method : 'POST',queryParameters: requestBody,isAuthorize: true);
    return parseResponse<ResponseModel>(response,ResponseModel.fromJson);
  }
  Future<ResponseModel>  logout() async {
    final response = await _apiClient.request(
        path: Url.logout, method : 'POST',isAuthorize: true);
    return parseResponse<ResponseModel>(response,ResponseModel.fromJson);
  }
  Future<CountriesModel> getAllCountries() async {
    final response = await _apiClient.request(
        path: Url.allCountries, method : 'GET',isAuthorize: true);
    return parseResponse<CountriesModel>(response,CountriesModel.fromJson);

  }
  Future<RegionsModel> getAllRegions(String countryId) async {
    final Map<String, dynamic> requestBody = {
      'country_id':countryId};
    final response = await _apiClient.request(
        path: Url.allRegions, method : 'GET',queryParameters: requestBody,isAuthorize: true);
    return parseResponse<RegionsModel>(response,RegionsModel.fromJson);

  }
  Future<CitiesModel> getAllCities(String countryId,String regionId) async {
    final Map<String, dynamic> requestBody = {
      'country_id':countryId,
      'region_id':regionId,
    };
    final response = await _apiClient.request(
        path: Url.allCities, method : 'GET',queryParameters: requestBody,isAuthorize: true);
    return parseResponse<CitiesModel>(response,CitiesModel.fromJson);
  }
}