<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAddressTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('address', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->integer('uid');
            $table->tinyInteger('is_default')->default(0);
            $table->text('optional_phone')->nullable();
            $table->tinyInteger('title');
            $table->text('address');
            $table->text('house');
            $table->text('landmark');
            $table->text('pincode');
            $table->string('lat')->nullable();
            $table->string('lng')->nullable();
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
        Schema::dropIfExists('address');
    }
}
