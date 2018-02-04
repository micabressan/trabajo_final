<?php

	

	class ApiMpController extends BaseController {

		

		public function get_pagamento(){

			$mp = new MP(MP_CLIENT, MP_SECRET);

			//$mp->sandbox_mode(true);

	        $preference_data = array(

	                "items" => array(

		               array(

		                   "title" => "InscriÃ§Ã£o SeminÃ¡rio - Alberto Almeida",

		                   "quantity" => 1,

		                   "currency_id" => "BRL",

		                   "unit_price" => 15.00

		               )

		            ),

					"external_reference" => Auth::User()->participante->id

	        );

	        

	        $preference = $mp->create_preference ($preference_data);

	        return Response::json($preference);

		}

		

		public function post_ipn(){

			

			$mp = new MP (MP_CLIENT, MP_SECRET);

			//$mp->sandbox_mode(SANDBOX_MODE);

			$paymentInfo = $mp->get_payment_info(Request::get('id'));

			$payment = $paymentInfo['response']['collection'];

			$participante = Participante::find($payment['external_reference']);

			$pagamento = $participante->pagamento;

	        $pagamento->valor = $payment['transaction_amount'];

			$pagamento->status = $payment['status'];

	        $pagamento->tipo = $payment['payment_type'];

			$pagamento->save();

			

		}

		

		public function get_success($id){

			

			$participante = Participante::find($id);

			

			$participante->pagamento->status = "in_process";

			DB::transaction(function() use ($participante){

				$participante->pagamento->save();

			});

			

			return Redirect::to('/#/app/home');

			

		}

		

	}