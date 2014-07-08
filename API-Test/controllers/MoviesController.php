<?php

class MoviesController{

	public function get(){
		$data = json_decode(file_get_contents('data/movies.json'), 1);
		API::status(200);
		API::response($data);
	}

	public function post(){
		 if(isset($_POST['title']) && isset($_POST['genre']) && 
            strlen(trim($_POST['title'])) > 0 && $_POST['genre'] > 0){

			$data = array(
				'meta'=>array('code'=>200),
				'data'=>array(
					'id' => 999,
					'title'=> trim($_POST['title']),
					'cover'=> isset($_POST['cover']) ? $_POST['cover'] : '',
					'genre'=> (int)$_POST['genre']
				)
			);

			API::status(200);
			API::response($data);
        }
        else{
        	API::status(400);
        }
	}
}