<?php

require("libs/toro.php");
require("components/api.php");
require("controllers/MovieController.php");
require("controllers/MoviesController.php");
require("controllers/UsersController.php");
require("controllers/GenresController.php");

ToroHook::add("404", function() {
    API::status(404);
	API::response(array('meta'=>array('code'=>404, 'error'=>'Not Found')));
});

Toro::serve(array(
    '/movies' => 'MoviesController',
    '/movies/([0-9]+)' => 'MovieController',
    '/users' => 'UsersController',
    '/genres' => 'GenresController',
));
