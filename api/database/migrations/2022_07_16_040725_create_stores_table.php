<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateStoresTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('stores', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->integer('uid');
            $table->integer('city_id');
            $table->string('name');
            $table->text('cover');
            $table->string('mobile');
            $table->text('address');
            $table->text('landmark');
            $table->text('pincode');
            $table->string('lat')->nullable();
            $table->string('lng')->nullable();
            $table->text('master_categories')->nullable();
            $table->tinyInteger('delivery_type');
            $table->tinyInteger('pure_veg');
            $table->tinyInteger('have_dining')->default(0);
            $table->double('min_order_price',10,2);
            $table->double('extra_charges',10,2);
            $table->text('short_descriptions')->nullable();
            $table->text('images')->nullable();
            $table->tinyInteger('verified')->default(0);
            $table->tinyInteger('status')->default(0);
            $table->time('open_time')->nullable();
            $table->time('close_time')->nullable();
            $table->tinyInteger('is_closed')->default(0);
            $table->text('certificate')->nullabel();
            $table->double('ratings',10,2)->default(0);
            $table->integer('total_ratings')->default(0);
            $table->text('cuisines')->nullable();
            $table->string('delivery_time');
            $table->double('cost_for_two')->default(0);
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
        Schema::dropIfExists('stores');
    }
}
