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

class General extends Model
{
    protected $table = 'general';

    public $timestamps = true; //by default timestamp false

    protected $fillable = ['store_name','mobile','email','address','searchResultKind','city','state','country','zip','free_delivery','tax','shipping','shippingPrice','allowDistance','facebook_url','instagram','twitter','google_playstore','apple_appstore','web_footer','status','extra_field'];

    protected $hidden = [
        'updated_at', 'created_at',
    ];
}
