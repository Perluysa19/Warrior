import { Router } from "express";
import PlayerController from '../controllers/player.controller.js';
const router = Router();
const name = '/player';

// Rutas públicas
router.route(name)
  .post(PlayerController.register) // Registrar un nuevo jugador
  .get(PlayerController.show);     // Mostrar todos los jugadores

router.route(`${name}/:id`)
  .get(PlayerController.findById)  // Mostrar un jugador por ID
  .put(PlayerController.update)    // Actualizar un jugador por ID
  .delete(PlayerController.delete);// Eliminar un jugador por ID

export default router; 