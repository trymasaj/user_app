import 'package:masaj/main.dart';

abstract class ApiEndPoint {
  static const BASE_URL = BUILD_TYPE == BuildType.release
      ? 'https://stagingapi.trymasaj.com/masaj'
      : 'https://stagingapi.trymasaj.com/masaj';

  static const _REQUEST_URL = '$BASE_URL/api/v1';

  static const _TICKETMX_API_URL =
  BUILD_TYPE == BuildType.release ? 'https://api.ticketmx.com' : 'https://devapi.ticketmx.com';

  static const TICKETMX_WEB_URL =
  BUILD_TYPE == BuildType.release ? 'https://ticketmx.com' : 'https://dev.ticketmx.com';

  //Auth
  static const SIGN_UP = '$BASE_URL/Identity/register';
  static const UPDATE_PROFILE_INFORMATION = '$BASE_URL/Identity/update-profile';
  // home
  static const HOME = '$BASE_URL/home';

  static const VERIFY_OTP = '$BASE_URL/Identity/verify-otp';
  // resend otp
  static const RESEND_OTP = '$BASE_URL/Identity/resend-otp';
  static const CONFIRM_REGISTRATION = '$_REQUEST_URL/confirmregistration';
  static const LOGIN = '$BASE_URL/Identity/login';
  static const EXTERNAL_LOGIN = '$BASE_URL/Identity/login/social';
  static const APPLE_REDIRECT_URL = '$BASE_URL/callbacks/sign_in_with_apple';
  static const FORGET_PASSWORD = '$BASE_URL/Identity/forget-password';
  // VERIFY_FORGET_PASSWORD
  static const VERIFY_FORGET_PASSWORD =
      '$BASE_URL/Identity/verify-forget-password';
  //RESET_PASSWORD
  static const RESET_PASSWORD = '$BASE_URL/Identity/reset-password';
  static const CHANGE_PHONE = '$BASE_URL/Identity/change-phone';
  static const VERIFY_CHANGE_PHONE = '$BASE_URL/Identity/verify-change-phone';
  static const REFRESH_TOKEN = '$_REQUEST_URL/refresh';
  static const LOGOUT = '$_REQUEST_URL/revoke';
  static const ABOUT_US_DETAILS = '$_REQUEST_URL/getaboutus';
  static const CHANGE_PASSWORD = '$BASE_URL/identity/reset-password';
  static const USER_INFO = '$_REQUEST_URL/userinfo';
  static const EDIT_USER_INFO = '$BASE_URL/identity/update-profile';
  static const UPDATE_USER_LANGUAGE = '$_REQUEST_URL/updateuserlanguage';
  static const GET_INTERESTS = '$_REQUEST_URL/getInterests';
  static const EDIT_USER_INTERESTS = '$_REQUEST_URL/edituserinterests';
  static const CHECK_EMAIL_VERIFIED = '$_REQUEST_URL/checkemailverified';
  static const RESEND_VERIFICATION_EMAIL =
      '$_REQUEST_URL/resendverificationemail';
  static const GET_AVAILABLE_PROJECTS = '$_REQUEST_URL/getprojects';
  static const SELECT_PROJECT = '$_REQUEST_URL/selectproject';
  static const UPDATE_USER_NOTIFICATION =
      '$_REQUEST_URL/updateusernotification';

  //Home
  static const GET_HOME_PAGE_DATA = '$_REQUEST_URL/homepage';
  static const CHECK_TREASURE_HUNT_CODE = '$_REQUEST_URL/scanqrcode';
  static const GET_HOME_SEARCH = '$_REQUEST_URL/homesearch';
  static const GET_HOME_NOTIFICATIONS = '$_REQUEST_URL/usernotification';
  static const GET_COUNTRIES = '$BASE_URL/Countries';
  static const GET_CITIES = '$BASE_URL/Countries/cities';
  static const ADDRESS = '$BASE_URL/customer-address';

  //Zones
  static const GET_ZONES = '$_REQUEST_URL/getzones';
  static const GET_ZONE_DETAILS = '$_REQUEST_URL/getzonedetails';
  static const GET_ZONE_EVENTS = '$_REQUEST_URL/getevents';
  static const GET_ZONE_MAP = '$_REQUEST_URL/zonemap';

  //Events
  static const GET_EVENT_DETAILS = '$_REQUEST_URL/geteventdetails';
  static const GET_FILTRATION_DATA = '$_REQUEST_URL/geteventsfilterdata';
  static const GET_EVENTS_CALENDAR = '$_REQUEST_URL/geteventscalendar';
  static const GET_EVENTS_SECTION_DETAILS =
      '$_REQUEST_URL/geteventssectiondetails';
  static const INFORM_EVENT_SHARE = '$_REQUEST_URL/shareevent';
  static const SUBMIT_QUIZ = '$BASE_URL/Identity/submit-quiz';

  //Other
  static const TOPICS_DATA = '$_REQUEST_URL/block';
  static const CONTACT_US = '$_REQUEST_URL/contactus';
  static const GUIDE_PAGE = '$_REQUEST_URL/guidepage';
  static const FAVORITES = '$_REQUEST_URL/userfavorites';
  static const ADD_OR_REMOVE_FAV = '$_REQUEST_URL/updateuserfavorite';
  static const EXTERNAL_SECTION = '$_REQUEST_URL/getexternalsections';
  static const ALL_COUPON = '$_REQUEST_URL/getcoupons';
  static const GET_COUPON_DETAILS = '$_REQUEST_URL/getcoupon';
  static const GET_COUPON_CODE = '$_REQUEST_URL/getusercouponcode';
  static const REDEEMED_COUPON = '$_REQUEST_URL/usercoupons';
  static const REDEEM_COUPON = '$_REQUEST_URL/buycoupon';
  static const SCAN_TREASURE = '$_REQUEST_URL/scanqrcode';
  static const GET_USER_POINTS = '$_REQUEST_URL/getuserpointhistory';
  static const GET_MORE_USER_POINTS = '$_REQUEST_URL/userpointhistory';
  static const DELETE_ACCOUNT = '$BASE_URL/identity';

  //TicketMX
  static const CHECK_TICKETMX_TOKEN = '$_TICKETMX_API_URL/checktoken';
  static const ORDERS = '$_TICKETMX_API_URL/orders';
  static const TICKETS = '$_TICKETMX_API_URL/tickets';
  static const TICKET_PASSBOOK = '$TICKETMX_WEB_URL/api/v1/ticketpassbook';
  // service categories
  static const SERVICE_CATEGORIES = '$BASE_URL/service-category';
  // services
  static const SERVICES = '$BASE_URL/services';
  static const SERVICES_RECOMMENDED = '$SERVICES/recommended';
  static const SERVICES_OFFERS = '$SERVICES/offers';
  // banners
  static const BANNERS = '$BASE_URL/banners';
  // therapists
  static const Therapists = '$BASE_URL/therapists';
  static const RECOMMENDED_THERAPISTS = '$Therapists/recommended';
  // add or remove favorite therapists
  static const FAV_THERAPISTS = '$Therapists/favourite';
  static const AVAILABLE_THERAPISTS = '$Therapists/available-therapists';

  // home
  static const HOME_SEARCH = '$BASE_URL/home/search';
  //Member
  static const ADD_MEMBER = '$BASE_URL/member';
  static const GET_MEMBERS = '$BASE_URL/member';
  static const GET_MEMBER = '$BASE_URL/member';
  static const UPDATE_MEMBER = '$BASE_URL/member';
  static const DELETE_MEMBER = '$BASE_URL/member';

  //Booking
  static const BOOKING = '$BASE_URL/bookings';
  static const BOOKING_LATEST = '$BASE_URL/bookings/latest';
  static const BOOKING_ADDRESS = '$BASE_URL/bookings/address';
  static const BOOKING_SERVICE = '$BASE_URL/bookings/service';
  static const BOOKING_MEMBERS = '$BASE_URL/bookings/members';
  static const BOOKING_THERAPIST = '$BASE_URL/bookings/therapist';
  static const BOOKING_DETAILS = '$BASE_URL/bookings/';
  static const GET_BOOKING_STREAKS = '$BASE_URL/bookings/booking-streak';

  static const BOOKING_ADD_VOUCHER = '$BASE_URL/bookings/voucher';
  static const BOOKING_REMOVE_VOUCHER = '$BASE_URL/bookings/remove-voucher';
  //Payment
  static const BOOKING_CONFIRM = '$BASE_URL/bookings/confirm';
  static const GET_PAYMENT_METHODS = '$BASE_URL/payments/methods';

  //giftCards
  static const GET_GIFT_CARDS = '$BASE_URL/gift-cards';
  static const GET_PURCHASED_GIFT_CARDS = '$BASE_URL/gift-cards/purchased';
  static const BUY_GIFT_CARD = '$BASE_URL/gift-cards/purchase/';
  static const REDEEM_GIFT_CARDS = '$BASE_URL/gift-cards/redeem';
  //Wallet
  static const GET_WALLET_BALANCE = '$BASE_URL/wallet';
  static const CHARGE_WALLET = '$BASE_URL/wallet';
  static const GET_PREDEFINED_WALLET = '$BASE_URL/wallet/predefined';
  // Medical Form
  static const MEDICAL_FORM = '$BASE_URL/medical-form';
  static const MEDICAL_CONDITION = '$BASE_URL/medical-form/conditions';
  // membership
  static const MEMBERSHIP = '$BASE_URL/subscription';
  static const MEMBERSHIP_PLANS = '$BASE_URL/plan';
  static const MESSAGES = '$BASE_URL/messages';
}
