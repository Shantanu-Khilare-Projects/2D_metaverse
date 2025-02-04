"use strict";
const http = require('http');
const express = require('express');
const app = express();
app.post('/api/user/login', (req, res) => {
    req.on('data', (data) => {
        const user = JSON.parse(data);
        if (user.username === 'admin' && user.password === '1234') {
            res.json({ message: 'Login successful' });
        }
        else {
            res.json({ message: 'Login failed' });
        }
    });
});
app.listen(3001, () => {
    console.log('Server is running...');
});
