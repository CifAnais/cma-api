<?php

class UsersController{

	public function get(){
		$data = json_decode(file_get_contents('data/users.json'), 1);
		API::status(200);
		API::response($data);
	}
}