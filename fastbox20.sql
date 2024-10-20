CREATE DATABASE  IF NOT EXISTS `fastbox` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `fastbox`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: fastbox
-- ------------------------------------------------------
-- Server version	8.0.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (3,'customer'),(2,'dealer'),(1,'owner');
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add business_query',7,'add_business_query'),(26,'Can change business_query',7,'change_business_query'),(27,'Can delete business_query',7,'delete_business_query'),(28,'Can view business_query',7,'view_business_query'),(29,'Can add contact_query',8,'add_contact_query'),(30,'Can change contact_query',8,'change_contact_query'),(31,'Can delete contact_query',8,'delete_contact_query'),(32,'Can view contact_query',8,'view_contact_query'),(33,'Can add dealer_request',9,'add_dealer_request'),(34,'Can change dealer_request',9,'change_dealer_request'),(35,'Can delete dealer_request',9,'delete_dealer_request'),(36,'Can view dealer_request',9,'view_dealer_request'),(37,'Can add dealer',10,'add_dealer'),(38,'Can change dealer',10,'change_dealer'),(39,'Can delete dealer',10,'delete_dealer'),(40,'Can view dealer',10,'view_dealer'),(41,'Can add order_shipment',11,'add_order_shipment'),(42,'Can change order_shipment',11,'change_order_shipment'),(43,'Can delete order_shipment',11,'delete_order_shipment'),(44,'Can view order_shipment',11,'view_order_shipment'),(45,'Can add employee',12,'add_employee'),(46,'Can change employee',12,'change_employee'),(47,'Can delete employee',12,'delete_employee'),(48,'Can view employee',12,'view_employee'),(49,'Can add user profile',13,'add_userprofile'),(50,'Can change user profile',13,'change_userprofile'),(51,'Can delete user profile',13,'delete_userprofile'),(52,'Can view user profile',13,'view_userprofile');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$720000$YqGFVqabpUXkr650weTmm1$e/WZsz0X+E0+YVYvZOQIKXtawbC9X//TbsyXCDXp4rI=','2024-02-09 09:29:03.250713',1,'owner','','','owner@gmail.com',1,1,'2024-01-24 19:28:55.000000'),(2,'pbkdf2_sha256$720000$lHx31apQQ16EMhqxfSwqtX$Dj89XP06cTVk4cXDBkYtWoPF+GT/vKDDBsfDpnOiVB0=','2024-02-09 10:27:58.852812',1,'admin','','','admin@gmail.com',1,1,'2024-01-24 19:29:14.000000'),(3,'pbkdf2_sha256$720000$jjn7lhMlX7fdK2QXwFJaoQ$Q/a0fCWQ8aKOXSn7ORvU94yXjpb+0Zz1xJZH/B3kFfA=','2024-02-12 18:50:25.959363',0,'mumbaidealer','','','',0,1,'2024-01-25 14:34:13.396617'),(4,'pbkdf2_sha256$720000$4ZcaeWQBFZMOpLoNBn0Jhw$Hhq6ge8NGOKDHhP6HhMrSuG5R39M5YEXCFo1YEvvFFU=','2024-02-02 12:28:30.252160',0,'kolkatadealer','','','',0,1,'2024-01-25 14:34:21.238878'),(5,'pbkdf2_sha256$720000$pZcPKLiJ6uDYOmtHFEjNor$n1v1q/tUTWdlBT/k2nOVnq789TV5Sl8/ZMUwvIqInHs=','2024-02-12 18:30:57.005307',0,'bangloredealer','','','',0,1,'2024-01-25 14:34:49.874336'),(14,'pbkdf2_sha256$720000$gSnM5zY1z1HS9JmBjOzM0C$iG8kBQm0NAie31xF+Mj4EsXD+fbKeGkZCBmeAPDcw48=','2024-02-09 10:24:04.817422',0,'jkdealer','','','',0,1,'2024-01-25 14:45:05.360634'),(15,'pbkdf2_sha256$720000$yFI9p1h1sGDfL3AEcPBYty$WqkeWM4Kv3W5LME68vh4bCczdcoIQrjs3ykaCrhbhVI=','2024-02-12 18:51:03.935596',0,'parledealer','','','',0,1,'2024-01-25 14:45:08.804602'),(16,'pbkdf2_sha256$720000$HC3rFywf5lustgS262pqbP$BZGuEtsTZ6Ypaf5vCkarTTJL2gAJv6pmCNqmHwFoYnQ=','2024-02-09 10:48:46.116790',0,'nagpurdealer','','','',0,1,'2024-01-25 14:45:14.037596'),(17,'pbkdf2_sha256$720000$bhFDbS3z2DbZWLojN1V9Bl$QEDG0GsiX4u1APgJdZTqhJtypUTE4cPdqC+ONshb/38=','2024-02-12 16:13:48.263147',0,'nagdealer','','','',0,1,'2024-01-25 14:45:22.796397'),(18,'pbkdf2_sha256$720000$sZ55CP2lwYETQLrF2bRAiv$UvIApM2cgUOap8fk87AfThSJx20qKpIagSRbpTnc5wM=',NULL,0,'khanddealer','','','',0,1,'2024-01-25 14:45:25.318618'),(21,'pbkdf2_sha256$720000$qljaoCRz3kL6qQXptpTsYD$ibYsG9SlbvmTqc/RVQRVkOeN1P32GgLhxyUOfN8ITsA=','2024-02-03 08:44:46.276794',0,'customer','','','customer@gmail.com',0,1,'2024-01-25 15:03:58.433481'),(22,'pbkdf2_sha256$720000$yaQuuttN37MDWCkndQLAUt$QBZErlNDxPMRrocdKfs8tRrMg39uOQT2a20bIxvfVNQ=','2024-02-09 11:09:12.578313',0,'Demo user','','','demo@gmail.com',0,1,'2024-01-29 15:35:49.655377'),(23,'pbkdf2_sha256$720000$TeGH1CvqZvZYkPZUhWtudr$xDjSL7mXZuQJhjj3QZomeQOO+42TRKKDJtntLHDDuFU=',NULL,0,'sakshi','','','sakshi@gmail.com',0,1,'2024-02-05 11:35:56.685613'),(24,'pbkdf2_sha256$720000$Vug1Jwo5xsdTqMTrrpvV2l$aT2kDZGRYjQKJ1u1GhquszNrwtz9V/xmE0DolczNm+w=','2024-02-11 10:30:59.498780',0,'megha','megha','patil','megha@gmail.com',0,1,'2024-02-11 10:30:47.162411'),(25,'pbkdf2_sha256$720000$zsmszNA3PHpqxGsY8PUFme$tw4R34juPwcH4zLxxm60zISy8+uEGro/h+fLkOrdC7Y=','2024-02-12 18:31:27.483938',0,'aditya','','','adityabhoir9779@gmail.com',0,1,'2024-02-12 13:16:57.043053'),(26,'pbkdf2_sha256$720000$B046T9DI0olGTPyWAGdc30$pn7j6dYFRnlVWfxuwGEguvIXw9Vrt1vaExzho+kI4k4=','2024-02-12 17:41:57.757102',0,'vijay','','','vijay@gmail.com',0,1,'2024-02-12 17:41:51.188351');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
INSERT INTO `auth_user_groups` VALUES (2,1,1),(1,2,1),(3,3,2),(4,4,2),(5,5,2),(6,14,2),(7,15,2),(8,16,2),(9,17,2),(10,18,2),(11,21,3),(12,22,3),(13,23,3),(14,24,3),(15,25,3),(16,26,3);
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2024-01-24 19:29:59.169863','1','owner',1,'[{\"added\": {}}]',3,2),(2,'2024-01-24 19:30:02.868140','2','dealer',1,'[{\"added\": {}}]',3,2),(3,'2024-01-24 19:30:11.575166','3','customer',1,'[{\"added\": {}}]',3,2),(4,'2024-01-24 19:30:23.517015','2','admin',2,'[{\"changed\": {\"fields\": [\"Groups\"]}}]',4,2),(5,'2024-01-24 19:30:36.345278','1','owner',2,'[{\"changed\": {\"fields\": [\"Groups\"]}}]',4,2);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(7,'fastbox_app','business_query'),(8,'fastbox_app','contact_query'),(10,'fastbox_app','dealer'),(9,'fastbox_app','dealer_request'),(12,'fastbox_app','employee'),(11,'fastbox_app','order_shipment'),(13,'fastbox_app','userprofile'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2024-01-24 19:21:45.027007'),(2,'auth','0001_initial','2024-01-24 19:21:45.584779'),(3,'admin','0001_initial','2024-01-24 19:21:45.720932'),(4,'admin','0002_logentry_remove_auto_add','2024-01-24 19:21:45.729941'),(5,'admin','0003_logentry_add_action_flag_choices','2024-01-24 19:21:45.740167'),(6,'contenttypes','0002_remove_content_type_name','2024-01-24 19:21:45.821007'),(7,'auth','0002_alter_permission_name_max_length','2024-01-24 19:21:45.883574'),(8,'auth','0003_alter_user_email_max_length','2024-01-24 19:21:45.911537'),(9,'auth','0004_alter_user_username_opts','2024-01-24 19:21:45.922779'),(10,'auth','0005_alter_user_last_login_null','2024-01-24 19:21:45.983767'),(11,'auth','0006_require_contenttypes_0002','2024-01-24 19:21:45.985299'),(12,'auth','0007_alter_validators_add_error_messages','2024-01-24 19:21:45.994365'),(13,'auth','0008_alter_user_username_max_length','2024-01-24 19:21:46.059614'),(14,'auth','0009_alter_user_last_name_max_length','2024-01-24 19:21:46.125805'),(15,'auth','0010_alter_group_name_max_length','2024-01-24 19:21:46.143825'),(16,'auth','0011_update_proxy_permissions','2024-01-24 19:21:46.154230'),(17,'auth','0012_alter_user_first_name_max_length','2024-01-24 19:21:46.207679'),(18,'fastbox_app','0001_initial','2024-01-24 19:21:46.744730'),(19,'sessions','0001_initial','2024-01-24 19:21:46.785702'),(20,'fastbox_app','0002_alter_order_shipment_e_date','2024-01-25 18:00:22.638526'),(21,'fastbox_app','0003_employee_e_email_employee_e_phone','2024-01-26 08:43:57.582205'),(22,'fastbox_app','0004_alter_order_shipment_mot','2024-02-12 18:01:15.201238');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('0j0nud74zqb09xunors1e2f1un9mt43g','.eJxtU01vnDAQ_SvI5xWygQU2t1ZV1UpNDk2lqqfVgAeYZLGRbVJtq_73jrMkYkNu8N6bN5_-K44wh-E4e3RH0uJGZJnYrcEG2kc0kdEPYHqbttYER00aJenC-vTWajx9XLRXBgP4gaPbrpM15F2d6VxVrcS9yppOV_zR6AaqvGt0AYxpqUrEUuoascoPhxqVqtuGTUHryVGL4kZlcic8p0L3QWuH3h__0MRZCikrWYoX8g5GVovEw6MfSLyNYUNm83KX3CP8tlb75D5AIGuS7xb0Rt9SOHPAHTxRcjuPDWwtWzvzeKLqq9EEG34arIklyUNdFfs6K8qCNQ5bmghNWAp-ogc4r_HrijWONhn5H3pMOuuS8ZyA99SbkbXvxb2Zzobflr2VXJofwdA0u_cUr72pLC_2ZVUfJMsmPgqu8xuaPsRDUCvwJ-kN9gWpH8ILyGubYlM_zlO0_uygpxMyQcbPDky8BvELPSPdwvGC7CrFld0CfiL29LxnPiUpZcrXpMmHi50qS5Uqxfc2xqnE0LLKGYoGGuGEDsJlq8ztV-DzRPA5JL4i61gSH1Wd5bn69x8aQCCu:1rVsbg:PbAq4WyFmZSUwCPEBLtbsUy7BE0APrRIcycWb1VAs7k','2024-02-16 12:25:20.625977'),('0uo65n17dlp692kkpxoi7zl3ekzm7kfn','.eJxVjEEOwiAQRe_C2hBIC8y4dO8ZyMCAVA0kpV0Z764kXej2vff_S3jat-L3nla_sDiLSZx-WaD4SHUIvlO9NRlb3dYlyJHIw3Z5bZyel6P9OyjUy1gTs42IDCoxZULMys2RjNWADrKi-YtdBG20RTBGxykFsNbRbCiQeH8ADEE4fg:1rYOTw:r5i9MVrrWjd8VtjkPbGkMuMhoQ-G9qxGfZoIebT6-qo','2024-02-23 10:51:44.900280'),('2o9s6h0j0bqgi4jsa7qbczmbxq3enwz4','.eJxVjEEOwiAQRe_C2hAoyIBL9z0DgWFGqoYmpV0Z765NutDtf-_9l4hpW2vcOi1xKuIiNIjT75gTPqjtpNxTu80S57YuU5a7Ig_a5TgXel4P9--gpl6_tSUgNi4j2GwcMrFOPoE--2BAK2sGHgCcQseBSaPLyhJ5lZW3IRQj3h8RKDfs:1rZYwG:F99Jemr3xyj7UIAz5TZzwTlVUXmFKxVt6o34c_wyHxg','2024-02-26 16:13:48.269149'),('46jqjt4b25nn7y7esw4v31fjzza8jevj','.eJxtU8uO1DAQ_JWRz1FkO3HizI3VCi0C9oCQEKdRT9pJvJuxIztBGhD_TnsekGXmWlVd1Q_7F9vBMg-7JZqws8i2TAqWrcE9tK_GJQZfwPU-b72bg93nSZJf2Jh_9mjGh4v2jcEAcaDqstKFAqmMhK7QEgV0DXYo9nusq7aWdS20LlEWla552zVVXUmQTdcqlIgqdQWIU7CtYVshecYiRZnwDjGYGHc_7ZRSSs65ZFfyGQ6kZhs0B8_-ryA74kTdZJtHOMKIEDdfMLvRtXY-ktBBPy3hlvUL7SMJPji0cMNPg3epBy6lrIQUpWhIE0xrJ2vcfOnwh32B4xp_2-RHwKX3aLN7kvPkisx5cY-_7fBWch7xgQ4Mow_mnubvIJpLrUquyppkE50cevPJuH5OZ1b8H_jN4gkTK-zJ2H6Yr2Ac7HSgjK_HKVm_D9DbMaVbF5cALt2afTeRkO7CbdmzX0Vc7da5j5Y8o_WObRU9h5zeCto4n-20LvKC3tIhbYUKdaOKnKdqNDCaAPP5fkTVK_C0DnOqSEv2gSTpv9S8Es3vP2bkEXI:1rWBe1:jWYUP2E2o-5HpSnESfN0Y_8OAjA07aLq-FXq3TxSYnc','2024-02-17 08:45:01.999198'),('83wl3y8dxlzrbefpt0t0b7t42c0vo1vr','.eJxtU8uO1DAQ_JWRz6vIdl7O3lghBBI7F5AQp1FP7CS9JHZkO6AF8e-0dzIiu5lrVXX1o-w_7ARLHE5LMP6Emt0zKdjdFjxD-8PYxOgnsL3LWmejx3OWJNnKhuzRaTM-rNpXBgOEgaqLSuUlyNJI6HIltYCu0Z0W57Ouq7aWdS2UKrTMK1XztmuqupIgm64ttdS6TFOB1rPH1rB7IfkdC9TK-HdaexPC6TfOqQvnNa_YlTzCRGp2aJcQ2dsKsiMu_MJwGMGaHd9ifCbBEX7i4XGZzoB7iVvoGEn1yWqEHT8PzqYBeF3momxUUZWk8abFGY2N63gTWPe0xV9P-GUAG_FwhB78LdW6Oa3OxS1-P-Recln1gQKG0XlzS_N_FyEpraqpOclmihx689nYPqaYyw34DfUO-2iwH-IVDAPOE_X4-jwn6w8eehxTd7Rh8WBT1uy7CYR0K0eBuE2Lq53Y9HiP5BnQ2fRQSjpLRq9FY4gXQ8Vlpgp6TlM6DNUqUaisSAbawGg8xEuKyXYDvlzEvFTkBDtPkvRlCiVy_vcfNjcTLw:1rTgwN:FT3u7XMtfSSYJvuRPpBMGmP71qdC6PVBjOwTdcbar2Q','2024-02-10 11:33:39.600273'),('a5loogngs5uwnjlf4w8xy2z8057m9byj','.eJxVjMsOwiAQRf-FtSFAebp07zeQYQakaiAp7cr479qkC93ec859sQjbWuM28hJnYmem2Ol3S4CP3HZAd2i3zrG3dZkT3xV-0MGvnfLzcrh_BxVG_dbequwNTWiNKVMOyZG2oXiwQdigHSqPIMAqQF-EIe0cOadRyqS9nDR7fwDUCDcx:1rWxEF:XFkZw2oYi9XR3Y3PjSV2jiSxbbIbVrUWrxFGmDKAvwg','2024-02-19 11:33:35.763428'),('ac93b82ec4k8gnfqrmwl83t2xc3gpgqb','.eJxtU02P0zAU_CuRz6vIcePE6Q2EEEhsDywS4lQ9fyQxNHZkO7taEP-dZ5qKlvQ6M2_mfdi_yBGWNB6XaMLRarInjJOHa1CC-mFcZvR3cIMvlXcpWFlmSbmysXz02pzertobgxHiiNXNDnqhtJSyaxmVUNV9XVWy4x2DVu8k1axpmVIVbZVsesV6DUoZJup-xxsOaApaz8EqQ_YVow8kYpQJb7QOJsbjTztjSk1pSxtyIQ8woZoUoG16BfJ_DRoi-2TgxXsdi6cEyXpXfPagN1qFDig-wLMtHpdJgt1K_IKryaqPTttt3Dx6l9uhnWhrLljd1KgJRtnZGpfWZiczwDV822wc7XOhRv9yT7LuoKpayu_x2wa3kvOY84Kd3qEvI3SiaXnNuEDRjFeHwXwybkj50hX9B361eoN9MHYY0wXEgeYJE768ztn4fYDBnnK2dXEJ4PK5ycEj0K_Unnwz8Srixm4F31n0jHhMfCuU0hKfi7Yxne2abld2At_TlPeBlbiurhS5XBs4mQDpfLhsegX-3YY5VyDsA0ryn-GdENXvPytHFX4:1rZZ26:u3FgW5H4oG8SfUi04nG_uEVKho0t_XBmD3eVu6SJSy0','2024-02-26 16:19:50.286374'),('aklef6h7mo6ptser7dpnsiiyte30ugzk','.eJxVjEsOwjAMBe-SNYrSNE5jlux7hsqxDS2gROpnhbg7VOoCtm9m3ssMtK3jsC06D5OYs2nAnH7HTPzQshO5U7lVy7Ws85TtrtiDLravos_L4f4djLSM35qBYpfFcUZpEVIXnNdAToOmKysIpBgVEzBJ0yZ0OXtwIWHLiugb8_4AFTk37g:1rZbOR:OEaeuEG7jJF075ukmyiudf1Dc0rVq1mVxwYv_Z78OmQ','2024-02-26 18:51:03.938617'),('arur7iwo9fy0td7oz0ksga8fmanqutfg','.eJxVjEsOwjAMBe-SNYrSNE5jlux7hsqxDS2gROpnhbg7VOoCtm9m3ssMtK3jsC06D5OYs2nAnH7HTPzQshO5U7lVy7Ws85TtrtiDLravos_L4f4djLSM35qBYpfFcUZpEVIXnNdAToOmKysIpBgVEzBJ0yZ0OXtwIWHLiugb8_4AFTk37g:1rTJSi:bsNo4rAmRq3LFT6mJgTPQgHG57CPjTuFjOix73GkuTI','2024-02-09 10:29:28.738908'),('h7f4uaf2n2083um99xr73ub4ii4l9476','.eJxtU8tu2zAQ_BWBZ0MgqZeVW4ugaIEmh6RA0ZOxfEhiIpECSbVwi_57l7Hi2FWOnJmdffIPOcASh8MStD8YRW4Ir8juEhQgn7VNjHoC27tcOhu9EXmS5Csb8jun9Phx1V4ZDBAGjK4L6PZSCSHahlMBrOxKxkRbtRwaVQiqeN1wKRltpKg7yTsFUmq-L7uiqitAU1Bq9kZqcsM43ZGAqbT_oJTXIRx-mxmzlJQ2tCav5D1MqCYZKBOPQP6PQUNkHzX8ck6F7DFCNM5mDw7URivRAcX38NNkd8skwGwlbsHRJNUXq8w23Tw4m8qh7b4pqz0v6xI1XkszG23jWuyk-wGyGUsZL9nrmlnT7rJbOMKoIGQPavee9DwSWjXv8dt6t5JT1-eGN4JzT5zzmnFWshZlMx4C9Pqrtn1My2f0Dfxu1Ab7rE0_xFcwDGaeMMe345ysP3nozaiRMDYsHmy6APJDB0S6lcPFuIsUV3YreGvQM-B-8XxwJDlekDIhnuzwAVMaRwriSKZApWHUHuJpi4m5AF8moV8C0o9xHiXpAxUF49XffxoVGSI:1rZb8d:NOglPnrocRzcCY9Ft877ndCOBNHxcGP4W9F5SQv_vf8','2024-02-26 18:34:43.588318'),('jofgdfre4zljtujj2x2unx13dwgdvzkx','.eJxVjEEOgjAQRe_StWlmoMWWpXvP0Ew7g60aMAVWxrsLCQvd_vfef6tA65LDOksNhVWvGqNOv2Ok9JBxJ3yn8TbpNI1LLVHvij7orK8Ty_NyuH8Hmea81d4lwcFG8TYmJoFWhD0jtgOyi9wMZ2e89RAdAHeCaIgsgBXci247JeZXLUlUjw18vqZNPQw:1rZ7C1:LlZTMJyW-sgGGY7Nn8UPGsi8GVjJBp6STNdFM6ZzNNQ','2024-02-25 10:36:13.531319'),('jwap1lnz52bgnp8zxnwff4o0a80an3z7','.eJxVjEsKAjEQBe-StYQk5NO4dO8ZQqe7MaOSwGRmJd5dA7PQ3eNVUS-Vcd9q3oeseWF1Vladfr-C9JA2Ad-x3bqm3rZ1KXoq-qBDXzvL83K4f4GKo84sFmOQgrPFBkjGcnTixcfEETz5JMyAEQsFSlH8d4DBJE4Agg2s3h_hcTgl:1rYNBv:of5oTp8zxBbfbOKEC_igPQfEh9-cVJYh57se0RRsoXY','2024-02-23 09:29:03.250713'),('mrqmwkm7azrtfx1uo7fa8gwg4w8jcgr6','.eJxtU12PmzAQ_CuRnxGyDQSTt55OVau291BVqvoULewCvhKDbKiUVv3vXYdcyzV5QzOzsx9jfokjLHN_XAL5o0VxEFqLZAvW0HwnFxl8BteNaTO62ds6jZL0yob004g0PFy1rwx6CD1XN20rDWSt0ZipspFUKF23WPJHjTWUWVtjDoyhVHuivURDVGZVZUgp09RsCoiTtw2Jg9IyEYFbkX-D6CmE4087cZc8l1LGDVbyCU6sFjuk0yj-r2A75lRZJbtHOMOAEHafMbnRNXY-s9BBNy3-lh0XvkcUvHdo4Yaf-tHFGaTWeq-0ylXFGk-NnSy5-TrhD_sM5y3-esgPgEs3ok3uSdbNCzaX2T3-dsJbybriAwcMw-jpnubvIkZqU-SyyEuWTRw5dPSRXDfHmAv5D_xq8YKpDfaObNfPL2Do7XTiHl_OU7R-66GzQ-xuXVg8uJi1eIrRtVfqIL5R2LR4sdv2fbTsGezoxKHg55DyW0Eb5tXOmCzN-C2d4lW40FRFlspYjQQDeZjX_JgqN-DlHHSpiEcePUvi_2Iyva9-_wGyehKp:1rVTEo:9NsXxgiDIaBJJgYktr_sHmsoU3FYV1OnOa8UVdR9H3A','2024-02-15 09:20:02.329961'),('qa5t4y3zug48pdd0s59r653yzuut6dqn','.eJxtk09v1DAQxb9K5HMVOf-dvYEQAonugSIhTqtJPEmmbOzITooWxHdn3E1Rtult895vnsfj2T_iBMs8nBaP7kRaHESairut2ED7E01w9COY3satNbOjJg5IvLo-vrcaz-9X9iZgAD9wddt1UkHWqVRnSdVKLJK06XTFPxrdQJV1jc6BNS2TErGUWiFWWV0rTBLVNhwKWk-OWhSHJJV3wvNR6N5p7dD702-a-JRcykqW4sU8wsi0iDSOVryu4Dj2HhB-Wat99DDDTNZEXy3oHdvSfGH4CE8U3S9jA7RH7MKDCdRnowl2_jRYE5qRtaryQqV5mTPjsKWJ0Mxrq0_0CJdo4lbOW_e253CdaORv6DHqrIvGSwTeU29GZt-qezWdnb9vfo9cRzCCoWlxbxH_b5ikWV6UlaolYxMvBff5BU0_h0VINuJ30jvtE1I_zC-iH2gKl_p2mUL0Rwc9nZENMn5xYMI2iGN43G61DuIH-s0RN3Gr-IE40_Nr8ypJKWPeJk1-vsaVdRbXitdtDEPhykoWdaxCuUY4o4P5-rLB2ojP88DnioJl6xgJf6msSKvq7z9kqyEe:1rY0s3:ZdCttJVLfIyRlu7b3awnw9dN44Xb9KnItNd1yQ1xlcQ','2024-02-22 09:39:03.988623'),('qkzevh8dl4hodbgh7gpd1hlbdws53a2j','.eJxVjDsOwjAQBe_iGll48WeXkp4zRLZ3TQLIluKkQtwdIqWA9s3Me6khrss4rF3mYWJ1Vk4dfrcU80PqBvge663p3OoyT0lvit5p19fG8rzs7t_BGPv4rUuA4jEUOnqw2YoDYzKJP0EsiYxDZESDDhiZKJApxktCsjYEYBD1_gDF0Dbu:1rVTI5:XMNCf4RJ96OEVMBnVNFa2UB0qa0seg_vHFzb5g91NVA','2024-02-15 09:23:25.359489'),('rtwjlysi7xs6a4pbkm32c1iy8b3l49lh','.eJxtU8tu2zAQ_BWDZ0MgqReVW4scUqDxoQ1Q5GSstCuJjk0JpHRwivx7l7ETO5Vv4szs7FN_xRbmqd_OgfzWorgTWov1NVhD80IuMrgD1w1JM7jJ2zqJkuTMhuRxQNp_P2u_GPQQeo5u2lYaSFujMVVlIylXum6x5I8aayjTtsYMGEOpCqJCoiEq06oypJRpajYFxNHbhsSd0nItAqci_w3RUwjbVztylkxKmZfig9zAgdViFeAl9Fb8H8OGzKqyWq_u4Qh7hLD6heuFrrHTkYWP86GGpUszzDyRKPjh0MKCH_vBxSqk1rpQWmWqYo2nxo6W3HSuEXa7-Rr-WuPvHtxkVxvowN9SnbuP7etb_LLGpeTUpINunG_m-OzDSG3yTOZZHPTIO4eOfpLrprjnVF_APxbfMa0u2APZrp8imMdJ9XY8cI6n4xitH-AVPA5zYMq6MHtwcd3imSLSeujsPr43w1WST0N5Ae8tuwY7OL6VwkiZ8L2gDdPJr6jSpDJ8UIc4Fg4tZV4lJsYjwZ48TKcVMpVfge8joVMEw4NnSfxpdKmMefsHUsYUcA:1rUVx1:4yl7ZW2zq3K-vlfk2epWkwNqYXJiEgFHPZRwLMO7Gc8','2024-02-12 18:01:43.086307'),('seuo9z4g55yab6jxw9v7vz67eypb4v4h','.eJxVjDEOwjAMRe-SGUVN4yguIztniOzYoQWUSk07VdwdVeoA63_v_d0k2tYxbU2XNIm5GjCX340pv7QeQJ5UH7PNc12Xie2h2JM2e59F37fT_TsYqY1H3QNyVO-chmFwKgqKrgcKvouIGJhLF6GPmQr7DBgIyiBCDn0pjs3nC9oUOA4:1rVsek:3vZGs27ogQIXGZREPs0pU10EMORfDDBVsSISeMy36aY','2024-02-16 12:28:30.260666'),('vp63n3ivff2ctbke77evims0tcwrw6k1','.eJxVjEsOwjAMBe-SNYrSNE5jlux7hsqxDS2gROpnhbg7VOoCtm9m3ssMtK3jsC06D5OYs2nAnH7HTPzQshO5U7lVy7Ws85TtrtiDLravos_L4f4djLSM35qBYpfFcUZpEVIXnNdAToOmKysIpBgVEzBJ0yZ0OXtwIWHLiugb8_4AFTk37g:1rTNGQ:ms-DLI2oyLDpho81i2s3uQDmfjPiERTceK4vHwiX4p8','2024-02-09 14:33:02.654129'),('z5lwvooud18fedsh0crwidr61e8xf0k4','.eJxtU8GO0zAQ_ZXK51XkOHFs9wZCCCTYExLiVE08TuLdxolsB7Qg_h27TbVZ0ut7b968mbH_kBMscTgtwfiTRXIkrCQPW7AF_WxcZvAJXD8VenLR27bIkmJlQ_F1QnN-v2rfGAwQhlRdN7LiwLhh0FWSYQmdwg7LtkXRaMGEKKWskVWNFFR3qhENA6Y6zZEh8pwKEGdvtSHHktEHElIr498hehPC6bedcxdKBW3IjXyEManJQS8hkv8rkl3ixsW3gDtS2_hyYccW7J6dlrSELPjs0MKOn4fJ5cZC8kYqyWuZJN5oO1vj4ppqNP0AhxmiPW_Zt_HCYH8e9DD9uidZZy5LQfk9fh9zL7nO6aCfF39PcBtFyUbwmvE8yZzuDL35Ylwf820r-gp-t3jByg32ydh-iDdhGmkeU4dvL3M2_uiht2eTCOvC4sHlA5MfJiSkW7kjeZw2LW527BX7YJNlsJMjR0UpLdL7QBvi1a1RVaFkekBjXki-C-WqkDkMGjgbD_F6v5x7A16WYa4VCZ58kuRPwlRdir__AIuyD-4:1rT42q:208BkFpTnFPDuN-4o9rGxxJLWi8KK9nrZdBJo79bGaA','2024-02-08 18:01:44.725327'),('zp5a2952xq1kb2zwthtromocj0nsdm68','.eJxVjEEOwiAQRe_C2hAoyIBL9z0DgWFGqoYmpV0Z765NutDtf-_9l4hpW2vcOi1xKuIiNIjT75gTPqjtpNxTu80S57YuU5a7Ig_a5TgXel4P9--gpl6_tSUgNi4j2GwcMrFOPoE--2BAK2sGHgCcQseBSaPLyhJ5lZW3IRQj3h8RKDfs:1rUWOz:zTqkhlsD_KPqwI4dRszLklFZAlAVHgj-qXGYU5XOAyY','2024-02-12 18:30:37.892597');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fastbox_app_business_query`
--

DROP TABLE IF EXISTS `fastbox_app_business_query`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fastbox_app_business_query` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `company_name` varchar(50) NOT NULL,
  `contact_person` varchar(50) NOT NULL,
  `street_address` varchar(255) NOT NULL,
  `street_address_line_2` varchar(255) NOT NULL,
  `city` varchar(50) NOT NULL,
  `postal_code` int NOT NULL,
  `country` varchar(50) NOT NULL,
  `ph_no` bigint NOT NULL,
  `email` varchar(254) NOT NULL,
  `details` longtext NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fastbox_app_business_query`
--

LOCK TABLES `fastbox_app_business_query` WRITE;
/*!40000 ALTER TABLE `fastbox_app_business_query` DISABLE KEYS */;
INSERT INTO `fastbox_app_business_query` VALUES (1,'katta kings','Demo user','demo message for my assignment','birju the boy','manipur',400706,'India',1234567890,'adityabhoir9779@gmail.com','this a test business query for demo\r\n\r\n','2024-01-25');
/*!40000 ALTER TABLE `fastbox_app_business_query` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fastbox_app_contact_query`
--

DROP TABLE IF EXISTS `fastbox_app_contact_query`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fastbox_app_contact_query` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `message` longtext NOT NULL,
  `date` date NOT NULL,
  `time` time(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fastbox_app_contact_query`
--

LOCK TABLES `fastbox_app_contact_query` WRITE;
/*!40000 ALTER TABLE `fastbox_app_contact_query` DISABLE KEYS */;
INSERT INTO `fastbox_app_contact_query` VALUES (1,'Demo user','adityabhoir9779@gmail.com','for query','this is a demo query to test for customers\r\n','2024-01-25','20:21:23.128326'),(2,'vijay','vijay123@gmail.com','addaadad','gfdhad','2024-02-09','15:58:32.106750');
/*!40000 ALTER TABLE `fastbox_app_contact_query` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fastbox_app_dealer`
--

DROP TABLE IF EXISTS `fastbox_app_dealer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fastbox_app_dealer` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  `pincode` int NOT NULL,
  `country` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone` bigint NOT NULL,
  `add_line_1` varchar(255) NOT NULL,
  `add_line_2` varchar(255) NOT NULL,
  `jdate` date NOT NULL,
  `dealer_id_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fastbox_app_dealer_dealer_id_id_ccdc213d_fk_auth_user_id` (`dealer_id_id`),
  CONSTRAINT `fastbox_app_dealer_dealer_id_id_ccdc213d_fk_auth_user_id` FOREIGN KEY (`dealer_id_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fastbox_app_dealer`
--

LOCK TABLES `fastbox_app_dealer` WRITE;
/*!40000 ALTER TABLE `fastbox_app_dealer` DISABLE KEYS */;
INSERT INTO `fastbox_app_dealer` VALUES (1,'mumbaidealer','one','Mumbai',400053,'India','mumbaidealer@gmail.com',2266989694,'Mathuradas Vasanji Rd,','Hanuman Nagar, Andheri East','2024-01-25',3),(2,'kolkatadealer','two','Kolkata',700049,'India','kolkata@gmail.com',9830741225,'204(34/4), SL Chatterjee St,','Sarada Palli, Nimta','2024-01-25',4),(3,'bangloredealer','three','Bangalore',561203,'India','banglore@gmail.com',8028540547,'Kadugodi,','Kodigehalli','2024-01-25',5),(4,'jkdealer','five','Srinagar',190001,'India','jandk@gmail.com',1942453290,'Boulevard Road, Srinaga','Jammu and Kashmir','2024-01-25',14),(5,'parledealer','six','Mumbai',400057,'India','vpdealer@gmail.com',2226121419,'179, Dayaldas Rd,','Vile Parle East','2024-01-25',15),(6,'nagpurdealer','seven','Nagpur',440022,'India','nagpur@gmail.com',9405549231,'Ring Rd,','Trimurti Nagar','2024-01-25',16),(7,'nagdealer','eight','Nagpur',440015,'India','nag@gmail.com',7126603197,'Wardha Rd, Ramkrishna Nagar, ','Vivekanand Nagar','2024-01-25',17),(8,'khanddealer','nine','Mumbai',400097,'India','khand@gmail.com',9322495548,'6, Khandwala Arcade Building, Khandwala Road,','Daftary Road, Malad East, Malad East','2024-01-25',18);
/*!40000 ALTER TABLE `fastbox_app_dealer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fastbox_app_dealer_request`
--

DROP TABLE IF EXISTS `fastbox_app_dealer_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fastbox_app_dealer_request` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `companyname` varchar(50) NOT NULL,
  `add_line_1` varchar(255) NOT NULL,
  `add_line_2` varchar(255) NOT NULL,
  `city` varchar(50) NOT NULL,
  `country` varchar(50) NOT NULL,
  `postalcode` int NOT NULL,
  `ph_no` bigint NOT NULL,
  `email` varchar(254) NOT NULL,
  `wh_city` varchar(50) NOT NULL,
  `wh_area` varchar(255) NOT NULL,
  `wh_country` varchar(50) NOT NULL,
  `wh_tenure` varchar(50) NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fastbox_app_dealer_request`
--

LOCK TABLES `fastbox_app_dealer_request` WRITE;
/*!40000 ALTER TABLE `fastbox_app_dealer_request` DISABLE KEYS */;
/*!40000 ALTER TABLE `fastbox_app_dealer_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fastbox_app_employee`
--

DROP TABLE IF EXISTS `fastbox_app_employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fastbox_app_employee` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `dealer_id_id` bigint NOT NULL,
  `assigned_order_id` bigint DEFAULT NULL,
  `e_email` varchar(254) NOT NULL,
  `e_phone` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fastbox_app_employee_dealer_id_id_0f810825_fk_fastbox_a` (`dealer_id_id`),
  KEY `fastbox_app_employee_assigned_order_id_490f7b3b_fk_fastbox_a` (`assigned_order_id`),
  CONSTRAINT `fastbox_app_employee_assigned_order_id_490f7b3b_fk_fastbox_a` FOREIGN KEY (`assigned_order_id`) REFERENCES `fastbox_app_order_shipment` (`id`),
  CONSTRAINT `fastbox_app_employee_dealer_id_id_0f810825_fk_fastbox_a` FOREIGN KEY (`dealer_id_id`) REFERENCES `fastbox_app_dealer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fastbox_app_employee`
--

LOCK TABLES `fastbox_app_employee` WRITE;
/*!40000 ALTER TABLE `fastbox_app_employee` DISABLE KEYS */;
INSERT INTO `fastbox_app_employee` VALUES (2,'major','kumar',5,NULL,'manoj@gmail.com',7126603197),(7,'kundan','khan',6,NULL,'kundan@gmail.com',98876256575),(8,'kamal','husan',3,NULL,'husan@gmail.com',985766589548),(9,'junaid','kurashi',7,NULL,'junaid@gmail.com',6898956956),(10,'Demo','user',2,NULL,'adityabhoir9779@gmail.com',1234567890),(11,'sakshi','bhooi',4,NULL,'ajkaf@gmail.com',5346543254),(12,'Demo','user',1,NULL,'adityabhoir9779@gmail.com',1234567890);
/*!40000 ALTER TABLE `fastbox_app_employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fastbox_app_order_shipment`
--

DROP TABLE IF EXISTS `fastbox_app_order_shipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fastbox_app_order_shipment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `shipment_id` int NOT NULL,
  `n_sender_add` varchar(50) NOT NULL,
  `n_sender_zip` int NOT NULL,
  `n_sender_city` varchar(50) NOT NULL,
  `n_sender_country` varchar(50) NOT NULL,
  `n_sender_ph_no` bigint NOT NULL,
  `n_recipent` varchar(50) NOT NULL,
  `n_recipent_add` varchar(50) NOT NULL,
  `n_recipent_zip` int NOT NULL,
  `n_recipent_city` varchar(50) NOT NULL,
  `n_recipent_country` varchar(50) NOT NULL,
  `n_recipent_ph_no` bigint NOT NULL,
  `p_width` double NOT NULL,
  `p_length` double NOT NULL,
  `p_height` double NOT NULL,
  `p_weight` double NOT NULL,
  `p_type` varchar(50) NOT NULL,
  `p_insurance` varchar(50) NOT NULL,
  `p_fragile` varchar(50) NOT NULL,
  `shipment_status` varchar(50) NOT NULL,
  `cost` double NOT NULL,
  `distance` double NOT NULL,
  `mot` varchar(50) DEFAULT NULL,
  `date` date NOT NULL,
  `e_date` date DEFAULT NULL,
  `completed` tinyint(1) NOT NULL,
  `r_dealer_id_id` bigint NOT NULL,
  `s_dealer_id_id` bigint NOT NULL,
  `sender_id_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fastbox_app_order_sh_r_dealer_id_id_c2b080de_fk_fastbox_a` (`r_dealer_id_id`),
  KEY `fastbox_app_order_sh_s_dealer_id_id_0390cdab_fk_fastbox_a` (`s_dealer_id_id`),
  KEY `fastbox_app_order_shipment_sender_id_id_c5eeba0d_fk_auth_user_id` (`sender_id_id`),
  CONSTRAINT `fastbox_app_order_sh_r_dealer_id_id_c2b080de_fk_fastbox_a` FOREIGN KEY (`r_dealer_id_id`) REFERENCES `fastbox_app_dealer` (`id`),
  CONSTRAINT `fastbox_app_order_sh_s_dealer_id_id_0390cdab_fk_fastbox_a` FOREIGN KEY (`s_dealer_id_id`) REFERENCES `fastbox_app_dealer` (`id`),
  CONSTRAINT `fastbox_app_order_shipment_sender_id_id_c5eeba0d_fk_auth_user_id` FOREIGN KEY (`sender_id_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fastbox_app_order_shipment`
--

LOCK TABLES `fastbox_app_order_shipment` WRITE;
/*!40000 ALTER TABLE `fastbox_app_order_shipment` DISABLE KEYS */;
INSERT INTO `fastbox_app_order_shipment` VALUES (20,59881,'Seawoods Station Road',400706,'Navi Mumbai','India',9874582464,'mega','shiv chow',411705,'pune','India',986754258,10,10,10,10,'Fragile','No','Yes','end',7059.8,693.98,NULL,'2024-02-12','2024-02-13',1,7,1,25),(21,83611,'hello',400706,'mumbai','India',9874582464,'aditya','Kadugodi,',561203,'Bangalore','India',8028540547,10,10,10,10,'Fragile','No','Yes','assigned',8148.4,802.84,NULL,'2024-02-12','2024-02-13',0,3,5,26),(22,34749,'hello',400706,'mumbai','India',9874582464,'aditya','Kadugodi,',561203,'Bangalore','India',8028540547,10,10,10,10,'Fragile','Yes','No','end',8148.4,802.84,NULL,'2024-02-12','2024-02-13',1,3,1,26),(23,64113,'hello',400706,'mumbai','India',9874582464,'aditya','Kadugodi,',561203,'Bangalore','India',8028540547,10,10,10,10,'Fragile','Yes','No','assigned',8148.4,802.84,NULL,'2024-02-12','2024-02-13',0,3,5,26),(24,33125,'Seawoods Station Road',400706,'Navi Mumbai','India',9874582464,'megha patil','179, Dayaldas Rd,',400057,'Mumbai','India',2226121419,10,10,10,10,'Fragile','Yes','No','end',120,0,NULL,'2024-02-13','2024-02-14',1,5,1,25);
/*!40000 ALTER TABLE `fastbox_app_order_shipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fastbox_app_userprofile`
--

DROP TABLE IF EXISTS `fastbox_app_userprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fastbox_app_userprofile` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `picture` varchar(100) DEFAULT NULL,
  `address` varchar(255) NOT NULL,
  `country` varchar(50) NOT NULL,
  `ph_no` bigint DEFAULT NULL,
  `userID` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `userID` (`userID`),
  CONSTRAINT `fastbox_app_userprofile_userID_65c11ba2_fk_auth_user_id` FOREIGN KEY (`userID`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fastbox_app_userprofile`
--

LOCK TABLES `fastbox_app_userprofile` WRITE;
/*!40000 ALTER TABLE `fastbox_app_userprofile` DISABLE KEYS */;
INSERT INTO `fastbox_app_userprofile` VALUES (1,'/media/creativemh43.png','seawoods','India',986754258,24);
/*!40000 ALTER TABLE `fastbox_app_userprofile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'fastbox'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-02-13  0:34:02
