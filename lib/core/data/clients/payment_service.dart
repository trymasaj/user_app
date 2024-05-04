// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:masaj/core/data/constants/api_end_point.dart';
import 'package:masaj/core/domain/enums/request_result_enum.dart';
import 'package:masaj/core/domain/exceptions/request_exception.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';
import 'package:masaj/main.dart';
import 'network_service.dart';

abstract class PaymentService {
  Future<void> buy(PaymentParam paymentParam);
}

class PaymentServiceImpl implements PaymentService {
  const PaymentServiceImpl(this._networkService);
  final NetworkService _networkService;
  @override
  Future<void> buy(PaymentParam paymentParm) async {
    if (paymentParm.paymentMethodId == null)
      throw Exception('paymentMethod is null');
    final url = await getPaymentSessionUrl(paymentParm.paymentMethodId!,
        params: paymentParm.params, urlPath: paymentParm.urlPath);
    final isPaymentSuccess =
        await _goToPaymentPage(url, paymentParm.customAppBar);
    if (isPaymentSuccess == null) return;
    if (isPaymentSuccess != false) return paymentParm.onSuccess();

    paymentParm.onFailure();
  }

  Future<String> getPaymentSessionUrl(int paymentMethodId,
      {Map<String, dynamic>? params, String? urlPath}) {
    final url = urlPath ?? ApiEndPoint.BOOKING_CONFIRM;

    final data = params ??
        {
          'paymentMethod': paymentMethodId,
        };

    return _networkService.post(url, data: data).then(
      (response) {
        if (response.statusCode != 200)
          throw RequestException(message: response.data['detail']);
        final result = response.data;
        final resultStatus = result['result'];
        if (resultStatus == RequestResult.Failed.name)
          throw RequestException(message: result['msg']);
        return result['threeDSecureUrl'];
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
      child: Scaffold(
        appBar: CustomAppBar(title: 'payment'),
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
    final isSuccess = urlString.contains('success=true');
    final isFailed = urlString.contains('success=false');
    if (isSuccess || isFailed) Navigator.of(context).pop(isSuccess);
  }
}

class PaymentParam {
  PaymentParam({
    this.orderId,
    this.params,
    this.urlPath,
    this.paymentMethodId,
    required this.onSuccess,
    required this.onFailure,
    this.customAppBar,
  });
  final int? paymentMethodId;
  final int? orderId;
  final void Function() onSuccess;
  final void Function() onFailure;
  final Widget? customAppBar;
  final Map<String, dynamic>? params;
  final String? urlPath;

  @override
  bool operator ==(covariant PaymentParam other) {
    if (identical(this, other)) return true;

    return other.paymentMethodId == paymentMethodId &&
        other.onSuccess == onSuccess &&
        other.onFailure == onFailure &&
        other.customAppBar == customAppBar &&
        other.orderId == orderId;
  }

  @override
  int get hashCode {
    return paymentMethodId.hashCode ^
        onSuccess.hashCode ^
        onFailure.hashCode ^
        orderId.hashCode ^
        customAppBar.hashCode;
  }
}
