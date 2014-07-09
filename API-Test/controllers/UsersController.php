<?php

class UsersController{

	public function get(){
		$data = json_decode(file_get_contents('data/users.json'), 1);
		API::status(200);
		API::response($data);
	}

	public function post(){
		if(isset($_POST['username']) && 
            strlen(trim($_POST['username'])) > 0){

			$data = array(
				'id' => 999,
				'username'=> trim($_POST['username']),
				'likes'=> 0,
		        'dislikes'=> 0,
        		'watched'=> 0,
        		'watchlist'=> 0
			);

			API::status(200);
			API::response($data);
        }
        else{
        	API::status(400);
        }
	}
}