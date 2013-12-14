

### Draft of API contracts
For all endpoints, request and response headers will include the following
```
Content-Type: application/json
```
When authentication is required, also include the auth token:
```
Authorization: Devise <token>
```

### Test Get / Test Post
```
curl -v -H 'Content-Type: application/json' -H 'Accept: application/json' -X GET http://localhost:3000/api/v1/test/get -d "{\"input\":\"hello\"}"


curl -v -H 'Content-Type: application/json' -H 'Accept: application/json' -X POST http://localhost:3000/api/v1/test/post.json -d "{\"input\":\"hello\"}"
```


### Registration
```
Method: POST /api/v1/users/find_or_register
Request Body: {
    email: "bob.singh@gmail.com"
}
Response Body: {
    token: <token>
}
```

### Login
```
Method: POST /api/v1/sessions
Request Body: {
    user: { email: "todd.sedano@sv.cmu.edu" , password: "pAsSwOrD" }
}
Response Body: {
     success: true,
     info: "Logged in",
     user_token: "rAnDomChArAcTerS"
}
Example:
curl -v -H 'Content-Type: application/json' -H 'Accept: application/json' -X POST http://localhost:3000/api/v1/sessions -d "{\"user\":{\"email\":\"todd.sedano@sv.cmu.edu\",\"password\":\"pAsSwOrD\"}}"
```

### Fetch the versions
```
Method: GET /api/v1/versions.json
Response Body: {
  versions: [
     { name: "OMG 1.0" },
     { name: "Printed Cards 1.0"}
  ]
}


### Fetch the contents of the alphas
```
Method: GET /api/v1/alphas.json (Deprecated)
Method: GET /api/v1/alphas.json?version=omg%201.0 (Deprecated)
Method: GET /api/v1/versions/omg%201.0.json
Response Body: {
    version: "OMG 1.0"
    alphas: [
        {
            id: <guid>,
            name: "Some Title Here",
            color: "Blue",
            concern: "Customer",
            definition: "The people, groups, or organizations who affect or are affected by a software system.",
            description: "The stakeholders provide the opportunity, and are the source of the requirements for the...",
            states: [
                {
                    id: <guid>,
                    name: "Card Name Here",
                    checklistItems: [
                        {
                            id: <guid>,
                            name: "Some label here"
                        },
                        /*some other checkboxes here*/
                    ]
                },
                /*some other cards here*/
            ]
        },
        /*some other alphas here*/
    ]
}
```

### Fetch the group memberships
```
Method: GET /api/v1/users/<emailAddress>/teams.json
Response Body: {
    teams: [
        {
            id: <guid>,
            name: "NotSoExceptional"
        },
        {
            id: <guid>,
            name: "The Foobar Awesome Conglomerate"
        }
    ]
}
```

### Fetch the progress for a specific group
```
Method: GET /api/v1/progress/<teamId>.json
Response Body: {
    currentVersion: 2, #Not sure about this
    checkboxes: [<guid>, <guid>]
}
```


### Upload the checkbox modifications
```
Method: POST /api/v1/progress<teamId>/mark.json
Request Body: {
    currentVersion: 2,  #Not sure about this
    checklist_id: <guid>
    checked: true
    user_email: <userId>
    user_token:
}
Response Body: {
    response: true
}
Example:
curl -v -H 'Content-Type: application/json' -H 'Accept: application/json' -X POST http://localhost:3000/api/v1/progress/1/.json -d "{\"checklist_id\":3, \"team_id\":1, \"checked\":true, \"user_email\":\"todd.sedano@sv.cmu.edu\", \"user_token\":\"tOkEn\"}"
```
_response will contain a message if it failed_

### Upload comments for synchronization
```
Method: POST /api/v1/progress/<teamId>/save_notes
Request Body: {
    alpha_id: <guid>,
    notes: "The professor says that we don't have enough exceptions in our code",
    user_email: <email>,
    user_token: <token>
}
Response Body: {
    response: true
}
```

```
Method: POST /api/v1/progress/<teamId>/save_actions
Request Body: {
    alpha_id: <guid>,
    actions: "The professor says that we don't have enough exceptions in our code",
    user_email: <email>,
    user_token: <token>
}
Response Body: {
    response: true
}
```

## Others

### Rename a team
```
Method: POST /api/v1/teams/<teamId>/rename
Request Body: {
    name: NewName,
    user_id: 1
}
Response Body: {
    response: true
}
```
_response will contain a message if it failed_





