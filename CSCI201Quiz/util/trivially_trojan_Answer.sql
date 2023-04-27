-- MySQL dump 10.13  Distrib 8.0.21, for macos10.15 (x86_64)
--
-- Host: localhost    Database: trivially_trojan
-- ------------------------------------------------------
-- Server version	8.0.31

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
-- Table structure for table `Answer`
--

DROP TABLE IF EXISTS `Answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Answer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `question_id` int NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `answer_value` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `question_id` (`question_id`),
  CONSTRAINT `answer_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `Question` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=161 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Answer`
--

LOCK TABLES `Answer` WRITE;
/*!40000 ALTER TABLE `Answer` DISABLE KEYS */;
INSERT INTO `Answer` VALUES (1,1,'1851',0),(2,1,'1905',0),(3,1,'1880',1),(4,1,'1867',0),(5,2,'Oski the Bear',0),(6,2,'Tommy Trojan',1),(7,2,'Tirebiter',0),(8,2,'Traveler',0),(9,3,'Crimson and Gold',0),(10,3,'Cardinal and Gold',1),(11,3,'Crimson and Mustard',0),(12,3,'Maroon and Gold',0),(13,4,'USC School of Cinematic Arts',1),(14,4,'USC School of Visual Arts',0),(15,4,'USC School of Film & Television',0),(16,4,'USC School of Media Arts',0),(17,5,'Los Angeles Memorial Coliseum',1),(18,5,'BMO Stadium',0),(19,5,'Soni McAlister Field',0),(20,5,'Brittingham Field',0),(21,6,'12',0),(22,6,'15',0),(23,6,'23',1),(24,6,'18',0),(25,7,'Inveniemus viam aut faciemus',0),(26,7,'Scientia potentia est',0),(27,7,'Crescit cum commercio civitas',0),(28,7,'Palmam qui meruit ferat',1),(29,8,'Buzz Aldrin',0),(30,8,'Neil Armstrong',1),(31,8,'John Glenn',0),(32,8,'Alan Shepard',0),(33,9,'Daily Trojan',1),(34,9,'Trojan News',0),(35,9,'Trojan Daily',0),(36,9,'The Voice of Troy',0),(37,10,'Big Ten',0),(38,10,'SEC',0),(39,10,'ACC',0),(40,10,'Pac-12',1),(41,11,'1776',1),(42,11,'1775',0),(43,11,'1783',0),(44,11,'1800',0),(45,12,'Texas',0),(46,12,'Hawaii',0),(47,12,'Arizona',1),(48,12,'Alaska',0),(49,13,'Sutter\'s Mill',1),(50,13,'Pikes Peak',0),(51,13,'Discovery of the Comstock Lode',0),(52,13,'Klondike Gold Rush',0),(53,14,'To find a direct water route to the Pacific Ocean',1),(54,14,'To establish trade with Native American tribes',0),(55,14,'To explore and map the newly acquired Louisiana Purchase',0),(56,14,'To find gold in the western territories',0),(57,15,'Manifest Destiny',1),(58,15,'Slavery',0),(59,15,'Economic disputes',0),(60,15,'Religious differences',0),(61,16,'Homestead Act',1),(62,16,'Land Ordinance of 1785',0),(63,16,'Dawes Act',0),(64,16,'Morrill Act',0),(65,17,'1787',0),(66,17,'1788',1),(67,17,'1789',0),(68,17,'1790',0),(69,18,'It doubled the size of the United States',1),(70,18,'It settled the border dispute with Canada',0),(71,18,'It established the United States as a world power',0),(72,18,'It marked the beginning of westward expansion',0),(73,19,'Sioux',0),(74,19,'Navajo',0),(75,19,'Cherokee',1),(76,19,'Iroquois',0),(77,20,'Treaty of Ghent',0),(78,20,'Treaty of Paris',0),(79,20,'Oregon Treaty',1),(80,20,'Treaty of Tordesillas',0),(81,21,'Herpetology',1),(82,21,'Frogology',0),(83,21,'Amphibiology',0),(84,21,'Ranology',0),(85,22,'Asia',0),(86,22,'Africa',1),(87,22,'South America',0),(88,22,'Australia',0),(89,23,'African Bullfrog',0),(90,23,'Goliath Frog',1),(91,23,'Amazonian Giant Frog',0),(92,23,'Cane Toad',0),(93,24,'Dart Frogs',1),(94,24,'Bullfrogs',0),(95,24,'Tree Frogs',0),(96,24,'Glass Frogs',0),(97,25,'Attracting mates',1),(98,25,'Eating',0),(99,25,'Breathing',0),(100,25,'Swimming',0),(101,26,'Aquatic',0),(102,26,'Terrestrial',0),(103,26,'Arboreal',1),(104,26,'Subterranean',0),(105,27,'Insects and small invertebrates',1),(106,27,'Fruits and vegetables',0),(107,27,'Small mammals',0),(108,27,'Seeds and nuts',0),(109,28,'Tadpole',1),(110,28,'Froglet',0),(111,28,'Spawn',0),(112,28,'Polliwog',0),(113,29,'Metamorphosis',1),(114,29,'Molting',0),(115,29,'Growth',0),(116,29,'Transformation',0),(117,30,'African Clawed Frog',0),(118,30,'Common European Frog',0),(119,30,'Golden Poison Dart Frog',0),(120,30,'Gray Tree Frog',1),(121,31,'Stephen King',0),(122,31,'George R.R. Martin',0),(123,31,'J.K. Rowling',1),(124,31,'J.R.R. Tolkien',0),(125,32,'Hogwarts School of Witchcraft and Wizardry',1),(126,32,'Beauxbatons Academy of Magic',0),(127,32,'Ilvermorny School of Witchcraft and Wizardry',0),(128,32,'Durmstrang Institute',0),(129,33,'Hermione Granger',0),(130,33,'Neville Longbottom',0),(131,33,'Ronald Weasley',1),(132,33,'Dobby The House Elf',0),(133,34,'Quidditch',1),(134,34,'Wizard Chess',0),(135,34,'Gobstones',0),(136,34,'Exploding Snap',0),(137,35,'Hufflepuff',0),(138,35,'Ravenclaw',0),(139,35,'Gryffindor',1),(140,35,'Slytherin',0),(141,36,'Draco Malfoy',0),(142,36,'Bellatrix Lestrange',0),(143,36,'Lord Voldemort',1),(144,36,'Severus Snape',0),(145,37,'Horace Slughorn',0),(146,37,'Minerva McGonagall',0),(147,37,'Severus Snape',1),(148,37,'Filius Flitwick',0),(149,38,'Dementor',0),(150,38,'Boggart',1),(151,38,'Thestral',0),(152,38,'Niffler',0),(153,39,'The Marauder\'s Map',1),(154,39,'The Weasley\'s Clock',0),(155,39,'The Quibbler',0),(156,39,'The Daily Prophet',0),(157,40,'Dragon Heartstring',0),(158,40,'Phoenix Feather',1),(159,40,'Unicorn Hair',0),(160,40,'Veela Hair',0);
/*!40000 ALTER TABLE `Answer` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-04-27  0:11:46
