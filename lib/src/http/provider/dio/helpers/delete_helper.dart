import 'package:dio/dio.dart';
import 'package:network/src/endpoint/endpoint.dart';
import 'package:network/src/http/provider/dio/helpers/request_helper.dart';
import 'package:network/src/http/provider/dio/helpers/response_type_dio_helper.dart';
import 'package:network/src/response/network_response.dart';

class DeleteHelper implements RequestHelper {
  final _contentTypeHelper = ContentTypeDioResponse();

  @override
  Future<NetworkResponse> makeRequestHelper({
    required Endpoint endpoint,
    required Dio httpProvider,
  }) async {
    final Response<dynamic> response = await httpProvider.delete<dynamic>(
      endpoint.path,
      data: endpoint.parameters,
      queryParameters: endpoint.queryParameters,
      options: Options(
        headers: <String, dynamic>{
          ...httpProvider.options.headers,
          ...endpoint.headers ?? {},
        },
        responseType:
            _contentTypeHelper.getDioResponseType(endpoint.responseType),
      ),
    );
    return NetworkResponse(
      data: response.data,
      status: response.statusCode,
    );
  }
}
