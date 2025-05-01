import express from 'express';
import dotenv from 'dotenv';
import mongoose from 'mongoose';
import cors from 'cors';
import productRoute from './routes/product.route.js'

const app = express();
app.use(express.json())
dotenv.config();
app.use(cors());

const PORT = process.env.PORT || 7000;
const MONGODB_CONNECTION_STRING = process.env.MONGODB_CONNECTION_STRING;

mongoose.connect(MONGODB_CONNECTION_STRING)
    .then(() => {
        console.log("Connected to DataBase successfully!");

        app.listen(PORT, (req,res) => {
            console.log(`Server is running on port ${PORT}`);
        });
    })
    .catch((error) => {
        console.error("Connection to MongoDB Atlas failed!", error);
    });

    app.use('/api/product',productRoute)