<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateOffersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('offers', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->string('name');
            $table->text('short_descriptions');
            $table->text('code');
            $table->tinyInteger('type');
            $table->double('discount',10,2);
            $table->double('upto',10,2);
            $table->date('expire');
            $table->text('store_ids');
            $table->integer('max_usage');
            $table->double('min_cart_value',10,2);
            $table->tinyInteger('validations');
            $table->integer('user_limit_validation')->nullable();
            $table->text('extra_field')->nullable();
            $table->tinyInteger('status');
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
        Schema::dropIfExists('offers');
    }
}
