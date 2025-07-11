import { Router } from "express";
import WarriorController from '../controllers/warrior.controller.js';
const router = Router();
const name = '/warrior';

// Rutas públicas
router.route(name)
  .post(WarriorController.register) // Registrar un nuevo guerrero
  .get(WarriorController.show);     // Mostrar todos los guerreros

router.route(`${name}/:id`)
  .get(WarriorController.findById)  // Mostrar un guerrero por ID
  .put(WarriorController.update)    // Actualizar un guerrero por ID
  .delete(WarriorController.delete);// Eliminar un guerrero por ID

export default router; 