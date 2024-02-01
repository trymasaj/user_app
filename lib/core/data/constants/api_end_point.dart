import 'package:masaj/main.dart';

abstract class ApiEndPoint {
  static const BASE_URL = isRelease
      ? 'https://stagingapi.trymasaj.com/masaj'
      : 'https://stagingapi.trymasaj.com/masaj';

  static const _REQUEST_URL = '$BASE_URL/api/v1';

  static const _TICKETMX_API_URL =
      isRelease ? 'https://api.ticketmx.com' : 'https://devapi.ticketmx.com';

  static const TICKETMX_WEB_URL =
      isRelease ? 'https://ticketmx.com' : 'https://dev.ticketmx.com';

  //Auth
  static const SIGN_UP = '$BASE_URL/Identity/register';
  static const UPDATE_PROFILE_INFORMATION = '$BASE_URL/Identity/update-profile';

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
  static const REFRESH_TOKEN = '$_REQUEST_URL/refresh';
  static const LOGOUT = '$_REQUEST_URL/revoke';
  static const ABOUT_US_DETAILS = '$_REQUEST_URL/getaboutus';
  static const CHANGE_PASSWORD = '$_REQUEST_URL/changepassword';
  static const USER_INFO = '$_REQUEST_URL/userinfo';
  static const EDIT_USER_INFO = '$_REQUEST_URL/edituserinfo';
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

  //TicketMX
  static const CHECK_TICKETMX_TOKEN = '$_TICKETMX_API_URL/checktoken';
  static const ORDERS = '$_TICKETMX_API_URL/orders';
  static const TICKETS = '$_TICKETMX_API_URL/tickets';
  static const TICKET_PASSBOOK = '$TICKETMX_WEB_URL/api/v1/ticketpassbook';
}
