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

class Medias extends Model
{
    protected $table = 'medias';
    protected $fillable = ['name','status','extra_fields'];

    protected $hidden = [
        'updated_at'
    ];
}
