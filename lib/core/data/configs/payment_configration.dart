// Copyright 2024 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     https://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/// This file contain sample payment configurations that can be used with the
/// payment providers in this library.
///
/// Although payment configurations can be hardcoded in your application source
/// (as displayed in this example), we recommend you to keep this information in
/// a remote location that can be accessed from your application (e.g.: a
/// backend server). That way, you benefit from being able to use multiple
/// payment configurations that can be modified without the need to update your
/// application.
library;

/// Sample configuration for Apple Pay. Contains the same content as the file
/// under `assets/default_payment_profile_apple_pay.json`.
String defaultApplePay({
  required String currency,
  required String countryCode,
}) =>
    '''{
  "provider": "apple_pay",
  "data": {
    "merchantIdentifier": "merchant.com.sams.fish",
    "displayName": "masaj session",
    "merchantCapabilities": ["3DS", "debit", "credit"],
    "supportedNetworks": ["amex", "visa", "discover", "masterCard"],
    "countryCode": "$countryCode",
    "currencyCode": "$currency",
    "requiredBillingContactFields": ["emailAddress", "name", "phoneNumber", "postalAddress"],
    "requiredShippingContactFields": [],
    "shippingMethods": [
     
    ]
  }
}''';
