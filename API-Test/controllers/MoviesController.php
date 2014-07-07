<?php

class MoviesController{

	public function get(){
		$data = json_decode(file_get_contents('data/movies.json'), 1);
		API::status(200);
		API::response($data);
	}
}