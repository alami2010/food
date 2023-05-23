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

class Offers extends Model
{
    protected $table = 'offers';

    public $timestamps = true; //by default timestamp false

    protected $fillable = ['name','short_descriptions','code','type','discount','upto',
    'expire','store_ids','max_usage','min_cart_value','validations','user_limit_validation','status','extra_field'];

    protected $hidden = [
        'updated_at', 'created_at',
    ];
}
