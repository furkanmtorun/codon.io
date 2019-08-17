-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 17 Ağu 2019, 22:57:19
-- Sunucu sürümü: 10.1.36-MariaDB
-- PHP Sürümü: 7.2.10

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
  `conversation_id` int(11) NOT NULL,
  `complained_by` int(11) NOT NULL,
  `complained_about` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `answer_rates`
--

CREATE TABLE `answer_rates` (
  `id` int(11) NOT NULL,
  `conversation_id` int(11) NOT NULL,
  `rate_type_id` int(11) NOT NULL,
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

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `rate_types`
--

CREATE TABLE `rate_types` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `value` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
(1, '4th Dimension/4D', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(2, 'ABAP', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(3, 'ABC', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(4, 'ActionScript', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(5, 'Ada', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(6, 'Agilent VEE', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(7, 'Algol', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(8, 'Alice', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(9, 'Angelscript', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(10, 'Apex', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(11, 'APL', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(12, 'AppleScript', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(13, 'Arc', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(14, 'Arduino', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(15, 'ASP', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(16, 'AspectJ', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(17, 'Assembly', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(18, 'ATLAS', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(19, 'Augeas', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(20, 'AutoHotkey', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(21, 'AutoIt', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(22, 'AutoLISP', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(23, 'Automator', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(24, 'Avenue', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(25, 'Awk', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(26, 'Bash', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(27, '(Visual) Basic', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(28, 'bc', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(29, 'BCPL', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(30, 'BETA', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(31, 'BlitzMax', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(32, 'Boo', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(33, 'Bourne Shell', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(34, 'Bro', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(35, 'C', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(36, 'C Shell', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(37, 'C#', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(38, 'C++', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(39, 'C++/CLI', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(40, 'C-Omega', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(41, 'Caml', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(42, 'Ceylon', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(43, 'CFML', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(44, 'cg', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(45, 'Ch', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(46, 'CHILL', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(47, 'CIL', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(48, 'CL (OS/400)', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(49, 'Clarion', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(50, 'Clean', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(51, 'Clipper', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(52, 'Clojure', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(53, 'CLU', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(54, 'COBOL', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(55, 'Cobra', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(56, 'CoffeeScript', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(57, 'ColdFusion', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(58, 'COMAL', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(59, 'Common Lisp', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(60, 'Coq', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(61, 'cT', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(62, 'Curl', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(63, 'D', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(64, 'Dart', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(65, 'DCL', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(66, 'DCPU-16 ASM', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(67, 'Delphi/Object Pascal', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(68, 'DiBOL', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(69, 'Dylan', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(70, 'E', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(71, 'eC', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(72, 'Ecl', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(73, 'ECMAScript', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(74, 'EGL', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(75, 'Eiffel', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(76, 'Elixir', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(77, 'Emacs Lisp', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(78, 'Erlang', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(79, 'Etoys', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(80, 'Euphoria', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(81, 'EXEC', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(82, 'F#', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(83, 'Factor', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(84, 'Falcon', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(85, 'Fancy', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(86, 'Fantom', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(87, 'Felix', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(88, 'Forth', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(89, 'Fortran', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(90, 'Fortress', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(91, '(Visual) FoxPro', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(92, 'Gambas', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(93, 'GNU Octave', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(94, 'Go', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(95, 'Google AppsScript', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(96, 'Gosu', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(97, 'Groovy', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(98, 'Haskell', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(99, 'haXe', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(100, 'Heron', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(101, 'HPL', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(102, 'HyperTalk', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(103, 'Icon', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(104, 'IDL', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(105, 'Inform', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(106, 'Informix-4GL', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(107, 'INTERCAL', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(108, 'Io', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(109, 'Ioke', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(110, 'J', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(111, 'J#', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(112, 'JADE', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(113, 'Java', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(114, 'Java FX Script', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(115, 'JavaScript', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(116, 'JScript', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(117, 'JScript.NET', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(118, 'Julia', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(119, 'Korn Shell', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(120, 'Kotlin', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(121, 'LabVIEW', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(122, 'Ladder Logic', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(123, 'Lasso', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(124, 'Limbo', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(125, 'Lingo', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(126, 'Lisp', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(127, 'Logo', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(128, 'Logtalk', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(129, 'LotusScript', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(130, 'LPC', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(131, 'Lua', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(132, 'Lustre', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(133, 'M4', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(134, 'MAD', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(135, 'Magic', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(136, 'Magik', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(137, 'Malbolge', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(138, 'MANTIS', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(139, 'Maple', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(140, 'Mathematica', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(141, 'MATLAB', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(142, 'Max/MSP', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(143, 'MAXScript', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(144, 'MEL', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(145, 'Mercury', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(146, 'Mirah', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(147, 'Miva', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(148, 'ML', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(149, 'Monkey', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(150, 'Modula-2', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(151, 'Modula-3', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(152, 'MOO', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(153, 'Moto', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(154, 'MS-DOS Batch', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(155, 'MUMPS', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(156, 'NATURAL', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(157, 'Nemerle', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(158, 'Nimrod', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(159, 'NQC', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(160, 'NSIS', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(161, 'Nu', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(162, 'NXT-G', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(163, 'Oberon', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(164, 'Object Rexx', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(165, 'Objective-C', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(166, 'Objective-J', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(167, 'OCaml', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(168, 'Occam', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(169, 'ooc', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(170, 'Opa', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(171, 'OpenCL', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(172, 'OpenEdge ABL', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(173, 'OPL', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(174, 'Oz', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(175, 'Paradox', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(176, 'Parrot', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(177, 'Pascal', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(178, 'Perl', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(179, 'PHP', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(180, 'Pike', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(181, 'PILOT', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(182, 'PL/I', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(183, 'PL/SQL', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(184, 'Pliant', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(185, 'PostScript', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(186, 'POV-Ray', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(187, 'PowerBasic', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(188, 'PowerScript', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(189, 'PowerShell', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(190, 'Processing', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(191, 'Prolog', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(192, 'Puppet', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(193, 'Pure Data', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(194, 'Python', 'Language', 'https://www.stickpng.com/assets/images/5848152fcef1014c0b5e4967.png', 'Python is an interpreted, object-oriented, high-level programming language with dynamic semantics. '),
(195, 'Q', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(196, 'R', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(197, 'Racket', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(198, 'REALBasic', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(199, 'REBOL', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(200, 'Revolution', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(201, 'REXX', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(202, 'RPG (OS/400)', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(203, 'Ruby', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(204, 'Rust', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(205, 'S', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(206, 'S-PLUS', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(207, 'SAS', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(208, 'Sather', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(209, 'Scala', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(210, 'Scheme', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(211, 'Scilab', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(212, 'Scratch', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(213, 'sed', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(214, 'Seed7', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(215, 'Self', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(216, 'Shell', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(217, 'SIGNAL', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(218, 'Simula', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(219, 'Simulink', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(220, 'Slate', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(221, 'Smalltalk', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(222, 'Smarty', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(223, 'SPARK', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(224, 'SPSS', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(225, 'SQR', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(226, 'Squeak', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(227, 'Squirrel', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(228, 'Standard ML', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(229, 'Suneido', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(230, 'SuperCollider', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(231, 'TACL', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(232, 'Tcl', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(233, 'Tex', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(234, 'thinBasic', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(235, 'TOM', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(236, 'Transact-SQL', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(237, 'Turing', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(238, 'TypeScript', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(239, 'Vala/Genie', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(240, 'VBScript', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(241, 'Verilog', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(242, 'VHDL', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(243, 'VimL', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(244, 'Visual Basic .NET', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(245, 'WebDNA', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(246, 'Whitespace', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(247, 'X10', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(248, 'xBase', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(249, 'XBase++', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(250, 'Xen', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(251, 'XPL', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(252, 'XSLT', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(253, 'XQuery', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(254, 'yacc', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(255, 'Yorick', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', ''),
(256, 'Z shell', 'Language', 'http://softcaliber.com/blog/wp-content/uploads/2019/04/programmingLanguages.jpg', '');

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
  ADD KEY `complained_about` (`complained_about`),
  ADD KEY `complained_by` (`complained_by`),
  ADD KEY `conversation_id` (`conversation_id`);

--
-- Tablo için indeksler `answer_rates`
--
ALTER TABLE `answer_rates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `conversation_id` (`conversation_id`),
  ADD KEY `rate_type_id` (`rate_type_id`);

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
-- Tablo için indeksler `rate_types`
--
ALTER TABLE `rate_types`
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
-- Tablo için indeksler `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`id`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
  ADD CONSTRAINT `abuse_allegations_ibfk_1` FOREIGN KEY (`complained_about`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `abuse_allegations_ibfk_2` FOREIGN KEY (`complained_by`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `abuse_allegations_ibfk_3` FOREIGN KEY (`conversation_id`) REFERENCES `conversation_logs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `answer_rates`
--
ALTER TABLE `answer_rates`
  ADD CONSTRAINT `answer_rates_ibfk_1` FOREIGN KEY (`conversation_id`) REFERENCES `conversation_logs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `answer_rates_ibfk_2` FOREIGN KEY (`rate_type_id`) REFERENCES `rate_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

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
  ADD CONSTRAINT `messages_fk1` FOREIGN KEY (`conversation_id`) REFERENCES `conversation_logs` (`id`);

--
-- Tablo kısıtlamaları `ranking_logs`
--
ALTER TABLE `ranking_logs`
  ADD CONSTRAINT `ranking_logs_fk0` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `ranking_logs_fk1` FOREIGN KEY (`ranking_type`) REFERENCES `ranking_types` (`id`);

--
-- Tablo kısıtlamaları `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_fk0` FOREIGN KEY (`role_id`) REFERENCES `user_roles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
