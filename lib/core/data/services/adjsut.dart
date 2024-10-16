import 'package:adjust_sdk/adjust.dart';
import 'package:adjust_sdk/adjust_config.dart';
import 'package:adjust_sdk/adjust_event.dart';
import 'package:masaj/core/data/di/injector.dart';
import 'package:masaj/features/book_service/data/models/booking_query_model.dart';

class AdjustTracker {
  static void initialize(String appToken) {
    AdjustConfig config = AdjustConfig(appToken, AdjustEnvironment.production);
    Adjust.initSdk(config);
  }

  static void trackRegistrationInitiated() {
    try {
      final AdjustEvent event = AdjustEvent('registration_initiated');
      Adjust.trackEvent(event);
    } catch (e) {
      print('Error: $e');
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
      print(e);
    }
  }

  static void trackGuestRegistration() {
    try {
      final AdjustEvent event = AdjustEvent('guest_registration');
      Adjust.trackEvent(event);
    } catch (e) {
      print(e);
    }
  }

  static void trackLogin() {
    try {
      final AdjustEvent event = AdjustEvent('login');
      Adjust.trackEvent(event);
    } catch (e) {
      print(e);
    }
  }

  static void trackSearchService(String query) {
    try {
      final AdjustEvent event = AdjustEvent('search_service');
      event.addCallbackParameter('query', query);
      Adjust.trackEvent(event);
    } catch (e) {
      print(e);
    }
  }

  static void trackViewListing(String serviceType) {
    try {
      final AdjustEvent event = AdjustEvent('view_listing');
      event.addCallbackParameter('service_type', serviceType);
      Adjust.trackEvent(event);
    } catch (e) {
      print(e);
    }
  }

  static void trackViewProduct(String serviceName) {
    try {
      final AdjustEvent event = AdjustEvent('view_product');
      event.addCallbackParameter('service_name', serviceName);
      Adjust.trackEvent(event);
    } catch (e) {
      print(e);
    }
  }

  static void trackAddToWishlist(String serviceName) {
    try {
      final AdjustEvent event = AdjustEvent('add_to_wishlist');
      event.addCallbackParameter('service_name', serviceName);
      Adjust.trackEvent(event);
    } catch (e) {
      print(e);
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
      print(e);
    }
  }

  static void trackAddToBasket(String serviceName, String duration) {
    try {
      final AdjustEvent event = AdjustEvent('add_to_basket');
      event.addCallbackParameter('service_name', serviceName);

      // event.addCallbackParameter('duration', duration);
      Adjust.trackEvent(event);
    } catch (e) {
      print(e);
    }
  }

  static Future<void> trackFirstSale() async {
    try {
      final bookingsRpository = Injector().bookingRepository;
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
      print(e);
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
      print(e);
    }
  }
}
