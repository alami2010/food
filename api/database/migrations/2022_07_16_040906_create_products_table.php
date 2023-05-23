<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateProductsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('products', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->integer('store_id');
            $table->tinyInteger('from_cate');
            $table->integer('cate_id');
            $table->text('cover');
            $table->text('name');
            $table->text('details')->nullable();
            $table->double('price',10,2);
            $table->double('discount',10,2)->default(0);
            $table->double('rating',10,2)->nullable();
            $table->tinyInteger('veg')->default(0);
            $table->text('variations')->nullable();
            $table->tinyInteger('size')->default(2);
            $table->tinyInteger('recommended')->default(2);
            $table->tinyInteger('outofstock')->default(2);
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
        Schema::dropIfExists('products');
    }
}
