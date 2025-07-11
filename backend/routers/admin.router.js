import { Router } from "express";
import AdminController from '../controllers/admin.controller.js';
const router = Router();

// Admin routes
router.post('/admin', AdminController.register); // Register a new admin
router.get('/admin', AdminController.show); // Show all admins

router.get('/admin/:id', AdminController.findById); // Show an admin by ID
router.put('/admin/:id', AdminController.update); // Update an admin by ID
router.delete('/admin/:id', AdminController.delete); // Delete an admin by ID

// Login route
router.post('/login', AdminController.login); // Login an admin

export default router; 