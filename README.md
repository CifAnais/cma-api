# API

## Pré-requis

### Version
À ajouter avant chaque URI.

```
/v1
```
   

## Endpoints
### Users 
#### GET /users 

Récupérer la liste des utilisateurs.

```
{
	"data":[
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

#### POST /users

Créer un utilisateur.

| Params | Type | Value |
| ------ | ---- | ----- |
| username | string | | 

**Réponse**

```
{
    "data": {
        "id": 20,
        "username": "Clément",
        "likes": 0,
        "dislikes": 0,
        "watched": 0,
        "watchlist": 0
    }
}
```

#### GET /users/:user_id

Récupérer le profil d'un utilisateur.

```
{
    "data": {
    	"id": 1,
        "username": "Maëlle",
        "likes": 3,
        "dislikes": 0,
        "watched": 12,
        "watchlist": 36
	}
}
```

#### PUT /users/:user_id

Mettre à jour le profil de l'utilisateur.

| Params | Type | Value |
| ------ | ---- | ----- |
| username | string | |

**Réponse**

```
{
    "data": {
    	"id": 1,
        "username": "Maëlle",
        "likes": 3,
        "dislikes": 0,
        "watched": 12,
        "watchlist": 36
	}
}
```

#### DELETE /users/:user_id

Supprimer l'utilisateur.


#### GET /users/:user_id/likes

Récupérer la liste des films aimés par l'utilisateur.

```
{
	"data": [
		{
			"id": "3",
			"title": "Jimmy's Hall",
			"cover":"http://domain.com/cover.png",
			"genre":2
		},
		{
			"id": "23",
			"title": "Dragons 2",
			"cover":"http://domain.com/cover.png",
			"genre":5
		},
		{...}
	]
}
```

#### POST /users/:user_id/likes/:movie_id  

Action : aimer un film.

#### DELETE /users/:user_id/likes/:movie_id  

Action: ne plus aimer un film.

#### GET /users/:user_id/dislikes 

Récupérer la liste des films que l'utilisateur n'aime pas.

```
{
	"data": [
		{
			"id": "3",
			"title": "Jimmy's Hall",
			"cover":"http://domain.com/cover.png",
			"genre":2
		},
		{
			"id": "23",
			"title": "Dragons 2",
			"cover":"http://domain.com/cover.png",
			"genre":5
		},
		{...}
	]
}
```

#### POST /users/:user_id/dislikes/:movie_id

Action : ne pas aimer un film.

#### DELETE /users/:user_id/dislikes/:movie_id

Action : supprimer action 'ne pas aimer un film'.

#### GET /users/:user_id/watched

Récupérer la liste des films vus par l'utilisateur.

```
{
	"data": [
		{
			"id": "3",
			"title": "Jimmy's Hall",
			"cover":"http://domain.com/cover.png",
			"genre":2
		},
		{
			"id": "23",
			"title": "Dragons 2",
			"cover":"http://domain.com/cover.png",
			"genre":5
		},
		{...}
	]
}
```

#### POST /users/:user_id/watched/:movie_id

Action : ajouter un film vu.

#### DELETE /users/:user_id/watched/:movie_id

Action : supprimer un film vu.


#### GET /users/:user_id/watchlist

Récupérer la liste des films que l'utilisateur aimerait voir.

```
{
	"data": [
		{
			"id": "3",
			"title": "Jimmy's Hall",
			"cover":"http://domain.com/cover.png",
			"genre":2
		},
		{
			"id": "23",
			"title": "Dragons 2",
			"cover":"http://domain.com/cover.png",
			"genre":5
		},
		{...}
	]
}
```

#### POST /users/:user_id/watchlist/:movie_id

Action : ajouter un film à voir.

#### DELETE /users/:user_id/watchlist/:movie_id

Action : supprimer un film à voir.

#### GET /users/:user_id/followed  

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

#### POST /users/:user_id/followed/:user_id

Action : suivre un utilisateur.

#### DELETE /users/:user_id/followed/:user_id

Action : ne plus suivre un utilisateur.

#### GET /users/:user_id/followers 

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

#### GET /movies

Récupérer la liste de tous les films.

```
{
	"data": [
		{
			"id": "3",
			"title": "Jimmy's Hall",
			"cover":"http://domain.com/cover.png",
			"genre":2
		},
		{
			"id": "23",
			"title": "Dragons 2",
			"cover":"http://domain.com/cover.png",
			"genre":5
		},
		{...}
	]
}
```

#### POST /movies

Ajouter un film.

| Params | Type | Value |
| ------ | ---- | ----- |
| title | string | | 
| cover | string | | 
| genre | int | ID Genre | 

**Réponse**

```
{
	"data": {
		"id": "3",
		"title": "Jimmy's Hall",
		"cover":"http://domain.com/cover.png",
		"genre":2
	}
}
```


#### GET /movies/:movie_id

Récupérer la fiche d'un film.

```
{
	"data": {
		"id": "1",
		"title": "X-men",
		"cover":"http://domain.com/cover.png",
		"genre":3
	}
}

```

#### PUT /movies/:movie_id

Mettre à jour la fiche d'un film.

| Params | Type | Value |
| ------ | ---- | ----- |
| title | string | | 
| cover | string | | 
| genre | int | ID Genre |  

**Réponse**

```
{
	"data": {
		"id": "3",
		"title": "Jimmy's Hall",
		"cover":"http://domain.com/cover.png",
		"genre":2
	}
}
```

#### DELETE /movies/:movie_id

Supprimer la fiche d'un film.

### Search

#### GET /search
Rechercher un film ou un utilisateur.

| Params | Type | Value |
| ------ | ---- | ----- |
| q | string | |
| type | string | **movies** ou **users** |

**Réponse**

```
{
	"data": [
		{
			"id": "3",
			"title": "Jimmy's Hall",
			"cover":"http://domain.com/cover.png",
			"genre":2
		},
		{
			"id": "3",
			"title": "Jimmy's Hall",
			"cover":"http://domain.com/cover.png",
			"genre":2
		},
		{...}	
	]
}
```

### Genre

#### GET /genres

Récupérer la liste de tous les genres de film.

```
{
	"data": [
		{
			"id": 1,
			"name": "drama",
		},
		{
			"id": 2,
			"name": "comedy",
		},
		{
			"id": 3,
			"name": "action",
		},
		{...}
	]
}
```

## Représentations

# API Example
- [http://cma-api.eu01.aws.af.cm](http://cma-api.eu01.aws.af.cm)

## Endpoints
### Movies
- GET /movies
- POST /movies
- DELETE /movies/:id

### Genres
- GET /genres

### Users
- GET /users 
- POST /users
- GET /users/:user_id
- DELETE /users/:user_id

### User likes
- GET /users/:user_id/likes
- POST /users/:user_id/likes/:movie_id  
- DELETE /users/:user_id/likes/:movie_id  

### User dislikes
- GET /users/:user_id/dislikes 
- POST /users/:user_id/dislikes/:movie_id
- DELETE /users/:user_id/dislikes/:movie_id

### User watched
- GET /users/:user_id/watched
- POST /users/:user_id/watched/:movie_id
- DELETE /users/:user_id/watched/:movie_id

### User watchlist
- GET /users/:user_id/watchlist
- POST /users/:user_id/watchlist/:movie_id
- DELETE /users/:user_id/watchlist/:movie_id


# iOS Example
## Pré-requis
Remplacez la valeur de la constante ```kAPIUrl``` par votre API

```
iOS/Movies/Constants.h
```
