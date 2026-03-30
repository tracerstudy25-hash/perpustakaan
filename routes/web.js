const express = require('express')
const router = express.Router()

router.get('/hello', (req, res) => {
 res.render('hello');
});
router.get('/', (req, res) => {
 res.render('Index/index');
});

module.exports = router