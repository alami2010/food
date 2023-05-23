<?php
/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\v1\Auth\AuthController;
use App\Http\Controllers\v1\Auth\RegisterController;
use App\Http\Controllers\v1\Auth\ForgotPasswordController;
use App\Http\Controllers\v1\Auth\ResetPasswordController;
use App\Http\Controllers\v1\Auth\VerifyAccountController;
use App\Http\Controllers\v1\Profile\ProfileController;
use App\Http\Controllers\v1\Auth\LogoutController;
use App\Http\Controllers\v1\CitiesController;
use App\Http\Controllers\v1\MasterCategoriesController;
use App\Http\Controllers\v1\PagesController;
use App\Http\Controllers\v1\MediasController;
use App\Http\Controllers\v1\SettingsController;
use App\Http\Controllers\v1\GeneralController;
use App\Http\Controllers\v1\StoresController;
use App\Http\Controllers\v1\CommissionsController;
use App\Http\Controllers\v1\ReferralController;
use App\Http\Controllers\v1\LanguageController;
use App\Http\Controllers\v1\ReferralCodesController;
use App\Http\Controllers\v1\StoresCategoriesController;
use App\Http\Controllers\v1\ProductsController;
use App\Http\Controllers\v1\BannersController;
use App\Http\Controllers\v1\AddressController;
use App\Http\Controllers\v1\PaymentsController;
use App\Http\Controllers\v1\OffersController;
use App\Http\Controllers\v1\OrdersController;
use App\Http\Controllers\v1\PaytmPayController;
use App\Http\Controllers\v1\TableBookingController;
use App\Http\Controllers\v1\ContactsController;
use App\Http\Controllers\v1\BlogsController;
use App\Http\Controllers\v1\ComplaintsController;
use App\Http\Controllers\v1\RatingsController;
use App\Http\Controllers\v1\OtpController;
use App\Http\Controllers\v1\ChatRoomsController;
use App\Http\Controllers\v1\ConversionsController;
use App\Http\Controllers\v1\FavouritesController;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::get('/', function () {
    return [
        'app' => 'FoodWorlds API',
        'version' => '1.0.0',
    ];
});

Route::prefix('/v1')->group(function () {
    Route::group(['namespace' => 'Auth'], function () {
        Route::post('auth/login', [AuthController::class, 'login']);
        Route::post('auth/loginWithPhonePassword', [AuthController::class, 'loginWithPhonePassword']);
        Route::post('auth/store_login', [AuthController::class, 'store_login']);
        Route::post('auth/create_account', [RegisterController::class, 'register']);
        Route::post('auth/create_admin_account', [RegisterController::class, 'create_admin_account']);
        Route::post('auth/verifyEmailForReset', [AuthController::class, 'verifyEmailForReset']);
        Route::get('users/get_admin', [ProfileController::class, 'get_admin']);
        Route::get('auth/firebaseauth', [AuthController::class, 'firebaseauth']);
        Route::post('uploadImage', [ProfileController::class, 'uploadImage']);
        Route::post('auth/loginWithMobileOtp', [AuthController::class, 'loginWithMobileOtp']);
    });

    // Main Admin Routes
    Route::group(['middleware' => ['admin_auth', 'jwt.auth']], function () {
        Route::post('auth/admin_logout', [LogoutController::class, 'logout']);

        Route::get('auth/getMyAccount', [ProfileController::class, 'me']);
        Route::get('home/getAdminDashboard', [OrdersController::class, 'getAdminDashboard']);
        Route::post('drivers/create', [RegisterController::class, 'create_driver_account']);
        Route::get('drivers/getAll', [ProfileController::class, 'getAllDriver']);
        Route::get('users/getAll', [ProfileController::class, 'getAllUser']);
        Route::post('drivers/update', [ProfileController::class, 'update']);
        Route::post('drivers/destroy', [ProfileController::class, 'destroy_driver']);

        Route::post('auth/create_store_account', [RegisterController::class, 'create_store_account']);
        Route::post('store/create_store_account', [StoresController::class, 'save']);
        Route::get('store/getStores', [StoresController::class, 'getStores']);
        Route::post('store/getStoresWithCityId', [StoresController::class, 'getStoresWithCityId']);
        Route::post('commission/save', [CommissionsController::class, 'save']);
        Route::post('store/getById', [StoresController::class, 'getById']);
        Route::post('store/updateStatus', [StoresController::class, 'updateStatus']);
        Route::post('store/updateInfo', [StoresController::class, 'updateInfo']);
        Route::post('commission/updateCommission', [CommissionsController::class, 'updateCommission']);

        Route::get('referral/getAll', [ReferralController::class, 'getAll']);
        Route::post('referral/save', [ReferralController::class, 'save']);
        Route::post('referral/update', [ReferralController::class, 'update']);

        // Cities Routes
        Route::get('cities/getAll', [CitiesController::class, 'getAll']);
        Route::post('cities/create', [CitiesController::class, 'save']);
        Route::post('cities/update', [CitiesController::class, 'update']);
        Route::post('cities/destroy', [CitiesController::class, 'delete']);
        Route::post('cities/getById', [CitiesController::class, 'getById']);

        // Categories Routes
        Route::get('categories/getAll', [MasterCategoriesController::class, 'getAll']);
        Route::post('categories/create', [MasterCategoriesController::class, 'save']);
        Route::post('categories/update', [MasterCategoriesController::class, 'update']);
        Route::post('categories/destroy', [MasterCategoriesController::class, 'delete']);
        Route::post('categories/getById', [MasterCategoriesController::class, 'getById']);

        // Blogs Routes
        Route::get('blogs/getAll', [BlogsController::class, 'getAll']);
        Route::post('blogs/create', [BlogsController::class, 'save']);
        Route::post('blogs/update', [BlogsController::class, 'update']);
        Route::post('blogs/destroy', [BlogsController::class, 'delete']);
        Route::post('blogs/getById', [BlogsController::class, 'getById']);

        // Pages Routes
        Route::post('pages/getById', [PagesController::class, 'getById']);
        Route::get('pages/getAll', [PagesController::class, 'getAllPages']);
        Route::post('pages/update', [PagesController::class, 'update']);

        // Medias Routes
        Route::post('medias/create', [MediasController::class, 'save']);
        Route::post('medias/getById', [MediasController::class, 'getById']);
        Route::post('medias/update', [MediasController::class, 'update']);
        Route::post('medias/destroy', [MediasController::class, 'delete']);
        Route::get('medias/getAll', [MediasController::class, 'getAll']);

        // Settings Routes
        Route::post('setttings/save',[SettingsController::class, 'save'] );
        Route::post('setttings/getById', [SettingsController::class, 'getById']);
        Route::get('setttings/getAll', [SettingsController::class, 'getAll']);
        Route::get('setttings/getSettingsForOwner',[SettingsController::class, 'getSettingsForOwner'] );
        Route::post('setttings/update', [SettingsController::class, 'update']);
        Route::post('setttings/delete', [SettingsController::class, 'delete']);

        // General Routes
        Route::post('general/save',[GeneralController::class, 'save'] );
        Route::post('general/getById', [GeneralController::class, 'getById']);
        Route::get('general/getAll', [GeneralController::class, 'getAll']);
        Route::post('general/update', [GeneralController::class, 'update']);
        Route::post('general/delete', [GeneralController::class, 'delete']);

        // Language Routes
        Route::post('languages/create', [LanguageController::class,'save']);
        Route::post('languages/update', [LanguageController::class,'update']);
        Route::post('languages/delete', [LanguageController::class,'delete']);
        Route::post('languages/getById', [LanguageController::class,'getById']);
        Route::post('languages/changeDefault', [LanguageController::class,'changeDefault']);
        Route::get('languages/getAll', [LanguageController::class,'getAll']);


        // Banners Routes
        Route::post('banners/save',[BannersController::class, 'save'] );
        Route::post('banners/getById', [BannersController::class, 'getById']);
        Route::post('banners/getInfoById', [BannersController::class, 'getInfoById']);
        Route::get('banners/getAll', [BannersController::class, 'getAll']);
        Route::post('banners/update', [BannersController::class, 'update']);
        Route::post('banners/destroy', [BannersController::class, 'delete']);


        // Admin Routes For Payments
        Route::post('payments/paytmRefund',[PaytmPayController::class, 'refundUserRequest']);
        Route::post('payments/paytmRefund',[PaytmPayController::class, 'refundUserRequest']);
        Route::post('payments/getById', [PaymentsController::class, 'getById']);
        Route::post('payments/getPaymentInfo', [PaymentsController::class, 'getPaymentInfo']);
        Route::get('payments/getAll', [PaymentsController::class, 'getAll']);
        Route::post('payments/update', [PaymentsController::class, 'update']);
        Route::post('payments/delete', [PaymentsController::class, 'delete']);
        Route::post('payments/refundFlutterwave', [PaymentsController::class, 'refundFlutterwave']);
        Route::post('payments/payPalRefund', [PaymentsController::class, 'payPalRefund']);
        Route::post('payments/refundPayStack',[PaymentsController::class, 'refundPayStack']);
        Route::post('payments/razorPayRefund',[PaymentsController::class, 'razorPayRefund']);
        Route::post('payments/refundStripePayments',[PaymentsController::class, 'refundStripePayments']);
        Route::post('payments/instaMOJORefund',[PaymentsController::class, 'instaMOJORefund']);

        // Offers Routes //

        Route::get('offers/getAll', [OffersController::class, 'getAll']);
        Route::get('offers/getStores', [OffersController::class, 'getStores']);
        Route::post('offers/create', [OffersController::class, 'save']);
        Route::post('offers/update', [OffersController::class, 'update']);
        Route::post('offers/destroy', [OffersController::class, 'delete']);
        Route::post('offers/getById', [OffersController::class, 'getById']);
        Route::post('offers/updateStatus', [OffersController::class, 'updateStatus']);

        Route::get('contacts/getAll',[ContactsController::class, 'getAll'] );
        Route::post('contacts/update',[ContactsController::class, 'update'] );
        Route::post('mails/replyContactForm',[ContactsController::class, 'replyContactForm']);

        Route::get('foods/getAllFoodList', [ProductsController::class,'getAllFoodList']);
        Route::post('foods-admin/updateStatus', [ProductsController::class,'update']);

        // Complaints Routes
        Route::get('complaints/getAll',[ComplaintsController::class, 'getAll'] );
        Route::post('complaints/update',[ComplaintsController::class, 'update'] );
        Route::post('complaints/replyContactForm',[ComplaintsController::class, 'replyContactForm']);

        Route::get('users/admins', [ProfileController::class, 'admins']);
        Route::post('users/deleteUser', [ProfileController::class, 'delete']);
        Route::post('users/adminNewAdmin', [RegisterController::class, 'adminNewAdmin']);

        Route::post('sendNoficationGlobal', [ProfileController::class, 'sendNoficationGlobal']);
        Route::post('notification/sendToAllUsers', [ProfileController::class, 'sendToAllUsers']);
        Route::post('notification/sendToUsers', [ProfileController::class, 'sendToUsers']);
        Route::post('notification/sendToStores', [ProfileController::class, 'sendToStores']);
        Route::post('notification/sendToDrivers', [ProfileController::class, 'sendToDrivers']);

        Route::post('users/sendMailToUsers', [ProfileController::class, 'sendMailToUsers']);
        Route::post('users/sendMailToAll', [ProfileController::class, 'sendMailToAll']);
        Route::post('users/sendMailToStores', [ProfileController::class, 'sendMailToStores']);
        Route::post('users/sendMailToDrivers', [ProfileController::class, 'sendMailToDrivers']);
        Route::post('users/userInfoAdmin', [ProfileController::class, 'getInfo']);

        Route::post('orders/getStatsOfStore', [OrdersController::class, 'getStoreStatsDataWithDates']);
        Route::get('orders/getAll', [OrdersController::class, 'getAll']);
        Route::post('orders/getByIdAdmin', [OrdersController::class, 'getByIdAdmin']);
        Route::post('orders/updateStatusAdmin', [OrdersController::class, 'updateStatusStore']);
    });

    // Store Routes
    Route::group(['middleware' => ['store_auth', 'jwt.auth']], function () {
        Route::post('auth/store_logout', [LogoutController::class, 'logout']);
        Route::post('categories/getList', [MasterCategoriesController::class, 'getList']);
        Route::post('store/getStoreInfo', [StoresController::class, 'getStoreInfo']);
        Route::get('categories/get', [MasterCategoriesController::class, 'getActive']);
        Route::post('categories/updateCategories', [StoresController::class, 'updateCategories']);
        Route::post('store/updateData', [StoresController::class, 'updateData']);
        Route::post('storeWeb/getFoodList', [ProductsController::class, 'getFoodList']);

        Route::post('drivers/getDriversNearStore', [ProfileController::class, 'getDriversNearStore']);
        //

        Route::post('storeCates/create', [StoresCategoriesController::class,'save']);
        Route::post('storeCates/updateStatus', [StoresCategoriesController::class,'updateStatus']);
        Route::post('storeCates/updateInfo', [StoresCategoriesController::class,'updateInfo']);
        Route::post('storeCates/delete', [StoresCategoriesController::class,'delete']);
        Route::post('storeCates/getById', [StoresCategoriesController::class,'getById']);


        Route::post('foods/stores', [ProductsController::class,'stores']);
        Route::post('foods/save', [ProductsController::class,'save']);
        Route::post('foods/update', [ProductsController::class,'update']);
        Route::post('foods/updateRecommended', [ProductsController::class,'updateRecommended']);
        Route::post('foods/updateStock', [ProductsController::class,'updateStock']);
        Route::post('foods/updateStatus', [ProductsController::class,'updateStatus']);
        Route::post('foods/getProductInfo', [ProductsController::class,'getProductInfo']);

        Route::post('foods/getMenu', [ProductsController::class,'getMenu']);
        Route::post('foods/getListByStoreId', [ProductsController::class,'getListByStoreId']);

        Route::post('orders/getByStore', [OrdersController::class, 'getByStore']);
        Route::post('orders/getOrderByIdForStore', [OrdersController::class, 'getOrderByIdForStore']);
        Route::post('orders/updateFromStore', [OrdersController::class, 'update']);

        Route::post('table_booking/getBookingsByStore', [TableBookingController::class, 'getBookingsByStore']);
        Route::post('table_booking/getBookingInfo', [TableBookingController::class, 'getBookingInfo']);
        Route::post('table_booking/updateBookingInfo', [TableBookingController::class, 'update']);

        Route::post('orders/getStoreStatsData', [OrdersController::class, 'getStoreStatsData']);
        Route::post('orders/getStoreStatsDataWithDates', [OrdersController::class, 'getStoreStatsDataWithDates']);
    });

    // User Routes
    Route::group(['middleware' => ['jwt', 'jwt.auth']], function () {
        Route::post('profile/update', [ProfileController::class, 'update']);
        Route::post('profile/getByID', [ProfileController::class,'getByID']);
        Route::post('profile/getMyWallet', [ProfileController::class,'getMyWallet']);
        Route::post('auth/logout', [LogoutController::class, 'logout']);

        Route::post('referralcode/getMyCode', [ReferralCodesController::class, 'getMyCode']);
        Route::post('referral/redeemReferral', [ReferralController::class, 'redeemReferral']);

        Route::post('profile/getMyWalletBalance', [ProfileController::class,'getMyWalletBalance']);

        // General Routes
        Route::post('address/save',[AddressController::class, 'save'] );
        Route::post('address/getById', [AddressController::class, 'getById']);
        Route::post('address/getByUID', [AddressController::class, 'getByUID']);
        Route::get('address/getAll', [AddressController::class, 'getAll']);
        Route::post('address/update', [AddressController::class, 'update']);
        Route::post('address/delete', [AddressController::class, 'delete']);

        // Payments Routes For Users
        Route::post('payments/createStripeToken', [PaymentsController::class, 'createStripeToken']);
        Route::post('payments/createCustomer', [PaymentsController::class, 'createCustomer']);
        Route::post('payments/getStripeCards', [PaymentsController::class, 'getStripeCards']);
        Route::post('payments/addStripeCards', [PaymentsController::class, 'addStripeCards']);
        Route::post('payments/createStripePayments', [PaymentsController::class, 'createStripePayments']);
        Route::get('getPayPalKey', [PaymentsController::class, 'getPayPalKey']);
        Route::get('getFlutterwaveKey', [PaymentsController::class, 'getFlutterwaveKey']);
        Route::get('getPaystackKey', [PaymentsController::class, 'getPaystackKey']);
        Route::get('getRazorPayKey', [PaymentsController::class, 'getRazorPayKey']);
        Route::get('payments/getPayments', [PaymentsController::class, 'getPayments']);

        // Orders Routes
        Route::post('orders/create', [OrdersController::class, 'save']);
        Route::post('orders/getById', [OrdersController::class, 'getById']);
        Route::post('orders/sendMailForOrders', [OrdersController::class, 'sendMailForOrders']);
        Route::post('orders/getByUid', [OrdersController::class, 'getByUid']);
        Route::post('orders/searchWithId', [OrdersController::class, 'searchWithId']);
        Route::post('orders/getByOrderId', [OrdersController::class, 'getByOrderId']);
        Route::post('orders/getByDriver', [OrdersController::class, 'getByDriver']);
        Route::post('store/getStoreInfoByUid', [StoresController::class, 'getStoreInfo']);
        Route::post('orders/cancelMyOrder', [OrdersController::class, 'update']);
        Route::post('orders/updateFromDriver', [OrdersController::class, 'update']);

        // Banners Routes
        Route::post('table_booking/save',[TableBookingController::class, 'save'] );
        Route::post('table_booking/getById', [TableBookingController::class, 'getById']);
        Route::post('table_booking/getInfoById', [TableBookingController::class, 'getInfoById']);
        Route::get('table_booking/getAll', [TableBookingController::class, 'getAll']);
        Route::post('table_booking/update', [TableBookingController::class, 'update']);
        Route::post('table_booking/destroy', [TableBookingController::class, 'delete']);
        Route::post('table_booking/getByUID', [TableBookingController::class, 'getByUID']);

        Route::post('complaints/registerNewComplaints', [ComplaintsController::class, 'save']);

        Route::post('ratings/getByStoreId', [RatingsController::class, 'getByStoreId']);
        Route::post('ratings/saveStoreRatings', [RatingsController::class, 'saveStoreRatings']);

        Route::post('ratings/getByProductId', [RatingsController::class, 'getByProductId']);
        Route::post('ratings/saveProductRatings', [RatingsController::class, 'saveProductRatings']);

        Route::post('ratings/getByDriverId', [RatingsController::class, 'getByDriverId']);
        Route::post('ratings/saveDriversRatings', [RatingsController::class, 'saveDriversRatings']);
        Route::post('ratings/getDriversReviews', [RatingsController::class, 'getDriversReviews']);
        Route::post('ratings/getStoreReviews', [RatingsController::class, 'getStoreReviews']);

        Route::post('password/updateUserPasswordWithEmail', [ProfileController::class, 'updateUserPasswordWithEmail']);

        Route::post('chats/getChatRooms', [ChatRoomsController::class, 'getChatRooms']);
        Route::post('chats/createChatRooms', [ChatRoomsController::class, 'createChatRooms']);
        Route::post('chats/getChatListBUid', [ChatRoomsController::class, 'getChatListBUid']);
        Route::post('chats/getById', [ConversionsController::class, 'getById']);
        Route::post('chats/sendMessage', [ConversionsController::class, 'save']);

        Route::post('favourite/inMyList', [FavouritesController::class, 'inMyList']);
        Route::post('favourite/save', [FavouritesController::class, 'save']);
        Route::post('favourite/delete', [FavouritesController::class, 'delete']);

        Route::post('user/getMyFavList', [StoresController::class, 'getMyFavList']);

    });

    // public routes
    // Payments Routes For User Public
    Route::get('payNow',[PaytmPayController::class, 'payNow']);
    Route::get('payNowWeb',[PaytmPayController::class, 'payNowWeb']);
    Route::post('paytm-callback',[PaytmPayController::class, 'paytmCallback']);
    Route::post('paytm-webCallback',[PaytmPayController::class, 'webCallback']);
    Route::get('refundUserRequest',[PaytmPayController::class, 'refundUserRequest']);

    Route::get('setttings/getDefaultSettings', [SettingsController::class, 'getDefaultSettings']);
    Route::post('setttings/getAppSettingsByLanguageId', [SettingsController::class, 'getAppSettingsByLanguageId']);
    Route::get('languages/getLanguages', [LanguageController::class, 'getLanguages']);

    Route::post('user/getHome', [StoresController::class, 'getHome']);
    Route::get('categories/userCategories', [MasterCategoriesController::class,'userCategories']);
    Route::post('user/getNearMeCategories', [StoresController::class, 'getNearMeCategories']);
    Route::post('stores/searchQuery', [StoresController::class, 'getSearchResults']);

    Route::post('user/getStoreProductsById', [StoresController::class, 'getStoreProductsById']);
    Route::post('user/getOffersRestaurants', [StoresController::class, 'getOffersRestaurants']);
    Route::post('user/getStoreProductsByIdWithType', [StoresController::class, 'getStoreProductsByIdWithType']);
    Route::post('foods/getProductDetails', [ProductsController::class,'getProductInfo']);
    Route::get('languages/public', [LanguageController::class,'public']);

    Route::get('success_payments',[PaymentsController::class, 'success_payments']);
    Route::get('failed_payments',[PaymentsController::class, 'failed_payments']);
    Route::get('instaMOJOWebSuccess',[PaymentsController::class, 'instaMOJOWebSuccess']);
    Route::get('payments/payPalPay', [PaymentsController::class, 'payPalPay']);
    Route::get('payments/razorPay', [PaymentsController::class, 'razorPay']);
    Route::get('payments/VerifyRazorPurchase', [PaymentsController::class, 'VerifyRazorPurchase']);
    Route::post('payments/capureRazorPay', [PaymentsController::class, 'capureRazorPay']);
    Route::post('payments/instamojoPay', [PaymentsController::class, 'instamojoPay']);
    Route::get('payments/flutterwavePay', [PaymentsController::class, 'flutterwavePay']);
    Route::get('payments/paystackPay', [PaymentsController::class, 'paystackPay']);
    Route::get('payments/payKunPay', [PaymentsController::class, 'payKunPay']);

    Route::get('offers/getActive', [OffersController::class, 'getActive']);
    Route::get('settings/getDefault', [SettingsController::class, 'getDefault']);

    Route::post('pages/getContent', [PagesController::class, 'getById']);

    Route::post('contacts/create',[ContactsController::class, 'save'] );
    Route::post('sendMailToAdmin',[ContactsController::class, 'sendMailToAdmin']);
    Route::get('orders/printInvoice', [OrdersController::class, 'printInvoice']);
    Route::post('otp/verifyOTPReset',[OtpController::class, 'verifyOTPReset'] );
    Route::post('auth/verifyPhoneForFirebase', [AuthController::class, 'verifyPhoneForFirebase']);
    Route::post('otp/verifyPhone',[OtpController::class, 'verifyPhone'] );
    Route::post('otp/verifyOTP',[OtpController::class, 'verifyOTP'] );
    Route::get('success_verified',[AuthController::class, 'success_verified']);

    Route::post('sendVerificationOnMail', [ProfileController::class, 'sendVerificationOnMail']);
    Route::post('verifyPhoneSignup', [ProfileController::class, 'verifyPhoneSignup']);
    Route::post('auth/verifyPhoneForFirebaseRegistrations', [AuthController::class, 'verifyPhoneForFirebaseRegistrations']);

    Route::get('blogs/getTop', [BlogsController::class, 'getTop']);
    Route::get('blogs/getPublic', [BlogsController::class, 'getPublic']);
    Route::post('blogs/getDetails', [BlogsController::class, 'getById']);
    Route::post('get_store/getStoreReviews', [RatingsController::class, 'getStoreReviews']);
});
