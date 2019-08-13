-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 13 Ağu 2019, 22:25:33
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
  `questioner_id` int(11) NOT NULL,
  `respondent_id` int(11) NOT NULL,
  `started_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `finished_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `privacy` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `conversation_topics`
--

CREATE TABLE `conversation_topics` (
  `id` int(11) NOT NULL,
  `conversation_id` int(11) NOT NULL,
  `topic_id` int(11) NOT NULL
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
-- Tablo için tablo yapısı `topics`
--

CREATE TABLE `topics` (
  `id` int(11) NOT NULL,
  `topic_name` varchar(255) NOT NULL
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

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `user_status`
--

CREATE TABLE `user_status` (
  `id` int(11) NOT NULL,
  `user_id` int(255) NOT NULL,
  `status_name` varchar(255) NOT NULL
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
-- Tablo için indeksler `conversation_topics`
--
ALTER TABLE `conversation_topics`
  ADD PRIMARY KEY (`id`),
  ADD KEY `conversation_topics_fk0` (`conversation_id`),
  ADD KEY `conversation_topics_fk1` (`topic_id`);

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
-- Tablo için indeksler `topics`
--
ALTER TABLE `topics`
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
-- Tablo için indeksler `user_status`
--
ALTER TABLE `user_status`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_status_fk0` (`user_id`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `conversation_logs`
--
ALTER TABLE `conversation_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `conversation_topics`
--
ALTER TABLE `conversation_topics`
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
-- Tablo için AUTO_INCREMENT değeri `topics`
--
ALTER TABLE `topics`
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
-- Tablo için AUTO_INCREMENT değeri `user_status`
--
ALTER TABLE `user_status`
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
-- Tablo kısıtlamaları `conversation_topics`
--
ALTER TABLE `conversation_topics`
  ADD CONSTRAINT `conversation_topics_fk0` FOREIGN KEY (`conversation_id`) REFERENCES `conversation_logs` (`id`),
  ADD CONSTRAINT `conversation_topics_fk1` FOREIGN KEY (`topic_id`) REFERENCES `topics` (`id`);

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

--
-- Tablo kısıtlamaları `user_status`
--
ALTER TABLE `user_status`
  ADD CONSTRAINT `user_status_fk0` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
