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

class Orders extends Model
{
    protected $table = 'orders';

    public $timestamps = true; //by default timestamp false

    protected $fillable = ['uid','store_id','address','items','coupon_id','coupon','order_to','wallet_used','wallet_price',
    'driver_id','delivery_charge','discount','total','serviceTax','grand_total','pay_method','paid','notes','status','extra_field'];

    // protected $hidden = [
    //     'updated_at', 'created_at',
    // ];
}
