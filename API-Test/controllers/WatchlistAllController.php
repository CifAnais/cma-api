<?php

class WatchlistAllController{

	public function get($user_id){
		$data = json_decode(file_get_contents('data/watchlist.json'), 1);
		API::status(200);
		API::response($data);
	}
}
