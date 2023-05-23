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
use App\Models\Orders;
use App\Models\User;
use App\Models\Stores;
use App\Models\General;
use App\Models\Complaints;
use App\Models\Products;
use Validator;
use Carbon\Carbon;
use DB;
class OrdersController extends Controller
{
    public function save(Request $request){
        $validator = Validator::make($request->all(), [
            'uid' => 'required',
            'store_id' => 'required',
            'order_to' => 'required',
            'address' => 'required',
            'items' => 'required',
            'coupon_id' => 'required',
            'coupon' => 'required',
            'driver_id' => 'required',
            'delivery_charge' => 'required',
            'discount' => 'required',
            'total' => 'required',
            'serviceTax' => 'required',
            'grand_total' => 'required',
            'pay_method' => 'required',
            'paid' => 'required',
            'notes' => 'required',
            'status' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }

        $data = Orders::create($request->all());
        if (is_null($data)) {
            $response = [
            'data'=>$data,
            'message' => 'error',
            'status' => 500,
        ];
        return response()->json($response, 200);
        }
        if($request && $request->wallet_used == 1){
            $redeemer = User::where('id',$request->uid)->first();
            $redeemer->withdraw($request->wallet_price);
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

        $data = Orders::find($request->id);

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
        $data = Orders::find($request->id)->update($request->all());

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
        $data = Orders::find($request->id);
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
        // $data = Orders::all();
        // if (is_null($data)) {
        //     $response = [
        //         'success' => false,
        //         'message' => 'Data not found.',
        //         'status' => 404
        //     ];
        //     return response()->json($response, 404);
        // }

        // $response = [
        //     'data'=>$data,
        //     'success' => true,
        //     'status' => 200,
        // ];
        // return response()->json($response, 200);
        $data = DB::table('orders')
                ->select('orders.*','users.first_name as first_name','users.last_name as last_name','stores.name as store_name')
                ->join('users','orders.uid','users.id')
                ->join('stores','orders.store_id','stores.uid')
                ->orderBy('orders.id','desc')
                ->get();

        $response = [
            'data'=>$data,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function getByUid(Request $request){
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
        $data = DB::table('orders')
        ->select('orders.*','stores.name as store_name','stores.cover as store_cover','stores.address as store_address')
        ->join('stores','orders.store_id','stores.uid')
        ->where('orders.uid',$request->id)
        ->orderBy('orders.id','desc')
        ->get();
        $response = [
            'data'=>$data,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function getByStore(Request $request){
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
        $data = DB::table('orders')
        ->select('orders.*','users.first_name as first_name','users.cover as user_cover','users.last_name as last_name')
        ->join('users','orders.uid','users.id')
        ->where('orders.store_id',$request->id)
        ->orderBy('orders.id','desc')
        ->get();
        $response = [
            'data'=>$data,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function getByDriver(Request $request){
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
        $data = DB::table('orders')
        ->select('orders.*','users.first_name as first_name','users.cover as user_cover','users.last_name as last_name','stores.name as store_name','stores.cover as store_cover','stores.address as store_address')
        ->join('users','orders.uid','users.id')
        ->join('stores','orders.store_id','stores.uid')
        ->where('orders.driver_id',$request->id)
        ->orderBy('orders.id','desc')
        ->get();
        $response = [
            'data'=>$data,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function getByOrderId(Request $request){
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

        $data = Orders::find($request->id);

        $storeInfo = Stores::where('uid',$data->store_id)->first();
        $userInfo  = User::where('id',$data->uid)->first();
        if($data && $data->driver_id !=0){
            $driverInfo = User::where('id',$data->driver_id)->first();
            $response = [
                'data'=>$data,
                'userInfo'=>$userInfo,
                'storeInfo'=>$storeInfo,
                'driverInfo'=>$driverInfo,
                'success' => true,
                'status' => 200,
            ];
            return response()->json($response, 200);
        }
        $response = [
            'data'=>$data,
            'storeInfo'=>$storeInfo,
            'userInfo'=>$userInfo,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function getOrderByIdForStore(Request $request){
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

        $data = Orders::find($request->id);
        $userInfo = User::where('id',$data->uid)->first();
        if($data->driver_id !=0){
            $driverInfo = User::where('id',$data->driver_id)->first();
            $response = [
                'data'=>$data,
                'userInfo'=>$userInfo,
                'driverInfo'=>$driverInfo,
                'success' => true,
                'status' => 200,
            ];
            return response()->json($response, 200);
        }

        $response = [
            'data'=>$data,
            'userInfo'=>$userInfo,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function getStoreStatsData(Request $request){
        $validator = Validator::make($request->all(), [
            'id'     => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }
        $now = Carbon::now();

        $todayData = Orders::whereRaw('FIND_IN_SET("'.$request->id.'",store_id)')->whereDate('created_at',Carbon::today())->get();
        $weekData = Orders::whereRaw('FIND_IN_SET("'.$request->id.'",store_id)')->whereBetween('created_at', [Carbon::now()->startOfWeek(), Carbon::now()->endOfWeek()])->get();
        $monthData = Orders::whereRaw('FIND_IN_SET("'.$request->id.'",store_id)')->whereMonth('created_at', Carbon::now()->month)->get();
        $complaints = Complaints::where(['store_id'=>$request->id,'status'=>0])->whereMonth('created_at', Carbon::now()->month)->get();
        $todayDate  = $now->format('d F');
        $todayResponse = [
            'data'=>$todayData,
            'label'=>$todayDate
        ];

        $weekStartDate = $now->startOfWeek()->format('d');
        $weekEndDate = $now->endOfWeek()->format('d F');

        $weekResponse = [
            'label' => $weekStartDate . '-'. $weekEndDate,
            'data' => $weekData
        ];

        $monthStartDate = $now->startOfMonth()->format('d');
        $monthEndDate = $now->endOfMonth()->format('d F');

        $monthResponse =  [
            'label'=>$monthStartDate.'-'.$monthEndDate,
            'data'=>$monthData,
        ];
        $data = [
            'today' => $todayResponse,
            'week' => $weekResponse,
            'month' => $monthResponse,
            'complaints'=>$complaints
        ];

        $response = [
            'data'=>$data,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function getStoreStatsDataWithDates(Request $request){
        $validator = Validator::make($request->all(), [
            'id'     => 'required',
            'from'     => 'required',
            'to'     => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }
        $from = date($request->from);
        $to = date($request->to);
        $data = Orders::whereRaw('FIND_IN_SET("'.$request->id.'",store_id)')->whereBetween('created_at',[$from, $to])->orderBy('id','desc')->get();
        $commission = DB::table('store_commission')->select('rate')->where('store_id',$request->id)->first();
        $response = [
            'data'=>$data,
            'commission'=>$commission,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function printInvoice(Request $request){
        $validator = Validator::make($request->all(), [
            'id'     => 'required',
            'token'  => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }

        try {
            $data = DB::table('orders')
            ->select('orders.*','users.first_name as user_first_name','users.last_name as user_last_name','users.cover as user_cover','users.fcm_token as user_fcm_token','users.mobile as user_mobile','users.email as user_email')
            ->join('users', 'orders.uid', '=', 'users.id')
            ->where('orders.id',$request->id)
            ->first();
            $general = General::first();
            $addres ='';
            if($data->order_to ==0){
                $compressed = json_decode($data->address);
                $addres = $compressed->house .' '.$compressed->landmark .' '.$compressed->address .' '.$compressed->pincode;
            }
            $data->items = json_decode($data->items);
            $response = [
                'data'=>$data,
                'email'=>$general->email,
                'delivery'=>$addres
            ];
            // echo json_encode($data);
            $mail = $data->user_email;
            $username = $data->user_first_name;
            return view('printinvoice',$response);
        } catch (TokenExpiredException $e) {

            return response()->json(['error' => 'Session Expired.', 'status_code' => 401], 401);

        } catch (TokenInvalidException $e) {

            return response()->json(['error' => 'Token invalid.', 'status_code' => 401], 401);

        } catch (JWTException $e) {

            return response()->json(['token_absent' => $e->getMessage()], 401);

        }
    }

    public function getByIdAdmin(Request $request){
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

        $data = Orders::find($request->id);

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
            'user'=>User::find($data->uid),
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }

    public function updateStatusStore(Request $request){
        $validator = Validator::make($request->all(), [
            'id' => 'required',
            'status' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }
        $data = Orders::find($request->id)->update($request->all());

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

    public function getAdminDashboard(Request $request){
        $now = Carbon::now();



        $todatData = Orders::select(\DB::raw("COUNT(*) as count"), \DB::raw("DATE_FORMAT(created_at,'%h:%m') as day_name"), \DB::raw("DATE_FORMAT(created_at,'%h:%m') as day"))
        ->whereDate('created_at',Carbon::today())
        ->groupBy('day_name','day')
        ->orderBy('day')
        ->get();

        $weekData = Orders::select(\DB::raw("COUNT(*) as count"), \DB::raw("DATE(created_at) as day_name"), \DB::raw("DATE(created_at) as day"))
            ->whereBetween('created_at', [Carbon::now()->startOfWeek(), Carbon::now()->endOfWeek()])
            ->groupBy('day_name','day')
            ->orderBy('day')
            ->get();

        $monthData = Orders::select(\DB::raw("COUNT(*) as count"), \DB::raw("DATE(created_at) as day_name"), \DB::raw("DATE(created_at) as day"))
            ->whereMonth('created_at', Carbon::now()->month)
            ->groupBy('day_name','day')
            ->orderBy('day')
            ->get();
        $monthResponse = [];
        $weekResponse =[];
        $todayResponse = [];

        foreach($todatData as $row) {
            $todayResponse['label'][] = $row->day_name;
            $todayResponse['data'][] = (int) $row->count;
        }
        foreach($weekData as $row) {
            $weekResponse['label'][] = $row->day_name;
            $weekResponse['data'][] = (int) $row->count;
        }

        foreach($monthData as $row) {
            $monthResponse['label'][] = $row->day_name;
            $monthResponse['data'][] = (int) $row->count;
        }

        $todayDate  = $now->format('d F');

        $weekStartDate = $now->startOfWeek()->format('d');
        $weekEndDate = $now->endOfWeek()->format('d F');

        $monthStartDate = $now->startOfMonth()->format('d');
        $monthEndDate = $now->endOfMonth()->format('d F');

        $recentOrders = DB::table('orders')
                ->select('orders.*','users.first_name as first_name','users.last_name as last_name')
                ->join('users','orders.uid','users.id')
                ->limit(10)
                ->orderBy('orders.id','desc')
                ->get();
        foreach($recentOrders as $loop){
            $store = Stores::select('name')->where('uid',$loop->store_id)->get();
            $loop->storeInfo = $store;
        }

        $complaints = Complaints::whereMonth('created_at', Carbon::now()->month)->get();

        foreach($complaints as $loop){
            $user = User::select('email','first_name','last_name','cover')->where('id',$loop->uid)->first();
            $loop->userInfo = $user;
            if($loop && $loop->store_id && $loop->store_id !=null){
                $store = Stores::select('name','cover')->where('uid',$loop->store_id)->first();
                $storeUser = User::select('email','cover')->where('id',$loop->store_id)->first();
                $loop->storeInfo = $store;
                $loop->storeUiserInfo = $storeUser;
            }

            if($loop && $loop->driver_id && $loop->driver_id !=null){
                $driver = User::select('email','first_name','last_name','cover')->where('id',$loop->driver_id)->first();
                $loop->driverInfo = $driver;
            }
            if($loop && $loop->product_id && $loop->product_id !=null){
                $product = Products::select('name','cover')->where('id',$loop->product_id)->first();
                $loop->productInfo = $product;
            }

        }
        $data = [
            'today' => $todayResponse,
            'week' => $weekResponse,
            'month' => $monthResponse,
            'todayLabel' => $todayDate,
            'weekLabel' => $weekStartDate . '-'. $weekEndDate,
            'monthLabel' => $monthStartDate.'-'.$monthEndDate,
            'complaints'=>$complaints,
            'users' =>User::where('type',1)->count(),
            'stores'=>User::where('type',2)->count(),
            'orders'=>Orders::count(),
            'recentOrders'=>$recentOrders,
            'recentUsers' =>User::where('type',1)->limit(10)->orderBy('id','desc')->get(),
            'products'=>Products::count()
        ];

        $response = [
            'data'=>$data,
            'success' => true,
            'status' => 200,
        ];
        return response()->json($response, 200);
    }
}
