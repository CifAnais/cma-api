<?php

class API{
	
	static function status($status){
		header('Content-type: application/json; charset=utf-8');
		header('HTTP/1.1 ' . $status);
	}

	static function response($response){
		print json_encode($response);
	}
}