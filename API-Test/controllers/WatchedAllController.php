<?php

class WatchedAllController{

	public function get($user_id){
		$data = json_decode(file_get_contents('data/watched.json'), 1);
		API::status(200);
		API::response($data);
	}
}
