<?php

class API{
	
	static function status($status){
		header('Content-type: application/json; charset=utf-8');
		header('HTTP/1.1 ' . $status);
	}

	static function response($response){
		$json = array(
			'meta'=>array(
				'code'=>200
			),
			'data'=>$response
		);

		print json_encode($json);
	}

	static function error($code, $error){
		$json = array(
			'meta'=>array(
				'code'=>$code,
				'error'=>$error	
			)
		);

		print json_encode($json);
	}

}