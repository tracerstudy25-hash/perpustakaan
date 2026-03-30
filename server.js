const { app, PORT } = require('./Bootstrap/app')

app.listen(PORT, () => {
 console.log(`Server is running on port http://localhost:${PORT}`)
})