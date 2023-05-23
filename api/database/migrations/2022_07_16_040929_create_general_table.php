<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateGeneralTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('general', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->text('store_name');
            $table->string('mobile');
            $table->string('email');
            $table->text('address');
            $table->string('city');
            $table->string('state');
            $table->string('country');
            $table->string('zip');
            $table->double('free_delivery',10,2);
            $table->double('tax',10,2);
            $table->tinyInteger('shipping');
            $table->double('shippingPrice',10,2);
            $table->double('allowDistance');
            $table->tinyInteger('searchResultKind')->default(0);
            $table->text('facebook_url')->nullable();
            $table->text('instagram')->nullable();
            $table->text('twitter')->nullable();
            $table->text('google_playstore')->nullable();
            $table->text('apple_appstore')->nullable();
            $table->text('web_footer')->nullable();
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
        Schema::dropIfExists('general');
    }
}
