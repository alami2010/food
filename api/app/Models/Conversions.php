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

class Conversions extends Model
{
    protected $table = 'conversions';

    public $timestamps = true; //by default timestamp false

    protected $fillable = ['room_id','sender_id','message_type','message','reported','extra_fields','status'];

    protected $hidden = [
         'created_at',
    ];
}
