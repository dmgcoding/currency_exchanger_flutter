import 'package:currency_converter/core/api/dio/dio_client.dart';
import 'package:currency_converter/core/api/paths.dart';
import 'package:currency_converter/core/config/app_config.dart';
import 'package:currency_converter/core/exceptions/base_exception.dart';
import 'package:currency_converter/src/domain/models/conversion_rates_res.dart';
import 'package:dio/dio.dart';

class CurrencyService {
  final _dioClient = DioClient();
  Dio get _dio => _dioClient.dio;

  //fetching currency map
  Future<ConversionRatesRes> fetchConversionRates() async {
    try {
      final apiKey = AppConfig.exchangeRateApiKey;
      const currencyCode = 'USD';
      final response =
          await _dio.get(ExchangeRateApi.fetchRates(apiKey, currencyCode));
      return ConversionRatesRes.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (dioError) {
      throw BaseException(
        dioError.response?.data['error-type'] as String? ?? '',
      );
    } catch (e) {
      throw BaseException(e.toString());
    }
  }
}
