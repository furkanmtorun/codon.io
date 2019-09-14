-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 14 Eyl 2019, 19:59:04
-- Sunucu sürümü: 10.1.38-MariaDB
-- PHP Sürümü: 5.6.40

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `codon.io`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `abuse_allegations`
--

CREATE TABLE `abuse_allegations` (
  `id` int(11) NOT NULL,
  `message_id` int(11) NOT NULL,
  `complained_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `conversation_logs`
--

CREATE TABLE `conversation_logs` (
  `id` int(11) NOT NULL,
  `topic` varchar(140) NOT NULL,
  `questioner_id` int(11) NOT NULL,
  `respondent_id` int(11) NOT NULL,
  `room_id` varchar(255) NOT NULL,
  `started_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `finished_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `privacy` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `conversation_skills`
--

CREATE TABLE `conversation_skills` (
  `id` int(11) NOT NULL,
  `conversation_id` int(11) NOT NULL,
  `skill_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `error_reports`
--

CREATE TABLE `error_reports` (
  `id` int(11) NOT NULL,
  `conversation_id` int(11) NOT NULL,
  `reported_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `report` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `mes_uniq_id` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `conversation_id` int(11) NOT NULL,
  `sent_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `message` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `ranking_logs`
--

CREATE TABLE `ranking_logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `ranking_type` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `ranking_types`
--

CREATE TABLE `ranking_types` (
  `id` int(11) NOT NULL,
  `ranking_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `ranking_types`
--

INSERT INTO `ranking_types` (`id`, `ranking_name`) VALUES
(1, '1st of the week'),
(2, '2nd of the week'),
(3, '3rd of the week'),
(4, '1st of the month'),
(5, '2nd of the month'),
(6, '3rd of the month');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `rating_logs`
--

CREATE TABLE `rating_logs` (
  `id` int(11) NOT NULL,
  `rated_by` int(11) NOT NULL,
  `rated_about` int(11) NOT NULL,
  `rate_type_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `rating_types`
--

CREATE TABLE `rating_types` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `value` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `rating_types`
--

INSERT INTO `rating_types` (`id`, `name`, `value`) VALUES
(1, 'Terrible', 0),
(2, 'Not satisfied', 1),
(3, 'So so', 2),
(4, 'Good', 3),
(5, 'Very Good', 4),
(6, 'Excellent', 5);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `skills`
--

CREATE TABLE `skills` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `skill_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `skill_list`
--

CREATE TABLE `skill_list` (
  `id` int(11) NOT NULL,
  `skill_name` varchar(50) NOT NULL,
  `skill_cat` varchar(255) NOT NULL,
  `skill_logo` varchar(255) NOT NULL,
  `skill_desc` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `skill_list`
--

INSERT INTO `skill_list` (`id`, `skill_name`, `skill_cat`, `skill_logo`, `skill_desc`) VALUES
(1, '4th Dimension/4D', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(2, 'ABAP', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(3, 'ABC', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(4, 'ActionScript', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(5, 'Ada', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(6, 'Agilent VEE', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(7, 'Algol', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(8, 'Alice', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(9, 'Angelscript', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(10, 'Apex', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(11, 'APL', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(12, 'AppleScript', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(13, 'Arc', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(14, 'Arduino', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(15, 'ASP', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(16, 'AspectJ', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(17, 'Assembly', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(18, 'ATLAS', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(19, 'Augeas', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(20, 'AutoHotkey', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(21, 'AutoIt', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(22, 'AutoLISP', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(23, 'Automator', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(24, 'Avenue', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(25, 'Awk', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(26, 'Bash', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(27, '(Visual) Basic', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(28, 'bc', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(29, 'BCPL', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(30, 'BETA', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(31, 'BlitzMax', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(32, 'Boo', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(33, 'Bourne Shell', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(34, 'Bro', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(35, 'C', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(36, 'C Shell', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(37, 'C#', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(38, 'C++', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(39, 'C++/CLI', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(40, 'C-Omega', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(41, 'Caml', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(42, 'Ceylon', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(43, 'CFML', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(44, 'cg', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(45, 'Ch', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(46, 'CHILL', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(47, 'CIL', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(48, 'CL (OS/400)', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(49, 'Clarion', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(50, 'Clean', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(51, 'Clipper', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(52, 'Clojure', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(53, 'CLU', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(54, 'COBOL', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(55, 'Cobra', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(56, 'CoffeeScript', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(57, 'ColdFusion', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(58, 'COMAL', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(59, 'Common Lisp', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(60, 'Coq', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(61, 'cT', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(62, 'Curl', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(63, 'D', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(64, 'Dart', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(65, 'DCL', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(66, 'DCPU-16 ASM', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(67, 'Delphi/Object Pascal', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(68, 'DiBOL', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(69, 'Dylan', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(70, 'E', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(71, 'eC', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(72, 'Ecl', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(73, 'ECMAScript', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(74, 'EGL', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(75, 'Eiffel', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(76, 'Elixir', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(77, 'Emacs Lisp', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(78, 'Erlang', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(79, 'Etoys', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(80, 'Euphoria', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(81, 'EXEC', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(82, 'F#', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(83, 'Factor', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(84, 'Falcon', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(85, 'Fancy', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(86, 'Fantom', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(87, 'Felix', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(88, 'Forth', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(89, 'Fortran', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(90, 'Fortress', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(91, '(Visual) FoxPro', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(92, 'Gambas', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(93, 'GNU Octave', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(94, 'Go', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(95, 'Google AppsScript', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(96, 'Gosu', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(97, 'Groovy', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(98, 'Haskell', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(99, 'haXe', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(100, 'Heron', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(101, 'HPL', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(102, 'HyperTalk', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(103, 'Icon', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(104, 'IDL', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(105, 'Inform', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(106, 'Informix-4GL', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(107, 'INTERCAL', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(108, 'Io', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(109, 'Ioke', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(110, 'J', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(111, 'J#', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(112, 'JADE', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(113, 'Java', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(114, 'Java FX Script', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(115, 'JavaScript', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(116, 'JScript', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(117, 'JScript.NET', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(118, 'Julia', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(119, 'Korn Shell', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(120, 'Kotlin', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(121, 'LabVIEW', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(122, 'Ladder Logic', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(123, 'Lasso', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(124, 'Limbo', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(125, 'Lingo', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(126, 'Lisp', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(127, 'Logo', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(128, 'Logtalk', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(129, 'LotusScript', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(130, 'LPC', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(131, 'Lua', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(132, 'Lustre', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(133, 'M4', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(134, 'MAD', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(135, 'Magic', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(136, 'Magik', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(137, 'Malbolge', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(138, 'MANTIS', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(139, 'Maple', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(140, 'Mathematica', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(141, 'MATLAB', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(142, 'Max/MSP', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(143, 'MAXScript', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(144, 'MEL', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(145, 'Mercury', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(146, 'Mirah', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(147, 'Miva', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(148, 'ML', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(149, 'Monkey', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(150, 'Modula-2', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(151, 'Modula-3', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(152, 'MOO', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(153, 'Moto', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(154, 'MS-DOS Batch', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(155, 'MUMPS', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(156, 'NATURAL', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(157, 'Nemerle', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(158, 'Nimrod', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(159, 'NQC', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(160, 'NSIS', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(161, 'Nu', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(162, 'NXT-G', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(163, 'Oberon', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(164, 'Object Rexx', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(165, 'Objective-C', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(166, 'Objective-J', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(167, 'OCaml', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(168, 'Occam', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(169, 'ooc', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(170, 'Opa', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(171, 'OpenCL', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(172, 'OpenEdge ABL', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(173, 'OPL', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(174, 'Oz', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(175, 'Paradox', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(176, 'Parrot', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(177, 'Pascal', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(178, 'Perl', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(179, 'PHP', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(180, 'Pike', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(181, 'PILOT', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(182, 'PL/I', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(183, 'PL/SQL', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(184, 'Pliant', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(185, 'PostScript', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(186, 'POV-Ray', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(187, 'PowerBasic', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(188, 'PowerScript', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(189, 'PowerShell', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(190, 'Processing', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(191, 'Prolog', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(192, 'Puppet', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(193, 'Pure Data', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(194, 'Python', 'Language', 'https://www.stickpng.com/assets/images/5848152fcef1014c0b5e4967.png', 'Python is an interpreted, object-oriented, high-level programming language with dynamic semantics. '),
(195, 'Q', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(196, 'R', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(197, 'Racket', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(198, 'REALBasic', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(199, 'REBOL', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(200, 'Revolution', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(201, 'REXX', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(202, 'RPG (OS/400)', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(203, 'Ruby', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(204, 'Rust', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(205, 'S', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(206, 'S-PLUS', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(207, 'SAS', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(208, 'Sather', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(209, 'Scala', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(210, 'Scheme', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(211, 'Scilab', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(212, 'Scratch', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(213, 'sed', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(214, 'Seed7', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(215, 'Self', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(216, 'Shell', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(217, 'SIGNAL', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(218, 'Simula', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(219, 'Simulink', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(220, 'Slate', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(221, 'Smalltalk', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(222, 'Smarty', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(223, 'SPARK', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(224, 'SPSS', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(225, 'SQR', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(226, 'Squeak', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(227, 'Squirrel', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(228, 'Standard ML', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(229, 'Suneido', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(230, 'SuperCollider', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(231, 'TACL', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(232, 'Tcl', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(233, 'Tex', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(234, 'thinBasic', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(235, 'TOM', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(236, 'Transact-SQL', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(237, 'Turing', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(238, 'TypeScript', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(239, 'Vala/Genie', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(240, 'VBScript', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(241, 'Verilog', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(242, 'VHDL', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(243, 'VimL', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(244, 'Visual Basic .NET', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(245, 'WebDNA', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(246, 'Whitespace', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(247, 'X10', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(248, 'xBase', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(249, 'XBase++', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(250, 'Xen', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(251, 'XPL', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(252, 'XSLT', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(253, 'XQuery', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(254, 'yacc', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(255, 'Yorick', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', ''),
(256, 'Z shell', 'Language', 'https://www.itonlinelearning.com/wp-content/uploads/2018/06/Which-programming-langauge-should-i-learn-first-ITonlinelearning.jpg', '');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `statuses`
--

CREATE TABLE `statuses` (
  `id` int(11) NOT NULL,
  `status_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `statuses`
--

INSERT INTO `statuses` (`id`, `status_name`) VALUES
(1, 'Available'),
(2, 'Unavailable'),
(3, 'Asking'),
(4, 'Answering');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `gender` varchar(255) NOT NULL,
  `avatar_link` varchar(255) NOT NULL DEFAULT 'https://cdn3.iconfinder.com/data/icons/luchesa-vol-9/128/Html-512.png',
  `password` varchar(255) NOT NULL,
  `about` varchar(255) NOT NULL,
  `registered_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `role_id` int(11) NOT NULL DEFAULT '2',
  `status_id` int(11) NOT NULL DEFAULT '2',
  `room_id` varchar(255) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `user_logs`
--

CREATE TABLE `user_logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `logined_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ip` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `user_roles`
--

CREATE TABLE `user_roles` (
  `id` int(11) NOT NULL,
  `role_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `user_roles`
--

INSERT INTO `user_roles` (`id`, `role_name`) VALUES
(1, 'admin'),
(2, 'normal'),
(3, 'suspended'),
(4, 'banned');

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `abuse_allegations`
--
ALTER TABLE `abuse_allegations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `complained_by` (`complained_by`),
  ADD KEY `message_id` (`message_id`);

--
-- Tablo için indeksler `conversation_logs`
--
ALTER TABLE `conversation_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `conversation_logs_fk0` (`questioner_id`),
  ADD KEY `conversation_logs_fk1` (`respondent_id`);

--
-- Tablo için indeksler `conversation_skills`
--
ALTER TABLE `conversation_skills`
  ADD PRIMARY KEY (`id`),
  ADD KEY `conversation_topics_fk0` (`conversation_id`),
  ADD KEY `skill_id` (`skill_id`);

--
-- Tablo için indeksler `error_reports`
--
ALTER TABLE `error_reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `conversation_id` (`conversation_id`),
  ADD KEY `reported_by` (`reported_by`);

--
-- Tablo için indeksler `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mes_uniq_id` (`mes_uniq_id`),
  ADD KEY `messages_fk0` (`user_id`),
  ADD KEY `messages_fk1` (`conversation_id`);

--
-- Tablo için indeksler `ranking_logs`
--
ALTER TABLE `ranking_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ranking_logs_fk0` (`user_id`),
  ADD KEY `ranking_logs_fk1` (`ranking_type`);

--
-- Tablo için indeksler `ranking_types`
--
ALTER TABLE `ranking_types`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `rating_logs`
--
ALTER TABLE `rating_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rate_type_id` (`rate_type_id`),
  ADD KEY `rated_by` (`rated_by`),
  ADD KEY `rated_about` (`rated_about`);

--
-- Tablo için indeksler `rating_types`
--
ALTER TABLE `rating_types`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `skills`
--
ALTER TABLE `skills`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id_rest` (`user_id`),
  ADD KEY `skill_id_rest` (`skill_id`);

--
-- Tablo için indeksler `skill_list`
--
ALTER TABLE `skill_list`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `statuses`
--
ALTER TABLE `statuses`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `users_fk0` (`role_id`);

--
-- Tablo için indeksler `user_logs`
--
ALTER TABLE `user_logs`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`id`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `abuse_allegations`
--
ALTER TABLE `abuse_allegations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `conversation_logs`
--
ALTER TABLE `conversation_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `conversation_skills`
--
ALTER TABLE `conversation_skills`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `error_reports`
--
ALTER TABLE `error_reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `ranking_logs`
--
ALTER TABLE `ranking_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `ranking_types`
--
ALTER TABLE `ranking_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Tablo için AUTO_INCREMENT değeri `rating_logs`
--
ALTER TABLE `rating_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `rating_types`
--
ALTER TABLE `rating_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Tablo için AUTO_INCREMENT değeri `skills`
--
ALTER TABLE `skills`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `skill_list`
--
ALTER TABLE `skill_list`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=257;

--
-- Tablo için AUTO_INCREMENT değeri `statuses`
--
ALTER TABLE `statuses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Tablo için AUTO_INCREMENT değeri `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `user_logs`
--
ALTER TABLE `user_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `user_roles`
--
ALTER TABLE `user_roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `abuse_allegations`
--
ALTER TABLE `abuse_allegations`
  ADD CONSTRAINT `abuse_allegations_ibfk_2` FOREIGN KEY (`complained_by`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `abuse_allegations_ibfk_3` FOREIGN KEY (`message_id`) REFERENCES `messages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `conversation_logs`
--
ALTER TABLE `conversation_logs`
  ADD CONSTRAINT `conversation_logs_fk0` FOREIGN KEY (`questioner_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `conversation_logs_fk1` FOREIGN KEY (`respondent_id`) REFERENCES `users` (`id`);

--
-- Tablo kısıtlamaları `conversation_skills`
--
ALTER TABLE `conversation_skills`
  ADD CONSTRAINT `conversation_skills_ibfk_1` FOREIGN KEY (`skill_id`) REFERENCES `skill_list` (`id`),
  ADD CONSTRAINT `conversation_topics_fk0` FOREIGN KEY (`conversation_id`) REFERENCES `conversation_logs` (`id`);

--
-- Tablo kısıtlamaları `error_reports`
--
ALTER TABLE `error_reports`
  ADD CONSTRAINT `error_reports_ibfk_1` FOREIGN KEY (`conversation_id`) REFERENCES `conversation_logs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `error_reports_ibfk_2` FOREIGN KEY (`reported_by`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_fk0` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`conversation_id`) REFERENCES `conversation_logs` (`id`);

--
-- Tablo kısıtlamaları `ranking_logs`
--
ALTER TABLE `ranking_logs`
  ADD CONSTRAINT `ranking_logs_fk0` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `ranking_logs_fk1` FOREIGN KEY (`ranking_type`) REFERENCES `ranking_types` (`id`);

--
-- Tablo kısıtlamaları `rating_logs`
--
ALTER TABLE `rating_logs`
  ADD CONSTRAINT `rating_logs_ibfk_3` FOREIGN KEY (`rated_by`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `rating_logs_ibfk_4` FOREIGN KEY (`rated_about`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_fk0` FOREIGN KEY (`role_id`) REFERENCES `user_roles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
