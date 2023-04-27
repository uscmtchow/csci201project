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
-- Table structure for table `Question`
--

DROP TABLE IF EXISTS `Question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Question` (
  `id` int NOT NULL AUTO_INCREMENT,
  `quiz_id` int NOT NULL,
  `question_no` int NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `image_location` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `quiz_id` (`quiz_id`),
  CONSTRAINT `question_ibfk_1` FOREIGN KEY (`quiz_id`) REFERENCES `Quiz` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Question`
--

LOCK TABLES `Question` WRITE;
/*!40000 ALTER TABLE `Question` DISABLE KEYS */;
INSERT INTO `Question` VALUES (1,1,1,'In what year was USC founded?',NULL),(2,1,2,'What is the name of the official USC mascot?',NULL),(3,1,3,'What are the official colors of USC?',NULL),(4,1,4,'Which famous film school is part of USC?',NULL),(5,1,5,'What is the name of the USC football stadium?',NULL),(6,1,6,'How many libraries does USC have?',NULL),(7,1,7,'What is the USC motto?',NULL),(8,1,8,'Which famous astronaut graduated from USC?',NULL),(9,1,9,'What is the name of USC\'s student newspaper?',NULL),(10,1,10,'What conference does USC belong to in college sports?',NULL),(11,2,1,'What year was the Declaration of Independence signed?',NULL),(12,2,2,'What was the last territory to become a state in the contiguous United States?',NULL),(13,2,3,'Which event started the California Gold Rush?',NULL),(14,2,4,'What was the purpose of the Lewis and Clark expedition?',NULL),(15,2,5,'What was the main cause of the Mexican-American War?',NULL),(16,2,6,'Which act provided land to settlers in the western territories?',NULL),(17,2,7,'In which year was the US Constitution ratified?',NULL),(18,2,8,'What was the significance of the Louisiana Purchase?',NULL),(19,2,9,'Which Native American tribe is associated with the Trail of Tears?',NULL),(20,2,10,'What treaty established the 49th parallel as the border between the U.S. and Canada?',NULL),(21,3,1,'What is the study of frogs called?',NULL),(22,3,2,'Which continent has the highest diversity of frog species?',NULL),(23,3,3,'What is the world\'s largest frog?',NULL),(24,3,4,'Which frogs are known for their toxic secretions?',NULL),(25,3,5,'What is the primary function of the vocal sac in male frogs?',NULL),(26,3,6,'Which type of habitat do tree frogs primarily live in?',NULL),(27,3,7,'What is the typical diet of a frog?',NULL),(28,3,8,'What is the term for a baby frog?',NULL),(29,3,9,'What is the process through which a tadpole becomes a frog called?',NULL),(30,3,10,'Which frog species can change its skin color?',NULL),(31,4,1,'Who is the author of the Harry Potter series?',NULL),(32,4,2,'What is the name of the school that Harry Potter attends?',NULL),(33,4,3,'What is the full name of the character who is Harry\'s best friend?',NULL),(34,4,4,'What is the name of the sport played by wizards in the Harry Potter universe?',NULL),(35,4,5,'Which house at Hogwarts has the symbol of a lion?',NULL),(36,4,6,'What is the name of the dark wizard and main antagonist in the series?',NULL),(37,4,7,'Which professor teaches Potions at Hogwarts during Harry\'s first year?',NULL),(38,4,8,'What is the name of the magical creature that can transform into a person\'s worst fear?',NULL),(39,4,9,'What is the name of the magical map that reveals the locations of people within Hogwarts?',NULL),(40,4,10,'What is the core of Harry Potter\'s wand made of?',NULL);
/*!40000 ALTER TABLE `Question` ENABLE KEYS */;
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
