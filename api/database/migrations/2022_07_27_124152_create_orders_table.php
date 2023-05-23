<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateOrdersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('orders', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->integer('uid');
            $table->integer('store_id');
            $table->integer('order_to');
            $table->text('address');
            $table->text('items');
            $table->integer('coupon_id')->nullable();
            $table->text('coupon')->nullable();
            $table->integer('driver_id')->nullable();
            $table->double('delivery_charge',10,2);
            $table->double('discount',10,2);
            $table->double('total',10,2);
            $table->double('serviceTax',10,2);
            $table->double('grand_total',10,2);
            $table->tinyInteger('wallet_used')->default(0);
            $table->double('wallet_price',10,2)->nullable();
            $table->integer('pay_method');
            $table->text('paid');
            $table->text('notes')->nullable();
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
        Schema::dropIfExists('orders');
    }
}
