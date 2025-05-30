// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Blog`
  String get blogTitle {
    return Intl.message('Blog', name: 'blogTitle', desc: '', args: []);
  }

  /// `Read More`
  String get readMore {
    return Intl.message('Read More', name: 'readMore', desc: '', args: []);
  }

  /// `Modern Chair`
  String get modernChair {
    return Intl.message(
      'Modern Chair',
      name: 'modernChair',
      desc: '',
      args: [],
    );
  }

  /// `Modern TV Stand`
  String get modernTVStand {
    return Intl.message(
      'Modern TV Stand',
      name: 'modernTVStand',
      desc: '',
      args: [],
    );
  }

  /// `Nice modern design`
  String get niceModernDesign {
    return Intl.message(
      'Nice modern design',
      name: 'niceModernDesign',
      desc: '',
      args: [],
    );
  }

  /// `Elegant black marble finish`
  String get elegantBlackFinish {
    return Intl.message(
      'Elegant black marble finish',
      name: 'elegantBlackFinish',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get contactUs {
    return Intl.message('Contact Us', name: 'contactUs', desc: '', args: []);
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Subject`
  String get subject {
    return Intl.message('Subject', name: 'subject', desc: '', args: []);
  }

  /// `Send`
  String get send {
    return Intl.message('Send', name: 'send', desc: '', args: []);
  }

  /// `About Us`
  String get aboutUs {
    return Intl.message('About Us', name: 'aboutUs', desc: '', args: []);
  }

  /// `At Furniture, we specialize in offering designer pieces that bring style and comfort to your home. Our collection features a curated selection of timeless and contemporary furniture that fits every taste and lifestyle. From cozy sofas to elegant dining tables, each piece is crafted with quality and care in mind.`
  String get aboutDescription {
    return Intl.message(
      'At Furniture, we specialize in offering designer pieces that bring style and comfort to your home. Our collection features a curated selection of timeless and contemporary furniture that fits every taste and lifestyle. From cozy sofas to elegant dining tables, each piece is crafted with quality and care in mind.',
      name: 'aboutDescription',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Dark Theme`
  String get darkTheme {
    return Intl.message('Dark Theme', name: 'darkTheme', desc: '', args: []);
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `Arabic`
  String get arabic {
    return Intl.message('Arabic', name: 'arabic', desc: '', args: []);
  }

  /// `by {author}`
  String byAuthor(Object author) {
    return Intl.message(
      'by $author',
      name: 'byAuthor',
      desc: '',
      args: [author],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Email Address`
  String get emailAddress {
    return Intl.message(
      'Email Address',
      name: 'emailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Forgot Password`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `LOG IN`
  String get logIn {
    return Intl.message('LOG IN', name: 'logIn', desc: '', args: []);
  }

  /// `Don't have an account?`
  String get dontHaveAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message('Success', name: 'success', desc: '', args: []);
  }

  /// `Email and password cannot be empty`
  String get emptyFields {
    return Intl.message(
      'Email and password cannot be empty',
      name: 'emptyFields',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email format`
  String get invalidEmail {
    return Intl.message(
      'Invalid email format',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters`
  String get shortPassword {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'shortPassword',
      desc: '',
      args: [],
    );
  }

  /// `Login Successful`
  String get loginSuccess {
    return Intl.message(
      'Login Successful',
      name: 'loginSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Best Price`
  String get bestPrice {
    return Intl.message('Best Price', name: 'bestPrice', desc: '', args: []);
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message('Sign Up', name: 'signUp', desc: '', args: []);
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Shop`
  String get shop {
    return Intl.message('Shop', name: 'shop', desc: '', args: []);
  }

  /// `Wishlist`
  String get wishlist {
    return Intl.message('Wishlist', name: 'wishlist', desc: '', args: []);
  }

  /// `Cart`
  String get cart {
    return Intl.message('Cart', name: 'cart', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `About Us`
  String get aboutTitle {
    return Intl.message('About Us', name: 'aboutTitle', desc: '', args: []);
  }

  /// `At ℂ𝑜𝓏𝘺𝐾𝓪𝕣𝘵, we specialize in offering designer pieces that bring style and comfort to your home. Our collection features a curated selection of timeless and contemporary furniture that fits every taste and lifestyle. From cozy sofas to elegant dining tables, each piece is crafted with quality and care in mind.`
  String get aboutParagraph {
    return Intl.message(
      'At ℂ𝑜𝓏𝘺𝐾𝓪𝕣𝘵, we specialize in offering designer pieces that bring style and comfort to your home. Our collection features a curated selection of timeless and contemporary furniture that fits every taste and lifestyle. From cozy sofas to elegant dining tables, each piece is crafted with quality and care in mind.',
      name: 'aboutParagraph',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `RESET PASSWORD`
  String get resetPassword {
    return Intl.message(
      'RESET PASSWORD',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email address to reset your password`
  String get enterEmailToReset {
    return Intl.message(
      'Enter your email address to reset your password',
      name: 'enterEmailToReset',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullNameEn {
    return Intl.message('Full Name', name: 'fullNameEn', desc: '', args: []);
  }

  /// `Full Name (Arabic)`
  String get fullNameAr {
    return Intl.message(
      'Full Name (Arabic)',
      name: 'fullNameAr',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message('Register', name: 'register', desc: '', args: []);
  }

  /// `All fields are required`
  String get allFieldsRequired {
    return Intl.message(
      'All fields are required',
      name: 'allFieldsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message('Full Name', name: 'fullName', desc: '', args: []);
  }

  /// `Account created successfully. Please login.`
  String get registerSuccess {
    return Intl.message(
      'Account created successfully. Please login.',
      name: 'registerSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordMismatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordMismatch',
      desc: '',
      args: [],
    );
  }

  /// `Your cart is empty`
  String get cartEmpty {
    return Intl.message(
      'Your cart is empty',
      name: 'cartEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Removed from cart`
  String get removedFromCart {
    return Intl.message(
      'Removed from cart',
      name: 'removedFromCart',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get totalAmount {
    return Intl.message('Total', name: 'totalAmount', desc: '', args: []);
  }

  /// `Checkout with PayPal`
  String get checkoutWithPaypal {
    return Intl.message(
      'Checkout with PayPal',
      name: 'checkoutWithPaypal',
      desc: '',
      args: [],
    );
  }

  /// `Find your perfect furniture for your home`
  String get splashTitle {
    return Intl.message(
      'Find your perfect furniture for your home',
      name: 'splashTitle',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get getStarted {
    return Intl.message('Get Started', name: 'getStarted', desc: '', args: []);
  }

  /// `Please fill all fields`
  String get fillAllFields {
    return Intl.message(
      'Please fill all fields',
      name: 'fillAllFields',
      desc: '',
      args: [],
    );
  }

  /// `Email sent successfully`
  String get emailSentSuccess {
    return Intl.message(
      'Email sent successfully',
      name: 'emailSentSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Failed to send email`
  String get emailSendFail {
    return Intl.message(
      'Failed to send email',
      name: 'emailSendFail',
      desc: '',
      args: [],
    );
  }

  /// `Add To Cart`
  String get addToCart {
    return Intl.message('Add To Cart', name: 'addToCart', desc: '', args: []);
  }

  /// `Search products...`
  String get searchProducts {
    return Intl.message(
      'Search products...',
      name: 'searchProducts',
      desc: '',
      args: [],
    );
  }

  /// `Added to cart`
  String get addedToCart {
    return Intl.message(
      'Added to cart',
      name: 'addedToCart',
      desc: '',
      args: [],
    );
  }

  /// `Already in cart`
  String get alreadyInCart {
    return Intl.message(
      'Already in cart',
      name: 'alreadyInCart',
      desc: '',
      args: [],
    );
  }

  /// `Description:`
  String get description {
    return Intl.message(
      'Description:',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Added to Wishlist`
  String get addedToWishlist {
    return Intl.message(
      'Added to Wishlist',
      name: 'addedToWishlist',
      desc: '',
      args: [],
    );
  }

  /// `Removed from Wishlist`
  String get removedFromWishlist {
    return Intl.message(
      'Removed from Wishlist',
      name: 'removedFromWishlist',
      desc: '',
      args: [],
    );
  }

  /// `Your wishlist is empty`
  String get wishlistEmpty {
    return Intl.message(
      'Your wishlist is empty',
      name: 'wishlistEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Checkout with PayPal`
  String get checkoutWithPayPal {
    return Intl.message(
      'Checkout with PayPal',
      name: 'checkoutWithPayPal',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message('Total', name: 'total', desc: '', args: []);
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Privacy`
  String get privacy {
    return Intl.message('Privacy', name: 'privacy', desc: '', args: []);
  }

  /// `Help`
  String get help {
    return Intl.message('Help', name: 'help', desc: '', args: []);
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `User not found`
  String get userNotFound {
    return Intl.message(
      'User not found',
      name: 'userNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfileTitle {
    return Intl.message(
      'Edit Profile',
      name: 'editProfileTitle',
      desc: '',
      args: [],
    );
  }

  /// `Name (EN)`
  String get nameEnHint {
    return Intl.message('Name (EN)', name: 'nameEnHint', desc: '', args: []);
  }

  /// `Name (AR)`
  String get nameArHint {
    return Intl.message('Name (AR)', name: 'nameArHint', desc: '', args: []);
  }

  /// `New Password (optional)`
  String get newPasswordHint {
    return Intl.message(
      'New Password (optional)',
      name: 'newPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Please fill in name fields`
  String get pleaseFillNames {
    return Intl.message(
      'Please fill in name fields',
      name: 'pleaseFillNames',
      desc: '',
      args: [],
    );
  }

  /// `Profile updated successfully`
  String get profileUpdated {
    return Intl.message(
      'Profile updated successfully',
      name: 'profileUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Please fill in name fields`
  String get pleaseFillNameFields {
    return Intl.message(
      'Please fill in name fields',
      name: 'pleaseFillNameFields',
      desc: '',
      args: [],
    );
  }

  /// `Name (EN)`
  String get nameEn {
    return Intl.message('Name (EN)', name: 'nameEn', desc: '', args: []);
  }

  /// `Name (AR)`
  String get nameAr {
    return Intl.message('Name (AR)', name: 'nameAr', desc: '', args: []);
  }

  /// `New Password (optional)`
  String get newPasswordOptional {
    return Intl.message(
      'New Password (optional)',
      name: 'newPasswordOptional',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyTitle {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyTitle',
      desc: '',
      args: [],
    );
  }

  /// `This is the privacy policy of the app. Your personal data will be safe and secure. We never share your information with any third parties without your consent. By using our app, you agree to our terms and privacy rules.`
  String get privacyContent {
    return Intl.message(
      'This is the privacy policy of the app. Your personal data will be safe and secure. We never share your information with any third parties without your consent. By using our app, you agree to our terms and privacy rules.',
      name: 'privacyContent',
      desc: '',
      args: [],
    );
  }

  /// `Help & Support`
  String get helpTitle {
    return Intl.message(
      'Help & Support',
      name: 'helpTitle',
      desc: '',
      args: [],
    );
  }

  /// `If you have any questions or issues, feel free to contact our support team. We are available 24/7 to assist you with any problems related to the app usage.`
  String get helpContent {
    return Intl.message(
      'If you have any questions or issues, feel free to contact our support team. We are available 24/7 to assist you with any problems related to the app usage.',
      name: 'helpContent',
      desc: '',
      args: [],
    );
  }

  /// `PayPal Checkout`
  String get paypalCheckout {
    return Intl.message(
      'PayPal Checkout',
      name: 'paypalCheckout',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message('Quantity', name: 'quantity', desc: '', args: []);
  }

  /// `EGP`
  String get egp {
    return Intl.message('EGP', name: 'egp', desc: '', args: []);
  }

  /// `Error:`
  String get errorPrefix {
    return Intl.message('Error:', name: 'errorPrefix', desc: '', args: []);
  }

  /// `Your cart is empty 🛒`
  String get yourCartIsEmpty {
    return Intl.message(
      'Your cart is empty 🛒',
      name: 'yourCartIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Switch Language`
  String get switchLanguage {
    return Intl.message(
      'Switch Language',
      name: 'switchLanguage',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
