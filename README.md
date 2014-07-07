# API
## Endpoints
### Users 
#### GET /v1/users 

Récupérer la liste des utilisateurs.

```
{
	"data": [
		{
			"id": "1",
			"username": "Maëlle"
		},
		{
			"id": "2",
			"username": "Anaïs"
		},
		{
			"id": "3",
			"username": "Aymeric"
		},
		{...}
	]
}

```

#### POST /v1/users

Créer un utilisateur.

#### GET /v1/users/:user_id

Récupérer le profil d'un utilisateur.

```
{
	"data": [
		{
			"id": "1",
			"username": "Maëlle",
			"counts": [
				{ "likes_count": "3" },
				{ "dislikes_count": "0" },
				{ "watched_count": "12" },
				{ "watchlist_count": "36" }
			]
			
		}
	]
}

```

#### PUT /v1/users/:user_id

Mettre à jour le profil de l'utilisateur.

#### DELETE /v1/users/:user_id

Supprimer l'utilisateur.

#### GET /v1/users/:user_id/likes

Récupérer la liste des films aimés par l'utilisateur.

```
{
	"data": [
		{
			"id": "3",
			"title": "La vie aquatique"
		},
		{
			"id": "23",
			"title": "Transcendance"
		},
		{...}
	]
}
```

#### POST /v1/users/:user_id/likes/:movie_id  

Action : aimer un film.

#### DELETE /v1/users/:user_id/likes/:movie_id  

Action: ne plus aimer un film.

#### GET /v1/users/:user_id/dislikes 

Récupérer la liste des films que l'utilisateur n'aime pas.

```
{
	"data": [
		{
			"id": "3",
			"title": "Big bad wolfes"
		},
		{
			"id": "23",
			"title": "Hunger games"
		},
		{...}
	]
}
```

#### POST /v1/users/:user_id/dislikes/:movie_id

Action : ne pas aimer un film.

#### DELETE /v1/users/:user_id/dislikes/:movie_id

Action : supprimer action 'ne pas aimer un film'.

#### GET /v1/users/:user_id/watched

Récupérer la liste des films vus par l'utilisateur.

```
{
	"data": [
		{
			"id": "3",
			"title": "X-men"
		},
		{
			"id": "23",
			"title": "Edge of Tomorrow"
		},
		{...}
	]
}
```

#### POST /v1/users/:user_id/watched/:movie_id

Action : ajouter un film vu.

#### DELETE /v1/users/:user_id/watched/:movie_id

Action : supprimer un film vu.


#### GET /v1/users/:user_id/watchlist

Récupérer la liste des films que l'utilisateur aimerait voir.

```
{
	"data": [
		{
			"id": "3",
			"title": "Jimmy's Hall"
		},
		{
			"id": "23",
			"title": "Dragons 2"
		},
		{...}
	]
}
```

#### POST /v1/users/:user_id/watchlist/:movie_id

Action : ajouter un film à voir.

#### DELETE /v1/users/:user_id/watchlist/:movie_id

Action : supprimer un film à voir.

#### GET /v1/users/:user_id/followed  

Récupérer la liste des utilisateurs suivis par l'utilisateur.

```
{
	"data": [
		{
			"id": "3",
			"username": "Guillaume"
		},
		{
			"id": "23",
			"username": "Pierre"
		},
		{...}
	]
}
```

#### POST /v1/users/:user_id/followed/:user_id

Action : suivre un utilisateur.

#### DELETE /v1/users/:user_id/followed/:user_id

Action : ne plus suivre un utilisateur.

#### GET /v1/users/:user_id/followers 

```
{
	"data": [
		{
			"id": "3",
			"username": "Florian"
		},
		{
			"id": "23",
			"username": "Esther"
		},
		{...}
	]
}
```

### Movies

#### GET /v1/movies

Récupérer la liste de tous les films.

```
{
	"data": [
		{
			"id": "3",
			"title": "Jimmy's Hall"
		},
		{
			"id": "23",
			"title": "Dragons 2"
		},
		{...}
	]
}
```

#### POST /v1/movies

Ajouter un film.

#### GET /v1/movies/:movie_id

Récupérer la fiche d'un film.

```
{
	"data": [
		{
			"id": "1",
			"title": "X-men"
		}
	]
}

```

#### PUT /v1/movies/:movie_id

Mettre à jour la fiche d'un film.

#### DELETE /v1/movies/:movie_id

Supprimer la fiche d'un film.

### Search

#### GET /v1/search?q=:recherche&type=movies|users

Rechercher un film ou un utilisateur.


## Représentations

# API Example
- [http://cma-api.eu01.aws.af.cm](http://cma-api.eu01.aws.af.cm)

## Endpoints
### Movies
#### GET /movies

```
{
	"meta":{
		"code":200
	},
	"data":[
		{
			"id":1,
			"title": "Palo Alto",
			"cover":"http://cma-api.eu01.aws.af.cm/assets/movies/palo-alto.jpg",
			"genre":"drama"
		}
	]
}
```