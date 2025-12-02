-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.43 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table serenity.blogs
CREATE TABLE IF NOT EXISTS `blogs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_keyword` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_description` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `status` enum('draft','published','archived') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'draft',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `blogs_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.blogs: ~0 rows (approximately)

-- Dumping structure for table serenity.blog_tag
CREATE TABLE IF NOT EXISTS `blog_tag` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `blog_id` bigint unsigned NOT NULL,
  `tag_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `blog_tag_blog_id_foreign` (`blog_id`),
  KEY `blog_tag_tag_id_foreign` (`tag_id`),
  CONSTRAINT `blog_tag_blog_id_foreign` FOREIGN KEY (`blog_id`) REFERENCES `blogs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `blog_tag_tag_id_foreign` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.blog_tag: ~0 rows (approximately)

-- Dumping structure for table serenity.brands
CREATE TABLE IF NOT EXISTS `brands` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `brands_name_unique` (`name`),
  UNIQUE KEY `brands_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.brands: ~1 rows (approximately)
INSERT INTO `brands` (`id`, `name`, `slug`, `description`, `status`, `created_at`, `updated_at`) VALUES
	(5, 'Default Brand', 'default-brand', NULL, 1, '2025-11-21 12:35:23', '2025-11-21 12:35:23');

-- Dumping structure for table serenity.cache
CREATE TABLE IF NOT EXISTS `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.cache: ~0 rows (approximately)

-- Dumping structure for table serenity.cache_locks
CREATE TABLE IF NOT EXISTS `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.cache_locks: ~0 rows (approximately)

-- Dumping structure for table serenity.categories
CREATE TABLE IF NOT EXISTS `categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `categories_name_unique` (`name`),
  UNIQUE KEY `categories_slug_unique` (`slug`),
  KEY `categories_parent_id_foreign` (`parent_id`),
  CONSTRAINT `categories_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.categories: ~11 rows (approximately)
INSERT INTO `categories` (`id`, `parent_id`, `name`, `slug`, `description`, `status`, `created_at`, `updated_at`) VALUES
	(1, NULL, 'Beauty', 'beauty', NULL, 1, '2025-11-20 20:23:24', '2025-11-20 20:23:24'),
	(2, NULL, 'Pets', 'pets', NULL, 1, '2025-11-20 20:23:41', '2025-11-20 20:23:41'),
	(3, 1, 'Wellness', 'wellness', NULL, 1, '2025-11-20 20:23:58', '2025-11-20 20:23:58'),
	(4, 1, 'Relaxation', 'relaxation', NULL, 1, '2025-11-20 20:24:35', '2025-11-20 20:24:35'),
	(5, 1, 'Home Comfort', 'home-comfort', NULL, 1, '2025-11-20 20:24:48', '2025-11-20 20:24:48'),
	(6, 1, 'Spiritual Balance', 'spiritual-balance', NULL, 1, '2025-11-20 20:25:02', '2025-11-20 20:25:02'),
	(7, 2, 'Wellness & Supplements', 'wellness-&-supplements', NULL, 1, '2025-11-20 20:27:16', '2025-11-20 20:27:16'),
	(8, 2, 'Spa & Grooming', 'spa-&-grooming', NULL, 1, '2025-11-20 20:27:32', '2025-11-20 20:27:32'),
	(9, 2, 'Home Care & Cleanup', 'home-care-&-cleanup', NULL, 1, '2025-11-20 20:27:43', '2025-11-20 20:27:43'),
	(10, 2, 'Hydration & Feeding', 'hydration-&-feeding', NULL, 1, '2025-11-20 20:27:55', '2025-11-20 20:27:55');

-- Dumping structure for table serenity.cms_pages
CREATE TABLE IF NOT EXISTS `cms_pages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `page_title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `page_slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `page_meta_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `page_meta_keyword` text COLLATE utf8mb4_unicode_ci,
  `page_meta_description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cms_pages_page_slug_unique` (`page_slug`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.cms_pages: ~5 rows (approximately)
INSERT INTO `cms_pages` (`id`, `page_title`, `page_slug`, `page_meta_title`, `page_meta_keyword`, `page_meta_description`, `created_at`, `updated_at`) VALUES
	(1, 'Home', 'home', 'Home | Pure Serenity', 'PureSerenity', 'Pure Serenity Shop', '2025-11-03 21:22:39', '2025-11-03 21:22:39'),
	(2, 'About Us', 'about-us', 'About Us', 'About Us', 'About Us', '2025-11-07 03:32:16', '2025-11-07 03:32:16'),
	(3, 'Shop', 'shop', 'shop', 'shop', 'shop', '2025-11-14 04:08:18', '2025-11-14 04:08:18'),
	(4, 'Pets', 'pets', 'pets', 'pets', 'pets', '2025-11-14 04:08:39', '2025-11-14 04:08:39'),
	(5, 'Contact Us', 'contact-us', 'contact-us', 'contact-us', 'contact us', '2025-11-14 04:09:19', '2025-11-14 04:09:19'),
	(6, 'Privacy Policy', 'privacy-policy', 'privacy policy', 'privacy policy', 'privacy policy', '2025-11-20 19:32:03', '2025-11-20 19:32:03');

-- Dumping structure for table serenity.cms_page_sections
CREATE TABLE IF NOT EXISTS `cms_page_sections` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `cms_page_id` bigint unsigned NOT NULL,
  `section_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `section_type` enum('single','repeater') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'single',
  `section_sort_order` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cms_page_sections_cms_page_id_foreign` (`cms_page_id`),
  CONSTRAINT `cms_page_sections_cms_page_id_foreign` FOREIGN KEY (`cms_page_id`) REFERENCES `cms_pages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.cms_page_sections: ~36 rows (approximately)
INSERT INTO `cms_page_sections` (`id`, `cms_page_id`, `section_name`, `section_type`, `section_sort_order`, `created_at`, `updated_at`) VALUES
	(1, 1, 'Hero Slider', 'repeater', 1, '2025-11-03 21:24:48', '2025-11-03 21:24:48'),
	(2, 1, 'Home About', 'single', 2, '2025-11-03 21:37:07', '2025-11-03 21:37:07'),
	(3, 1, 'Home Why Chose Us', 'single', 3, '2025-11-03 21:40:10', '2025-11-03 21:40:10'),
	(4, 1, 'Home Signature Collections', 'single', 4, '2025-11-03 21:56:42', '2025-11-03 21:56:42'),
	(5, 1, 'Home Journey Today', 'single', 5, '2025-11-03 22:15:27', '2025-11-03 22:15:27'),
	(6, 1, 'Home Discover Ritual', 'single', 6, '2025-11-03 22:30:35', '2025-11-03 22:30:35'),
	(7, 1, 'Home People Saying', 'single', 7, '2025-11-03 22:46:26', '2025-11-03 22:46:26'),
	(8, 1, 'Home Featured Products', 'single', 8, '2025-11-03 22:51:58', '2025-11-03 22:51:58'),
	(9, 2, 'About Banner', 'single', 1, '2025-11-14 03:08:11', '2025-11-14 03:08:11'),
	(10, 2, 'Our Mission', 'single', 2, '2025-11-14 03:09:50', '2025-11-14 03:09:50'),
	(11, 2, 'Community Section', 'single', 3, '2025-11-14 03:14:20', '2025-11-14 03:14:20'),
	(12, 2, 'Our Story - Content', 'single', 4, '2025-11-14 03:19:30', '2025-11-14 03:20:09'),
	(13, 2, 'Our Story', 'repeater', 5, '2025-11-14 03:20:21', '2025-11-14 03:20:21'),
	(14, 2, 'Commitment Section', 'single', 6, '2025-11-14 03:32:25', '2025-11-14 03:32:25'),
	(15, 2, 'Collective - Section', 'single', 7, '2025-11-14 03:43:50', '2025-11-14 03:44:21'),
	(16, 2, 'Team Section', 'repeater', 8, '2025-11-14 03:50:54', '2025-11-14 03:50:54'),
	(17, 2, 'Collective Impact - Section', 'single', 9, '2025-11-14 03:57:59', '2025-11-14 03:57:59'),
	(18, 2, 'Ritual Lab - Section', 'single', 10, '2025-11-14 04:05:40', '2025-11-14 04:05:40'),
	(19, 5, 'Contact Page Banner', 'single', 1, '2025-11-20 14:53:20', '2025-11-20 14:53:20'),
	(20, 5, 'Get In Touch', 'single', 2, '2025-11-20 15:10:01', '2025-11-20 15:10:01'),
	(21, 5, 'Inner Studio Section', 'single', 3, '2025-11-20 15:11:31', '2025-11-20 15:11:31'),
	(22, 5, 'Support Guide Section', 'single', 4, '2025-11-20 15:14:38', '2025-11-20 15:14:38'),
	(23, 5, 'Faq Content', 'single', 5, '2025-11-20 16:07:34', '2025-11-20 16:07:34'),
	(24, 5, 'Faq', 'repeater', 6, '2025-11-20 16:10:27', '2025-11-20 16:10:27'),
	(25, 5, 'Community Section', 'single', 7, '2025-11-20 16:25:01', '2025-11-20 16:25:01'),
	(26, 3, 'Shop Banner', 'single', 1, '2025-11-20 17:06:17', '2025-11-20 17:06:17'),
	(27, 3, 'Featured Collection Section', 'single', 2, '2025-11-20 17:11:37', '2025-11-20 17:11:37'),
	(28, 3, 'Spotlight Section', 'single', 3, '2025-11-20 17:18:46', '2025-11-20 17:18:46'),
	(29, 3, 'Perks Section', 'single', 4, '2025-11-20 17:20:24', '2025-11-20 17:20:24'),
	(30, 4, 'Pets Banner', 'single', 1, '2025-11-20 17:40:52', '2025-11-20 17:40:52'),
	(31, 4, 'Featured Collections Section', 'single', 2, '2025-11-20 17:45:00', '2025-11-20 17:45:00'),
	(32, 4, 'Ritual Guides', 'single', 3, '2025-11-20 17:47:22', '2025-11-20 17:47:22'),
	(33, 4, 'Perks Section', 'single', 4, '2025-11-20 17:50:39', '2025-11-20 17:50:39'),
	(34, 6, 'Privacy Policy Banner', 'single', 1, '2025-11-20 19:33:14', '2025-11-20 19:33:14'),
	(35, 6, 'Privacy policy', 'repeater', 2, '2025-11-20 19:43:58', '2025-11-20 19:43:58'),
	(36, 6, 'Details section', 'single', 3, '2025-11-20 19:45:39', '2025-11-20 19:45:39');

-- Dumping structure for table serenity.cms_page_section_fields
CREATE TABLE IF NOT EXISTS `cms_page_section_fields` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `cms_page_section_id` bigint unsigned NOT NULL,
  `field_group` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `field_type` enum('text','textarea','image','number','boolean','select') COLLATE utf8mb4_unicode_ci NOT NULL,
  `field_value` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cms_page_section_fields_cms_page_section_id_foreign` (`cms_page_section_id`),
  CONSTRAINT `cms_page_section_fields_cms_page_section_id_foreign` FOREIGN KEY (`cms_page_section_id`) REFERENCES `cms_page_sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=235 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.cms_page_section_fields: ~215 rows (approximately)
INSERT INTO `cms_page_section_fields` (`id`, `cms_page_section_id`, `field_group`, `field_name`, `field_type`, `field_value`, `created_at`, `updated_at`) VALUES
	(3, 1, 'Group_1', 'Title', 'text', 'Morning Rituals', '2025-11-03 21:27:16', '2025-11-05 22:24:45'),
	(4, 1, 'Group_1', 'Heading', 'text', 'Ease into the day with mindful energy', '2025-11-03 21:27:16', '2025-11-05 22:25:33'),
	(5, 1, 'Group_1', 'Description', 'textarea', '<p>Layer aromatherapy, sunrise lamps, and guided journaling to greet each morning feeling grounded and bright.</p>', '2025-11-03 21:27:16', '2025-11-03 21:28:26'),
	(6, 1, 'Group_1', 'Banner', 'image', 'cms_fields/1762277306_banner1.jpg', '2025-11-03 21:27:16', '2025-11-03 21:28:27'),
	(7, 1, 'Group_2', 'Title', 'text', 'Twilight Retreat', '2025-11-03 21:28:35', '2025-11-03 21:30:31'),
	(8, 1, 'Group_2', 'Heading', 'text', 'Wind down with calming essentials', '2025-11-03 21:28:35', '2025-11-03 21:30:31'),
	(9, 1, 'Group_2', 'Description', 'textarea', '<p>Create a sanctuary after sunset with plush textures, herbal teas, and soft light curated for deep relaxation.</p>', '2025-11-03 21:28:35', '2025-11-03 21:30:31'),
	(10, 1, 'Group_2', 'Banner', 'image', 'cms_fields/1762277431_banner2.jpg', '2025-11-03 21:28:35', '2025-11-03 21:30:31'),
	(11, 1, 'Group_3', 'Title', 'text', 'Gifted Serenity', '2025-11-03 21:28:40', '2025-11-03 21:30:31'),
	(12, 1, 'Group_3', 'Heading', 'text', 'Share curated calm with someone special', '2025-11-03 21:28:40', '2025-11-03 21:30:31'),
	(13, 1, 'Group_3', 'Description', 'textarea', '<p>From small gestures to statement bundles, discover gifts that help your favorite people breathe a little easier.</p>', '2025-11-03 21:28:40', '2025-11-03 21:30:31'),
	(14, 1, 'Group_3', 'Banner', 'image', 'cms_fields/1762277431_banner3.jpg', '2025-11-03 21:28:40', '2025-11-03 21:30:31'),
	(15, 2, NULL, 'Title', 'text', 'About Pure Serenity', '2025-11-03 21:37:45', '2025-11-03 21:38:16'),
	(16, 2, NULL, 'Heading', 'text', 'At Pure Serenity, we believe every woman deserves to feel beautiful and confident at any age.', '2025-11-03 21:37:45', '2025-11-03 21:38:16'),
	(17, 2, NULL, 'Description', 'textarea', '<p>Our products blend natural ingredients with proven science to help reduce wrinkles, firm skin, and bring back your radiant glow.</p>', '2025-11-03 21:37:45', '2025-11-03 21:38:16'),
	(18, 2, NULL, 'Image', 'image', 'cms_sections/j7F7y9dMENofVwmaeybOHvgho3AZlOV4hFIIFKca.jpg', '2025-11-03 21:37:45', '2025-11-03 21:38:16'),
	(19, 3, NULL, 'Heading', 'text', 'Why Choose Pure Serenity', '2025-11-03 21:42:53', '2025-11-03 21:44:52'),
	(20, 3, NULL, 'Description', 'textarea', '<p>We help you find peace and balance with carefully selected wellness products</p>', '2025-11-03 21:42:53', '2025-11-03 21:44:52'),
	(21, 3, NULL, 'Box 1 - Heading', 'text', 'Curated Selection', '2025-11-03 21:42:53', '2025-11-03 21:44:52'),
	(22, 3, NULL, 'Box 1 - Description', 'textarea', '<p>Handpicked products for your wellness journey</p>', '2025-11-03 21:42:53', '2025-11-03 21:44:52'),
	(23, 3, NULL, 'Box 2 - Heading', 'text', 'Peaceful Living', '2025-11-03 21:42:53', '2025-11-03 21:44:52'),
	(24, 3, NULL, 'Box 2 - Description', 'textarea', '<p>Create balance and harmony in daily life</p>', '2025-11-03 21:42:53', '2025-11-03 21:44:52'),
	(25, 3, NULL, 'Box 3 - Heading', 'text', 'Natural Wellness', '2025-11-03 21:42:53', '2025-11-03 21:44:52'),
	(26, 3, NULL, 'Box 3 - Description', 'textarea', '<p>Products that nurture mind, body, and spirit</p>', '2025-11-03 21:42:53', '2025-11-03 21:44:52'),
	(27, 3, NULL, 'Image 1', 'image', 'cms_sections/armEmk62pxT7XiXzYSVBH6V9qpv1TFds4Iez2sJG.jpg', '2025-11-03 21:43:50', '2025-11-03 21:44:52'),
	(28, 3, NULL, 'Image 2', 'image', 'cms_sections/ctCL316ZVN7RYugO6D0rKU39Qm3B3VcPC5c22iQn.jpg', '2025-11-03 21:43:50', '2025-11-03 21:44:52'),
	(29, 4, NULL, 'Title', 'text', 'Signature Collections', '2025-11-03 21:57:15', '2025-11-03 21:57:28'),
	(30, 4, NULL, 'Heading', 'text', 'Shop by the mood you want to create', '2025-11-03 21:57:15', '2025-11-03 21:57:28'),
	(31, 4, NULL, 'Description', 'textarea', '<p>Browse bundles curated for every moment of your day&mdash;from sunrise energizers to twilight rituals.</p>', '2025-11-03 21:57:15', '2025-11-03 21:57:28'),
	(32, 5, NULL, 'Heading', 'text', 'Start Your Wellness Journey Today', '2025-11-03 22:15:59', '2025-11-03 22:16:18'),
	(33, 5, NULL, 'Description', 'textarea', '<p>Discover products that bring calm and positivity into your everyday life</p>', '2025-11-03 22:15:59', '2025-11-03 22:16:18'),
	(34, 6, NULL, 'Title', 'text', 'Just For You', '2025-11-03 22:35:31', '2025-11-03 22:36:27'),
	(35, 6, NULL, 'Heading', 'text', 'Discover the ritual that fits your flow', '2025-11-03 22:35:31', '2025-11-03 22:36:27'),
	(36, 6, NULL, 'Description', 'textarea', '<p>Our mood matcher highlights products that support what you need most today&mdash;focus, restoration, or cozy comfort.</p>', '2025-11-03 22:35:31', '2025-11-03 22:36:27'),
	(37, 6, NULL, 'Box 1 - Heading', 'text', 'Elevate Energy', '2025-11-03 22:35:31', '2025-11-03 22:36:27'),
	(38, 6, NULL, 'Box 1 - Description', 'textarea', '<ul>\r\n	<li>Citrus mists</li>\r\n	<li>Motivational journals</li>\r\n	<li>Bright light therapy</li>\r\n</ul>', '2025-11-03 22:35:31', '2025-11-03 22:36:27'),
	(39, 6, NULL, 'Box 2 - Heading', 'text', 'Nightly Wind Down', '2025-11-03 22:35:31', '2025-11-03 22:36:27'),
	(40, 6, NULL, 'Box 2 - Description', 'textarea', '<ul>\r\n	<li>Silk sleep masks</li>\r\n	<li>Chamomile infusions</li>\r\n	<li>Weighted blankets</li>\r\n</ul>', '2025-11-03 22:35:31', '2025-11-03 22:36:27'),
	(41, 6, NULL, 'Box 3 - Heading', 'text', 'Self-Care Sunday', '2025-11-03 22:35:31', '2025-11-03 22:36:27'),
	(42, 6, NULL, 'Box 3 - Description', 'textarea', '<ul>\r\n	<li>Bath soaks</li>\r\n	<li>Facial rollers</li>\r\n	<li>Restorative playlists</li>\r\n</ul>', '2025-11-03 22:35:31', '2025-11-03 22:36:27'),
	(43, 7, NULL, 'Title', 'text', 'What People Are Saying', '2025-11-03 22:49:23', '2025-11-03 22:50:01'),
	(44, 7, NULL, 'Heading', 'text', 'Loved by our wellness community', '2025-11-03 22:49:23', '2025-11-03 22:50:01'),
	(45, 7, NULL, 'Description', 'textarea', '<p>We listen closely to the Pure Serenity community to keep refining every box, recommendation, and ritual guide we share.</p>', '2025-11-03 22:49:23', '2025-11-03 22:50:01'),
	(46, 7, NULL, 'Image 1', 'image', 'cms_sections/IRavYGbALuElwrTxHiRcqRweHXDWFSh4TgV8Cm0e.jpg', '2025-11-03 22:49:23', '2025-11-03 22:50:02'),
	(47, 7, NULL, 'Image 2', 'image', 'cms_sections/UP7B7s6U7AB7eHIpR7QTwhmMMskQcmySAB3XfD2K.jpg', '2025-11-03 22:49:23', '2025-11-03 22:50:02'),
	(48, 7, NULL, 'Image 3', 'image', 'cms_sections/9xLU1S7M7fGpd387wnHCRXNu1g2FEmW47MyaYaB3.jpg', '2025-11-03 22:49:23', '2025-11-03 22:50:02'),
	(49, 8, NULL, 'Title', 'text', 'Featured Products', '2025-11-03 22:52:22', '2025-11-03 22:52:39'),
	(50, 8, NULL, 'Heading', 'text', 'Fresh ideas to inspire your rituals', '2025-11-03 22:52:22', '2025-11-03 22:52:39'),
	(51, 8, NULL, 'Description', 'textarea', '<p>Explore a trio of customer-favorite essentials ready to elevate your daily calm.</p>', '2025-11-03 22:52:22', '2025-11-03 22:52:39'),
	(52, 9, NULL, 'Title', 'text', 'Inside Pure Serenity', '2025-11-14 03:08:40', '2025-11-14 03:09:20'),
	(53, 9, NULL, 'Heading', 'text', 'About Pure Serenity Shop', '2025-11-14 03:08:40', '2025-11-14 03:09:20'),
	(54, 9, NULL, 'Description', 'textarea', '<p>We curate thoughtful wellness rituals, meaningful partnerships, and cozy moments that bring calm into every day.</p>', '2025-11-14 03:08:40', '2025-11-14 03:09:20'),
	(55, 9, NULL, 'Banner Image', 'image', 'cms_sections/bhyqwlZ5wHfN7JENWXpheRdzs0Je9X5231rOpqMA.jpg', '2025-11-14 03:08:40', '2025-11-14 03:09:20'),
	(56, 10, NULL, 'Our Mission - Title', 'text', 'Our Mission', '2025-11-14 03:12:44', '2025-11-14 03:13:37'),
	(57, 10, NULL, 'Our Mission - Description', 'textarea', '<p>In a world that moves too fast, we&#39;re here to help you slow down. We curate products that encourage mindfulness, promote relaxation, and support your journey toward a more balanced life. Each item in our collection is chosen with intention and care.</p>', '2025-11-14 03:12:44', '2025-11-14 03:13:37'),
	(58, 10, NULL, '1st Box - Title', 'text', 'Wellness First', '2025-11-14 03:12:44', '2025-11-14 03:13:37'),
	(59, 10, NULL, '1st Box - Description', 'textarea', '<p>We prioritize products that genuinely support your physical and mental wellbeing</p>', '2025-11-14 03:12:44', '2025-11-14 03:13:37'),
	(60, 10, NULL, '2nd Box - Title', 'text', 'Quality Curation', '2025-11-14 03:12:44', '2025-11-14 03:13:37'),
	(61, 10, NULL, '2nd Box - Description', 'textarea', '<p>Every item is carefully selected and tested to meet our high standards</p>', '2025-11-14 03:12:44', '2025-11-14 03:13:37'),
	(62, 10, NULL, '3rd Box - Title', 'text', 'Mindful Living', '2025-11-14 03:12:44', '2025-11-14 03:13:37'),
	(63, 10, NULL, '3rd Box - Description', 'textarea', '<p>We believe in creating a balanced lifestyle through intentional choices</p>', '2025-11-14 03:12:44', '2025-11-14 03:13:37'),
	(64, 10, NULL, '4th Box - Title', 'text', 'Community Care', '2025-11-14 03:12:44', '2025-11-14 03:13:37'),
	(65, 10, NULL, '4th Box - Description', 'textarea', '<p>Building a supportive community focused on collective wellness and growth</p>', '2025-11-14 03:12:44', '2025-11-14 03:13:37'),
	(66, 11, NULL, 'Title', 'text', 'Join Our Wellness Community', '2025-11-14 03:15:25', '2025-11-14 03:16:41'),
	(67, 11, NULL, 'Heading', 'text', 'Membership that keeps your rituals inspired', '2025-11-14 03:15:25', '2025-11-14 03:16:41'),
	(68, 11, NULL, 'Description', 'textarea', '<p>Discover products that nurture your mind, body, and spirit. Whether you&#39;re beginning your wellness journey or deepening your practice, we&#39;re here to support you every step of the way.</p>', '2025-11-14 03:15:25', '2025-11-14 03:16:41'),
	(69, 11, NULL, 'Image', 'image', 'cms_sections/jS0ERhGfg7rgVjYq4AKMOAQXPCAntJnVcRKltqR3.jpg', '2025-11-14 03:15:25', '2025-11-14 03:16:41'),
	(70, 11, NULL, 'Image - Description', 'textarea', '<p>&ldquo;Every Sunday we gather virtually to slow down, share wins, and explore the ritual of the week&mdash;led by our guest coaches and community guides.&rdquo;</p>', '2025-11-14 03:15:25', '2025-11-14 03:16:41'),
	(71, 11, NULL, '1st Box', 'text', 'Weekly ritual circles', '2025-11-14 03:15:25', '2025-11-14 03:16:41'),
	(72, 11, NULL, '2nd Box', 'text', 'Live meditations & workshops', '2025-11-14 03:15:25', '2025-11-14 03:16:41'),
	(73, 11, NULL, '3rd Box', 'text', 'Curated playlists & guides', '2025-11-14 03:15:25', '2025-11-14 03:16:41'),
	(74, 12, NULL, 'Title', 'text', 'Our Story', '2025-11-14 03:20:44', '2025-11-14 03:21:07'),
	(75, 12, NULL, 'Heading', 'text', 'Crafted from a love of nourished moments', '2025-11-14 03:20:44', '2025-11-14 03:21:07'),
	(76, 12, NULL, 'Description', 'textarea', '<p>Pure Serenity is the culmination of years spent studying rituals from around the world, chatting with healers, and testing thousands of tactile products. Each milestone has been shaped by community feedback and a devotion to approachable, joy-filled wellness.</p>', '2025-11-14 03:20:44', '2025-11-14 03:21:07'),
	(77, 13, 'Group_1', 'Year', 'text', '2019', '2025-11-14 03:23:22', '2025-11-14 03:23:46'),
	(78, 13, 'Group_1', 'Title', 'text', 'The spark', '2025-11-14 03:23:22', '2025-11-14 03:23:47'),
	(79, 13, 'Group_1', 'Description', 'textarea', '<p>Pure Serenity began as a weekly newsletter sharing mindful rituals with friends and family.</p>', '2025-11-14 03:23:22', '2025-11-14 03:23:47'),
	(80, 13, 'Group_1', 'Image', 'image', 'cms_fields/1763144627_about-us2.jpg', '2025-11-14 03:23:22', '2025-11-14 03:23:47'),
	(81, 13, 'Group_2', 'Year', 'text', '2021', '2025-11-14 03:23:57', '2025-11-14 03:24:52'),
	(82, 13, 'Group_2', 'Title', 'text', 'Community grows', '2025-11-14 03:23:57', '2025-11-14 03:24:52'),
	(83, 13, 'Group_2', 'Description', 'textarea', '<p>Our curated shop launched with 30 handpicked products crafted by independent makers.</p>', '2025-11-14 03:23:57', '2025-11-14 03:24:52'),
	(84, 13, 'Group_2', 'Image', 'image', 'cms_fields/1763144692_about-us3.jpg', '2025-11-14 03:23:57', '2025-11-14 03:24:52'),
	(85, 13, 'Group_3', 'Year', 'text', '2024', '2025-11-14 03:24:03', '2025-11-14 03:25:20'),
	(86, 13, 'Group_3', 'Title', 'text', 'Wellness collective', '2025-11-14 03:24:03', '2025-11-14 03:25:20'),
	(87, 13, 'Group_3', 'Description', 'textarea', '<p>We partner with coaches, herbalists, and artists to co-create limited-edition ritual kits.</p>', '2025-11-14 03:24:03', '2025-11-14 03:25:20'),
	(88, 13, 'Group_3', 'Image', 'image', 'cms_fields/1763144720_about-us4.jpg', '2025-11-14 03:24:03', '2025-11-14 03:25:20'),
	(89, 14, NULL, 'Title', 'text', 'Our Commitment to You', '2025-11-14 03:35:35', '2025-11-14 03:35:46'),
	(90, 14, NULL, 'Description', 'textarea', '<p>We understand that finding quality wellness products can be overwhelming. That&#39;s why we do the research for you, testing and vetting each item before adding it to our shop.</p>\r\n\r\n<p>As an affiliate partner with trusted brands, we earn a small commission when you purchase through our links. This helps us continue curating the best products for you, at no extra cost.</p>\r\n\r\n<p>Your trust means everything to us. We only recommend products we genuinely believe will enhance your wellness journey.</p>', '2025-11-14 03:35:35', '2025-11-14 03:35:46'),
	(91, 15, NULL, 'Title', 'text', 'Meet the Collective', '2025-11-14 03:46:15', '2025-11-14 03:47:44'),
	(92, 15, NULL, 'heading', 'text', 'The people guiding your wellness journey', '2025-11-14 03:46:15', '2025-11-14 03:47:44'),
	(93, 15, NULL, 'Description', 'textarea', '<p>We are storytellers, listeners, and curious explorers who believe that soft moments can change a day.</p>', '2025-11-14 03:46:15', '2025-11-14 03:47:44'),
	(94, 16, 'Group_1', 'Title', 'text', 'Serena Rivera', '2025-11-14 03:51:42', '2025-11-14 03:53:52'),
	(95, 16, 'Group_1', 'Heading', 'text', 'Founder & Curator', '2025-11-14 03:51:42', '2025-11-14 03:53:52'),
	(96, 16, 'Group_1', 'Description', 'textarea', '<p>Designs every collection with an eye for harmony and intention.</p>', '2025-11-14 03:51:42', '2025-11-14 03:53:52'),
	(97, 16, 'Group_1', 'Image', 'image', 'cms_fields/1763146432_about-people1.jpg', '2025-11-14 03:51:42', '2025-11-14 03:53:52'),
	(98, 16, 'Group_2', 'Title', 'text', 'Jordan Lee', '2025-11-14 03:51:46', '2025-11-14 03:53:52'),
	(99, 16, 'Group_2', 'Heading', 'text', 'Community Guide', '2025-11-14 03:51:46', '2025-11-14 03:53:52'),
	(100, 16, 'Group_2', 'Description', 'textarea', '<p>Hosts live breathwork and guides our weekly ritual circles.</p>', '2025-11-14 03:51:46', '2025-11-14 03:53:52'),
	(101, 16, 'Group_2', 'Image', 'image', 'cms_fields/1763146432_about-people2.jpg', '2025-11-14 03:51:46', '2025-11-14 03:53:52'),
	(102, 16, 'Group_3', 'Title', 'text', 'Maya Chen', '2025-11-14 03:51:47', '2025-11-14 03:53:52'),
	(103, 16, 'Group_3', 'Heading', 'text', 'Sustainability Lead', '2025-11-14 03:51:47', '2025-11-14 03:53:52'),
	(104, 16, 'Group_3', 'Description', 'textarea', '<p>Ensures every partner aligns with our eco-conscious standards.</p>', '2025-11-14 03:51:47', '2025-11-14 03:53:52'),
	(105, 16, 'Group_3', 'Image', 'image', 'cms_fields/1763146432_about-people3.jpg', '2025-11-14 03:51:47', '2025-11-14 03:53:52'),
	(106, 17, NULL, 'Titile', 'text', 'Collective Impact', '2025-11-14 04:01:52', '2025-11-14 04:04:34'),
	(107, 17, NULL, 'Heading', 'text', 'Intentional shopping with ripple effects', '2025-11-14 04:01:52', '2025-11-14 04:04:34'),
	(108, 17, NULL, 'Description', 'textarea', '<p>Every affiliate purchase supports mindful makers, reduces waste through small-batch production, and funds community care initiatives. Together we keep wellness accessible, transparent, and kind.</p>', '2025-11-14 04:01:52', '2025-11-14 04:04:34'),
	(109, 17, NULL, 'Box 1 - title', 'text', 'Conscious Sourcing', '2025-11-14 04:01:52', '2025-11-14 04:04:34'),
	(115, 17, NULL, 'Box 1 - Description', 'textarea', '<p>Small-batch artisans and certified eco-friendly suppliers anchor our catalog.</p>', '2025-11-14 04:03:38', '2025-11-14 04:04:34'),
	(116, 17, NULL, 'Box 2 - title', 'text', 'Giving Circles', '2025-11-14 04:03:38', '2025-11-14 04:04:34'),
	(117, 17, NULL, 'Box 2 - Description', 'textarea', '<p>1% of every affiliate order funds mental health nonprofits within our community.</p>', '2025-11-14 04:03:38', '2025-11-14 04:04:34'),
	(118, 17, NULL, 'Box 3 - title', 'text', 'Wellness Scholarships', '2025-11-14 04:03:38', '2025-11-14 04:04:34'),
	(119, 17, NULL, 'Box 3 - Description', 'textarea', '<p>Free access to restorative workshops for caregivers and teachers each season.</p>', '2025-11-14 04:03:38', '2025-11-14 04:04:34'),
	(120, 18, NULL, 'Title', 'text', 'Inside the Ritual Lab', '2025-11-14 04:06:46', '2025-11-14 04:07:24'),
	(121, 18, NULL, 'Heading', 'text', 'Testing every product we recommend', '2025-11-14 04:06:46', '2025-11-14 04:07:24'),
	(122, 18, NULL, 'Description', 'textarea', '<p>Our light-filled studio is where we brew tea samples, compare textures, and build routine playlists at sunrise. We only share the products that evoke a genuine wow. Your trust guides every pick.</p>', '2025-11-14 04:06:46', '2025-11-14 04:07:24'),
	(123, 18, NULL, 'Tag Line', 'textarea', '<p>Sunrise sessions | sound baths | sensory testing</p>', '2025-11-14 04:06:46', '2025-11-14 04:07:24'),
	(124, 18, NULL, 'Image 1', 'image', 'cms_sections/vIMEfQZgbcBmwog3NvrpOHHxIFxBiHibzqLAW5mn.jpg', '2025-11-14 04:06:46', '2025-11-14 04:07:24'),
	(125, 18, NULL, 'Image 2', 'image', 'cms_sections/XnLvGrfdXanF2E5ArC2ievEIKnVNoQm90ns2nxui.jpg', '2025-11-14 04:06:46', '2025-11-14 04:07:25'),
	(126, 18, NULL, 'Image 3', 'image', 'cms_sections/nLnjGAF3IZVEln34haixUvQpIghMk9nAGCyOP4UO.jpg', '2025-11-14 04:06:46', '2025-11-14 04:07:25'),
	(127, 19, NULL, 'Title', 'text', 'We’re here to help', '2025-11-20 14:54:00', '2025-11-20 14:54:42'),
	(128, 19, NULL, 'Heading', 'text', 'Let’s talk about your wellness journey', '2025-11-20 14:54:00', '2025-11-20 14:54:42'),
	(129, 19, NULL, 'Description', 'textarea', '<p>Reach out for personalized recommendations, partnership inquiries, or support with your order.</p>', '2025-11-20 14:54:00', '2025-11-20 14:54:42'),
	(130, 19, NULL, 'Banner Image', 'image', 'cms_sections/l8VA1a7ojzScfooHCzYJBf87wtewpwEYLofp3zTt.jpg', '2025-11-20 14:54:00', '2025-11-20 14:54:42'),
	(131, 20, NULL, 'Heading', 'text', 'Get in Touch', '2025-11-20 15:10:22', '2025-11-20 15:11:05'),
	(132, 20, NULL, 'Description', 'textarea', '<p>We&#39;d love to hear from you. Send us a message and we&#39;ll respond as soon as possible.</p>', '2025-11-20 15:10:22', '2025-11-20 15:11:05'),
	(133, 21, NULL, 'Title', 'text', 'Inner Studio', '2025-11-20 15:12:35', '2025-11-20 15:13:52'),
	(134, 21, NULL, 'Heading', 'text', 'Where every Pure Serenity recommendation comes to life', '2025-11-20 15:12:35', '2025-11-20 15:13:52'),
	(135, 21, NULL, 'Description', 'textarea', '<p>Visit our Brooklyn ritual lab or schedule a virtual tour to see how we sample fragrances, test textures, and curate sensory playlists before sharing them with you.</p>', '2025-11-20 15:12:35', '2025-11-20 15:13:52'),
	(136, 21, NULL, 'Heading 2', 'text', 'What you\'ll experience', '2025-11-20 15:12:35', '2025-11-20 15:13:52'),
	(137, 21, NULL, 'Description 2', 'textarea', '<ul>\r\n	<li>Hands-on testing tables for textures, aromatherapy, and soundscapes.</li>\r\n	<li>Weekly guest healers sharing live meditations and ritual demos.</li>\r\n	<li>Playlist curation corner featuring analog mixers and vinyl for ambient layering.</li>\r\n</ul>', '2025-11-20 15:12:35', '2025-11-20 15:13:52'),
	(138, 21, NULL, 'Image', 'image', 'cms_sections/XJ2F3R8GC4nGklAbXn4b9RxHNvP4iBZZ5DIGOqGx.webp', '2025-11-20 15:12:35', '2025-11-20 15:13:52'),
	(139, 22, NULL, 'Title', 'text', 'Need a faster reply?', '2025-11-20 15:53:12', '2025-11-20 15:56:03'),
	(140, 22, NULL, 'Heading', 'text', 'Our support guides are ready to help', '2025-11-20 15:53:12', '2025-11-20 15:56:03'),
	(141, 22, NULL, 'Description', 'textarea', '<p>Whether you are designing a wellness retreat, planning corporate gifting, or selecting your first ritual kit, the concierge team has hands-on experience with every product in the shop.</p>', '2025-11-20 15:53:12', '2025-11-20 15:56:03'),
	(142, 22, NULL, 'Contact Heading', 'text', 'Text Concierge', '2025-11-20 15:53:12', '2025-11-20 15:56:03'),
	(143, 22, NULL, 'Contact Description', 'text', 'Message us at (333) 555-0192 for quick wellness recommendations.', '2025-11-20 15:53:12', '2025-11-20 15:56:03'),
	(144, 22, NULL, 'Time Heading', 'text', 'Support Hours', '2025-11-20 15:53:12', '2025-11-20 15:56:03'),
	(145, 22, NULL, 'Time Description', 'text', 'Monday-Friday: 9am-6pm EST | Saturday: 10am-2pm EST', '2025-11-20 15:53:12', '2025-11-20 15:56:03'),
	(146, 22, NULL, 'Location Heading', 'text', 'Ritual Studio', '2025-11-20 15:53:12', '2025-11-20 15:56:03'),
	(147, 22, NULL, 'Location Description', 'text', 'Book a private shopping appointment at our Brooklyn loft.', '2025-11-20 15:53:12', '2025-11-20 15:56:03'),
	(148, 22, NULL, 'Image Title', 'text', 'Studio Hours', '2025-11-20 15:53:12', '2025-11-20 15:56:03'),
	(149, 22, NULL, 'Image Description', 'text', 'Visit us by appointment for sensory testing sessions.', '2025-11-20 15:53:12', '2025-11-20 15:56:03'),
	(150, 22, NULL, 'Image', 'image', 'cms_sections/SP97mjThXYQol3JRYFxTMHVU9pKTQPUR093qFWNX.jpg', '2025-11-20 15:53:12', '2025-11-20 15:56:03'),
	(153, 23, NULL, 'Title', 'text', 'FAQ', '2025-11-20 16:08:56', '2025-11-20 16:09:13'),
	(154, 23, NULL, 'Heading', 'text', 'Questions we get from the Pure Serenity community', '2025-11-20 16:08:56', '2025-11-20 16:09:13'),
	(155, 23, NULL, 'Description', 'textarea', '<p>Click below to see how we handle custom orders, collaborations, and support timelines.</p>', '2025-11-20 16:08:56', '2025-11-20 16:09:13'),
	(156, 24, 'Group_1', 'Question', 'textarea', '<p>How soon will I hear back after submitting the form?</p>', '2025-11-20 16:11:06', '2025-11-20 16:11:22'),
	(157, 24, 'Group_1', 'Answer', 'textarea', '<p>We respond within two business days. For urgent requests, text us using the concierge line and note your order number.</p>', '2025-11-20 16:11:06', '2025-11-20 16:11:22'),
	(158, 24, 'Group_2', 'Question', 'textarea', '<p>Do you offer custom curated boxes?</p>', '2025-11-20 16:11:33', '2025-11-20 16:12:02'),
	(159, 24, 'Group_2', 'Answer', 'textarea', '<p>Yes! Share a few details about the recipient or occasion and our team will send 3 tailored bundles to choose from.</p>', '2025-11-20 16:11:33', '2025-11-20 16:12:02'),
	(160, 24, 'Group_3', 'Question', 'textarea', '<p>Can I pitch my wellness brand for collaboration?</p>', '2025-11-20 16:11:37', '2025-11-20 16:13:24'),
	(161, 24, 'Group_3', 'Answer', 'textarea', '<p>Absolutely. Tell us about your product story and sustainability practices - our curation team reviews submissions weekly.</p>', '2025-11-20 16:11:37', '2025-11-20 16:13:24'),
	(162, 25, NULL, 'Title', 'text', 'Studio Socials 1', '2025-11-20 16:36:06', '2025-11-20 16:37:26'),
	(163, 25, NULL, 'Heading', 'text', 'Peek behind the scenes', '2025-11-20 16:36:06', '2025-11-20 16:37:26'),
	(164, 25, NULL, 'Description', 'textarea', '<p>Follow along @PureSerenityShop for weekly ritual inspiration, playlists, and live product testing.</p>', '2025-11-20 16:36:06', '2025-11-20 16:37:26'),
	(165, 25, NULL, 'Image Text 1', 'text', 'Tea tasting hour inside the Pure Serenity studio.', '2025-11-20 16:36:06', '2025-11-20 16:37:26'),
	(167, 25, NULL, 'Image Text 2', 'text', 'New aromatherapy collection landing soon.', '2025-11-20 16:36:06', '2025-11-20 16:37:26'),
	(169, 25, NULL, 'Image Text 3', 'text', 'Community journaling circle every Thursday.', '2025-11-20 16:36:06', '2025-11-20 16:37:26'),
	(171, 25, NULL, 'Image 1', 'image', 'cms_sections/5lIpZy2YwhiogH81W5HNPEIWIyrVoQgAK021qr5W.jpg', '2025-11-20 16:38:12', '2025-11-20 16:40:54'),
	(172, 25, NULL, 'Image 2', 'image', 'cms_sections/WVAWQlYXx7Wkcqrax620XaIGR1E5JvjDkab45KeI.jpg', '2025-11-20 16:38:12', '2025-11-20 16:40:54'),
	(173, 25, NULL, 'Image 3', 'image', 'cms_sections/71Jdx4DOtgGAbCP5Vuc7Yb8uDY4jOBjyosx9Cg1y.jpg', '2025-11-20 16:38:12', '2025-11-20 16:40:54'),
	(174, 26, NULL, 'Title', 'text', 'Curated Marketplace', '2025-11-20 17:08:22', '2025-11-20 17:09:47'),
	(175, 26, NULL, 'Heading', 'text', 'Shop Pure Serenity', '2025-11-20 17:08:22', '2025-11-20 17:09:47'),
	(176, 26, NULL, 'Description', 'textarea', '<p>Discover curated rituals, calming essentials, and mindful luxuries selected to elevate your everyday.</p>', '2025-11-20 17:08:22', '2025-11-20 17:09:47'),
	(177, 26, NULL, 'Shop Banner', 'image', 'cms_sections/z2zKL83H6Hc0AYGX7iv1nxqdml7NUf63rgTlarDz.jpg', '2025-11-20 17:08:22', '2025-11-20 17:09:47'),
	(178, 27, NULL, 'Heading', 'text', 'Our Featured Collections', '2025-11-20 17:12:14', '2025-11-20 17:13:28'),
	(179, 27, NULL, 'Description', 'textarea', '<p>Explore our carefully curated selection of wellness products</p>', '2025-11-20 17:12:14', '2025-11-20 17:13:28'),
	(180, 28, NULL, 'Title', 'text', 'Editor Spotlights', '2025-11-20 17:19:21', '2025-11-20 17:19:37'),
	(181, 28, NULL, 'Heading', 'text', 'Ritual edits to guide your cart', '2025-11-20 17:19:21', '2025-11-20 17:19:37'),
	(182, 28, NULL, 'Description', 'textarea', '<p>Lean on our stylists for a polished selection. Each edit features well-loved products paired with new discoveries.</p>', '2025-11-20 17:19:21', '2025-11-20 17:19:37'),
	(183, 29, NULL, 'Title', 'text', 'Pure Serenity Perks', '2025-11-20 17:20:46', '2025-11-20 17:20:59'),
	(184, 29, NULL, 'Heading', 'text', 'Shop confidently with rituals that last', '2025-11-20 17:20:46', '2025-11-20 17:20:59'),
	(185, 29, NULL, 'Description', 'textarea', '<p>We remove the guesswork so your wellness investments genuinely support a calmer life.</p>', '2025-11-20 17:20:46', '2025-11-20 17:20:59'),
	(186, 29, NULL, 'Card 1 heading', 'text', 'Curated Quality', '2025-11-20 17:22:39', '2025-11-20 17:23:29'),
	(187, 29, NULL, 'Card 1 Description', 'textarea', '<p>Every product is hand-tested by our ritual lab before it reaches the shop.</p>', '2025-11-20 17:22:39', '2025-11-20 17:23:29'),
	(188, 29, NULL, 'Card 2 heading', 'text', 'Bundle & Save', '2025-11-20 17:22:39', '2025-11-20 17:23:29'),
	(189, 29, NULL, 'Card 2 Description', 'textarea', '<p>Look for collection badges to unlock exclusive affiliate bundle pricing.</p>', '2025-11-20 17:22:39', '2025-11-20 17:23:29'),
	(190, 29, NULL, 'Card 3 heading', 'text', 'Fast Shipping', '2025-11-20 17:22:39', '2025-11-20 17:23:29'),
	(191, 29, NULL, 'Card 3 Description', 'textarea', '<p>Prime-eligible picks get to your door in as few as two days.</p>', '2025-11-20 17:22:39', '2025-11-20 17:23:29'),
	(192, 29, NULL, 'Card 4 heading', 'text', 'Trusted Partners', '2025-11-20 17:22:39', '2025-11-20 17:23:29'),
	(193, 29, NULL, 'Card 4 Description', 'textarea', '<p>We only partner with brands committed to ethical and sustainable practices.</p>', '2025-11-20 17:22:39', '2025-11-20 17:23:29'),
	(194, 30, NULL, 'Title', 'text', 'Pure Serenity Pet Essentials', '2025-11-20 17:41:52', '2025-11-20 17:44:30'),
	(195, 30, NULL, 'Heading', 'text', 'Happy Pets, Calmer Homes', '2025-11-20 17:41:52', '2025-11-20 17:44:30'),
	(196, 30, NULL, 'Description', 'textarea', '<p>Shop trusted essentials for your furry family grooming, calming, toys, and cleaning products.</p>', '2025-11-20 17:41:52', '2025-11-20 17:44:30'),
	(197, 30, NULL, 'Banner Image', 'image', 'cms_sections/eok42Boeb0VS0HMReR9WY98jSQ5RbHSwgtHRFxYl.jpg', '2025-11-20 17:41:52', '2025-11-20 17:44:30'),
	(198, 31, NULL, 'Heading', 'text', 'Featured Pet Collections', '2025-11-20 17:45:53', '2025-11-20 17:46:08'),
	(199, 31, NULL, 'Description', 'textarea', '<p>Intentional grooming, calming, and play essentials selected to nurture serene routines.</p>', '2025-11-20 17:45:53', '2025-11-20 17:46:08'),
	(200, 32, NULL, 'Title', 'text', 'Pet Ritual Guides', '2025-11-20 17:49:52', '2025-11-20 17:50:17'),
	(201, 32, NULL, 'Heading', 'text', 'Stylists-curated pet edits', '2025-11-20 17:49:52', '2025-11-20 17:50:17'),
	(202, 32, NULL, 'Description', 'textarea', '<p>Build a soothing pet routine with curated bundles tested in our calm climate studio.</p>', '2025-11-20 17:49:52', '2025-11-20 17:50:17'),
	(203, 33, NULL, 'Title', 'text', 'Serenity Perks', '2025-11-20 17:55:23', '2025-11-20 18:05:22'),
	(204, 33, NULL, 'Heading', 'text', 'Care with confidence', '2025-11-20 17:55:23', '2025-11-20 18:05:23'),
	(205, 33, NULL, 'Description', 'textarea', '<p>From daily brushes to enrichment toys, each recommendation is evaluated for long-term wellbeing.</p>', '2025-11-20 17:55:23', '2025-11-20 18:05:23'),
	(206, 33, NULL, 'Card 1 heading', 'text', 'Pet-Tested Picks', '2025-11-20 17:55:23', '2025-11-20 18:05:23'),
	(214, 33, NULL, 'Card 1 Description', 'textarea', '<p>All items are reviewed with trainers and groomers for comfort and long-term safety.</p>', '2025-11-20 17:57:41', '2025-11-20 18:05:23'),
	(215, 33, NULL, 'Card 2 heading', 'text', 'Calm-First Philosophy', '2025-11-20 17:58:15', '2025-11-20 18:05:23'),
	(216, 33, NULL, 'Card 2 Description', 'textarea', '<p>Products are selected to soften stressful transitions, from grooming sessions to travel days.</p>', '2025-11-20 17:58:15', '2025-11-20 18:05:23'),
	(217, 33, NULL, 'Card 3 heading', 'text', 'Holistic Wellness', '2025-11-20 17:58:41', '2025-11-20 18:05:23'),
	(218, 33, NULL, 'Card 3 Description', 'textarea', '<p>We pair supplements with routines and accessories that support mind-body balance.</p>', '2025-11-20 17:58:41', '2025-11-20 18:05:23'),
	(219, 33, NULL, 'Card 4 heading', 'text', 'Ethical Partners', '2025-11-20 17:59:17', '2025-11-20 18:05:23'),
	(220, 33, NULL, 'Card 4 Description', 'textarea', '<p>Brands align with cruelty-free standards and transparent ingredient lists.</p>', '2025-11-20 17:59:17', '2025-11-20 18:05:23'),
	(221, 34, NULL, 'Title', 'text', 'Privacy Policy', '2025-11-20 19:34:41', '2025-11-20 19:37:10'),
	(222, 34, NULL, 'Heading', 'text', 'Privacy & Data Care', '2025-11-20 19:34:41', '2025-11-20 19:37:10'),
	(223, 34, NULL, 'Description', 'textarea', '<p>We honor your privacy as carefully as we curate your wellness routine. Explore how we collect, safeguard, and use your information.</p>', '2025-11-20 19:34:41', '2025-11-20 19:37:10'),
	(224, 34, NULL, 'Banner image', 'image', 'cms_sections/udybBqiC5Y6Wbnq6ljTdQHDHU31f7eGKqlQv6BLe.jpg', '2025-11-20 19:34:41', '2025-11-20 19:37:11'),
	(225, 35, 'Group_1', 'Heading', 'text', 'Our Commitment to Your Privacy', '2025-11-20 19:44:21', '2025-11-20 19:45:12'),
	(226, 35, 'Group_1', 'Description', 'textarea', '<p>Pure Serenity collects only the information needed to fulfill your orders, personalize recommendations, and keep you informed about new rituals. We never sell or rent your personal data to third parties.</p>', '2025-11-20 19:44:21', '2025-11-20 19:45:12'),
	(227, 35, 'Group_2', 'Heading', 'text', 'What We Collect', '2025-11-20 19:44:27', '2025-11-20 19:45:12'),
	(228, 35, 'Group_2', 'Description', 'textarea', '<p>When you shop with us or subscribe to Pure Notes, we may store your name, email address, shipping details, and purchase history. Any payment information is processed securely by our trusted payment partners.</p>', '2025-11-20 19:44:27', '2025-11-20 19:45:12'),
	(229, 35, 'Group_3', 'Heading', 'text', 'How We Use Your Information', '2025-11-20 19:44:29', '2025-11-20 19:45:12'),
	(230, 35, 'Group_3', 'Description', 'textarea', '<p>Your details help us deliver orders, respond to support requests, tailor product suggestions, and share relevant content. We also use aggregated analytics to improve the Pure Serenity experience across our site.</p>', '2025-11-20 19:44:29', '2025-11-20 19:45:12'),
	(231, 35, 'Group_4', 'Heading', 'text', 'Staying in Control', '2025-11-20 19:44:30', '2025-11-20 19:45:12'),
	(232, 35, 'Group_4', 'Description', 'textarea', '<p>You can update your preferences or unsubscribe from marketing emails at any time using the link provided in our messages. For data removal or additional questions, reach out to privacy@pureserenityshop.com.</p>', '2025-11-20 19:44:30', '2025-11-20 19:45:12'),
	(233, 36, NULL, 'Heading', 'text', 'Need More Details?', '2025-11-20 19:46:04', '2025-11-20 19:46:17'),
	(234, 36, NULL, 'Description', 'textarea', '<p>Email our privacy team at&nbsp;<a href="mailto:privacy@pureserenityshop.com">privacy@pureserenityshop.com</a>&nbsp;and we will respond within two business days.</p>', '2025-11-20 19:46:04', '2025-11-20 19:46:17');

-- Dumping structure for table serenity.comments
CREATE TABLE IF NOT EXISTS `comments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `comment` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `commentable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `commentable_id` bigint unsigned NOT NULL,
  `parent_id` bigint unsigned DEFAULT NULL,
  `user_id` bigint unsigned NOT NULL,
  `status` enum('pending','approved','rejected') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `comments_commentable_type_commentable_id_index` (`commentable_type`,`commentable_id`),
  KEY `comments_parent_id_foreign` (`parent_id`),
  KEY `comments_user_id_foreign` (`user_id`),
  CONSTRAINT `comments_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `comments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.comments: ~0 rows (approximately)

-- Dumping structure for table serenity.contact_inquiries
CREATE TABLE IF NOT EXISTS `contact_inquiries` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.contact_inquiries: ~2 rows (approximately)
INSERT INTO `contact_inquiries` (`id`, `name`, `email`, `phone`, `subject`, `message`, `type`, `is_read`, `deleted_at`, `created_at`, `updated_at`) VALUES
	(1, 'Nicholas Irwin', 'qula@mailinator.com', NULL, 'Adipisci voluptates', 'Assumenda veniam pa', NULL, 1, NULL, '2025-11-20 14:35:25', '2025-11-21 13:25:31'),
	(2, 'Ada', 'ada@wong.com', NULL, 'Lorem Ipsum', 'This is lorem ipsum', NULL, 1, NULL, '2025-11-20 14:36:10', '2025-11-21 13:25:25');

-- Dumping structure for table serenity.failed_jobs
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.failed_jobs: ~0 rows (approximately)

-- Dumping structure for table serenity.general_settings
CREATE TABLE IF NOT EXISTS `general_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'text',
  `value` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `general_settings_key_unique` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.general_settings: ~8 rows (approximately)
INSERT INTO `general_settings` (`id`, `key`, `type`, `value`, `created_at`, `updated_at`) VALUES
	(1, 'Email', 'text', 'hello@pureserenityshop.com', '2025-11-20 14:42:00', '2025-11-20 14:48:39'),
	(2, 'Phone', 'text', '+1234567890', '2025-11-20 14:42:00', '2025-11-20 14:48:39'),
	(3, 'Response Time', 'text', 'We typically respond within 24-48 hours', '2025-11-20 14:42:00', '2025-11-20 14:48:39'),
	(4, 'Have Questions', 'text', 'Whether you need product recommendations or have inquiries about our affiliate partnerships, we\'re here to help!', '2025-11-20 14:42:00', '2025-11-20 14:48:39'),
	(5, 'Footer Content', 'textarea', '<p>Curated rituals for your modern sanctuary. Our team tests every recommendation so you can invest in wellness pieces with confidence.</p>', '2025-11-20 14:42:00', '2025-11-20 14:48:39'),
	(6, 'Facebook', 'text', 'https://www.facebook.com/', '2025-11-20 14:49:18', '2025-11-20 14:50:09'),
	(7, 'Instagram', 'text', 'https://www.instagram.com/', '2025-11-20 14:49:18', '2025-11-20 14:50:09'),
	(8, 'Twitter', 'text', 'https://x.com/', '2025-11-20 14:49:18', '2025-11-20 14:50:09');

-- Dumping structure for table serenity.jobs
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.jobs: ~0 rows (approximately)

-- Dumping structure for table serenity.job_batches
CREATE TABLE IF NOT EXISTS `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.job_batches: ~0 rows (approximately)

-- Dumping structure for table serenity.media
CREATE TABLE IF NOT EXISTS `media` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `media_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mediaable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mediaable_id` bigint unsigned NOT NULL,
  `is_featured` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `media_mediaable_type_mediaable_id_index` (`mediaable_type`,`mediaable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.media: ~8 rows (approximately)
INSERT INTO `media` (`id`, `path`, `media_type`, `mediaable_type`, `mediaable_id`, `is_featured`, `deleted_at`, `created_at`, `updated_at`) VALUES
	(1, 'products/UVJRoVIBnikqY2tHoeo9wwIy3v8yiBFxrQh0WCIt.jpg', 'image', 'App\\Models\\Product', 1, 1, '2025-11-21 12:43:45', '2025-11-21 12:35:23', '2025-11-21 12:43:45'),
	(2, 'products/x7vQ96RXjA885zml0ypDlDVORkbB3ZQhrJ7v40vI.png', 'image', 'App\\Models\\Product', 1, 1, '2025-11-21 12:44:01', '2025-11-21 12:43:45', '2025-11-21 12:44:01'),
	(3, 'products/QO78qeqzAvOJSTfaCxqp8NxR6XkGrWZVeWlXbstN.png', 'image', 'App\\Models\\Product', 1, 1, '2025-11-21 12:44:30', '2025-11-21 12:44:01', '2025-11-21 12:44:30'),
	(4, 'products/FeYNQsp35qgeWRngRQ8y3xGsfT7nmeVfzt9lLimg.jpg', 'image', 'App\\Models\\Product', 1, 1, '2025-11-21 12:49:52', '2025-11-21 12:44:30', '2025-11-21 12:49:52'),
	(5, 'products/3CPTFrejm4uKcMiT5dguDNmPxLXSx4o6oPf7Fu12.png', 'image', 'App\\Models\\Product', 1, 1, '2025-11-21 12:50:41', '2025-11-21 12:49:52', '2025-11-21 12:50:41'),
	(6, 'products/BWWKIptzdQ4vXJLDYg3oOjYg0u7pmwsM2eLzGZ38.jpg', 'image', 'App\\Models\\Product', 1, 1, '2025-11-21 12:58:58', '2025-11-21 12:50:41', '2025-11-21 12:58:58'),
	(7, '/storage/categories/zl70LJ9OMko558XDsDUmGciniQwBOOpFOBsGKRGV.png', 'image', 'App\\Models\\Category', 11, 1, '2025-11-21 13:06:49', '2025-11-21 13:05:19', '2025-11-21 13:06:49'),
	(8, '/storage/categories/aXZvcEhHNreroNVjb6iCadpLQEZ3ylR12maAAOfP.png', 'image', 'App\\Models\\Category', 11, 1, '2025-11-21 13:24:35', '2025-11-21 13:06:49', '2025-11-21 13:24:35'),
	(9, 'products/i2I2ahzfRJ6I59X3z0AJV6r3wngJSrd9JUM1mhHu.jpg', 'image', 'App\\Models\\Product', 2, 1, '2025-11-21 22:30:20', '2025-11-21 13:31:26', '2025-11-21 22:30:20'),
	(10, 'products/IdfrcJbt0xepHIPYt70tRxkCXulFd3ZnF80ivHb7.webp', 'image', 'App\\Models\\Product', 3, 1, '2025-11-21 22:30:41', '2025-11-21 20:02:56', '2025-11-21 22:30:41'),
	(11, 'products/HVTzTh3SpK88JTmQgpWbafpjB78mLlBgdkvQJJfQ.webp', 'image', 'App\\Models\\Product', 4, 1, '2025-11-21 22:31:08', '2025-11-21 22:27:36', '2025-11-21 22:31:08'),
	(12, 'products/0BtbCb8yeNuVK8HOrCb6SlF4W7snwfyIF5y0eeGJ.webp', 'image', 'App\\Models\\Product', 1, 1, NULL, '2025-11-21 22:30:01', '2025-11-21 22:30:01'),
	(13, 'products/aU7MfR9JCsGMGd6JvaSJIsdgGdhhhmfc6Lg5Me6f.webp', 'image', 'App\\Models\\Product', 2, 1, NULL, '2025-11-21 22:30:20', '2025-11-21 22:30:20'),
	(14, 'products/Itx4ETZtMw72T8k49YfKqTMxrMwIJcwIWW3Krnpj.webp', 'image', 'App\\Models\\Product', 3, 1, NULL, '2025-11-21 22:30:41', '2025-11-21 22:30:41'),
	(15, 'products/PxAW05t7xRmeEFf89oZZBBJtMorIHfTxtPxjDfcr.webp', 'image', 'App\\Models\\Product', 4, 1, NULL, '2025-11-21 22:31:08', '2025-11-21 22:31:08'),
	(16, 'products/foFAuoHrJQTvy9kJsn172cCnc3iNjC1XWh1rnFeU.webp', 'image', 'App\\Models\\Product', 5, 1, NULL, '2025-11-21 22:31:30', '2025-11-21 22:31:30'),
	(17, 'products/HRisS9PT1s8O3KtJwn9JUxkgHeRi9x0GOsajzi4J.webp', 'image', 'App\\Models\\Product', 6, 1, NULL, '2025-11-21 22:31:54', '2025-11-21 22:31:54'),
	(18, 'products/gYUxTe2KVkmmAXKhpQuRwsq8IFuGNmIC3XqQ0bxN.webp', 'image', 'App\\Models\\Product', 7, 1, NULL, '2025-11-21 22:32:21', '2025-11-21 22:32:21'),
	(19, 'products/TDsyzoe88JpkN0beJz1jPKWQk2lr8w8d5yKNJQVW.webp', 'image', 'App\\Models\\Product', 8, 1, NULL, '2025-11-21 22:32:59', '2025-11-21 22:32:59'),
	(20, 'products/FB16L1WFjLq8jnuMjJiUcA0LpzdFgY0G6eACOkOI.webp', 'image', 'App\\Models\\Product', 9, 1, NULL, '2025-11-21 22:33:22', '2025-11-21 22:33:22'),
	(21, 'products/9oEKAlML19PBllSUbGnfZjkC9ckG5lKsnhIFyrIB.webp', 'image', 'App\\Models\\Product', 10, 1, NULL, '2025-11-21 22:34:42', '2025-11-21 22:34:42'),
	(22, 'products/zLfhC9O01nrXeCtcglU471hY0TXXxcItFpqX1PqK.webp', 'image', 'App\\Models\\Product', 11, 1, NULL, '2025-11-21 22:35:22', '2025-11-21 22:35:22'),
	(23, 'products/nzIJcuvYLCigWqzSvIYuxx21tOXV4hYX6LByyKkr.webp', 'image', 'App\\Models\\Product', 12, 1, NULL, '2025-11-21 22:35:49', '2025-11-21 22:35:49'),
	(24, 'products/eSC6qsBH9Ie2R0pB4fK3MdJ7IInMcB9UVHJDDNJE.webp', 'image', 'App\\Models\\Product', 13, 1, NULL, '2025-11-21 22:36:14', '2025-11-21 22:36:14'),
	(25, 'products/6weKnEphkuMbT40goHjFpb5f1ICxf2iaUNbl5Uf3.webp', 'image', 'App\\Models\\Product', 14, 1, NULL, '2025-11-21 22:36:38', '2025-11-21 22:36:38'),
	(26, 'products/ATmunNoKuL9ebTjDdjFSwJ3a6HI8odsxt8SytxyG.webp', 'image', 'App\\Models\\Product', 15, 1, NULL, '2025-11-21 22:37:12', '2025-11-21 22:37:12'),
	(27, 'products/mZtJlvEplhMwrS8podXBWISOl5Cq5EeEPN7xGACU.webp', 'image', 'App\\Models\\Product', 16, 1, NULL, '2025-11-21 22:37:38', '2025-11-21 22:37:38'),
	(28, 'products/t9TqaujyG4JKEoRgcOAazQqDeetqGacPTmV8njbY.webp', 'image', 'App\\Models\\Product', 17, 1, NULL, '2025-11-21 22:38:05', '2025-11-21 22:38:05'),
	(29, 'products/DKRvmzAUzL84BLZmC0Sj2Wh52DwVvMRXnKx8b5vr.webp', 'image', 'App\\Models\\Product', 18, 1, NULL, '2025-11-21 22:38:50', '2025-11-21 22:38:50'),
	(30, 'products/OQUusEBji4aeUIFgI0VOGWLPQIfwmO0OnW4CFwNy.webp', 'image', 'App\\Models\\Product', 19, 1, NULL, '2025-11-21 22:39:41', '2025-11-21 22:39:41');

-- Dumping structure for table serenity.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.migrations: ~25 rows (approximately)
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '0001_01_01_000000_create_users_table', 1),
	(2, '0001_01_01_000001_create_cache_table', 1),
	(3, '0001_01_01_000002_create_jobs_table', 1),
	(4, '2025_03_07_174825_create_roles_table', 1),
	(5, '2025_03_11_005549_create_smtp_settings_table', 1),
	(6, '2025_03_11_005632_create_settings_table', 1),
	(7, '2025_03_12_174255_create_general_settings_table', 1),
	(8, '2025_03_14_165559_create_cms_pages_table', 1),
	(9, '2025_03_14_165622_create_cms_page_sections_table', 1),
	(10, '2025_03_14_165724_create_cms_page_section_fields_table', 1),
	(11, '2025_03_20_004833_create_newsletters_table', 1),
	(12, '2025_03_20_181115_add_soft_delete_column_in_news_letter', 1),
	(13, '2025_03_24_225725_create_contact_inquiries_table', 1),
	(14, '2025_03_26_185938_create_tags_table', 1),
	(15, '2025_03_26_185947_create_blogs_table', 1),
	(16, '2025_03_26_185955_create_media_table', 1),
	(17, '2025_03_26_191914_create_blog_tag_table', 1),
	(18, '2025_03_28_163339_create_comments_table', 1),
	(19, '2025_04_28_194922_create_categories_table', 1),
	(20, '2025_04_28_194931_create_brands_table', 1),
	(21, '2025_04_30_231701_create_product_attributes_table', 1),
	(22, '2025_04_30_231719_create_product_attribute_options_table', 1),
	(23, '2025_04_30_231739_create_products_table', 1),
	(24, '2025_04_30_231747_create_product_variations_table', 1),
	(25, '2025_11_14_000001_add_amazon_link_to_products_table', 1);

-- Dumping structure for table serenity.newsletters
CREATE TABLE IF NOT EXISTS `newsletters` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_subscribed` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `newsletters_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.newsletters: ~2 rows (approximately)
INSERT INTO `newsletters` (`id`, `email`, `is_subscribed`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 'cucetuto@mailinator.com', 1, '2025-11-21 13:34:18', '2025-11-21 13:34:40', '2025-11-21 13:34:40'),
	(2, 'dili@mailinator.com', 1, '2025-11-21 14:05:00', '2025-11-21 14:05:00', NULL);

-- Dumping structure for table serenity.password_reset_tokens
CREATE TABLE IF NOT EXISTS `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.password_reset_tokens: ~0 rows (approximately)

-- Dumping structure for table serenity.products
CREATE TABLE IF NOT EXISTS `products` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `amazon_link` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `base_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `stock` int NOT NULL DEFAULT '0',
  `has_variations` tinyint(1) NOT NULL DEFAULT '0',
  `category_id` bigint unsigned NOT NULL,
  `brand_id` bigint unsigned NOT NULL,
  `has_discount` tinyint(1) NOT NULL DEFAULT '0',
  `discount_type` enum('fixed','percentage') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount_value` decimal(10,2) DEFAULT NULL,
  `created_by` bigint unsigned NOT NULL,
  `featured` tinyint(1) NOT NULL DEFAULT '0',
  `new` tinyint(1) NOT NULL DEFAULT '0',
  `top` tinyint(1) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `products_category_id_foreign` (`category_id`),
  KEY `products_brand_id_foreign` (`brand_id`),
  KEY `products_created_by_foreign` (`created_by`),
  CONSTRAINT `products_brand_id_foreign` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `products_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.products: ~2 rows (approximately)
INSERT INTO `products` (`id`, `name`, `slug`, `description`, `amazon_link`, `base_price`, `stock`, `has_variations`, `category_id`, `brand_id`, `has_discount`, `discount_type`, `discount_value`, `created_by`, `featured`, `new`, `top`, `status`, `created_at`, `updated_at`) VALUES
	(1, 'Jennifer Aniston Perfume', 'jennifer-aniston-perfume', '<p>Jennifer Aniston by Jennifer Aniston Eau de Parfum Womens Perfume - 0.33 fl oz</p>', 'https://www.amazon.com/Jennifer-Aniston-Parfum-Womens-Perfume/dp/B07CKR1JNM?crid=3HZIFHDVQKLBN&dib=eyJ2IjoiMSJ9.P4HaPc1YOIPESwOjGvL7Ma0u1haO9yi0qW60BOnxOUwyqrHmQ_bmJuhhVxxHA6b-3xQJKx2ecpwdVWsnRdsZXalO5IW9PU6BQfyAEHBX3G7DA0NFaF3AT_V83xnA0vbII6npTmli3Ooz5h_zDB8AyWKqe-QW8Ji41qgzl7YUPyZMKg_Jcu2sEwTyKv-9SC4WsPe3HukT0Wj8J7GejS6zzh8-phTJkXRzLp-XoohzIUsBEVTbPsyha-aO_j3EQVNcGsVTnqqG3dLvfZnzNPWBrui65JUPUH471uaAy1xWlAA.JIrY-N_RqLFeZZcqxc8k_O5iBCFekCCgoKyya_x3_I8&dib_tag=se&keywords=Aniston%2BEau%2BParfum&qid=1761686206&sprefix=%2Caps%2C622&sr=8-3&th=1&linkCode=ll1&tag=pureserenity-20&linkId=e760712fa12a63dba20d97f496dbc7aa&language=en_US&ref_=as_li_ss_tl', 0.00, 0, 0, 3, 5, 0, NULL, 0.00, 1, 0, 0, 0, 1, '2025-11-21 22:30:01', '2025-11-21 22:30:01'),
	(2, 'Olay Ultra rich Moisture Butter', 'olay-ultra-rich-moisture-butter', '<p>Olay Body Wash for Women, Ultra Moisture, 24hr Moisturizing, Hydrating &amp; Refreshing, B3 Vitamin Complex, Free of Parabens &amp; Phthalates, For All Skin Types, Shea Butter Scent, 22 fl oz (Pack of 4)</p>', 'https://www.amazon.com/Olay-Ultra-Rich-Moisture-Butter/dp/B0BHH1LBX2?crid=32LLDY65D6Y8L&dib=eyJ2IjoiMSJ9.DEXjqcpe5vJL6jYEiv4me8k4CgyaHaGPezBeFj3v4okDIyqtobO6ISy8jfv3tU2uEmAj3P7HpsHefZQv9MpnXDqNyX4FvuTzErS-PoNZl_9UUrYDMfpe0_TtVZ_DaSD1ezFX7NtpYF3Trn26kJH3eObKsB8BBAqefpdbly4KtHBj6lIOBqJB0YK6zMJ-MmNiysDOfKFQmJlHKZ8mqMSt5y83zocZLPul8LNMxAfNSLZItM6KUaYT4YD8pReN7s0TiT6JjwrwENU3zN3UdbKVxHRvcBFzIpH7Et4o_NaRieM.gUSWH_z2uT_NA2PvT1XndiS2fhzOR8ZmrDyPjh-syIY&dib_tag=se&keywords=necessaire%2Bbody%2Bwash&qid=1761739642&sprefix=Necessaire%2BBody%2Blotion%2Caps%2C232&sr=8-3-spons&sp_csd=d2lkZ2V0TmFtZT1zcF9hdGY&th=1&linkCode=ll1&tag=pureserenity-20&linkId=8c8a11fa9a1e707b64e464c2f53fd426&language=en_US&ref_=as_li_ss_tl', 0.00, 0, 0, 3, 5, 0, NULL, 0.00, 1, 0, 0, 0, 1, '2025-11-21 22:30:20', '2025-11-21 22:30:20'),
	(3, 'Cetaphil Moisturizing cream', 'cetaphil-moisturizing-cream', '<p>Cetaphil Face &amp; Body Moisturizer, Hydrating Moisturizing Cream for Dry to Very Dry, Sensitive Skin, NEW 16 oz 2 Pack, Fragrance Free, Non-Comedogenic, Non-Greasy</p>', 'https://www.amazon.com/Moisturizer-Hydrating-Moisturizing-Non-Comedogenic-Non-Greasy/dp/B01H20MA62?crid=3QTSJZNUSALL3&dib=eyJ2IjoiMSJ9.4s3py5bOtCIJhvWB9AyYtkxClNA-WYZs0528oIk8lm4_0zSM5AKtjVyI2hMcTbX77dbeXRxIqdW4UN-ZFGqmfNqPFnHhMFcRRd3-YEFtOkJ21XFeOQ8UsKKD9jz96-Pe6Np-4k--4QEEG6_eJ6E9Lx9Wk3cH4yuIAaTbU8lFdilbGx2UDlOwf9iJRP-Y5hvUef5nAFAuNKhL8PlIN_GF8WtiRPouhg7g96CMIeFiP0lmCPsXUtWLDEL6EPh_ZqyZWcn24o9vJxEXBkkAQmaw1zOQMBbDDBj3CcbXjxcIyyU.QdH8g_T3TjjgfQldNY-qkptcWf2ZQxbR87JTu7U_ahU&dib_tag=se&keywords=Cetaphil%2BHydrating%2BMoisturizing%2BLotion&qid=1761739794&rdc=1&sprefix=cetaphil%2Bhydrating%2Bmoisturizing%2Blotion%2Caps%2C241&sr=8-7&th=1&linkCode=ll1&tag=pureserenity-20&linkId=fd4503bf39f92128409f3c2a2058868e&language=en_US&ref_=as_li_ss_tl', 0.00, 0, 0, 3, 5, 0, NULL, 0.00, 1, 0, 0, 0, 1, '2025-11-21 22:30:41', '2025-11-21 22:30:41'),
	(4, 'Cerava Face Moisturizer', 'cerava-face-moisturizer', '<p>CeraVe Moisturizing Cream, Body and Face Moisturizer for Dry Skin, Body Cream with Hyaluronic Acid and Ceramides, Daily Moisturizer, Oil-Free, Fragrance Free, Non-Comedogenic, 19 Ounce</p>', 'https://www.amazon.com/CeraVe-Moisturizing-Cream-Daily-Moisturizer/dp/B00TTD9BRC?crid=3QTSJZNUSALL3&dib=eyJ2IjoiMSJ9.4s3py5bOtCIJhvWB9AyYtkxClNA-WYZs0528oIk8lm4_0zSM5AKtjVyI2hMcTbX77dbeXRxIqdW4UN-ZFGqmfNqPFnHhMFcRRd3-YEFtOkJ21XFeOQ8UsKKD9jz96-Pe6Np-4k--4QEEG6_eJ6E9Lx9Wk3cH4yuIAaTbU8lFdilbGx2UDlOwf9iJRP-Y5hvUef5nAFAuNKhL8PlIN_GF8WtiRPouhg7g96CMIeFiP0lmCPsXUtWLDEL6EPh_ZqyZWcn24o9vJxEXBkkAQmaw1zOQMBbDDBj3CcbXjxcIyyU.QdH8g_T3TjjgfQldNY-qkptcWf2ZQxbR87JTu7U_ahU&dib_tag=se&keywords=Cetaphil%2BHydrating%2BMoisturizing%2BLotion&qid=1761739794&sprefix=cetaphil%2Bhydrating%2Bmoisturizing%2Blotion%2Caps%2C241&sr=8-22-spons&sp_csd=d2lkZ2V0TmFtZT1zcF9tdGY&th=1&linkCode=ll1&tag=pureserenity-20&linkId=175a1921236358a5f7b7170d20492215&language=en_US&ref_=as_li_ss_tl', 0.00, 0, 0, 4, 5, 0, NULL, 0.00, 1, 0, 0, 0, 1, '2025-11-21 22:31:08', '2025-11-21 22:31:08'),
	(5, 'Nivea Cocoa butter', 'nivea-cocoa-butter', '<p>NIVEA Cocoa Butter Body Cream with Deep Nourishing Serum, Cocoa Butter Cream for Dry Skin, 16 Ounce Jar</p>', 'https://www.amazon.com/NIVEA-Hyaluronic-Nourishing-72-Hour-Moisturizer/dp/B01H6OYPU8?crid=2YZDE67Q3H3UC&dib=eyJ2IjoiMSJ9.v01rNmRvso3MtB459Q_Ja3DWgGcqki2Br8CmBGpBNU76oHtoyEE3gKOew5ifYLJg51oKy74UxrznBzr4CubJ0dM6gDaHOpg89cYLqS_-41B7kjl-m3ItAsNT8mJaZV32Y7SoYRBoU7Fb7EF7O_HgqAHdAStyYvvYNno6muzM5ZcDIli7ALr9BLsilnE5JpwQUJtcaNMeWas-NV1rMJHAAHO7q75E6YOA4W-G5o4ifrkyX8FIJqooO5T8eYf4IlKaI1pCiqGXX1dQHubDm5lRjdkxc40rUlBW3aBAbL1WWt8.DkCulD--kVJBrTgdJDLIJxWNZQgay2mYwl8F24eU5q0&dib_tag=se&keywords=NIVEA%2BEssentially%2BEnriched%2BBody%2BLotion&qid=1761740106&sprefix=nivea%2Bessentially%2Benriched%2Bbody%2Blotion%2Caps%2C381&sr=8-26&th=1&linkCode=ll1&tag=pureserenity-20&linkId=a3e9a041adbd0088a2dc3bc22c49d0e9&language=en_US&ref_=as_li_ss_tl', 0.00, 0, 0, 4, 5, 0, NULL, 0.00, 1, 0, 0, 0, 1, '2025-11-21 22:31:30', '2025-11-21 22:31:30'),
	(6, 'La Roche-Posay Face and Body Lotion', 'la-roche-posay-face-and-body-lotion', '<p>La Roche-Posay Lipikar AP+ Triple Repair Moisturizing Cream | Face &amp; Body Lotion For Dry Skin | Shea Butter &amp; Niacinamide Moisturizer | Gentle Face &amp; Body Cream For Dry, Rough &amp; Sensitive Skin</p>', 'https://www.amazon.com/Roche-Posay-Lipikar-Intense-Repair-Cream/dp/B003QXZWYW?crid=28R2L2SEWKE6T&dib=eyJ2IjoiMSJ9.LoPvY3cSWQK48WfQkdZZ-T41g4IUHDI2bSDvNCrlxSn4sTu0wnZTma2w8YzvPmBOh0xV-Ufcm73fnUggTH34uS-fkQ14PIQABUa69_Y0tXZ9zwg_BxOQaQNpmPPXrClGRGkO2ylF1nfXc-FVBSCfPJZakLVe8JUvex78GFdLXRWEq_8oosiZH2uS0uhI2N6CtLKVUzFeVDycxJ8FGFwhZ7gVUgAouJCtKR6aon8woRJvsy9bVD87Ejdl4QcyrIcU4BB247KcZD6edCgQ2A_SXZMwQyKSBdSUID1QmLAmmk8.Z1j2WMkKnU9R092mmHqcHa_JpaGDgx6LWCgIraBQZus&dib_tag=se&keywords=La%2BRoche-Posay%2BLipikar%2BAP%2B%2BTriple%2BRepair%2BMoisturizing%2BCream%2B%7C%2BFace%2B%26%2BBody&qid=1761740437&sprefix=la%2Broche-posay%2Blipikar%2Bap%2B%2Btriple%2Brepair%2Bmoisturizing%2Bcream%2Bface%2B%26%2Bbody%2Caps%2C277&sr=8-1&th=1&linkCode=ll1&tag=pureserenity-20&linkId=2c451a92fe65ddbd9ec980b428de7d0e&language=en_US&ref_=as_li_ss_tl', 0.00, 0, 0, 4, 5, 0, NULL, 0.00, 1, 0, 0, 0, 1, '2025-11-21 22:31:54', '2025-11-21 22:31:54'),
	(7, 'marvee Lifting Mask', 'marvee-lifting-mask', '<p>MAREE V Line Lifting Mask with 24K Gold - Deep Collagen Face Mask for Women - Jawline Shaper Mask with Retinol &amp; Hyaluronic Acid - Neck Tightening &amp; Firming - Double Chin Strap for Face Lift</p>', 'https://www.amazon.com/MAREE-Gold-Collagen-Facial-Hyaluronic/dp/B0CNDCKXDX?crid=3ER50IP16UDGN&dib=eyJ2IjoiMSJ9.90Sqd4wwnVVjr0PQg2pRY4av5V6Kpc61J7ld8uofkf8Gdunr1f4JyeSx5GDh-Ma7Z7xWBtwuc2EXKfS2uMn88WRrfFrAx_1_k3bo3h427SeTOm4xdiT4gFEDrEpOFX3pNhzKe3HfqoRteAKCml0r2QzYZ325VUjkSPNL_2hpzRXONbIiKcCzMiAIL6RcfTEzxR4ROK8mstQzDXeOuSqxRYFhrvC6klkVuiJWgsMT4Z988GhZlk2p9jvlE6BNJhSlJIQCQA28vxsD69h8FJehPahdUech3k3JjbpYcR0erqg.TCHMuc-Tx8x7Dt8wYgdmGcqRug8E1aG_LqcLY7W_Jyw&dib_tag=se&keywords=nourish+max+instant+face+%2F+neck+lift&qid=1761740742&rdc=1&sprefix=nourish+max+instant+face+%2F+neck+lift%2Caps%2C136&sr=8-8&linkCode=ll1&tag=pureserenity-20&linkId=9a15e3ba700a4fe0f00a0db750fabe61&language=en_US&ref_=as_li_ss_tl', 0.00, 0, 0, 5, 5, 0, NULL, 0.00, 1, 0, 0, 0, 1, '2025-11-21 22:32:21', '2025-11-21 22:32:21'),
	(8, 'Loreal Paris Skincare', 'loreal-paris-skincare', '<p>LOreal Paris Dermo-Expertise Eye Defense Eye Cream with Caffeine and Hyaluronic Acid 0.5 oz</p>', 'https://www.amazon.com/LOreal-Paris-Skincare-Dermo-Expertise-Hyaluronic/dp/B00005333I?crid=2OMLX9E4MRCVP&dib=eyJ2IjoiMSJ9.2GwXhx576SgmLY9Le1BPRD_gyy-yr0l_u3jMNQe3bbGGQ10ZC6jZ74U6bhj-zEX6hkaEgvtGcA-t6JZpmDXEo1hgHEIgpe3kdVATrbmZm4YdpPeBXu2g1QtACZ5U4e1KZgBJ55RZsrIFx0krRx6dTj0Wr75FZjtudpqJ3wgVET0afL9-apgdMnLS4VSvn4smLd6Qk7HcQDji5BcBRpPTJmgwSX5dAhhpC_CX_EwTHkYqPlAXHU75fRcpXUkGiG1m7EgoNefu4qsmd32ZRt6fvTZX78RZD0SvBHM0CdfTWY8.9LBz62--dVF2hzhhnucBuQQuSY-rUI_b6f-jNXEiXZ0&dib_tag=se&keywords=perricone%2Bmd%2Bfirming%2Beye%2Bcream&qid=1761741003&sprefix=Perricone%2BMD%2BBrightening%2Bunder%2Beye%2Bcream%2Caps%2C374&sr=8-45&th=1&linkCode=ll1&tag=pureserenity-20&linkId=7a88cd0cf1daf188f95f06152e6f3f38&language=en_US&ref_=as_li_ss_tl', 0.00, 0, 0, 5, 5, 0, NULL, 0.00, 1, 0, 0, 0, 1, '2025-11-21 22:32:59', '2025-11-21 22:32:59'),
	(9, 'Joseon Eye serum', 'joseon-eye-serum', '<p>Beauty of Joseon Revive Eye Serum with Retinal Niacinamide Correction for Puffy Eye Bags Fine Lines Dark Circles Wrinkles, Korean Skin Care 30ml, 1 fl.oz</p>', 'https://www.amazon.com/Beauty-Joseon-Revive-eye-serum/dp/B0B45LL4DD?crid=38AMTZ94XIA41&dib=eyJ2IjoiMSJ9._SZA6ploot0PMdQcgQUlrPITUSp42qVmyBziUYZbozIysl-h8xz9SepE6Q5ZubbWNWfC0eZz0ifdiYWXcRC2CO9vW18Z0FuTgQgB4loIi9fu6R72qabdSvJ_8pfxR4-PN8Oox3oc9KyWFEGUAu3wTX198g-t-kRo_OYCsxGQcs_hAEK6Ea8u1anT0pHndBe8i6g7c2-BcOYf0jcY9KVvFBb4Hv-qBKM7rEQYQRX1z2C5FfB3NnSZKdlMcDZGKsvU7HU6UhnGj1J1r_nVn8LvZ_4J_cki1oNYr_AP9qzZWns.faAcEMTkNCVt-MUH09fRVWt0VWaQklB9EDTVhOsrL2E&dib_tag=se&keywords=rodan%2Band%2Bfields%2Beye%2Bcream&qid=1761741294&sprefix=RODAN%2Caps%2C160&sr=8-19&th=1&linkCode=ll1&tag=pureserenity-20&linkId=69267c42e4a6761965e3f2b07a6b19c6&language=en_US&ref_=as_li_ss_tl', 0.00, 0, 0, 5, 5, 0, NULL, 0.00, 1, 0, 0, 0, 1, '2025-11-21 22:33:22', '2025-11-21 22:33:22'),
	(10, 'Wuffes Advanced Dog Hip and Joint Supplement', 'wuffes-advanced-dog-hip-and-joint-supplement', '<p>Veterinarian-formulated chews with glucosamine, MSM, and turmeric to support mobility.</p>', 'https://www.amazon.com/Wuffes-Chewable-Supplement-Medium-Breeds/dp/B0C1HG6XC8?th=1&linkCode=ll1&tag=pureserenity-20&linkId=934d3d47dce7d77c3532c4e8d18724b7&language=en_US&ref_=as_li_ss_tl', 0.00, 0, 0, 7, 5, 0, NULL, 0.00, 1, 0, 0, 0, 1, '2025-11-21 22:34:41', '2025-11-21 22:34:41'),
	(11, 'Purina Pro Plan Veterinary Supplements (Dog)', 'purina-pro-plan-veterinary-supplements-dog', '<p>Probiotic powder that supports digestive balance and immune health in dogs.</p>', 'https://www.amazon.com/Purina-Veterinary-Fortiflora-Nutritional-Supplement/dp/B001650NNW?content-id=amzn1.sym.a1bc2dac-8d07-44d1-9477-59bc11451909%3Aamzn1.sym.a1bc2dac-8d07-44d1-9477-59bc11451909&cv_ct_cx=Pet+products&keywords=Pet+products&pd_rd_i=B001650NNW&pd_rd_r=d43e7883-f084-4e40-9df0-3b1e1360d1dd&pd_rd_w=agZsj&pd_rd_wg=CauVN&pf_rd_p=a1bc2dac-8d07-44d1-9477-59bc11451909&pf_rd_r=BD23SDEATSWJGAQRZ6JC&qid=1762195958&rdc=1&sbo=RZvfv%2F%2FHxDF%2BO5021pAnSA%3D%3D&sr=1-2-9428117c-b940-4daa-97e9-ad363ada7940-spons&sp_csd=d2lkZ2V0TmFtZT1zcF9zZWFyY2hfdGhlbWF0aWM&psc=1&linkCode=ll1&tag=pureserenity-20&linkId=e0104e3ceba02c00f96a8dfcc0440345&language=en_US&ref_=as_li_ss_tl', 0.00, 0, 0, 7, 5, 0, NULL, 0.00, 1, 0, 0, 0, 1, '2025-11-21 22:35:21', '2025-11-21 22:35:21'),
	(12, 'Zesty Paws Dog Allergy Relief', 'zesty-paws-dog-allergy-relief', '<p>Skin health chews with omegas, probiotics, and EpiCor postbiotics to calm itching.</p>', 'https://www.amazon.com/Zesty-Paws-Dog-Allergy-Relief/dp/B071WCV19B?dib=eyJ2IjoiMSJ9.rKU-d3f6mBlbdlgmWWr9sIYMpTmo0jPDl75UHgxqWGosCguX6qM6O5Rsd848u3jdEAEIkuYJo2gdB-P6fMVigRansipTWGT0RnVo2lRgj5h_QbivfPe5wbjAMfPzacxyvvnwXYptAbrLn7KFlBrq9ebCQ6GWzTMlGXWcpuiEoBqQJCxlfZnZc9D7D31D3ImD-ZcyiQk0hTBCkEA1ZqNTYlxZQbdg-CDTSoQk_RXgVZpdViAkyQ7EkP99-2oIZIJRUIklxIFmGZOvYMZu31zUBUcxM6X1_bNA2od0MSpS3Rk.89dhWpSQTj7cLXxB3Rwz36pvWjO4btZ3W0MBtWz5OA0&dib_tag=se&keywords=Pet%2Bproducts&qid=1762195958&rdc=1&sr=8-24&th=1&linkCode=ll1&tag=pureserenity-20&linkId=d3571c040687645daaba050ea63b55d8&language=en_US&ref_=as_li_ss_tl', 0.00, 0, 0, 7, 5, 0, NULL, 0.00, 1, 0, 0, 0, 1, '2025-11-21 22:35:49', '2025-11-21 22:35:49'),
	(13, 'Pet Honesty Dog Breath Freshener Dental Powder', 'pet-honesty-dog-breath-freshener-dental-powder', '<p>Plaque-fighting dental powder with probiotics for cleaner teeth and fresher breath.</p>', 'https://www.amazon.com/Pet-Honesty-Freshener-Cleaning-Postbiotics/dp/B0DM3486LG?dib=eyJ2IjoiMSJ9.rKU-d3f6mBlbdlgmWWr9sIYMpTmo0jPDl75UHgxqWGosCguX6qM6O5Rsd848u3jdEAEIkuYJo2gdB-P6fMVigRansipTWGT0RnVo2lRgj5h_QbivfPe5wbjAMfPzacxyvvnwXYptAbrLn7KFlBrq9ebCQ6GWzTMlGXWcpuiEoBqQJCxlfZnZc9D7D31D3ImD-ZcyiQk0hTBCkEA1ZqNTYlxZQbdg-CDTSoQk_RXgVZpdViAkyQ7EkP99-2oIZIJRUIklxIFmGZOvYMZu31zUBUcxM6X1_bNA2od0MSpS3Rk.89dhWpSQTj7cLXxB3Rwz36pvWjO4btZ3W0MBtWz5OA0&dib_tag=se&keywords=Pet%2Bproducts&qid=1762195958&rdc=1&sr=8-58&th=1&linkCode=ll1&tag=pureserenity-20&linkId=3ff2a6fcbfb3c24a2c1f9bc3aa1b7062&language=en_US&ref_=as_li_ss_tl', 0.00, 0, 0, 7, 5, 0, NULL, 0.00, 1, 0, 0, 0, 1, '2025-11-21 22:36:14', '2025-11-21 22:36:14'),
	(14, 'Purina Pro Plan Veterinary Supplements FortiFlora (Cat)', 'purina-pro-plan-veterinary-supplements-fortiflora-cat', '<p>Cat-specific probiotic supplement that helps maintain healthy intestinal microflora.</p>', 'https://www.amazon.com/Purina-Veterinary-Fortiflora-Nutritional-Supplement/dp/B001650OE0?crid=59GHIHC8QH8T&dib=eyJ2IjoiMSJ9.ZN2wjgR2XMm1cEa-4Qa1oVtaH0BNqh_qJKmhr44kz6Kcz596yxMhjoLDHiddv4UN_Nu68tP24vbaPRQXMrPUCwbldjn7LE2Adp7CxyzixJ-PZcGkyNAqHhAYMFIwspGvZz7wShGXLHQH0-Q0qlkLOnDpFfJpzzQnslyjpX6lqUGyPySIpn4OkFDOAl7fyc_7nPE7a5M9zi9c5nxKYbtf96vhfqUIkVgWmBcrVN1nw557OZHTSXrcv6UISVS_b0K4FK2txh4Z291FksChI2G3r52xum-BnQqzAbUWuIMGqvw.Lgm_gwV1Ci0AQzGQH0Qx-0ishs6EGXj6J2d4ZxZi4Q8&dib_tag=se&keywords=pet%2Bproducts%2Bfor%2Bcats&qid=1762196877&rdc=1&sprefix=Pet%2Bproducts%2B%2Caps%2C246&sr=8-5-spons&sp_csd=d2lkZ2V0TmFtZT1zcF9hdGY&th=1&linkCode=ll1&tag=pureserenity-20&linkId=705159099a7de919be8ff56fab02f273&language=en_US&ref_=as_li_ss_tl', 0.00, 0, 0, 7, 5, 0, NULL, 0.00, 1, 0, 0, 0, 1, '2025-11-21 22:36:38', '2025-11-21 22:36:38'),
	(15, 'oneisall Dog Clipper Low Noise Grooming Kit', 'oneisall-dog-clipper-low-noise-grooming-kit', '<p>Cordless grooming set with quiet motor and guide combs for stress-free trims.</p>', 'https://www.amazon.com/ONEISALL-Cllippers-Rechargeable-Cordless-Electric/dp/B01HRSZRXM?dib=eyJ2IjoiMSJ9.rKU-d3f6mBlbdlgmWWr9sIYMpTmo0jPDl75UHgxqWGosCguX6qM6O5Rsd848u3jdEAEIkuYJo2gdB-P6fMVigRansipTWGT0RnVo2lRgj5h_QbivfPe5wbjAMfPzacxyvvnwXYptAbrLn7KFlBrq9ebCQ6GWzTMlGXWcpuiEoBqQJCxlfZnZc9D7D31D3ImD-ZcyiQk0hTBCkEA1ZqNTYlxZQbdg-CDTSoQk_RXgVZpdViAkyQ7EkP99-2oIZIJRUIklxIFmGZOvYMZu31zUBUcxM6X1_bNA2od0MSpS3Rk.89dhWpSQTj7cLXxB3Rwz36pvWjO4btZ3W0MBtWz5OA0&dib_tag=se&keywords=Pet%2Bproducts&qid=1762195958&sr=8-59&th=1&linkCode=ll1&tag=pureserenity-20&linkId=e66ba935283e6f9fe260ba4a5b60f84f&language=en_US&ref_=as_li_ss_tl', 0.00, 0, 0, 8, 5, 0, NULL, 0.00, 1, 0, 0, 0, 1, '2025-11-21 22:37:12', '2025-11-21 22:37:12'),
	(16, 'Amazon Basics Dog and Puppy Pee Pads', 'amazon-basics-dog-and-puppy-pee-pads', '<p>Multi-layered, leakproof training pads with quick-dry technology for tidy floors.</p>', 'https://www.amazon.com/Amazon-Basics-Leak-Proof-Quick-Dry-Absorbency/dp/B00MW8G62E?dib=eyJ2IjoiMSJ9.rKU-d3f6mBlbdlgmWWr9sIYMpTmo0jPDl75UHgxqWGosCguX6qM6O5Rsd848u3jdEAEIkuYJo2gdB-P6fMVigRansipTWGT0RnVo2lRgj5h_QbivfPe5wbjAMfPzacxyvvnwXYptAbrLn7KFlBrq9ebCQ6GWzTMlGXWcpuiEoBqQJCxlfZnZc9D7D31D3ImD-ZcyiQk0hTBCkEA1ZqNTYlxZQbdg-CDTSoQk_RXgVZpdViAkyQ7EkP99-2oIZIJRUIklxIFmGZOvYMZu31zUBUcxM6X1_bNA2od0MSpS3Rk.89dhWpSQTj7cLXxB3Rwz36pvWjO4btZ3W0MBtWz5OA0&dib_tag=se&keywords=Pet%2Bproducts&qid=1762195958&rdc=1&sr=8-6&th=1&linkCode=ll1&tag=pureserenity-20&linkId=a9bd29b48207b9468877287c38dfbf08&language=en_US&ref_=as_li_ss_tl', 0.00, 0, 0, 9, 5, 0, NULL, 0.00, 1, 0, 0, 0, 1, '2025-11-21 22:37:38', '2025-11-21 22:37:38'),
	(17, 'Amazon Basics Dog Poop Bags', 'amazon-basics-dog-poop-bags', '<p>Durable, leak-resistant waste bags with dispenser for tidy walks and backyard clean-up.</p>', 'https://www.amazon.com/AmazonBasics-Waste-Bags-Dispenser-Leash/dp/B00NABTC8M?dib=eyJ2IjoiMSJ9.rKU-d3f6mBlbdlgmWWr9sIYMpTmo0jPDl75UHgxqWGosCguX6qM6O5Rsd848u3jdEAEIkuYJo2gdB-P6fMVigRansipTWGT0RnVo2lRgj5h_QbivfPe5wbjAMfPzacxyvvnwXYptAbrLn7KFlBrq9ebCQ6GWzTMlGXWcpuiEoBqQJCxlfZnZc9D7D31D3ImD-ZcyiQk0hTBCkEA1ZqNTYlxZQbdg-CDTSoQk_RXgVZpdViAkyQ7EkP99-2oIZIJRUIklxIFmGZOvYMZu31zUBUcxM6X1_bNA2od0MSpS3Rk.89dhWpSQTj7cLXxB3Rwz36pvWjO4btZ3W0MBtWz5OA0&dib_tag=se&keywords=Pet%2Bproducts&qid=1762195958&rdc=1&sr=8-7&th=1&linkCode=ll1&tag=pureserenity-20&linkId=ef41502268259786894ac5d28fba69c3&language=en_US&ref_=as_li_ss_tl', 0.00, 0, 0, 9, 5, 0, NULL, 0.00, 1, 0, 0, 0, 1, '2025-11-21 22:38:05', '2025-11-21 22:38:05'),
	(18, 'POOPH Odor Eliminator', 'pooph-odor-eliminator', '<p>Fragrance-free, non-toxic spray that neutralizes pet odors on contact.</p>', 'https://www.amazon.com/POOPH%C2%AE-Odor-Eliminator-Spray-Contact/dp/B09PF4KVHJ?dib=eyJ2IjoiMSJ9.rKU-d3f6mBlbdlgmWWr9sIYMpTmo0jPDl75UHgxqWGosCguX6qM6O5Rsd848u3jdEAEIkuYJo2gdB-P6fMVigRansipTWGT0RnVo2lRgj5h_QbivfPe5wbjAMfPzacxyvvnwXYptAbrLn7KFlBrq9ebCQ6GWzTMlGXWcpuiEoBqQJCxlfZnZc9D7D31D3ImD-ZcyiQk0hTBCkEA1ZqNTYlxZQbdg-CDTSoQk_RXgVZpdViAkyQ7EkP99-2oIZIJRUIklxIFmGZOvYMZu31zUBUcxM6X1_bNA2od0MSpS3Rk.89dhWpSQTj7cLXxB3Rwz36pvWjO4btZ3W0MBtWz5OA0&dib_tag=se&keywords=Pet%2Bproducts&qid=1762195958&rdc=1&sr=8-43&th=1&linkCode=ll1&tag=pureserenity-20&linkId=a7d27406fc002d5913210585fbb02826&language=en_US&ref_=as_li_ss_tl', 0.00, 0, 0, 9, 5, 0, NULL, 0.00, 1, 0, 0, 0, 1, '2025-11-21 22:38:50', '2025-11-21 22:38:50'),
	(19, 'Veken 95oz Pet Fountain', 'veken-95oz-pet-fountain', '<p>Triple-filtration pet fountain with quiet pump to keep water fresh and enticing.</p>', 'https://www.amazon.com/Veken-Fountain-Automatic-Dispenser-Replacement/dp/B08NCDBT7Q?dib=eyJ2IjoiMSJ9.rKU-d3f6mBlbdlgmWWr9sIYMpTmo0jPDl75UHgxqWGosCguX6qM6O5Rsd848u3jdEAEIkuYJo2gdB-P6fMVigRansipTWGT0RnVo2lRgj5h_QbivfPe5wbjAMfPzacxyvvnwXYptAbrLn7KFlBrq9ebCQ6GWzTMlGXWcpuiEoBqQJCxlfZnZc9D7D31D3ImD-ZcyiQk0hTBCkEA1ZqNTYlxZQbdg-CDTSoQk_RXgVZpdViAkyQ7EkP99-2oIZIJRUIklxIFmGZOvYMZu31zUBUcxM6X1_bNA2od0MSpS3Rk.89dhWpSQTj7cLXxB3Rwz36pvWjO4btZ3W0MBtWz5OA0&dib_tag=se&keywords=Pet%2Bproducts&qid=1762195958&sr=8-54&th=1&linkCode=ll1&tag=pureserenity-20&linkId=6c6606a1c583d5fbd0ef8df650cfb299&language=en_US&ref_=as_li_ss_tl', 0.00, 0, 0, 10, 5, 0, NULL, 0.00, 1, 0, 0, 0, 1, '2025-11-21 22:39:41', '2025-11-21 22:39:41');

-- Dumping structure for table serenity.product_attributes
CREATE TABLE IF NOT EXISTS `product_attributes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.product_attributes: ~0 rows (approximately)

-- Dumping structure for table serenity.product_attribute_options
CREATE TABLE IF NOT EXISTS `product_attribute_options` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `attribute_id` bigint unsigned NOT NULL,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_attribute_options_attribute_id_foreign` (`attribute_id`),
  CONSTRAINT `product_attribute_options_attribute_id_foreign` FOREIGN KEY (`attribute_id`) REFERENCES `product_attributes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.product_attribute_options: ~0 rows (approximately)

-- Dumping structure for table serenity.product_variations
CREATE TABLE IF NOT EXISTS `product_variations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `product_id` bigint unsigned NOT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `stock` int NOT NULL DEFAULT '0',
  `option_ids` json NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `attribute_option_index` varchar(191) COLLATE utf8mb4_unicode_ci GENERATED ALWAYS AS (json_unquote(json_extract(`option_ids`,_utf8mb4'$[0]'))) STORED,
  PRIMARY KEY (`id`),
  KEY `product_variations_product_id_foreign` (`product_id`),
  CONSTRAINT `product_variations_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.product_variations: ~0 rows (approximately)

-- Dumping structure for table serenity.roles
CREATE TABLE IF NOT EXISTS `roles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.roles: ~2 rows (approximately)
INSERT INTO `roles` (`id`, `name`, `created_at`, `updated_at`) VALUES
	(1, 'admin', '2025-11-20 14:29:07', '2025-11-20 14:29:07'),
	(2, 'user', '2025-11-20 14:29:07', '2025-11-20 14:29:07');

-- Dumping structure for table serenity.sessions
CREATE TABLE IF NOT EXISTS `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.sessions: ~1 rows (approximately)
INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
	('NQIvYWsAXZ6RWnon647AICmd5DfWQ2OyhRxYYpF1', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiRTQwU0ZEcXZNUzluUlduTWlnSTcweVB2VXEzcWdHMFVvczM5REhzNyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6ODU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9tZWRpYS9jbXNfc2VjdGlvbnMvejJ6S0w4M0g2SGMwQVlHWDdpdjFueHFkbWw3TlVmNjNyZ1RsYXJEei5qcGciO3M6NToicm91dGUiO3M6MTE6Im1lZGlhLmFzc2V0Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo1MjoiaHR0cDovL2xvY2FsaG9zdDo4MDAwL2FkbWluL2ludmVudG9yeS9wcm9kdWN0L2NyZWF0ZSI7fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7fQ==', 1763782804);

-- Dumping structure for table serenity.settings
CREATE TABLE IF NOT EXISTS `settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `settings_key_unique` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.settings: ~0 rows (approximately)

-- Dumping structure for table serenity.smtp_settings
CREATE TABLE IF NOT EXISTS `smtp_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `mail_driver` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mail_host` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mail_port` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mail_username` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mail_password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mail_encryption` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mail_from_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.smtp_settings: ~0 rows (approximately)

-- Dumping structure for table serenity.tags
CREATE TABLE IF NOT EXISTS `tags` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.tags: ~0 rows (approximately)

-- Dumping structure for table serenity.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `role_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_role_id_foreign` (`role_id`),
  CONSTRAINT `users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.users: ~0 rows (approximately)
INSERT INTO `users` (`id`, `name`, `email`, `image`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `role_id`) VALUES
	(1, 'Admin', 'admin@mail.com', NULL, NULL, '$2y$12$8Eh6gfN2K0uSRy4Pk.z1F.3l.Lh01d/cmBU8d6Ka229o3e5..KCOK', NULL, '2025-11-20 14:29:07', '2025-11-20 14:29:07', 1);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
