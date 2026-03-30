biru, kaca, emas, putih agak hitam

npm init -y
npm install express
npm install ejs
npm install mysql2
npm install dotenv
npm install nodemon --save-dev
npx nodemon server.js
npm install -g nodemon
npm install tailwindcss @tailwindcss/cli
npx @tailwindcss/cli -i ./resources/css/app.css -o ./public/css/app.css --watch
npm install concurrently --save-dev

Set-ExecutionPolicy -Scope CurrentUser RemoteSigned

--------------------------------------------------------------------------------------------------------------------------------------------

perpustakaan
│
├── app
│   ├── Console
│   │   └── commands
│   │
│   ├── Exceptions
│   │   └── Handler.js
│   │
│   ├── Http
│   │   ├── Controllers
│   │   │   └── UsersController.js
│   │   │
│   │   ├── Middleware
│   │   │   └── rateLimit.js
│   │   │
│   │   └── Requests
│   │       └── userRequestValidator.js
│   │
│   ├── Models
│   │   └── Review.js
│   │
│   ├── Services
│   │   └── BorrowService.js
│   │
│   └── Providers
│       └── AppServiceProvider.js
│
├── bootstrap
│   └── app.js
│
├── config
│   └── auth.js
│
├── database
│   └── factories
│
├── public
│   ├── index.js
│   └── uploads
│
├── resources
│   ├── views
│   │   ├── books
│   │   └── users
│   │
│   ├── css
│   │   └── app.css
│   │
│   └── js
│       └── app.js
│
├── routes
│   └── web.js
│
├── storage
│   └── logs
│
├── tests
│   ├── feature
│   └── unit
│
├── .env
├── package.json
├── server.js
└── README.md