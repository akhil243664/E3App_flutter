import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @about_us.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get about_us;

  /// No description provided for @account_settings.
  ///
  /// In en, this message translates to:
  /// **'Account Settings'**
  String get account_settings;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @take_picture.
  ///
  /// In en, this message translates to:
  /// **'Take Picture'**
  String get take_picture;

  /// No description provided for @image_from_gallery.
  ///
  /// In en, this message translates to:
  /// **'Image from Gallery'**
  String get image_from_gallery;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @full_name.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get full_name;

  /// No description provided for @email_address.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get email_address;

  /// No description provided for @mobile_number.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get mobile_number;

  /// No description provided for @save_changes.
  ///
  /// In en, this message translates to:
  /// **'SAVE CHANGES'**
  String get save_changes;

  /// No description provided for @bank_transfer_redeem.
  ///
  /// In en, this message translates to:
  /// **'Bank Transfer Redeem'**
  String get bank_transfer_redeem;

  /// No description provided for @account_details.
  ///
  /// In en, this message translates to:
  /// **'Account Details'**
  String get account_details;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'edit'**
  String get edit;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'add'**
  String get add;

  /// No description provided for @holder_name.
  ///
  /// In en, this message translates to:
  /// **'Holder Name:'**
  String get holder_name;

  /// No description provided for @account_no.
  ///
  /// In en, this message translates to:
  /// **'Account No.'**
  String get account_no;

  /// No description provided for @bank_name.
  ///
  /// In en, this message translates to:
  /// **'Bank Name:'**
  String get bank_name;

  /// No description provided for @ifsc_code.
  ///
  /// In en, this message translates to:
  /// **'IFSC Code:'**
  String get ifsc_code;

  /// No description provided for @send_withdrawal_request.
  ///
  /// In en, this message translates to:
  /// **'Send Withdrawal Request'**
  String get send_withdrawal_request;

  /// No description provided for @add_complaint.
  ///
  /// In en, this message translates to:
  /// **'Add Complaint'**
  String get add_complaint;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'SUBMIT'**
  String get submit;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @purchase.
  ///
  /// In en, this message translates to:
  /// **'Purchase'**
  String get purchase;

  /// No description provided for @cashback_tracks_in.
  ///
  /// In en, this message translates to:
  /// **'Cashback tracks in'**
  String get cashback_tracks_in;

  /// No description provided for @see_more_offers.
  ///
  /// In en, this message translates to:
  /// **'See More Offers'**
  String get see_more_offers;

  /// No description provided for @all_categories.
  ///
  /// In en, this message translates to:
  /// **'All Categories'**
  String get all_categories;

  /// No description provided for @amazon_pay_redeem.
  ///
  /// In en, this message translates to:
  /// **'Amazon Pay Redeem'**
  String get amazon_pay_redeem;

  /// No description provided for @add_amazon_account.
  ///
  /// In en, this message translates to:
  /// **'Add Amazon Account'**
  String get add_amazon_account;

  /// No description provided for @phone_no.
  ///
  /// In en, this message translates to:
  /// **'Phone No.'**
  String get phone_no;

  /// No description provided for @all_in_one_search.
  ///
  /// In en, this message translates to:
  /// **'All in one search'**
  String get all_in_one_search;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'SAVE'**
  String get save;

  /// No description provided for @add_new_tab.
  ///
  /// In en, this message translates to:
  /// **'ADD NEW TAB'**
  String get add_new_tab;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @recents_clicks.
  ///
  /// In en, this message translates to:
  /// **'Recents Clicks'**
  String get recents_clicks;

  /// No description provided for @recent_click.
  ///
  /// In en, this message translates to:
  /// **'Recent Click'**
  String get recent_click;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @bottom_allInOne.
  ///
  /// In en, this message translates to:
  /// **'All in one\n Search'**
  String get bottom_allInOne;

  /// No description provided for @earn_cashback.
  ///
  /// In en, this message translates to:
  /// **'EARN CASHBACK'**
  String get earn_cashback;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @primary_color.
  ///
  /// In en, this message translates to:
  /// **'Primary Color'**
  String get primary_color;

  /// No description provided for @secondary_color.
  ///
  /// In en, this message translates to:
  /// **'Secondary Color'**
  String get secondary_color;

  /// No description provided for @color_shade.
  ///
  /// In en, this message translates to:
  /// **'color shade'**
  String get color_shade;

  /// No description provided for @deal_ends_in.
  ///
  /// In en, this message translates to:
  /// **'Deal ends in:'**
  String get deal_ends_in;

  /// No description provided for @use_code.
  ///
  /// In en, this message translates to:
  /// **'Use Code'**
  String get use_code;

  /// No description provided for @copy_code.
  ///
  /// In en, this message translates to:
  /// **'Copy Code'**
  String get copy_code;

  /// No description provided for @about_this_coupon.
  ///
  /// In en, this message translates to:
  /// **'About this Coupon'**
  String get about_this_coupon;

  /// No description provided for @coupons_of_the_day.
  ///
  /// In en, this message translates to:
  /// **'Coupons of the day'**
  String get coupons_of_the_day;

  /// No description provided for @faqs.
  ///
  /// In en, this message translates to:
  /// **'FAQs'**
  String get faqs;

  /// No description provided for @message_us.
  ///
  /// In en, this message translates to:
  /// **'Message Us'**
  String get message_us;

  /// No description provided for @powered_by.
  ///
  /// In en, this message translates to:
  /// **'Powered by Freshdesk'**
  String get powered_by;

  /// No description provided for @get_help.
  ///
  /// In en, this message translates to:
  /// **'Get Help'**
  String get get_help;

  /// No description provided for @login_or_signup.
  ///
  /// In en, this message translates to:
  /// **'LOG IN OR SIGN UP'**
  String get login_or_signup;

  /// No description provided for @see_how_to.
  ///
  /// In en, this message translates to:
  /// **'See How To'**
  String get see_how_to;

  /// No description provided for @total_earning.
  ///
  /// In en, this message translates to:
  /// **'Total Earnings'**
  String get total_earning;

  /// No description provided for @rewards.
  ///
  /// In en, this message translates to:
  /// **'Rewards'**
  String get rewards;

  /// No description provided for @top_categories.
  ///
  /// In en, this message translates to:
  /// **'TOP CATEGORIES'**
  String get top_categories;

  /// No description provided for @view_all.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get view_all;

  /// No description provided for @exclusive_offers.
  ///
  /// In en, this message translates to:
  /// **'EXCLUSIVE OFFERS FOR YOU'**
  String get exclusive_offers;

  /// No description provided for @top_cashback_stores.
  ///
  /// In en, this message translates to:
  /// **'TOP CASHBACK STORES'**
  String get top_cashback_stores;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login or signup'**
  String get login;

  /// No description provided for @login_subtitle.
  ///
  /// In en, this message translates to:
  /// **'We will send a SMS to verify'**
  String get login_subtitle;

  /// No description provided for @conti.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get conti;

  /// No description provided for @order_complaints.
  ///
  /// In en, this message translates to:
  /// **'Order Complaints'**
  String get order_complaints;

  /// No description provided for @complaint.
  ///
  /// In en, this message translates to:
  /// **'Complaint'**
  String get complaint;

  /// No description provided for @reply.
  ///
  /// In en, this message translates to:
  /// **'Reply'**
  String get reply;

  /// No description provided for @add_complaint_title.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have any Complaint'**
  String get add_complaint_title;

  /// No description provided for @add_complaint_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Add any Complaint ?'**
  String get add_complaint_subtitle;

  /// No description provided for @my_earnings.
  ///
  /// In en, this message translates to:
  /// **'My Earnings'**
  String get my_earnings;

  /// No description provided for @my_earnings_subtitile.
  ///
  /// In en, this message translates to:
  /// **'Earning will show here within 24 hours of your shopping via'**
  String get my_earnings_subtitile;

  /// No description provided for @my_order_details.
  ///
  /// In en, this message translates to:
  /// **'My Order Details'**
  String get my_order_details;

  /// No description provided for @view_more.
  ///
  /// In en, this message translates to:
  /// **'View More'**
  String get view_more;

  /// No description provided for @request_paymets.
  ///
  /// In en, this message translates to:
  /// **'Request Payments'**
  String get request_paymets;

  /// No description provided for @my_orders.
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get my_orders;

  /// No description provided for @raise_complaint.
  ///
  /// In en, this message translates to:
  /// **'Raise Complaint'**
  String get raise_complaint;

  /// No description provided for @shopping.
  ///
  /// In en, this message translates to:
  /// **'Shopping'**
  String get shopping;

  /// No description provided for @orders_title.
  ///
  /// In en, this message translates to:
  /// **'There is where it all happens!'**
  String get orders_title;

  /// No description provided for @see_best_deals.
  ///
  /// In en, this message translates to:
  /// **'SEE BEST DEALS'**
  String get see_best_deals;

  /// No description provided for @otp_title.
  ///
  /// In en, this message translates to:
  /// **'Enter 6 digit code we have sent you'**
  String get otp_title;

  /// No description provided for @otp_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Code sent to'**
  String get otp_subtitle;

  /// No description provided for @otp_not_receive.
  ///
  /// In en, this message translates to:
  /// **'Haven\'t receive the OTP?'**
  String get otp_not_receive;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// No description provided for @payment_history.
  ///
  /// In en, this message translates to:
  /// **'Payment History'**
  String get payment_history;

  /// No description provided for @no_data_found.
  ///
  /// In en, this message translates to:
  /// **'No data found'**
  String get no_data_found;

  /// No description provided for @payments.
  ///
  /// In en, this message translates to:
  /// **'Payments'**
  String get payments;

  /// No description provided for @payTM_redeem.
  ///
  /// In en, this message translates to:
  /// **'PayTM Redeem'**
  String get payTM_redeem;

  /// No description provided for @add_payTM_account.
  ///
  /// In en, this message translates to:
  /// **'Add PayTM Account'**
  String get add_payTM_account;

  /// No description provided for @privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacy_policy;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @approved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get approved;

  /// No description provided for @redeemed.
  ///
  /// In en, this message translates to:
  /// **'Redeemed'**
  String get redeemed;

  /// No description provided for @rate_us.
  ///
  /// In en, this message translates to:
  /// **'Rate us'**
  String get rate_us;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @logout_desc.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout ?'**
  String get logout_desc;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @profile_desc.
  ///
  /// In en, this message translates to:
  /// **'Sign up or login to get exclusive Coupons & extras Cashback on all your online shopping'**
  String get profile_desc;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @delete_desc_click.
  ///
  /// In en, this message translates to:
  /// **'Are you sure, You want to delete clicks older than 10 days ?'**
  String get delete_desc_click;

  /// No description provided for @did_you_shop_on.
  ///
  /// In en, this message translates to:
  /// **'Did you shop on'**
  String get did_you_shop_on;

  /// No description provided for @yes_i_did.
  ///
  /// In en, this message translates to:
  /// **'Yes I Did'**
  String get yes_i_did;

  /// No description provided for @click_title.
  ///
  /// In en, this message translates to:
  /// **'Don\'t stop, just shop!'**
  String get click_title;

  /// No description provided for @cashback_status.
  ///
  /// In en, this message translates to:
  /// **'Cashback Status'**
  String get cashback_status;

  /// No description provided for @remaining_earning.
  ///
  /// In en, this message translates to:
  /// **'Remaining Earning'**
  String get remaining_earning;

  /// No description provided for @successful_withdrawal.
  ///
  /// In en, this message translates to:
  /// **'Successful Withdrawal'**
  String get successful_withdrawal;

  /// No description provided for @redeem.
  ///
  /// In en, this message translates to:
  /// **'Redeem'**
  String get redeem;

  /// No description provided for @amazon_pay.
  ///
  /// In en, this message translates to:
  /// **'Amazon Pay'**
  String get amazon_pay;

  /// No description provided for @payTM.
  ///
  /// In en, this message translates to:
  /// **'PayTM'**
  String get payTM;

  /// No description provided for @upi.
  ///
  /// In en, this message translates to:
  /// **'UPI'**
  String get upi;

  /// No description provided for @bank_transfer.
  ///
  /// In en, this message translates to:
  /// **'Bank Transfer'**
  String get bank_transfer;

  /// No description provided for @tnc.
  ///
  /// In en, this message translates to:
  /// **'Terms & Condition'**
  String get tnc;

  /// No description provided for @upi_redeem.
  ///
  /// In en, this message translates to:
  /// **'Upi Redeem'**
  String get upi_redeem;

  /// No description provided for @paypal_redeem.
  ///
  /// In en, this message translates to:
  /// **'PayPal Redeem'**
  String get paypal_redeem;

  /// No description provided for @paypal_email.
  ///
  /// In en, this message translates to:
  /// **'PayPal Email:'**
  String get paypal_email;

  /// No description provided for @upi_account_add.
  ///
  /// In en, this message translates to:
  /// **'Add Upi Account'**
  String get upi_account_add;

  /// No description provided for @paypal_account_add.
  ///
  /// In en, this message translates to:
  /// **'Add PayPal Account'**
  String get paypal_account_add;

  /// No description provided for @upi_address.
  ///
  /// In en, this message translates to:
  /// **'UPI address:'**
  String get upi_address;

  /// No description provided for @coupon.
  ///
  /// In en, this message translates to:
  /// **'Coupon'**
  String get coupon;

  /// No description provided for @what_next.
  ///
  /// In en, this message translates to:
  /// **'What\'s Next'**
  String get what_next;

  /// No description provided for @see_more.
  ///
  /// In en, this message translates to:
  /// **'See more'**
  String get see_more;

  /// No description provided for @add_bank_account.
  ///
  /// In en, this message translates to:
  /// **'Add Bank Account'**
  String get add_bank_account;

  /// No description provided for @my_account.
  ///
  /// In en, this message translates to:
  /// **'My Account'**
  String get my_account;

  /// No description provided for @redeem_cashback.
  ///
  /// In en, this message translates to:
  /// **'Redeem Cashback'**
  String get redeem_cashback;

  /// No description provided for @share_the_app.
  ///
  /// In en, this message translates to:
  /// **'Share The App'**
  String get share_the_app;

  /// No description provided for @rate_the_app.
  ///
  /// In en, this message translates to:
  /// **'Rate the App'**
  String get rate_the_app;

  /// No description provided for @paypal.
  ///
  /// In en, this message translates to:
  /// **'PayPal'**
  String get paypal;

  /// No description provided for @refer_earn.
  ///
  /// In en, this message translates to:
  /// **'Refer & Earn'**
  String get refer_earn;

  /// No description provided for @refer_earn_desc.
  ///
  /// In en, this message translates to:
  /// **'Invite friends & earn flat 10% of their Cashback amount, EVERYTIME they shop!'**
  String get refer_earn_desc;

  /// No description provided for @reffral_link.
  ///
  /// In en, this message translates to:
  /// **'Your Referal Link'**
  String get reffral_link;

  /// No description provided for @tap_to_copy.
  ///
  /// In en, this message translates to:
  /// **'Tap to Copy'**
  String get tap_to_copy;

  /// No description provided for @my_referrals.
  ///
  /// In en, this message translates to:
  /// **'My Referrals'**
  String get my_referrals;

  /// No description provided for @invite_now.
  ///
  /// In en, this message translates to:
  /// **'Invite Now'**
  String get invite_now;

  /// No description provided for @access_feature.
  ///
  /// In en, this message translates to:
  /// **'To access this feature, download the app'**
  String get access_feature;

  /// No description provided for @download_app.
  ///
  /// In en, this message translates to:
  /// **'Download The App'**
  String get download_app;

  /// No description provided for @exit_app.
  ///
  /// In en, this message translates to:
  /// **'Back press again to exit from app'**
  String get exit_app;

  /// No description provided for @code_not_required.
  ///
  /// In en, this message translates to:
  /// **'Coupon code not required'**
  String get code_not_required;

  /// No description provided for @login_apple.
  ///
  /// In en, this message translates to:
  /// **'Login with Apple'**
  String get login_apple;

  /// No description provided for @login_google.
  ///
  /// In en, this message translates to:
  /// **'Login with Google'**
  String get login_google;

  /// No description provided for @login_phone.
  ///
  /// In en, this message translates to:
  /// **'Login with Phone'**
  String get login_phone;

  /// No description provided for @login_email.
  ///
  /// In en, this message translates to:
  /// **'Login with Email'**
  String get login_email;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'skip'**
  String get skip;

  /// No description provided for @latest_product.
  ///
  /// In en, this message translates to:
  /// **'LATEST PRODUCTS'**
  String get latest_product;

  /// No description provided for @price_compared.
  ///
  /// In en, this message translates to:
  /// **'Price Compared '**
  String get price_compared;

  /// No description provided for @new_flash_deals.
  ///
  /// In en, this message translates to:
  /// **'NEW FLASH DEALS - LIVE NOW'**
  String get new_flash_deals;

  /// No description provided for @trending_products.
  ///
  /// In en, this message translates to:
  /// **'TRENDING PRODUCTS'**
  String get trending_products;

  /// No description provided for @no_offers_available.
  ///
  /// In en, this message translates to:
  /// **'No offers available in your country.'**
  String get no_offers_available;

  /// No description provided for @earning_desc.
  ///
  /// In en, this message translates to:
  /// **'Your total eanings and amount includes your Cashback + Rewards + Refferal amount.'**
  String get earning_desc;

  /// No description provided for @choose_best_price.
  ///
  /// In en, this message translates to:
  /// **'Choose Best Price'**
  String get choose_best_price;

  /// No description provided for @grab_now.
  ///
  /// In en, this message translates to:
  /// **'Grab Now'**
  String get grab_now;

  /// No description provided for @seller_price.
  ///
  /// In en, this message translates to:
  /// **'Seller price'**
  String get seller_price;

  /// No description provided for @this_is_best_price.
  ///
  /// In en, this message translates to:
  /// **'This is the best Price'**
  String get this_is_best_price;

  /// No description provided for @referral_network.
  ///
  /// In en, this message translates to:
  /// **'Referral Network'**
  String get referral_network;

  /// No description provided for @total_referral.
  ///
  /// In en, this message translates to:
  /// **'Total Referral'**
  String get total_referral;

  /// No description provided for @cashback_earned.
  ///
  /// In en, this message translates to:
  /// **'Cashback Earned'**
  String get cashback_earned;

  /// No description provided for @friends_joined.
  ///
  /// In en, this message translates to:
  /// **'Friends Joined'**
  String get friends_joined;

  /// No description provided for @no_referral_earnings.
  ///
  /// In en, this message translates to:
  /// **'There is no Refferal Earnings'**
  String get no_referral_earnings;

  /// No description provided for @in_stores.
  ///
  /// In en, this message translates to:
  /// **'in Stores'**
  String get in_stores;

  /// No description provided for @in_offers_deals.
  ///
  /// In en, this message translates to:
  /// **'in Offers & Deals'**
  String get in_offers_deals;

  /// No description provided for @trending_keyword.
  ///
  /// In en, this message translates to:
  /// **'Trending Keywords'**
  String get trending_keyword;

  /// No description provided for @no_more_offers.
  ///
  /// In en, this message translates to:
  /// **'No More Offers'**
  String get no_more_offers;

  /// No description provided for @quick_links.
  ///
  /// In en, this message translates to:
  /// **'Quick Links'**
  String get quick_links;

  /// No description provided for @get_it_on.
  ///
  /// In en, this message translates to:
  /// **'Get it on'**
  String get get_it_on;

  /// No description provided for @contact_us.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contact_us;

  /// No description provided for @how_it_works.
  ///
  /// In en, this message translates to:
  /// **'How It Works'**
  String get how_it_works;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
