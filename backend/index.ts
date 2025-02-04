import axios from "axios";

const http=require('http');
const express=require('express');
const app=express();
const prisma=require('./prismaClient');

app.post('/api/user/login',(req:any,res:any)=>{
    req.on('data',(data:any)=>{
        const user=JSON.parse(data);
        if(user.username==='admin' && user.password==='1234'){
            res.json({message:'Login successful'});
        }else{
            res.json({message:'Login failed'});
        }
    })
})

 app.post('/api/user/register', ((req:{
    username:string,
    position:JSON,
    avatar:JSON,
    playerState:string,
    password:string
},res:{
    message:string
})=>{
    prisma.user.create({
        data:{
            username:req.username,
            position:req.position,
            avatar:req.avatar,
            playerState:req.playerState,
            password:req.password
        }
    }).then(()=>{
        res.message='User created';
    }).catch(()=>{
        res.message='User not created';
    })
}))

app.listen(3001,()=>{
    console.log('Server is running...');
})