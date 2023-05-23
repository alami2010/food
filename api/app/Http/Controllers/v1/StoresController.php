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
use App\Models\Stores;
use App\Models\User;
use App\Models\MasterCategories;
use App\Models\StoresCategories;
use App\Models\Commissions;
use App\Models\Cities;
use App\Models\General;
use App\Models\Banners;
use App\Models\Products;
use App\Models\Favourites;
use Validator;
use DB;
class StoresController extends Controller
{
    public function save(Request $request){
        $validator = Validator::make($request->all(), [
            'uid' => 'required',
            'city_id' => 'required',
            'name' => 'required',
            'cover' => 'required',
            'mobile' => 'required',
            'address' => 'required',
            'landmark' => 'required',
            'pincode' => 'required',
            'lat' => 'required',
            'lng' => 'required',
            'master_categories' => 'required',
            'delivery_type' => 'required',
            'pure_veg' => 'required',
            'have_dining' => 'required',
            'min_order_price' => 'required',
            'extra_charges' => 'required',
            'short_descriptions' => 'required',
            'images' => 'required',
            'verified'=>'required',
            'status' => 'required',
            'open_time' => 'required',
            'close_time' => 'required',
            'is_closed' => 'required',
            'certificate' => 'required',
            'ratings' => 'required',
            'cuisines' => 'required',
            'delivery_time' => 'required',
            'cost_for_two' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }

        $data = Stores::create($request->all());
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

        $data = Stores::find($request->id);

        if (is_null($data)) {
            $response = [
                'success' => false,
                'message' => 'Data not found.',
                'status' => 404
            ];
            return response()->json($response, 404);
        }
        $cates = explode(',',$data->master_categories);
        $master = MasterCategories::select('id','name')->WhereIn('id',$cates)->get();
        $comission = Commissions::select('rate')->where('store_id',$request->id)->first();
        $data['master'] = $master;
        $data['commission'] = $comission->rate;
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
            'uid'=>'required',
            'status'=>'required'
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }
        $data = Stores::find($request->id)->update(['status'=>$request->status]);
        User::find($request->uid)->update(['status'=>$request->status]);
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

    public function updateInfo(Request $request){
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
        $data = Stores::find($request->id)->update($request->all());
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

    public function updateData(Request $request){
        $validator = Validator::make($request->all(), [
            'uid' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }
        $data = Stores::where('uid',$request->uid)->update($request->all());
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
        $data = Stores::find($request->id);
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
        $data = Stores::all();
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

    public function getStores(Request $request){
        $data = Stores::select('id','name','cover','uid','city_id','cuisines','delivery_type','master_categories','pure_veg','have_dining','ratings','total_ratings','open_time','close_time','status')->get();
        $response = array();
        foreach($data as $loop){
            $city = Cities::select('name')->where('id',$loop->city_id)->first();
            $user = User::select('first_name','last_name')->where('id',$loop->uid)->first();
            $ids = explode(',',$loop->master_categories);
            $master = MasterCategories::select('name')->WhereIn('id',$ids)->get();
            $loop['master_categories_name'] = $master;
            $loop['fname']= $user->first_name;
            $loop['lname']= $user->last_name;
            $loop['city_name'] = $city->name;
            array_push($response,$loop);
        }

        $response = [
            'data'=>$response,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function getStoresWithCityId(Request $request){
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
        $data = Stores::select('id','uid','name')->where(['city_id'=>$request->id,'status'=>1])->get();
        $response = [
            'data'=>$data,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function getStoreInfo(Request $request){
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
        $data = Stores::where('uid',$request->id)->first();
        if ($data) {
            $userInfo = User::where('id',$data->uid)->first();
            $response = [
                'data'=>$data,
                'user'=>$userInfo,
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

    public function updateCategories(Request $request){
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
        $data = Stores::where('uid',$request->id)->update($request->only('master_categories'));
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

    public function getMyFavList(Request $request){
        $validator = Validator::make($request->all(), [
            'lat' => 'required',
            'lng' => 'required',
            'uid' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }
        $searchQuery = General::select('allowDistance','searchResultKind')->first();

        if($searchQuery->searchResultKind == 1){
            $values = 3959; // miles
            $distanceType = 'miles';
        }else{
            $values = 6371; // km
            $distanceType = 'km';
        }
        $storeIds = Favourites::select('store_id')->where('uid',$request->uid)->get();
        $ids = array();
        foreach($storeIds as $i => $i_value) {
            array_push($ids,$i_value->store_id);
        }
        \DB::enableQueryLog();
        $data = Stores::select(DB::raw('stores.id as id,stores.name as name,stores.uid as uid,stores.city_id as city_id,stores.cover as cover,
        stores.address as address,stores.delivery_type as delivery_type,stores.pure_veg as pure_veg,stores.have_dining as have_dining,
        stores.images as images,stores.open_time as open_time,stores.close_time as close_time, stores.is_closed as is_closed,stores.ratings as ratings,
        stores.total_ratings as total_ratings,stores.cuisines as cuisines,stores.delivery_time as delivery_time,stores.cost_for_two as cost_for_two, ( '.$values.' * acos( cos( radians('.$request->lat.') ) * cos( radians( lat ) ) * cos( radians( lng ) - radians('.$request->lng.') ) + sin( radians('.$request->lat.') ) * sin( radians( lat ) ) ) ) AS distance'))
        // ->having('distance', '<', (int)$searchQuery->allowDistance)
        ->orderBy('distance')
        ->where('stores.status',1)
        ->WhereIn('stores.uid',$ids)
        // ->where('stores.name','like','%'.$request->param.'%')
        ->get();
        foreach($data as $loop){
            $loop->distance = round($loop->distance,2);
        }
        $response = [
            'data'=>$data,
            'distanceType'=>$distanceType,
            'success' => true,
            'status' => 200,
            'havedata'=>true,
        ];
        return response()->json($response, 200);
    }

    public function getOffersRestaurants(Request $request){
        $validator = Validator::make($request->all(), [
            'lat' => 'required',
            'lng' => 'required',
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

        $searchQuery = General::select('allowDistance','searchResultKind')->first();

        if($searchQuery->searchResultKind == 1){
            $values = 3959; // miles
            $distanceType = 'miles';
        }else{
            $values = 6371; // km
            $distanceType = 'km';
        }
        $ids = explode(',',$request->id);
        // $master = MasterCategories::select('id','name','cover')->WhereIn('id',$ids)->get();
        \DB::enableQueryLog();
        $data = Stores::select(DB::raw('stores.id as id,stores.name as name,stores.uid as uid,stores.city_id as city_id,stores.cover as cover,
        stores.address as address,stores.delivery_type as delivery_type,stores.pure_veg as pure_veg,stores.have_dining as have_dining,
        stores.images as images,stores.open_time as open_time,stores.close_time as close_time, stores.is_closed as is_closed,stores.ratings as ratings,
        stores.total_ratings as total_ratings,stores.cuisines as cuisines,stores.delivery_time as delivery_time,stores.cost_for_two as cost_for_two, ( '.$values.' * acos( cos( radians('.$request->lat.') ) * cos( radians( lat ) ) * cos( radians( lng ) - radians('.$request->lng.') ) + sin( radians('.$request->lat.') ) * sin( radians( lat ) ) ) ) AS distance'))
        // ->having('distance', '<', (int)$searchQuery->allowDistance)
        ->orderBy('distance')
        ->where('stores.status',1)
        ->WhereIn('stores.uid',$ids)
        // ->where('stores.name','like','%'.$request->param.'%')
        ->get();
        foreach($data as $loop){
            $loop->distance = round($loop->distance,2);
        }
        $response = [
            'data'=>$data,
            'distanceType'=>$distanceType,
            'success' => true,
            'status' => 200,
            'havedata'=>true,
        ];
        return response()->json($response, 200);
    }

    public function getSearchResults(Request $request){
        $validator = Validator::make($request->all(), [
            'lat' => 'required',
            'lng' => 'required',
            'param' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }

        $searchQuery = General::select('allowDistance','searchResultKind')->first();

        if($searchQuery->searchResultKind == 1){
            $values = 3959; // miles
            $distanceType = 'miles';
        }else{
            $values = 6371; // km
            $distanceType = 'km';
        }
        \DB::enableQueryLog();
        $data = Stores::select(DB::raw('stores.id as id,stores.name as name,stores.uid as uid,stores.city_id as city_id,stores.cover as cover,
        stores.address as address,stores.delivery_type as delivery_type,stores.pure_veg as pure_veg,stores.have_dining as have_dining,
        stores.images as images,stores.open_time as open_time,stores.close_time as close_time, stores.is_closed as is_closed,stores.ratings as ratings,
        stores.total_ratings as total_ratings,stores.cuisines as cuisines,stores.delivery_time as delivery_time,stores.cost_for_two as cost_for_two, ( '.$values.' * acos( cos( radians('.$request->lat.') ) * cos( radians( lat ) ) * cos( radians( lng ) - radians('.$request->lng.') ) + sin( radians('.$request->lat.') ) * sin( radians( lat ) ) ) ) AS distance'))
        ->having('distance', '<', (int)$searchQuery->allowDistance)
        ->orderBy('distance')
        ->where('stores.status',1)
        ->where('stores.name','like','%'.$request->param.'%')
        ->get();
        foreach($data as $loop){
            $loop->distance = round($loop->distance,2);
        }
        $response = [
            'data'=>$data,
            'distanceType'=>$distanceType,
            'success' => true,
            'status' => 200,
            'havedata'=>true,
        ];
        return response()->json($response, 200);
    }

    public function getHome(Request $request){
        $validator = Validator::make($request->all(), [
            'lat' => 'required',
            'lng' => 'required',
            'kind' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }

        $searchQuery = General::select('allowDistance','searchResultKind')->first();
        $categories = MasterCategories::where(['status'=>1,'kind'=>$request->kind])->get();

        if($searchQuery->searchResultKind == 1){
            $values = 3959; // miles
            $distanceType = 'miles';
        }else{
            $values = 6371; // km
            $distanceType = 'km';
        }
        \DB::enableQueryLog();
        $data = Stores::select(DB::raw('stores.id as id,stores.name as name,stores.uid as uid,stores.city_id as city_id,stores.cover as cover,
        stores.address as address,stores.delivery_type as delivery_type,stores.pure_veg as pure_veg,stores.have_dining as have_dining,
        stores.images as images,stores.open_time as open_time,stores.close_time as close_time, stores.is_closed as is_closed,stores.ratings as ratings,
        stores.total_ratings as total_ratings,stores.cuisines as cuisines,stores.delivery_time as delivery_time,stores.cost_for_two as cost_for_two, ( '.$values.' * acos( cos( radians('.$request->lat.') ) * cos( radians( lat ) ) * cos( radians( lng ) - radians('.$request->lng.') ) + sin( radians('.$request->lat.') ) * sin( radians( lat ) ) ) ) AS distance'))
        ->having('distance', '<', (int)$searchQuery->allowDistance)
        ->orderBy('distance')
        ->where('stores.status',1)
        ->get();
        if($data && sizeof($data) && count($data) >0){
            foreach($data as $loop){
                $loop->distance = round($loop->distance,2);
            }
            $today = date('Y-m-d');
            $banners = Banners::where(['city_id'=>$data[0]->city_id,'status'=>1])
            ->whereDate('from','<=', $today)
            ->whereDate('to','>=', $today)
            ->get();
            $response = [
                'categories'=>$categories,
                'data'=>$data,
                'banners'=>$banners,
                'distanceType'=>$distanceType,
                'success' => true,
                'status' => 200,
                'havedata'=>true,
            ];
            return response()->json($response, 200);
        }

        $response = [
            'categories'=>[],
            'data'=>[],
            'banners'=>[],
            'distanceType'=>$distanceType,
            'success' => true,
            'status' => 200,
            'havedata'=>false
        ];
        return response()->json($response, 200);
    }

    public function getNearMeCategories(Request $request){
        $validator = Validator::make($request->all(), [
            'lat' => 'required',
            'lng' => 'required',
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

        $searchQuery = General::select('allowDistance','searchResultKind')->first();
        $categories = MasterCategories::where(['status'=>1,'id'=>$request->id])->first();

        if($searchQuery->searchResultKind == 1){
            $values = 3959; // miles
            $distanceType = 'miles';
        }else{
            $values = 6371; // km
            $distanceType = 'km';
        }
        \DB::enableQueryLog();
        $data = Stores::select(DB::raw('stores.id as id,stores.name as name,stores.uid as uid,stores.city_id as city_id,stores.cover as cover,
        stores.address as address,stores.delivery_type as delivery_type,stores.pure_veg as pure_veg,stores.have_dining as have_dining,
        stores.images as images,stores.open_time as open_time,stores.close_time as close_time, stores.is_closed as is_closed,stores.ratings as ratings,
        stores.total_ratings as total_ratings,stores.cuisines as cuisines,stores.delivery_time as delivery_time,stores.cost_for_two as cost_for_two, ( '.$values.' * acos( cos( radians('.$request->lat.') ) * cos( radians( lat ) ) * cos( radians( lng ) - radians('.$request->lng.') ) + sin( radians('.$request->lat.') ) * sin( radians( lat ) ) ) ) AS distance'))
        ->having('distance', '<', (int)$searchQuery->allowDistance)
        ->orderBy('distance')
        ->where('stores.status',1)
        ->whereRaw("find_in_set('".$request->id."',stores.master_categories)")
        ->get();
        if($data && sizeof($data) && count($data) >0){
            $today = date('Y-m-d');
            $banners = Banners::where(['city_id'=>$data[0]->city_id,'status'=>1])
            ->whereDate('from','<=', $today)
            ->whereDate('to','>=', $today)
            ->get();
            $response = [
                'categories'=>$categories,
                'data'=>$data,
                'banners'=>$banners,
                'distanceType'=>$distanceType,
                'success' => true,
                'status' => 200,
                'havedata'=>true,
            ];
            return response()->json($response, 200);
        }

        $response = [
            'categories'=>[],
            'data'=>[],
            'banners'=>[],
            'distanceType'=>$distanceType,
            'success' => true,
            'status' => 200,
            'havedata'=>false
        ];
        return response()->json($response, 200);
    }

    public function getStoreProductsById(Request $request){
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
        $storeInfo = Stores::where('uid',$request->id)->first();
        $ids = explode(',',$storeInfo->master_categories);
        $master = MasterCategories::select('id','name','cover')->WhereIn('id',$ids)->get();
        $stores = StoresCategories::select('id','name','cover')->where(['store_id'=>$request->id,'status'=>1])->get();
        $response = array();
        $recam = Products::where(['store_id'=>$request->id,'recommended'=>1])->where('outofstock','!=',1)->get();
        $obj = [
            "id"=>'0_recom',
            'cover'=>'NA',
            'name'=>'Recommended',
            'from_cate' =>0,
            'products'=>$recam,
            'cate_id'=>'0_recom',
        ];
        if(isset($recam) && count($recam)){
            array_push($response,$obj);
        }
        foreach($master as $loop){
            $products = Products::where(['store_id'=>$request->id,'from_cate'=>0,'cate_id'=>$loop['id']])->where('outofstock','!=',1)->get();
            $obj = [
                "id"=>$loop['id'],
                'cover'=>$loop['cover'],
                'name'=>$loop['name'],
                'from_cate' =>0,
                'products'=>$products,
                'cate_id'=>$loop['id'].'_master'
            ];
            if(isset($products) && count($products)){
                array_push($response,$obj);
            }
        }
        foreach($stores as $loop){
            $products = Products::where(['store_id'=>$request->id,'from_cate'=>1,'cate_id'=>$loop['id']])->where('outofstock','!=',1)->get();
            $obj = [
                "id"=>$loop['id'],
                'cover'=>$loop['cover'],
                'name'=>$loop['name'],
                'from_cate' =>1,
                'products'=>$products,
                'cate_id'=>$loop['id'].'_store'
            ];
            if(isset($products) && count($products)){
                array_push($response,$obj);
            }
        }
        $response = [
            'store'=>$storeInfo,
            'data'=>$response,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);

    }

    public function getStoreProductsByIdWithType(Request $request){
        $validator = Validator::make($request->all(), [
            'id' => 'required',
            'value' =>'required'
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }

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
        $storeInfo = Stores::where('id',$request->id)->first();
        $ids = explode(',',$storeInfo->master_categories);
        $master = MasterCategories::select('id','name','cover')->WhereIn('id',$ids)->get();
        $stores = StoresCategories::select('id','name','cover')->where(['store_id'=>$request->id,'status'=>1])->get();
        $response = array();
        $recam = Products::where(['store_id'=>$request->id,'recommended'=>1,'veg'=>$request->value])->where('outofstock','!=',1)->get();
        $obj = [
            "id"=>'0_recom',
            'cover'=>'NA',
            'name'=>'Recommended',
            'from_cate' =>0,
            'products'=>$recam,
            'cate_id'=>'0_recom',
        ];
        if(isset($recam) && count($recam)){
            array_push($response,$obj);
        }
        foreach($master as $loop){
            $products = Products::where(['store_id'=>$request->id,'from_cate'=>0,'cate_id'=>$loop['id'],'veg'=>$request->value])->where('outofstock','!=',1)->get();
            $obj = [
                "id"=>$loop['id'],
                'cover'=>$loop['cover'],
                'name'=>$loop['name'],
                'from_cate' =>0,
                'products'=>$products,
                'cate_id'=>$loop['id'].'_master'
            ];
            if(isset($products) && count($products)){
                array_push($response,$obj);
            }
        }
        foreach($stores as $loop){
            $products = Products::where(['store_id'=>$request->id,'from_cate'=>1,'cate_id'=>$loop['id'],'veg'=>$request->value])->where('outofstock','!=',1)->get();
            $obj = [
                "id"=>$loop['id'],
                'cover'=>$loop['cover'],
                'name'=>$loop['name'],
                'from_cate' =>1,
                'products'=>$products,
                'cate_id'=>$loop['id'].'_store'
            ];
            if(isset($products) && count($products)){
                array_push($response,$obj);
            }
        }
        $response = [
            'data'=>$response,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }
}
