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

class TableBookings extends Model
{
    protected $table = 'table_booking';

    public $timestamps = true; //by default timestamp false

    protected $fillable = ['uid','store_id','total_guest','guest_name','mobile','email','notes','saved_date','slot','status','extra_field'];

    protected $hidden = [
        'updated_at', 'created_at',
    ];
}
