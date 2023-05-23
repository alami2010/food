<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTableBookingTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('table_booking', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->integer('uid');
            $table->integer('store_id');
            $table->integer('total_guest');
            $table->string('guest_name');
            $table->string('mobile');
            $table->string('email');
            $table->text('notes')->nullable();
            $table->date('saved_date');
            $table->tinyInteger('slot')->default(0);
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
        Schema::dropIfExists('table_booking');
    }
}
