-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 17 Ağu 2019, 22:53:06
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

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `statuses`
--

CREATE TABLE `statuses` (
  `id` int(11) NOT NULL,
  `status_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `statuses`
--
ALTER TABLE `statuses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `user_roles`
--
ALTER TABLE `user_roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
