<?php

// ini_set('display_errors', 1);
// error_reporting(E_ALL);

require("libs/toro.php");
require("components/api.php");

require("controllers/MovieController.php");
require("controllers/MoviesController.php");

require("controllers/UserController.php");
require("controllers/UsersController.php");

require("controllers/LikeController.php");
require("controllers/LikesController.php");

require("controllers/DislikeController.php");
require("controllers/DislikesController.php");

require("controllers/WatchedController.php");
require("controllers/WatchedAllController.php");

require("controllers/WatchlistController.php");
require("controllers/WatchlistAllController.php");

require("controllers/GenresController.php");

ToroHook::add("404", function() {
    API::status(404);
	API::error(404, 'Not Found');
});

Toro::serve(array(
    '/movies' => 'MoviesController',
    '/movies/([0-9]+)' => 'MovieController',

    '/users' => 'UsersController',
    '/users/([0-9]+)' => 'UserController',
    
    '/users/([0-9]+)/likes' => 'LikesController',
    '/users/([0-9]+)/likes/([0-9]+)' => 'LikeController',

    '/users/([0-9]+)/dislikes' => 'DislikesController',
    '/users/([0-9]+)/dislikes/([0-9]+)' => 'DislikeController',

    '/users/([0-9]+)/watched' => 'WatchedAllController',
    '/users/([0-9]+)/watched/([0-9]+)' => 'WatchedController',

    '/users/([0-9]+)/watchlist' => 'WatchlistAllController',
    '/users/([0-9]+)/watchlist/([0-9]+)' => 'WatchlistController',

    '/genres' => 'GenresController',
));
