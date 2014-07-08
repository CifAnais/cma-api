<?php

class GenresController{

	public function get(){
		$data = json_decode(file_get_contents('data/genres.json'), 1);
		API::status(200);
		API::response($data);
	}
}