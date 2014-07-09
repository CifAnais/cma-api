<?php

class UserController{

	public function get($id){
		$data = json_decode(file_get_contents('data/user.json'), 1);
		API::status(200);
		API::response($data);
	}

	public function delete($id){
		API::status(204);
	}
}