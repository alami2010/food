<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateUsersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('users', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->string('email')->unique();
            $table->string('password');
            $table->string('first_name');
            $table->string('last_name');
            $table->tinyInteger('gender')->default(4);
            $table->tinyInteger('type')->default(1);
            $table->tinyInteger('status')->default(1);
            $table->string('lat')->nullable();
            $table->string('lng')->nullable();
            $table->string('cover')->nullable();
            $table->string('country_code');
            $table->string('mobile');
            $table->tinyInteger('verified')->default(0);
            $table->text('fcm_token')->nullable();
            $table->text('others')->nullable();
            $table->string('stripe_key')->nullable();
            $table->text('extra_field')->nullable();
            $table->rememberToken();
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
        Schema::dropIfExists('users');
    }
}
