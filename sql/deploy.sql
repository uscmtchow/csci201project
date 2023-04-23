/*
 * The deployment script for the project.
 * Simply copy and paste this script into your local SQL database for the project, and run.
 */

/*
 * Create database
 */
CREATE DATABASE IF NOT EXISTS `trivially_trojan`;


/* 
 * Handle table deconstruction
 *
 * !!!WARNING!!!
 * 
 * Table deletion must be done in the order below.
 * Other this script will not run correctly.
 */
DROP TABLE IF EXISTS `trivially_trojan`.`UserQuizRecord`;
DROP TABLE IF EXISTS `trivially_trojan`.`Answer`;
DROP TABLE IF EXISTS `trivially_trojan`.`Result`;
DROP TABLE IF EXISTS `trivially_trojan`.`Results`;
DROP TABLE IF EXISTS `trivially_trojan`.`Question`;
DROP TABLE IF EXISTS `trivially_trojan`.`Quiz`;
DROP TABLE IF EXISTS `trivially_trojan`.`Category`;
DROP TABLE IF EXISTS `trivially_trojan`.`User`;
DROP TABLE IF EXISTS `trivially_trojan`.`Users`;


-- Table structure for table `trivially_trojan`.`Category`
CREATE TABLE `trivially_trojan`.`Category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `description` varchar(500) NOT NULL,
  `image_location` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- 
-- Table structure for table `trivially_trojan`.`Quiz`
-- 
CREATE TABLE `trivially_trojan`.`Quiz` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `image_location` varchar(1000) DEFAULT NULL,
  `category_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `quiz_ibfk_1` (`category_id`),
  CONSTRAINT `quiz_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `trivially_trojan`.`Category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- 
-- Table structure for table `trivially_trojan`.`Results`
-- 
CREATE TABLE `trivially_trojan`.`Result` (
  `id` int NOT NULL AUTO_INCREMENT,
  `quiz_id` int NOT NULL,
  `description` varchar(500) NOT NULL,
  `lower_bound` int NOT NULL,
  `upper_bound` int NOT NULL,
  `image_location` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Result_FK` (`quiz_id`),
  CONSTRAINT `Result_FK` FOREIGN KEY (`quiz_id`) REFERENCES `trivially_trojan`.`Quiz` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- 
-- Table structure for table `trivially_trojan`.`Question`
-- 
CREATE TABLE `trivially_trojan`.`Question` (
  `id` int NOT NULL AUTO_INCREMENT,
  `quiz_id` int NOT NULL,
  `question_no` int NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `image_location` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `quiz_id` (`quiz_id`),
  CONSTRAINT `question_ibfk_1` FOREIGN KEY (`quiz_id`) REFERENCES `trivially_trojan`.`Quiz` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Table structure for table `trivially_trojan`.`Answer`
--
CREATE TABLE `trivially_trojan`.`Answer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `question_id` int NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `answer_value` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `question_id` (`question_id`),
  CONSTRAINT `answer_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `trivially_trojan`.`Question` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `trivially_trojan`.`User`
--
CREATE TABLE `trivially_trojan`.`User` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(50) NOT NULL,
  `password` varchar(500) NOT NULL,
  `username` varchar(20) NOT NULL,
  UNIQUE KEY `idx_user_username` (`username`),
  UNIQUE KEY `idx_user_email` (`email`),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `trivially_trojan`.`UserQuizRecord`
--
CREATE TABLE `trivially_trojan`.`UserQuizRecord` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `quiz_id` int NOT NULL,
  `quiz_result_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `uqr_fk_1` (`user_id`),
  KEY `uqr_fk_2` (`quiz_id`),
  KEY `uqr_fk_3` (`quiz_result_id`),
  CONSTRAINT `uqr_fk_1` FOREIGN KEY (`user_id`) REFERENCES `trivially_trojan`.`User` (`id`),
  CONSTRAINT `uqr_fk_2` FOREIGN KEY (`quiz_id`) REFERENCES `trivially_trojan`.`Quiz` (`id`),
  CONSTRAINT `uqr_fk_3` FOREIGN KEY (`quiz_result_id`) REFERENCES `trivially_trojan`.`Result` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- Insert categories
INSERT INTO `trivially_trojan`.`Category` (`id`, `name`, `description`, `image_location`) VALUES
(1,'University of Southern California Trivia', 'Unlock your inner Trojan with various quizzes about USC', 'https://media.cnn.com/api/v1/images/stellar/prod/220727174432-university-of-southern-california-file.jpg?c=3x2'),
(2,'American History', 'Discover how much you know about the history of the United States.', 'https://mtv-main-assets.mountvernon.org/files/resources/large_crossing-the-delaware-met-museum.jpg'),
(3,'Science & Nature', 'Explore the world of science and nature with this quiz.', 'https://www.treehugger.com/thmb/c-l2dKPROwRrAq-PblDgCexhzLU=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/__opt__aboutcom__coeus__resources__content_migration__mnn__images__2016__10__temperate-rainforest-kermode-spirit-bear-682940c65f7a471bb182f77901b84c09.jpg'),
(4, 'Movies & TV', 'Prove your expertise in the realm of movies and television.', 'https://static01.nyt.com/images/2020/02/21/multimedia/21xp-friends/21xp-friends-mediumSquareAt3X.jpg');


-- Insert quizzes
INSERT INTO `trivially_trojan`.`Quiz` (`id`,`name`, `description`, `image_location`, `category_id`) VALUES
(1,'USC Trivia Challenge', 'Test your knowledge of the University of Southern California with this fun trivia quiz.', 'https://cdn.britannica.com/98/152398-050-781CA116/Doheny-Memorial-Library-University-of-Southern-California.jpg', 1),
(2,'AMST-301gp: America, the Frontier, and the New West', 'How well do you know American history? Take this quiz to find out!', 'https://cdn.britannica.com/79/171779-050-32244EA6/Emigrants-depiction-Kanesville-settlers-Missouri-River-William.jpg', 2),
(3,'Frogology 101', 'Test your knowledge of princess\' best friend', 'https://www.pbs.org/wnet/nature/files/2021/05/frog-1280x720.png', 3),
(4, 'Harry Potter Trivia', 'Think you\'re a true potterhead? Test your knowledge of the Harry Potter universe!', 'https://cdn.britannica.com/82/152982-050-11159CF4/Daniel-Radcliffe-Rupert-Grint-Emma-Watson-Harry.jpg', 4);





-- 
-- Quiz 1 Content
-- 

-- Insert questions for USC Trivia Challenge
INSERT INTO `trivially_trojan`.`Question` (`id`, `quiz_id`, `question_no`, `description`) VALUES
(1, 1, 1, 'In what year was USC founded?'),
(2, 1, 2, 'What is the name of the official USC mascot?'),
(3, 1, 3, 'What are the official colors of USC?'),
(4, 1, 4, 'Which famous film school is part of USC?'),
(5, 1, 5, 'What is the name of the USC football stadium?'),
(6, 1, 6, 'How many libraries does USC have?'),
(7, 1, 7, 'What is the USC motto?'),
(8, 1, 8, 'Which famous astronaut graduated from USC?'),
(9, 1, 9, 'What is the name of USC\'s student newspaper?'),
(10, 1, 10, 'What conference does USC belong to in college sports?');


-- Insert answers for USC Trivia Challenge
INSERT INTO `trivially_trojan`.`Answer` (id, question_id, description, answer_value) VALUES
(1, 1, '1851', 0),
(2, 1, '1905', 0),
(3, 1, '1880', 1),
(4, 1, '1867', 0),
(5, 2, 'Oski the Bear', 0),
(6, 2, 'Tommy Trojan', 1),
(7, 2, 'Tirebiter', 0),
(8, 2, 'Traveler', 0),
(9, 3, 'Crimson and Gold', 0),
(10, 3, 'Cardinal and Gold', 1),
(11, 3, 'Crimson and Mustard', 0),
(12, 3, 'Maroon and Gold', 0),
(13, 4, 'USC School of Cinematic Arts', 1),
(14, 4, 'USC School of Visual Arts', 0),
(15, 4, 'USC School of Film & Television', 0),
(16, 4, 'USC School of Media Arts', 0),
(17, 5, 'Los Angeles Memorial Coliseum', 1),
(18, 5, 'BMO Stadium', 0),
(19, 5, 'Soni McAlister Field', 0),
(20, 5, 'Brittingham Field', 0),
(21, 6, '12', 0),
(22, 6, '15', 0),
(23, 6, '23', 1),
(24, 6, '18', 0),
(25, 7, 'Inveniemus viam aut faciemus', 0),
(26, 7, 'Scientia potentia est', 0),
(27, 7, 'Crescit cum commercio civitas', 0),
(28, 7, 'Palmam qui meruit ferat', 1),
(29, 8, 'Buzz Aldrin', 0),
(30, 8, 'Neil Armstrong', 1),
(31, 8, 'John Glenn', 0),
(32, 8, 'Alan Shepard', 0),
(33, 9, 'Daily Trojan', 1),
(34, 9, 'Trojan News', 0),
(35, 9, 'Trojan Daily', 0),
(36, 9, 'The Voice of Troy', 0),
(37, 10, 'Big Ten', 0),
(38, 10, 'SEC', 0),
(39, 10, 'ACC', 0),
(40, 10, 'Pac-12', 1);

-- Insert results for Quiz 1 (USC Trivia Challenge)
INSERT INTO `trivially_trojan`.`Result` (id, quiz_id, description, lower_bound, upper_bound, image_location) VALUES
(1, 1, 'Trojan Novice: Looks like you might be new to the USC scene. Keep exploring and learning more about this great university!', 0, 2, 'https://cdn2.lamag.com/wp-content/uploads/sites/6/2019/04/USC_CoverImage.jpg'),
(2, 1, 'Trojan Explorer: You have a decent understanding of USC, but there is still a lot to learn. Continue to expand your knowledge of this historic university.', 3, 5, 'https://image.shutterstock.com/image-vector/vector-cartoon-style-illustration-educational-600w-1711456037.jpg'),
(3, 1, 'Trojan Enthusiast: You know quite a bit about USC! You\'re well on your way to becoming a true Trojan expert.', 6, 8, 'https://dailytrojan.com/wp-content/uploads/2021/11/DSC-5123-1-scaled.jpg'),
(4, 1, 'True Trojan: Congratulations! Your extensive knowledge of USC proves that you are a true Trojan. Fight On!', 9, 10, 'https://usg.usc.edu/trojanpride/wp-content/uploads/sites/9/2020/09/pom-poms-1.jpg');






-- 
-- Quiz 2 Content
-- 

-- Insert questions for AMST-301gp: America, the Frontier, and the New West
INSERT INTO `trivially_trojan`.`Question` (`id`, `quiz_id`, `question_no`, `description`) VALUES
(11, 2, 1, 'What year was the Declaration of Independence signed?'),
(12, 2, 2, 'What was the last territory to become a state in the contiguous United States?'),
(13, 2, 3, 'Which event started the California Gold Rush?'),
(14, 2, 4, 'What was the purpose of the Lewis and Clark expedition?'),
(15, 2, 5, 'What was the main cause of the Mexican-American War?'),
(16, 2, 6, 'Which act provided land to settlers in the western territories?'),
(17, 2, 7, 'In which year was the US Constitution ratified?'),
(18, 2, 8, 'What was the significance of the Louisiana Purchase?'),
(19, 2, 9, 'Which Native American tribe is associated with the Trail of Tears?'),
(20, 2, 10, 'What treaty established the 49th parallel as the border between the U.S. and Canada?');

-- Insert answers for AMST-301gp: America, the Frontier, and the New West
INSERT INTO `trivially_trojan`.`Answer` (id, question_id, description, answer_value) VALUES
(41, 11, '1776', 1),
(42, 11, '1775', 0),
(43, 11, '1783', 0),
(44, 11, '1800', 0),
(45, 12, 'Texas', 0),
(46, 12, 'Hawaii', 0),
(47, 12, 'Arizona', 1),
(48, 12, 'Alaska', 0),
(49, 13, 'Sutter\'s Mill', 1),
(50, 13, 'Pikes Peak', 0),
(51, 13, 'Discovery of the Comstock Lode', 0),
(52, 13, 'Klondike Gold Rush', 0),
(53, 14, 'To find a direct water route to the Pacific Ocean', 1),
(54, 14, 'To establish trade with Native American tribes', 0),
(55, 14, 'To explore and map the newly acquired Louisiana Purchase', 0),
(56, 14, 'To find gold in the western territories', 0),
(57, 15, 'Manifest Destiny', 1),
(58, 15, 'Slavery', 0),
(59, 15, 'Economic disputes', 0),
(60, 15, 'Religious differences', 0),
(61, 16, 'Homestead Act', 1),
(62, 16, 'Land Ordinance of 1785', 0),
(63, 16, 'Dawes Act', 0),
(64, 16, 'Morrill Act', 0),
(65, 17, '1787', 0),
(66, 17, '1788', 1),
(67, 17, '1789', 0),
(68, 17, '1790', 0),
(69, 18, 'It doubled the size of the United States', 1),
(70, 18, 'It settled the border dispute with Canada', 0),
(71, 18, 'It established the United States as a world power', 0),
(72, 18, 'It marked the beginning of westward expansion', 0),
(73, 19, 'Sioux', 0),
(74, 19, 'Navajo', 0),
(75, 19, 'Cherokee', 1),
(76, 19, 'Iroquois', 0),
(77, 20, 'Treaty of Ghent', 0),
(78, 20, 'Treaty of Paris', 0),
(79, 20, 'Oregon Treaty', 1),
(80, 20, 'Treaty of Tordesillas', 0);

-- Insert results for AMST-301gp: America, the Frontier, and the New West
INSERT INTO `trivially_trojan`.`Result` (id, quiz_id, description, lower_bound, upper_bound, image_location) VALUES
(5, 2, 'Frontier Scholar: You have a deep understanding of the American Frontier and the New West. Keep exploring the vast history of this great nation!', 8, 10, 'https://static01.nyt.com/images/2019/03/17/books/review/17dolnik/17dolnik-superJumbo.jpg'),
(6, 2, 'Trailblazer: You have a good grasp on the history of America, the Frontier, and the New West. Keep learning and you\'ll become a true expert!', 5, 7, 'https://cdn.britannica.com/71/167171-138-7555E3F9/Overview-Louisiana-Purchase.jpg?w=800&h=450&c=crop'),
(7, 2, 'Settler: You know some basics, but there\'s much more to learn about the history of America, the Frontier, and the New West. Keep studying!', 3, 4, 'https://cdn.britannica.com/11/190311-050-07D54147/reenactment-horse-wagon-team-trail-North-America.jpg'),
(8, 2, 'Greenhorn: You have a lot to learn about the history of America, the Frontier, and the New West. Don\'t worry, history is full of fascinating stories waiting to be discovered!', 0, 2, 'https://i0.wp.com/longreads.com/wp-content/uploads/2019/03/gettyimages-96742168-2-scaled.jpg?fit=2560%2C1683&ssl=1');




-- 
-- Quiz 3 Content
-- 

-- Insert questions for Frogology 101
INSERT INTO `trivially_trojan`.`Question` (`id`, `quiz_id`, `question_no`, `description`) VALUES
(21, 3, 1, 'What is the study of frogs called?'),
(22, 3, 2, 'Which continent has the highest diversity of frog species?'),
(23, 3, 3, 'What is the world\'s largest frog?'),
(24, 3, 4, 'Which frogs are known for their toxic secretions?'),
(25, 3, 5, 'What is the primary function of the vocal sac in male frogs?'),
(26, 3, 6, 'Which type of habitat do tree frogs primarily live in?'),
(27, 3, 7, 'What is the typical diet of a frog?'),
(28, 3, 8, 'What is the term for a baby frog?'),
(29, 3, 9, 'What is the process through which a tadpole becomes a frog called?'),
(30, 3, 10, 'Which frog species can change its skin color?');

-- Insert answers for Frogology 101
INSERT INTO `trivially_trojan`.`Answer` (id, question_id, description, answer_value) VALUES
(81, 21, 'Herpetology', 1),
(82, 21, 'Frogology', 0),
(83, 21, 'Amphibiology', 0),
(84, 21, 'Ranology', 0),
(85, 22, 'Asia', 0),
(86, 22, 'Africa', 1),
(87, 22, 'South America', 0),
(88, 22, 'Australia', 0),
(89, 23, 'African Bullfrog', 0),
(90, 23, 'Goliath Frog', 1),
(91, 23, 'Amazonian Giant Frog', 0),
(92, 23, 'Cane Toad', 0),
(93, 24, 'Dart Frogs', 1),
(94, 24, 'Bullfrogs', 0),
(95, 24, 'Tree Frogs', 0),
(96, 24, 'Glass Frogs', 0),
(97, 25, 'Attracting mates', 1),
(98, 25, 'Eating', 0),
(99, 25, 'Breathing', 0),
(100, 25, 'Swimming', 0),
(101, 26, 'Aquatic', 0),
(102, 26, 'Terrestrial', 0),
(103, 26, 'Arboreal', 1),
(104, 26, 'Subterranean', 0),
(105, 27, 'Insects and small invertebrates', 1),
(106, 27, 'Fruits and vegetables', 0),
(107, 27, 'Small mammals', 0),
(108, 27, 'Seeds and nuts', 0),
(109, 28, 'Tadpole', 1),
(110, 28, 'Froglet', 0),
(111, 28, 'Spawn', 0),
(112, 28, 'Polliwog', 0),
(113, 29, 'Metamorphosis', 1),
(114, 29, 'Molting', 0),
(115, 29, 'Growth', 0),
(116, 29, 'Transformation', 0),
(117, 30, 'African Clawed Frog', 0),
(118, 30, 'Common European Frog', 0),
(119, 30, 'Golden Poison Dart Frog', 0),
(120, 30, 'Gray Tree Frog', 1);

-- Insert results for Frogology 101
INSERT INTO `trivially_trojan`.`Result` (id, quiz_id, description, lower_bound, upper_bound, image_location) VALUES
(9, 3, 'Frog Whisperer: Your knowledge of frogs is outstanding! You must have spent a lot of time in the wild or have a deep fascination for these amazing creatures.', 8, 10, 'https://www.everythingreptiles.com/wp-content/uploads/2020/10/Pacman-Frog.jpg'),
(10, 3, 'Frog Friend: You have a good understanding of frogs, but there\'s always more to learn. Keep exploring the fascinating world of amphibians!', 5, 7, 'https://cdn.mos.cms.futurecdn.net/39CUYMP8vJqHAYGVzUghBX.jpg'),
(11, 3, 'Tadpole: You have some basic knowledge of frogs, but there\'s a lot more to discover. Dive into the world of frogs and continue learning!', 2, 4, 'https://cdn.britannica.com/20/231520-050-9DF96017/tadpole-common-frog-amphibian.jpg'),
(12, 3, 'Frog Newbie: It seems you\'re just starting to learn about frogs. Don\'t worry, there\'s a whole world of information out there for you to explore!', 0, 1, 'https://static.boredpanda.com/blog/wp-content/uploads/2021/08/funny-frogs-3-61239cc65b109__700.jpg');






-- 
-- Quiz 4 Content
-- 

-- Insert questions for Harry Potter Trivia
INSERT INTO `trivially_trojan`.`Question` (id, quiz_id, question_no, description) VALUES
(31, 4, 1, 'Who is the author of the Harry Potter series?'),
(32, 4, 2, 'What is the name of the school that Harry Potter attends?'),
(33, 4, 3, 'What is the full name of the character who is Harry\'s best friend?'),
(34, 4, 4, 'What is the name of the sport played by wizards in the Harry Potter universe?'),
(35, 4, 5, 'Which house at Hogwarts has the symbol of a lion?'),
(36, 4, 6, 'What is the name of the dark wizard and main antagonist in the series?'),
(37, 4, 7, 'Which professor teaches Potions at Hogwarts during Harry\'s first year?'),
(38, 4, 8, 'What is the name of the magical creature that can transform into a person\'s worst fear?'),
(39, 4, 9, 'What is the name of the magical map that reveals the locations of people within Hogwarts?'),
(40, 4, 10, 'What is the core of Harry Potter\'s wand made of?');

-- Insert answers for Harry Potter Trivia
INSERT INTO `trivially_trojan`.`Answer` (id, question_id, description, answer_value) VALUES
(121, 31, 'Stephen King', 0),
(122, 31, 'George R.R. Martin', 0),
(123, 31, 'J.K. Rowling', 1),
(124, 31, 'J.R.R. Tolkien', 0),
(125, 32, 'Hogwarts School of Witchcraft and Wizardry', 1),
(126, 32, 'Beauxbatons Academy of Magic', 0),
(127, 32, 'Ilvermorny School of Witchcraft and Wizardry', 0),
(128, 32, 'Durmstrang Institute', 0),
(129, 33, 'Hermione Granger', 0),
(130, 33, 'Neville Longbottom', 0),
(131, 33, 'Ronald Weasley', 1),
(132, 33, 'Dobby The House Elf', 0),
(133, 34, 'Quidditch', 1),
(134, 34, 'Wizard Chess', 0),
(135, 34, 'Gobstones', 0),
(136, 34, 'Exploding Snap', 0),
(137, 35, 'Hufflepuff', 0),
(138, 35, 'Ravenclaw', 0),
(139, 35, 'Gryffindor', 1),
(140, 35, 'Slytherin', 0),
(141, 36, 'Draco Malfoy', 0),
(142, 36, 'Bellatrix Lestrange', 0),
(143, 36, 'Lord Voldemort', 1),
(144, 36, 'Severus Snape', 0),
(145, 37, 'Horace Slughorn', 0),
(146, 37, 'Minerva McGonagall', 0),
(147, 37, 'Severus Snape', 1),
(148, 37, 'Filius Flitwick', 0),
(149, 38, 'Dementor', 0),
(150, 38, 'Boggart', 1),
(151, 38, 'Thestral', 0),
(152, 38, 'Niffler', 0),
(153, 39, 'The Marauder\'s Map', 1),
(154, 39, 'The Weasley\'s Clock', 0),
(155, 39, 'The Quibbler', 0),
(156, 39, 'The Daily Prophet', 0),
(157, 40, 'Dragon Heartstring', 0),
(158, 40, 'Phoenix Feather', 1),
(159, 40, 'Unicorn Hair', 0),
(160, 40, 'Veela Hair', 0);

-- Insert results for Harry Potter Trivia
INSERT INTO `trivially_trojan`.`Result` (id, quiz_id, description, lower_bound, upper_bound, image_location) VALUES
(13, 4, 'Muggle: You might need to brush up on your Harry Potter knowledge. Time for a re-read or a movie marathon!', 0, 2, 'https://api.time.com/wp-content/uploads/2015/06/dursleys.jpg?quality=85&w=720&h=469&crop=1'),
(14, 4, 'Casual Fan: You know a fair bit about the magical world of Harry Potter. Keep exploring and learning!', 3, 5, 'https://media-cldnry.s-nbcnews.com/image/upload/rockcms/2021-11/211116-harry-potter-al-1232-b41548.jpg'),
(15, 4, 'Wizard-in-Training: Impressive! Your knowledge of the Harry Potter universe is vast. Keep practicing your spells!', 6, 8, 'https://www.usmagazine.com/wp-content/uploads/2018/08/harry-potter-inspired-cocktails.jpg?crop=182px%2C94px%2C1539px%2C869px&resize=1600%2C900&quality=86&strip=all'),
(16, 4, 'True Potterhead: Congratulations! Your knowledge of the Harry Potter world is truly magical. Dumbledore would be proud!', 9, 10, 'https://i.insider.com/5dc2fb9479d75707a81210d5?width=1136&format=jpeg');



-- 
-- Add Demo User
-- 
INSERT  INTO `trivially_trojan`.`User` (`id`,`email`,`password`,`username`) VALUES
(1, "ttrojan@usc.edu", "fighton", "ttrojan");

-- 
-- Add example User Quiz Record
-- 
INSERT  INTO `trivially_trojan`.`UserQuizRecord`  (`id`,`user_id`,`quiz_id`,`quiz_result_id`) VALUES
(1, 1, 1, 4),
(2, 1, 3, 7);