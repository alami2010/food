<?php
/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
namespace App\Http\Controllers\v1;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Products;
use App\Models\Stores;
use App\Models\MasterCategories;
use App\Models\StoresCategories;
use Validator;
class ProductsController extends Controller
{
    public function save(Request $request){
        $validator = Validator::make($request->all(), [
            'store_id' => 'required',
            'from_cate' => 'required',
            'outofstock' => 'required',
            'recommended' => 'required',
            'cate_id' => 'required',
            'cover' => 'required',
            'name' => 'required',
            'details' => 'required',
            'price' => 'required',
            'rating' => 'required',
            'veg' => 'required',
            'variations' => 'required',
            'size' => 'required',
            'status' => 'required'
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }

        $data = Products::create($request->all());
        if (is_null($data)) {
            $response = [
            'data'=>$data,
            'message' => 'error',
            'status' => 500,
        ];
        return response()->json($response, 200);
        }
        $response = [
            'data'=>$data,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function getById(Request $request){
        $validator = Validator::make($request->all(), [
            'id' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }

        $data = Products::find($request->id);

        if (is_null($data)) {
            $response = [
                'success' => false,
                'message' => 'Data not found.',
                'status' => 404
            ];
            return response()->json($response, 404);
        }

        $response = [
            'data'=>$data,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function updateRecommended(Request $request){
        $validator = Validator::make($request->all(), [
            'id' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }
        $data = Products::find($request->id)->update($request->only('recommended'));

        if (is_null($data)) {
            $response = [
                'success' => false,
                'message' => 'Data not found.',
                'status' => 404
            ];
            return response()->json($response, 404);
        }
        $response = [
            'data'=>$data,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function updateStatus(Request $request){
        $validator = Validator::make($request->all(), [
            'id' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }
        $data = Products::find($request->id)->update($request->only('status'));

        if (is_null($data)) {
            $response = [
                'success' => false,
                'message' => 'Data not found.',
                'status' => 404
            ];
            return response()->json($response, 404);
        }
        $response = [
            'data'=>$data,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function updateStock(Request $request){
        $validator = Validator::make($request->all(), [
            'id' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }
        $data = Products::find($request->id)->update($request->only('outofstock'));

        if (is_null($data)) {
            $response = [
                'success' => false,
                'message' => 'Data not found.',
                'status' => 404
            ];
            return response()->json($response, 404);
        }
        $response = [
            'data'=>$data,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function getProductInfo(Request $request){
        $validator = Validator::make($request->all(), [
            'id' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }

        $data = Products::find($request->id);


        if (is_null($data)) {
            $response = [
                'success' => false,
                'message' => 'Data not found.',
                'status' => 404
            ];
            return response()->json($response, 404);
        }

        if($data->from_cate == 1){ // store ni category
            $cates = StoresCategories::where('id',$data->cate_id)->first();
            $data['cate_name'] = $cates->name;
        }else if($data->from_cate == 0){ // master category
            $cates = MasterCategories::select('id','name')->where('id',$data->cate_id)->first();
            $data['cate_name'] = $cates->name;
        }

        $response = [
            'data'=>$data,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function update(Request $request){
        $validator = Validator::make($request->all(), [
            'id' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }
        $data = Products::find($request->id)->update($request->all());

        if (is_null($data)) {
            $response = [
                'success' => false,
                'message' => 'Data not found.',
                'status' => 404
            ];
            return response()->json($response, 404);
        }
        $response = [
            'data'=>$data,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function delete(Request $request){
        $validator = Validator::make($request->all(), [
            'id' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }
        $data = Products::find($request->id);
        if ($data) {
            $data->delete();
            $response = [
                'data'=>$data,
                'success' => true,
                'status' => 200,
            ];
            return response()->json($response, 200);
        }
        $response = [
            'success' => false,
            'message' => 'Data not found.',
            'status' => 404
        ];
        return response()->json($response, 404);
    }

    public function getAll(){
        $data = Products::all();
        if (is_null($data)) {
            $response = [
                'success' => false,
                'message' => 'Data not found.',
                'status' => 404
            ];
            return response()->json($response, 404);
        }

        $response = [
            'data'=>$data,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function stores(Request $request){
        $validator = Validator::make($request->all(), [
            'store_id' => 'required',
            'from_cate' => 'required',
            'cate_id' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }
        $data = Products::where(['store_id'=>$request->store_id,'from_cate'=>$request->from_cate,'cate_id'=>$request->cate_id])->get();
        $response = [
            'data'=>$data,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function getMenu(Request $request){
        $validator = Validator::make($request->all(), [
            'id' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }
        $storeCates = Stores::select('master_categories')->where('id',$request->id)->first();
        $ids = explode(',',$storeCates->master_categories);
        $master = MasterCategories::select('id','name','cover')->WhereIn('id',$ids)->get();
        $stores = StoresCategories::select('id','name','cover')->where('store_id',$request->id)->get();
        $response = array();
        foreach($master as $loop){
            $products = Products::where(['store_id'=>$request->id,'from_cate'=>0,'cate_id'=>$loop['id']])->get();
            $obj = [
                "id"=>$loop['id'],
                'cover'=>$loop['cover'],
                'name'=>$loop['name'],
                'from_cate' =>0,
                'products'=>$products
            ];
            array_push($response,$obj);
        }
        foreach($stores as $loop){
            $products = Products::where(['store_id'=>$request->id,'from_cate'=>1,'cate_id'=>$loop['id']])->get();
            $obj = [
                "id"=>$loop['id'],
                'cover'=>$loop['cover'],
                'name'=>$loop['name'],
                'from_cate' =>1,
                'products'=>$products
            ];
            array_push($response,$obj);
        }

        $response = [
            // 'master'=>$master,
            // 'stores'=>$stores,
            'data'=>$response,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function getFoodList(Request $request){
        $validator = Validator::make($request->all(), [
            'id' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }
        $storeCates = Stores::select('master_categories')->where('uid',$request->id)->first();
        $ids = explode(',',$storeCates->master_categories);
        $data = MasterCategories::select('id','name')->WhereIn('id',$ids)->get();
        $stores = StoresCategories::where('store_id',$request->id)->get();
        $products = Products::where(['store_id'=>$request->id])->get();
        $productsResponse = array();
        foreach($products as $loop){
            if($loop->from_cate == 1){ // store ni category
                $cates = StoresCategories::where(['store_id'=>$request->id,'id'=>$loop->cate_id])->first();
                $loop['cate_name'] = $cates->name;
            }else if($loop->from_cate == 0){ // master category
                $cates = MasterCategories::select('id','name')->where('id',$loop->cate_id)->first();
                $loop['cate_name'] = $cates->name;
            }
            array_push($productsResponse,$loop);
        }
        $response = [
            'data'=>$data,
            'stores'=>$stores,
            'response'=>$productsResponse,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function getListByStoreId(Request $request){
        $validator = Validator::make($request->all(), [
            'id' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }
        $products = Products::where(['store_id'=>$request->id])->get();
        $response = [
            'data'=>$products,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function getAllFoodList(Request $request){
        $data = Products::all();
        foreach($data as $loop){
            $loop->storeInfo = Stores::select('name','address','cuisines')->where('uid',$loop->store_id)->first();
            if($loop->from_cate == 1){ // store ni category
                $cates = StoresCategories::where('id',$loop->cate_id)->first();
                $loop['cate_name'] = $cates->name;
            }else if($loop->from_cate == 0){ // master category
                $cates = MasterCategories::select('id','name')->where('id',$loop->cate_id)->first();
                $loop['cate_name'] = $cates->name;
            }
        }
        $response = [
            'data'=>$data,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }
}
