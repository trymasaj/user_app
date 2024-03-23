// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:masaj/core/data/constants/api_end_point.dart';
import 'package:masaj/core/domain/enums/payment_methods.dart';
import 'package:masaj/core/domain/enums/request_result_enum.dart';
import 'package:masaj/core/domain/exceptions/request_exception.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';
import 'package:masaj/main.dart';
import 'network_service.dart';

abstract class PaymentService {
  Future<void> buy(PaymentParam paymentParam);
}

class PayMobPaymentService implements PaymentService {
  const PayMobPaymentService(this._networkService);
  final NetworkService _networkService;
  @override
  Future<void> buy(PaymentParam paymentParm) async {
    if (paymentParm.paymentMethod == null || paymentParm.orderId == null)
      throw Exception('paymentMethod is null');
    final url = await getPaymentSessionUrl(
        paymentParm.paymentMethod!, paymentParm.orderId!,
        params: paymentParm.params, urlPath: paymentParm.urlPath);
    final isPaymentSuccess =
        await _goToPaymentPage(url, paymentParm.customAppBar);
    if (isPaymentSuccess == null) return;
    if (isPaymentSuccess != false) return paymentParm.onSuccess();

    paymentParm.onFailure();
  }

  Future<String> getPaymentSessionUrl(PaymentMethodEnum paymentMethod, int id,
      {Map<String, dynamic>? params, String? urlPath}) {
    final url = urlPath ?? ApiEndPoint.CHECKOUT;

    final param = params ??
        {
          'id': id,
          'paymentId': paymentMethod.index,
        };

    return _networkService.post(url, queryParameters: param).then(
      (response) {
        if (response.statusCode != 200)
          throw RequestException(message: response.data);
        final result = response.data;
        final resultStatus = result['result'];
        if (resultStatus == RequestResult.Failed.name)
          throw RequestException(message: result['msg']);
        return result['data'];
      },
    );
  }

  Future<bool?> _goToPaymentPage(
    String url,
    Widget? customAppBar,
  ) {
    return navigatorKey.currentState!.push<bool?>(MaterialPageRoute(
        builder: (_) => createPaymentPage(url, customAppBar)));
  }

  static final Map<String, _PaymentPage> _cache = {};
  static String _generateCacheKey(String url, Widget? customAppBar) =>
      '$url-${customAppBar?.hashCode ?? 0}';

  static Widget createPaymentPage(String url, Widget? customAppBar) {
    final key = _generateCacheKey(url, customAppBar);
    if (_cache.containsKey(key))
      return _cache[key]!;
    else {
      final widget = _PaymentPage(url: url, customAppBar: customAppBar);
      _cache[key] = widget;
      return widget;
    }
  }
}

class _PaymentPage extends StatelessWidget {
  const _PaymentPage({
    required this.url,
    this.customAppBar,
  });

  final String url;
  final Widget? customAppBar;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return CustomAppPage(
      child: Column(children: [
        if (customAppBar != null) ...[
          const SizedBox(height: 48.0),
          customAppBar!,
          const SizedBox(height: 12.0),
        ],
        Expanded(
          child: InAppWebView(
            initialUrlRequest: URLRequest(url: Uri.parse(url)),
            onUpdateVisitedHistory: (_, url, __) => _handleUrl(context, url),
          ),
        )
      ]),
    );
  }

  void _handleUrl(BuildContext context, Uri? url) {
    log('url hist: $url');
    final urlString = url.toString();
    final isSuccess = urlString.contains('Success');
    final isFailed = urlString.contains('Failed');
    if (isSuccess || isFailed) Navigator.of(context).pop(isSuccess);
  }
}

class PaymentParam {
  PaymentParam({
    this.orderId,
    this.params,
    this.urlPath,
    this.paymentMethod,
    required this.onSuccess,
    required this.onFailure,
    this.customAppBar,
  });
  final PaymentMethodEnum? paymentMethod;
  final int? orderId;
  final void Function() onSuccess;
  final void Function() onFailure;
  final Widget? customAppBar;
  final Map<String, dynamic>? params;
  final String? urlPath;

  @override
  bool operator ==(covariant PaymentParam other) {
    if (identical(this, other)) return true;

    return other.paymentMethod == paymentMethod &&
        other.onSuccess == onSuccess &&
        other.onFailure == onFailure &&
        other.customAppBar == customAppBar &&
        other.orderId == orderId;
  }

  @override
  int get hashCode {
    return paymentMethod.hashCode ^
        onSuccess.hashCode ^
        onFailure.hashCode ^
        orderId.hashCode ^
        customAppBar.hashCode;
  }
}
