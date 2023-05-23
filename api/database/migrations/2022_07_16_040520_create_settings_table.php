<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateSettingsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('settings', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->string('currencySymbol');
            $table->string('currencySide');
            $table->string('currencyCode');
            $table->string('appDirection');
            $table->string('logo');
            $table->string('sms_name');
            $table->text('sms_creds');
            $table->tinyInteger('user_login');
            $table->tinyInteger('user_verify_with');
            $table->text('country_modal');
            $table->string('default_country_code');
            $table->text('app_color');
            $table->tinyInteger('show_booking');
            $table->tinyInteger('app_status');
            $table->tinyInteger('driver_assign');
            $table->tinyInteger('home_page_style');
            $table->tinyInteger('store_page_stype');
            $table->text('fcm_token')->nullable();
            $table->tinyInteger('status')->default(0);
            $table->text('extra_field')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('settings');
    }
}
