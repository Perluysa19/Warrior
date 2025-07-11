-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 08-07-2025 a las 02:41:05
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `warrior`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_assign_power_to_warrior` (IN `warriorId` INT, IN `powerId` INT, IN `adminId` INT)   BEGIN
    INSERT INTO warrior_power (Warrior_id, Power_id, Admin_id)
    VALUES (warriorId, powerId, adminId);
  END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_game` (IN `gameName` VARCHAR(30), IN `isPublic` TINYINT(1), IN `gameCode` VARCHAR(20), IN `playerId` INT)   BEGIN
    INSERT INTO game (Game_name, Game_Public, Game_Code, Player_id)
    VALUES (gameName, isPublic, gameCode, playerId);
  END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_player` (IN `playerName` VARCHAR(20))   BEGIN
     INSERT INTO player (Player_name) VALUES (playerName);
   END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_warrior` (IN `warriorName` VARCHAR(30), IN `warriorLevel` INT, IN `raceId` INT, IN `warriorTypeId` INT, IN `magicId` INT, IN `adminId` INT)   BEGIN
    INSERT INTO warrior (
      Warrior_name, Warrior_level, Race_id, Warrior_type_id, Magic_id, Admin_id
    )
    VALUES (warriorName, warriorLevel, raceId, warriorTypeId, magicId, adminId);
  END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_player_warriors` (IN `playerId` INT)   BEGIN
    SELECT w.*
    FROM warrior w
    INNER JOIN game_player_warrior gpw ON gpw.Warrior_id = w.Warrior_id
    WHERE gpw.Player_id = playerId;
  END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_warrior_powers` (IN `warriorId` INT)   BEGIN
    SELECT p.Power_id, p.Power_name
    FROM power p
    INNER JOIN warrior_power wp ON wp.Power_id = p.Power_id
    WHERE wp.Warrior_id = warriorId;
  END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_join_game` (IN `gameId` INT, IN `playerId` INT)   BEGIN
    INSERT INTO player_game (Game_id, Player_id)
    VALUES (gameId, playerId);
  END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_list_public_games` ()   BEGIN
    SELECT * FROM game WHERE Game_Public = 1;
  END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_register_warrior_to_game` (IN `gameId` INT, IN `playerId` INT, IN `warriorId` INT)   BEGIN
    INSERT INTO game_player_warrior (Game_id, Player_id, Warrior_id)
    VALUES (gameId, playerId, warriorId);
  END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `admin`
--

CREATE TABLE `admin` (
  `Admin_id` int(11) NOT NULL,
  `Admin_name` varchar(20) NOT NULL,
  `Admin_password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `admin`
--

INSERT INTO `admin` (`Admin_id`, `Admin_name`, `Admin_password`, `created_at`, `updated_at`) VALUES
(1, 'Carlos111', '$2b$10$0ROz/1rHbBSA5', '2025-07-07 23:32:53', '2025-07-08 00:24:23'),
(2, 'Carlos', 'admin123', '2025-07-07 23:32:53', '2025-07-07 23:32:53'),
(4, 'test_admin_qa', '$2b$10$TzL9eGLpXFILz', '2025-07-07 23:44:14', '2025-07-07 23:44:14'),
(5, 'Luisa_pereira', '$2b$10$ZuwdzYJ.F0Hfq', '2025-07-08 00:23:55', '2025-07-08 00:23:55');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `game`
--

CREATE TABLE `game` (
  `Game_id` int(11) NOT NULL,
  `Game_name` varchar(30) NOT NULL,
  `Game_Public` tinyint(1) NOT NULL DEFAULT 1,
  `Game_Code` varchar(20) DEFAULT NULL,
  `Player_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `game`
--

INSERT INTO `game` (`Game_id`, `Game_name`, `Game_Public`, `Game_Code`, `Player_id`, `created_at`, `updated_at`) VALUES
(1, 'Batalla del Norte', 1, 'ABC123', 1, '2025-07-07 23:32:53', '2025-07-07 23:32:53'),
(2, 'Guerra de los Reinos', 0, 'XYZ789', 2, '2025-07-07 23:32:53', '2025-07-07 23:32:53');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `game_player_warrior`
--

CREATE TABLE `game_player_warrior` (
  `Game_id` int(11) NOT NULL,
  `Player_id` int(11) NOT NULL,
  `Warrior_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `game_player_warrior`
--

INSERT INTO `game_player_warrior` (`Game_id`, `Player_id`, `Warrior_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2025-07-07 23:32:53', '2025-07-07 23:32:53'),
(1, 2, 2, '2025-07-07 23:32:53', '2025-07-07 23:32:53'),
(2, 2, 2, '2025-07-07 23:32:53', '2025-07-07 23:32:53'),
(2, 3, 3, '2025-07-07 23:32:53', '2025-07-07 23:32:53');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `magic`
--

CREATE TABLE `magic` (
  `Magic_id` int(11) NOT NULL,
  `Magic_type` varchar(30) NOT NULL,
  `Admin_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `magic`
--

INSERT INTO `magic` (`Magic_id`, `Magic_type`, `Admin_id`, `created_at`, `updated_at`) VALUES
(1, 'Fuego', 1, '2025-07-07 23:32:53', '2025-07-07 23:32:53'),
(2, 'Hielo', 2, '2025-07-07 23:32:53', '2025-07-07 23:32:53'),
(3, 'Electricidad', 1, '2025-07-07 23:32:53', '2025-07-07 23:32:53');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `player`
--

CREATE TABLE `player` (
  `Player_id` int(11) NOT NULL,
  `Player_name` varchar(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `player`
--

INSERT INTO `player` (`Player_id`, `Player_name`, `created_at`, `updated_at`) VALUES
(1, 'Luisanys', '2025-07-07 23:32:53', '2025-07-07 23:32:53'),
(2, 'Daniel', '2025-07-07 23:32:53', '2025-07-07 23:32:53'),
(3, 'Camila', '2025-07-07 23:32:53', '2025-07-07 23:32:53');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `player_game`
--

CREATE TABLE `player_game` (
  `Game_id` int(11) NOT NULL,
  `Player_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `player_game`
--

INSERT INTO `player_game` (`Game_id`, `Player_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2025-07-07 23:32:53', '2025-07-07 23:32:53'),
(1, 2, '2025-07-07 23:32:53', '2025-07-07 23:32:53'),
(2, 2, '2025-07-07 23:32:53', '2025-07-07 23:32:53'),
(2, 3, '2025-07-07 23:32:53', '2025-07-07 23:32:53');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `power`
--

CREATE TABLE `power` (
  `Power_id` int(11) NOT NULL,
  `Power_name` varchar(30) NOT NULL,
  `Admin_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `power`
--

INSERT INTO `power` (`Power_id`, `Power_name`, `Admin_id`, `created_at`, `updated_at`) VALUES
(1, 'Ataque rápido', 1, '2025-07-07 23:32:53', '2025-07-07 23:32:53'),
(2, 'Invisibilidad', 2, '2025-07-07 23:32:53', '2025-07-07 23:32:53'),
(3, 'Curación', 1, '2025-07-07 23:32:53', '2025-07-07 23:32:53'),
(4, 'Teleportación', 2, '2025-07-07 23:32:53', '2025-07-07 23:32:53');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `race`
--

CREATE TABLE `race` (
  `Race_id` int(11) NOT NULL,
  `Race_name` varchar(30) NOT NULL,
  `Admin_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `race`
--

INSERT INTO `race` (`Race_id`, `Race_name`, `Admin_id`, `created_at`, `updated_at`) VALUES
(1, 'Elfo', 1, '2025-07-07 23:32:53', '2025-07-07 23:32:53'),
(2, 'Orco', 2, '2025-07-07 23:32:53', '2025-07-07 23:32:53'),
(3, 'Humano', 1, '2025-07-07 23:32:53', '2025-07-07 23:32:53');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `warrior`
--

CREATE TABLE `warrior` (
  `Warrior_id` int(11) NOT NULL,
  `Warrior_name` varchar(30) NOT NULL,
  `Warrior_level` int(11) NOT NULL,
  `Race_id` int(11) NOT NULL,
  `Warrior_type_id` int(11) NOT NULL,
  `Magic_id` int(11) DEFAULT NULL,
  `Admin_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `warrior`
--

INSERT INTO `warrior` (`Warrior_id`, `Warrior_name`, `Warrior_level`, `Race_id`, `Warrior_type_id`, `Magic_id`, `Admin_id`, `created_at`, `updated_at`) VALUES
(1, 'Thalor', 10, 1, 1, 1, 1, '2025-07-07 23:32:53', '2025-07-07 23:32:53'),
(2, 'Goruk', 5, 2, 2, 2, 2, '2025-07-07 23:32:53', '2025-07-07 23:32:53'),
(3, 'Aeryn', 8, 3, 3, 3, 1, '2025-07-07 23:32:53', '2025-07-07 23:32:53');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `warrior_power`
--

CREATE TABLE `warrior_power` (
  `Warrior_id` int(11) NOT NULL,
  `Power_id` int(11) NOT NULL,
  `Admin_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `warrior_power`
--

INSERT INTO `warrior_power` (`Warrior_id`, `Power_id`, `Admin_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2025-07-07 23:32:53', '2025-07-07 23:32:53'),
(1, 3, 1, '2025-07-07 23:32:53', '2025-07-07 23:32:53'),
(2, 2, 2, '2025-07-07 23:32:53', '2025-07-07 23:32:53'),
(3, 4, 1, '2025-07-07 23:32:53', '2025-07-07 23:32:53');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `warrior_type`
--

CREATE TABLE `warrior_type` (
  `Warrior_type_id` int(11) NOT NULL,
  `Warrior_type_name` varchar(30) NOT NULL,
  `Admin_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `warrior_type`
--

INSERT INTO `warrior_type` (`Warrior_type_id`, `Warrior_type_name`, `Admin_id`, `created_at`, `updated_at`) VALUES
(1, 'Espadachín', 1, '2025-07-07 23:32:53', '2025-07-07 23:32:53'),
(2, 'Arquero', 1, '2025-07-07 23:32:53', '2025-07-07 23:32:53'),
(3, 'Mago', 2, '2025-07-07 23:32:53', '2025-07-07 23:32:53');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`Admin_id`);

--
-- Indices de la tabla `game`
--
ALTER TABLE `game`
  ADD PRIMARY KEY (`Game_id`),
  ADD KEY `Player_id` (`Player_id`);

--
-- Indices de la tabla `game_player_warrior`
--
ALTER TABLE `game_player_warrior`
  ADD PRIMARY KEY (`Game_id`,`Player_id`,`Warrior_id`),
  ADD KEY `Player_id` (`Player_id`),
  ADD KEY `Warrior_id` (`Warrior_id`);

--
-- Indices de la tabla `magic`
--
ALTER TABLE `magic`
  ADD PRIMARY KEY (`Magic_id`),
  ADD KEY `Admin_id` (`Admin_id`);

--
-- Indices de la tabla `player`
--
ALTER TABLE `player`
  ADD PRIMARY KEY (`Player_id`);

--
-- Indices de la tabla `player_game`
--
ALTER TABLE `player_game`
  ADD PRIMARY KEY (`Game_id`,`Player_id`),
  ADD KEY `Player_id` (`Player_id`);

--
-- Indices de la tabla `power`
--
ALTER TABLE `power`
  ADD PRIMARY KEY (`Power_id`),
  ADD KEY `Admin_id` (`Admin_id`);

--
-- Indices de la tabla `race`
--
ALTER TABLE `race`
  ADD PRIMARY KEY (`Race_id`),
  ADD KEY `Admin_id` (`Admin_id`);

--
-- Indices de la tabla `warrior`
--
ALTER TABLE `warrior`
  ADD PRIMARY KEY (`Warrior_id`),
  ADD KEY `Race_id` (`Race_id`),
  ADD KEY `Warrior_type_id` (`Warrior_type_id`),
  ADD KEY `Magic_id` (`Magic_id`),
  ADD KEY `Admin_id` (`Admin_id`);

--
-- Indices de la tabla `warrior_power`
--
ALTER TABLE `warrior_power`
  ADD PRIMARY KEY (`Warrior_id`,`Power_id`),
  ADD KEY `Power_id` (`Power_id`),
  ADD KEY `Admin_id` (`Admin_id`);

--
-- Indices de la tabla `warrior_type`
--
ALTER TABLE `warrior_type`
  ADD PRIMARY KEY (`Warrior_type_id`),
  ADD KEY `Admin_id` (`Admin_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `admin`
--
ALTER TABLE `admin`
  MODIFY `Admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `game`
--
ALTER TABLE `game`
  MODIFY `Game_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `magic`
--
ALTER TABLE `magic`
  MODIFY `Magic_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `player`
--
ALTER TABLE `player`
  MODIFY `Player_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `power`
--
ALTER TABLE `power`
  MODIFY `Power_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `race`
--
ALTER TABLE `race`
  MODIFY `Race_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `warrior`
--
ALTER TABLE `warrior`
  MODIFY `Warrior_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `warrior_type`
--
ALTER TABLE `warrior_type`
  MODIFY `Warrior_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `game`
--
ALTER TABLE `game`
  ADD CONSTRAINT `game_ibfk_1` FOREIGN KEY (`Player_id`) REFERENCES `player` (`Player_id`);

--
-- Filtros para la tabla `game_player_warrior`
--
ALTER TABLE `game_player_warrior`
  ADD CONSTRAINT `game_player_warrior_ibfk_1` FOREIGN KEY (`Game_id`) REFERENCES `game` (`Game_id`),
  ADD CONSTRAINT `game_player_warrior_ibfk_2` FOREIGN KEY (`Player_id`) REFERENCES `player` (`Player_id`),
  ADD CONSTRAINT `game_player_warrior_ibfk_3` FOREIGN KEY (`Warrior_id`) REFERENCES `warrior` (`Warrior_id`);

--
-- Filtros para la tabla `magic`
--
ALTER TABLE `magic`
  ADD CONSTRAINT `magic_ibfk_1` FOREIGN KEY (`Admin_id`) REFERENCES `admin` (`Admin_id`);

--
-- Filtros para la tabla `player_game`
--
ALTER TABLE `player_game`
  ADD CONSTRAINT `player_game_ibfk_1` FOREIGN KEY (`Game_id`) REFERENCES `game` (`Game_id`),
  ADD CONSTRAINT `player_game_ibfk_2` FOREIGN KEY (`Player_id`) REFERENCES `player` (`Player_id`);

--
-- Filtros para la tabla `power`
--
ALTER TABLE `power`
  ADD CONSTRAINT `power_ibfk_1` FOREIGN KEY (`Admin_id`) REFERENCES `admin` (`Admin_id`);

--
-- Filtros para la tabla `race`
--
ALTER TABLE `race`
  ADD CONSTRAINT `race_ibfk_1` FOREIGN KEY (`Admin_id`) REFERENCES `admin` (`Admin_id`);

--
-- Filtros para la tabla `warrior`
--
ALTER TABLE `warrior`
  ADD CONSTRAINT `warrior_ibfk_1` FOREIGN KEY (`Race_id`) REFERENCES `race` (`Race_id`),
  ADD CONSTRAINT `warrior_ibfk_2` FOREIGN KEY (`Warrior_type_id`) REFERENCES `warrior_type` (`Warrior_type_id`),
  ADD CONSTRAINT `warrior_ibfk_3` FOREIGN KEY (`Magic_id`) REFERENCES `magic` (`Magic_id`),
  ADD CONSTRAINT `warrior_ibfk_4` FOREIGN KEY (`Admin_id`) REFERENCES `admin` (`Admin_id`);

--
-- Filtros para la tabla `warrior_power`
--
ALTER TABLE `warrior_power`
  ADD CONSTRAINT `warrior_power_ibfk_1` FOREIGN KEY (`Warrior_id`) REFERENCES `warrior` (`Warrior_id`),
  ADD CONSTRAINT `warrior_power_ibfk_2` FOREIGN KEY (`Power_id`) REFERENCES `power` (`Power_id`),
  ADD CONSTRAINT `warrior_power_ibfk_3` FOREIGN KEY (`Admin_id`) REFERENCES `admin` (`Admin_id`);

--
-- Filtros para la tabla `warrior_type`
--
ALTER TABLE `warrior_type`
  ADD CONSTRAINT `warrior_type_ibfk_1` FOREIGN KEY (`Admin_id`) REFERENCES `admin` (`Admin_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
