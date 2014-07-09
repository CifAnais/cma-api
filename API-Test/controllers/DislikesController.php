<?php

class DislikesController{

	public function get($user_id){
		$data = json_decode(file_get_contents('data/dislikes.json'), 1);
		API::status(200);
		API::response($data);
	}
}
