# Bucketlist
A Rails API that provides a bucket list service

##GETTING STARTED
Its really easy. Following the next few steps should get you up and running in no time.

###Step 1: Clone the repo
Start by copying the ```https``` or ```ssh``` links for the repo then run
for ssh
```
git clone git@github.com:andela-mogala/bucket_list.git
```
and for https,
```
git clone https://github.com/andela-mogala/bucket_list.git
```
from your terminal. This should copy the repo to your local machine.

###Step 2: Install dependencies
Simply running
```
rake exec bundle install
```
should take care of this.

###Step 3: Start your server
```
rails s
```
The server is responsible for receving requests and serving you a response, so its only logicall to have this running.
To view the results of queries made to the api, you would need a tool like [cURL](https://curl.haxx.se/download.html) or [POSTMAN](https://chrome.google.com/webstore/detail/postman/fhbjgbiflinjbdggehcddcbncdddomop?hl=en)(POSTMAN is a chrome extension). You can snoop around internet for quick tutorials on how to use these tools. I will however show you an example of how to construct a request in cURL. But before then ...

###Step 4: Sign Up
Typically, items belong to individual bucketlists and a bucketlist belongs to a user. This means that you can not create a bucketlist without signing up. So you need to visit [http://localhost:3000/signup](http://localhost:3000/signup) to sign up and register your data as a user on the app. Once you have done this, you are now ready to make requests.

###Step 5: Log In
Unlike conventional web apps, apis are authenticated differently. Logging in will return an authentication token which you would use to make further calls to the api. The token expires after 2 hours so you would have to log in again.
```
curl -X POST -d email='me@example.com'&password='somepassword' http://localhost:3000/auth/login
```
The command above will log you in provided your credentials are correct and it would return a JWT(JSON web token) that looks like this
```
ahdfsudjadnfiuabdskjfasdkjflas.jbsdafp_jhbadhjffb1jfbdv.jskhdgkfasjkdhflsadjfabskfh
```
This token can now be used to make further requests

##AVAILABLE END POINTS
|END POINT|FUNCTIONALITY | PUBLIC ACCESS|
|:-----|:-----|:-----:|
|POST /auth/login | Logs a user in | true |
|GET /auth/logout | Logs out a user | false |
|POST /bucketlists | Create a new bucketlist | false |
|GET /bucketlists | Retrieve all bucketlists | false |
|GET /bucketlists/:id | REtrieve a particular bucketlist | false |
|PUT /bucketlists/:id | Update a bucketlist | false |
|DELETE /bucketlists/:id | Delete a bucketlist | false |
|POST /bucketlists/:id/items | Create a new item in a bucketlist | false |
|GET /bucketlists/:id/items | Retrieve all the items in a bucketlist | false |
|GET /bucketlists/:id/items/:id | Retrieve a particular item in a bucketlist | false |
|PUT /bucketlists/:id/items/:id |Update an item in a bucketlist | false |
|DELETE /bucketlists/:id/items/:id | Delete an item in a bucketlist | false |

###Example
So here's a nice example of how to create a bucketlist via cURL
```
curl -X POST -H 'Authorization: Bearer ahdfsudjadnfiuabdskjfasdkjflas.jbsdafp_jhbadhjffb1jfbdv.jskhdgkfasjkdhflsadjfabskfh' -d name='Build a Drone' http://localhost:3000/bucketlists
```
###FYI
Authentication is done by adding your auth token to the Authorization header.

##EXTERNAL DEPENDENCIES
This app uses some third party gems like:
* [jwt](https://github.com/jwt/ruby-jwt) for token authentication
* [active_model_serializers](https://github.com/rails-api/active_model_serializers) for formatting JSON responses
* [bcrypt](https://github.com/codahale/bcrypt-ruby) for user authentication.

Other gems can be viewed in the [gemfile](https://github.com/andela-mogala/bucket_list/blob/master/Gemfile)

##RUNNING THE TESTS
```
bundle exec rspec
```
should run all the tests. You must make sure you are in the root directory of the project before running the command.
The tests are configured to run with full documentation by default, however if you want to disable this you can open the ```.rspec``` file and remove the ```--format documentation``` command.

##LIMITATIONS
* Though the app uses token based authentication, there is still a risk of falling prey to replay attacks. Each login session has been set to expire 2 hours afer login to mitigate this loop hole but it doesn't totally eradicate the possibility.
* Caching was not implemented so there could be some performance implications.
