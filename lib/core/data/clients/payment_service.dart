// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/configs/payment_configration.dart';
import 'package:masaj/core/data/constants/api_end_point.dart';
import 'package:masaj/core/domain/enums/request_result_enum.dart';
import 'package:masaj/core/domain/exceptions/request_exception.dart';
import 'package:masaj/core/presentation/overlay/show_snack_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';
import 'package:masaj/main.dart';
import 'package:pay/pay.dart';
import 'network_service.dart';

abstract class PaymentService {
  Future<void> buy(PaymentParam paymentParam);
  Future<void> buyWithApple({
    required PaymentParam paymentType,
  });
}

class PaymentServiceImpl implements PaymentService {
  const PaymentServiceImpl(this._networkService);
  final NetworkService _networkService;
  @override
  Future<void> buy(PaymentParam paymentParm) async {
    if (paymentParm.paymentMethodId == null)
      throw Exception('paymentMethod is null');

    if (paymentParm.paymentMethodId == 3)
      return buyWithApple(paymentType: paymentParm);
    final url = await getPaymentSessionUrl(paymentParm.paymentMethodId!,
        params: paymentParm.params, urlPath: paymentParm.urlPath);
    if (url == '') {
      return paymentParm.onSuccess();
    }
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
        if (result['isThreeDSecure']) {
          return result['threeDSecureUrl'];
        } else {
          return '';
        }
      },
    );
  }

  Future<bool> getApplePaymentConfirm(int paymentMethodId,
      {Map<String, dynamic>? params, String? urlPath}) {
    final url = urlPath ?? ApiEndPoint.BOOKING_CONFIRM;

    final data = params ??
        {
          'paymentMethod': paymentMethodId,
        };

    return _networkService.post(url, data: data).then(
      (response) {
        if (response.statusCode != 200) return false;
        final result = response.data;
        final resultStatus = result['result'];
        if (resultStatus == RequestResult.Failed.name) return false;

        return true;
      },
    );
  }

  Future<bool?> _goToPaymentPage(
    String url,
    Widget? customAppBar,
  ) {
    return navigatorKey.currentState!.pushReplacement<bool?, bool?>(
        MaterialPageRoute(
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

  @override
  Future<void> buyWithApple({
    required PaymentParam paymentType,
  }) async {
    String? token;
    if (paymentType.price == null) throw Exception('please add a price');
    final paymentConfiguration = getUpdatedApplePayConfig(
      currencyCode: paymentType.currency,
      countryCode: paymentType.countryCode,
    );
    final applePayClient = Pay({
      PayProvider.apple_pay: PaymentConfiguration.fromJsonString(
        paymentConfiguration,
      ),
    });
    final priceAfterWallet = paymentType.fromWallet == true
        ? paymentType.price! - (paymentType.walletBalance ?? 0)
        : paymentType.price!;
    if (priceAfterWallet >= 0) {
      final paymentItems = _getPaymentItems(priceAfterWallet);
      final userCanPay = await applePayClient.userCanPay(PayProvider.apple_pay);
      if (!userCanPay) {
        final context = navigatorKey.currentState!.context;
        showSnackBar(context,
            message: 'Apple pay not supported on this device');
        return;
      }
      final result = await applePayClient.showPaymentSelector(
        PayProvider.apple_pay,
        paymentItems,
      );
      token = result.toString();
    }
    //Delay 1 second till the bottom sheet is closed to avoid any UI exception
    await Future.delayed(const Duration(seconds: 1));

    navigatorKey.currentState!.context.loaderOverlay.show();
    final isSuccesses = await getApplePaymentConfirm(
      paymentType.paymentMethodId ?? 3,
      urlPath: paymentType.urlPath,
      params: paymentType.params?..putIfAbsent('applePayToken', () => token),
    );
    try {
      if (isSuccesses) {
        paymentType.onSuccess.call();
      } else {
        paymentType.onFailure.call();
      }
    } catch (e) {
      log(e.toString());
      paymentType.onFailure.call();
    } finally {
      navigatorKey.currentState!.context.loaderOverlay.hide();
    }
  }

  List<PaymentItem> _getPaymentItems(num price) {
    return [
      PaymentItem(
        label: 'Total',
        amount: price.toString(),
        status: PaymentItemStatus.final_price,
      ),
    ];
  }
}

class _PaymentPage extends StatefulWidget {
  const _PaymentPage({
    required this.url,
    this.customAppBar,
  });
  final String url;
  final Widget? customAppBar;

  @override
  State<_PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<_PaymentPage> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        appBar: const CustomAppBar(title: 'payment'),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return CustomAppPage(
      child: Column(children: [
        if (widget.customAppBar != null) ...[
          const SizedBox(height: 48.0),
          widget.customAppBar!,
          const SizedBox(height: 12.0),
        ],
        Expanded(
          child: Stack(
            children: [
              InAppWebView(
                initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
                onUpdateVisitedHistory: (_, url, __) =>
                    _handleUrl(context, url),
                onLoadStop: (finish, _) {
                  setState(() {
                    isLoading = false;
                  });
                },
              ),
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : const Stack(),
            ],
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
    this.price,
    this.countryCode,
    this.currency,
    this.walletAmount,
    this.fromWallet,
    this.walletBalance,
  });
  final int? paymentMethodId;
  final int? orderId;
  final void Function() onSuccess;
  final void Function() onFailure;
  final Widget? customAppBar;
  final Map<String, dynamic>? params;
  final String? urlPath;
  final num? price;
  final String? currency;
  final String? countryCode;
  final bool? fromWallet;
  final double? walletAmount;
  final double? walletBalance;

  @override
  bool operator ==(covariant PaymentParam other) {
    if (identical(this, other)) return true;

    return other.paymentMethodId == paymentMethodId &&
        other.onSuccess == onSuccess &&
        other.onFailure == onFailure &&
        other.customAppBar == customAppBar &&
        other.orderId == orderId &&
        other.urlPath == urlPath &&
        other.price == price &&
        other.currency == currency &&
        other.walletAmount == walletAmount &&
        other.walletBalance == walletBalance &&
        other.params == params;
  }

  @override
  int get hashCode {
    return paymentMethodId.hashCode ^
        onSuccess.hashCode ^
        onFailure.hashCode ^
        orderId.hashCode ^
        params.hashCode ^
        walletBalance.hashCode ^
        walletAmount.hashCode ^
        currency.hashCode ^
        price.hashCode ^
        urlPath.hashCode;
  }
}
