-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2025. Ápr 15. 18:42
-- Kiszolgáló verziója: 10.4.32-MariaDB
-- PHP verzió: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `uszoeb`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `orszagok`
--

CREATE TABLE `orszagok` (
  `id` int(11) NOT NULL,
  `nev` varchar(60) DEFAULT NULL,
  `nobid` varchar(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `orszagok`
--

INSERT INTO `orszagok` (`id`, `nev`, `nobid`) VALUES
(1, 'Magyarország', 'HUN'),
(2, 'Nagy-Britannia', 'GBR');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `szamok`
--

CREATE TABLE `szamok` (
  `id` int(11) NOT NULL,
  `nev` varchar(40) DEFAULT NULL,
  `versenyzoid` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `szamok`
--

INSERT INTO `szamok` (`id`, `nev`, `versenyzoid`) VALUES
(1, '100m hát', 1),
(2, '200m hát', 1),
(3, '200m vegyes', 1),
(4, '200m vegyes', 2);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `versenyzok`
--

CREATE TABLE `versenyzok` (
  `id` int(11) NOT NULL,
  `nev` varchar(60) DEFAULT NULL,
  `orszagid` int(11) DEFAULT NULL,
  `nem` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `versenyzok`
--

INSERT INTO `versenyzok` (`id`, `nev`, `orszagid`, `nem`) VALUES
(1, 'Hosszú Katinka', 1, 'N'),
(2, 'Siobhan-Marie O’Connor', 2, 'N'),
(3, 'Késely Ajna', 1, 'N'),
(4, 'Telegdy Ádám', 1, 'F');

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `orszagok`
--
ALTER TABLE `orszagok`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `szamok`
--
ALTER TABLE `szamok`
  ADD PRIMARY KEY (`id`),
  ADD KEY `versenyzoid` (`versenyzoid`);

--
-- A tábla indexei `versenyzok`
--
ALTER TABLE `versenyzok`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orszagid` (`orszagid`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `orszagok`
--
ALTER TABLE `orszagok`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT a táblához `szamok`
--
ALTER TABLE `szamok`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT a táblához `versenyzok`
--
ALTER TABLE `versenyzok`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `szamok`
--
ALTER TABLE `szamok`
  ADD CONSTRAINT `szamok_ibfk_1` FOREIGN KEY (`versenyzoid`) REFERENCES `versenyzok` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Megkötések a táblához `versenyzok`
--
ALTER TABLE `versenyzok`
  ADD CONSTRAINT `versenyzok_ibfk_1` FOREIGN KEY (`orszagid`) REFERENCES `orszagok` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
