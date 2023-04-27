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
-- Table structure for table `Result`
--

DROP TABLE IF EXISTS `Result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Result` (
  `id` int NOT NULL AUTO_INCREMENT,
  `quiz_id` int NOT NULL,
  `description` varchar(500) NOT NULL,
  `lower_bound` int NOT NULL,
  `upper_bound` int NOT NULL,
  `image_location` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Result_FK` (`quiz_id`),
  CONSTRAINT `Result_FK` FOREIGN KEY (`quiz_id`) REFERENCES `Quiz` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Result`
--

LOCK TABLES `Result` WRITE;
/*!40000 ALTER TABLE `Result` DISABLE KEYS */;
INSERT INTO `Result` VALUES (1,1,'Trojan Novice: Looks like you might be new to the USC scene. Keep exploring and learning more about this great university!',0,2,'https://cdn2.lamag.com/wp-content/uploads/sites/6/2019/04/USC_CoverImage.jpg'),(2,1,'Trojan Explorer: You have a decent understanding of USC, but there is still a lot to learn. Continue to expand your knowledge of this historic university.',3,5,'https://media-cldnry.s-nbcnews.com/image/upload/newscms/2020_08/3238096/200220-usc-campus-free-tuition-2019-ac-429p.jpg'),(3,1,'Trojan Enthusiast: You know quite a bit about USC! You\'re well on your way to becoming a true Trojan expert.',6,8,'https://dailytrojan.com/wp-content/uploads/2021/11/DSC-5123-1-scaled.jpg'),(4,1,'True Trojan: Congratulations! Your extensive knowledge of USC proves that you are a true Trojan. Fight On!',9,10,'https://usg.usc.edu/trojanpride/wp-content/uploads/sites/9/2020/09/pom-poms-1.jpg'),(5,2,'Frontier Scholar: You have a deep understanding of the American Frontier and the New West. Keep exploring the vast history of this great nation!',8,10,'https://static01.nyt.com/images/2019/03/17/books/review/17dolnik/17dolnik-superJumbo.jpg'),(6,2,'Trailblazer: You have a good grasp on the history of America, the Frontier, and the New West. Keep learning and you\'ll become a true expert!',5,7,'https://cdn.britannica.com/71/167171-138-7555E3F9/Overview-Louisiana-Purchase.jpg?w=800&h=450&c=crop'),(7,2,'Settler: You know some basics, but there\'s much more to learn about the history of America, the Frontier, and the New West. Keep studying!',3,4,'https://cdn.britannica.com/11/190311-050-07D54147/reenactment-horse-wagon-team-trail-North-America.jpg'),(8,2,'Greenhorn: You have a lot to learn about the history of America, the Frontier, and the New West. Don\'t worry, history is full of fascinating stories waiting to be discovered!',0,2,'https://i0.wp.com/longreads.com/wp-content/uploads/2019/03/gettyimages-96742168-2-scaled.jpg?fit=2560%2C1683&ssl=1'),(9,3,'Frog Whisperer: Your knowledge of frogs is outstanding! You must have spent a lot of time in the wild or have a deep fascination for these amazing creatures.',8,10,'https://www.everythingreptiles.com/wp-content/uploads/2020/10/Pacman-Frog.jpg'),(10,3,'Frog Friend: You have a good understanding of frogs, but there\'s always more to learn. Keep exploring the fascinating world of amphibians!',5,7,'https://cdn.mos.cms.futurecdn.net/39CUYMP8vJqHAYGVzUghBX.jpg'),(11,3,'Tadpole: You have some basic knowledge of frogs, but there\'s a lot more to discover. Dive into the world of frogs and continue learning!',2,4,'https://cdn.britannica.com/20/231520-050-9DF96017/tadpole-common-frog-amphibian.jpg'),(12,3,'Frog Newbie: It seems you\'re just starting to learn about frogs. Don\'t worry, there\'s a whole world of information out there for you to explore!',0,1,'https://static.boredpanda.com/blog/wp-content/uploads/2021/08/funny-frogs-3-61239cc65b109__700.jpg'),(13,4,'Muggle: You might need to brush up on your Harry Potter knowledge. Time for a re-read or a movie marathon!',0,2,'https://api.time.com/wp-content/uploads/2015/06/dursleys.jpg?quality=85&w=720&h=469&crop=1'),(14,4,'Casual Fan: You know a fair bit about the magical world of Harry Potter. Keep exploring and learning!',3,5,'https://media-cldnry.s-nbcnews.com/image/upload/rockcms/2021-11/211116-harry-potter-al-1232-b41548.jpg'),(15,4,'Wizard-in-Training: Impressive! Your knowledge of the Harry Potter universe is vast. Keep practicing your spells!',6,8,'https://www.usmagazine.com/wp-content/uploads/2018/08/harry-potter-inspired-cocktails.jpg?crop=182px%2C94px%2C1539px%2C869px&resize=1600%2C900&quality=86&strip=all'),(16,4,'True Potterhead: Congratulations! Your knowledge of the Harry Potter world is truly magical. Dumbledore would be proud!',9,10,'https://i.insider.com/5dc2fb9479d75707a81210d5?width=1136&format=jpeg');
/*!40000 ALTER TABLE `Result` ENABLE KEYS */;
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
