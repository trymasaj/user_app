import 'package:adjust_sdk/adjust.dart';
import 'package:adjust_sdk/adjust_config.dart';
import 'package:adjust_sdk/adjust_event.dart';
import 'package:masaj/core/data/di/di_wrapper.dart';
import 'package:masaj/core/data/logger/abs_logger.dart';
import 'package:masaj/features/book_service/data/models/booking_query_model.dart';
import 'package:masaj/features/book_service/data/repositories/booking_repository.dart';

class AdjustTracker {

  // AbsLogger _logger;
  // AdjustTracker(this._logger);

  static void initialize(String appToken) {
    AdjustConfig config = AdjustConfig(appToken, AdjustEnvironment.production);
    Adjust.initSdk(config);
  }

  static void trackRegistrationInitiated() {
    try {
      final AdjustEvent event = AdjustEvent('registration_initiated');
      Adjust.trackEvent(event);
    } catch (e) {
      DI.find<AbsLogger>().error('Adjust.trackRegistrationInitiated()' ,e);
    }
  }

  static void trackRegistrationCompleted(Map<String, dynamic> userDetails) {
    try {
      final AdjustEvent event = AdjustEvent('registration_completed');
      userDetails.forEach((key, value) {
        event.addCallbackParameter(key, value.toString());
      });
      Adjust.trackEvent(event);
    } catch (e) {
      DI.find<AbsLogger>().error('Adjust.trackRegistrationCompleted($userDetails)' ,e);
    }
  }

  static void trackGuestRegistration() {
    try {
      final AdjustEvent event = AdjustEvent('guest_registration');
      Adjust.trackEvent(event);
    } catch (e) {
      DI.find<AbsLogger>().error('Adjust.trackGuestRegistration()' ,e);
    }
  }

  static void trackLogin() {
    try {
      final AdjustEvent event = AdjustEvent('login');
      Adjust.trackEvent(event);
    } catch (e) {
      DI.find<AbsLogger>().error('Adjust.trackLogin()' ,e);
    }
  }

  static void trackSearchService(String query) {
    try {
      final AdjustEvent event = AdjustEvent('search_service');
      event.addCallbackParameter('query', query);
      Adjust.trackEvent(event);
    } catch (e) {
      DI.find<AbsLogger>().error('Adjust.trackSearchService($query)' ,e);
    }
  }

  static void trackViewListing(String serviceType) {
    try {
      final AdjustEvent event = AdjustEvent('view_listing');
      event.addCallbackParameter('service_type', serviceType);
      Adjust.trackEvent(event);
    } catch (e) {
      DI.find<AbsLogger>().error('Adjust.trackViewListing($serviceType)' ,e);
    }
  }

  static void trackViewProduct(String serviceName) {
    try {
      final AdjustEvent event = AdjustEvent('view_product');
      event.addCallbackParameter('service_name', serviceName);
      Adjust.trackEvent(event);
    } catch (e) {
      DI.find<AbsLogger>().error('Adjust.trackViewProduct($serviceName)' ,e);
    }
  }

  static void trackAddToWishlist(String serviceName) {
    try {
      final AdjustEvent event = AdjustEvent('add_to_wishlist');
      event.addCallbackParameter('service_name', serviceName);
      Adjust.trackEvent(event);
    } catch (e) {
      DI.find<AbsLogger>().error('Adjust.trackAddToWishlist($serviceName)' ,e);
    }
  }

  static void trackDurationSelected(
      {required String duration, required String serviceName}) {
    try {
      final AdjustEvent event = AdjustEvent('duration_selected');
      event.addCallbackParameter(
        'duration',
        duration,
      );
      event.addCallbackParameter('service_name', serviceName);
      Adjust.trackEvent(event);
    } catch (e) {
      DI.find<AbsLogger>().error('Adjust.trackDurationSelected($serviceName, $duration)' ,e);
    }
  }

  static void trackAddToBasket(String serviceName, String duration) {
    try {
      final AdjustEvent event = AdjustEvent('add_to_basket');
      event.addCallbackParameter('service_name', serviceName);

      // event.addCallbackParameter('duration', duration);
      Adjust.trackEvent(event);
    } catch (e) {
      DI.find<AbsLogger>().error('Adjust.trackAddToBasket($serviceName, $duration)' ,e);
    }
  }

  static Future<void> trackFirstSale() async {
    try {
      final bookingsRpository = DI.find<BookingRepository>();
      final bookingStreaks =
          await bookingsRpository.getBookingList(BookingQueryModel(
        status: BookingQueryStatus.completed,
        page: 1,
        pageSize: 1,
      ));
      if ((bookingStreaks.data ?? []).isNotEmpty) return;
      final AdjustEvent event = AdjustEvent('first_sale');
      Adjust.trackEvent(event);
    } catch (e) {
      DI.find<AbsLogger>().error('Adjust.trackFirstSale()' ,e);
    }
  }

  static void trackCheckoutSuccess(
    double revenue,
  ) {
    try {
      final AdjustEvent event = AdjustEvent('checkout_success');
      event.setRevenue(revenue, 'KWD');
      Adjust.trackEvent(event);
    } catch (e) {
      DI.find<AbsLogger>().error('Adjust.trackCheckoutSuccess($revenue)' ,e);
    }
  }
}
