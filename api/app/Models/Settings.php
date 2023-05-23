<?php
/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Settings extends Model
{
    protected $table = 'settings';

    public $timestamps = true; //by default timestamp false

    protected $fillable = ['currencySymbol','currencySide','currencyCode','appDirection','logo','sms_name','sms_creds','user_login',
    'user_verify_with','country_modal','default_country_code','app_color','show_booking','app_status','driver_assign','home_page_style',
    'store_page_stype','fcm_token','status','extra_field'];

    protected $hidden = [
        'updated_at', 'created_at','sms_creds','fcm_token','search_radius'
    ];
}
