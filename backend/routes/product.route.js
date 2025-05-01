import express from 'express';
import { addProduct, deleteProduct, editProduct, getAllProducts, getProduct } from '../controllers/product.controller.js';

const route = express.Router();

route.get('/', getAllProducts);
route.post('/', addProduct);
route.get('/:id', getProduct);
route.put('/:id', editProduct);
route.delete('/:id', deleteProduct);

export default route;