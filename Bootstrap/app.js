require('dotenv').config()

const express = require('express')
const path = require('path')

const app = express()

const PORT = process.env.PORT || 4594

app.use(express.json())
app.use(express.urlencoded({ extended: true }))

app.set('view engine', 'ejs')
app.set('views', path.join(__dirname, '../resources/views'))

app.use(express.static(path.join(__dirname, '../public')))

const webRoutes = require('../routes/web')

app.use('/', webRoutes)

module.exports = {
 app,
 PORT,
}