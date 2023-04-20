/*
 * The deployment script for the project.
 * Simply copy and paste this script into your local SQL database for the project, and run.
 * Alternatively, you can import the script directly using your SQL management software.
 */

/* 
 * Handle table deconstruction
 *
 * !!!WARNING!!!
 * 
 * Table deletion must be done in the order below.
 * Other this script will not run correctly.
 */
DROP TABLE IF EXISTS `UserQuizRecord`;
DROP TABLE IF EXISTS `Answer`;
DROP TABLE IF EXISTS `Result`;
DROP TABLE IF EXISTS `Results`;
DROP TABLE IF EXISTS `Question`;
DROP TABLE IF EXISTS `Quiz`;
DROP TABLE IF EXISTS `Category`;
DROP TABLE IF EXISTS `User`;
DROP TABLE IF EXISTS `Users`;


--
-- Table structure for table `Category`
--
CREATE TABLE `Category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `description` varchar(500) NOT NULL,
  `image_location` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



--
-- Table structure for table `Quiz`
--
CREATE TABLE `Quiz` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `image_location` varchar(1000) DEFAULT NULL,
  `category_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `quiz_ibfk_1` (`category_id`),
  CONSTRAINT `quiz_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `Category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



--
-- Table structure for table `Results`
--
CREATE TABLE `Result` (
  `id` int NOT NULL AUTO_INCREMENT,
  `quiz_id` int NOT NULL,
  `description` varchar(500) NOT NULL,
  `value` int NOT NULL,
  `image_location` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Result_FK` (`quiz_id`),
  CONSTRAINT `Result_FK` FOREIGN KEY (`quiz_id`) REFERENCES `Quiz` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



--
-- Table structure for table `Question`
--
CREATE TABLE `Question` (
  `id` int NOT NULL AUTO_INCREMENT,
  `quiz_id` int NOT NULL,
  `question_no` int NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `image_location` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `quiz_id` (`quiz_id`),
  CONSTRAINT `question_ibfk_1` FOREIGN KEY (`quiz_id`) REFERENCES `QUIZ` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Table structure for table `Answer`
--
CREATE TABLE `Answer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `question_id` int NOT NULL,
  `answer_description` varchar(200) DEFAULT NULL,
  `answer_value` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `question_id` (`question_id`),
  CONSTRAINT `answer_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `Question` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `User`
--
CREATE TABLE `User` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(50) NOT NULL,
  `password` varchar(500) NOT NULL,
  `username` varchar(20) NOT NULL,
  UNIQUE(`email`),
  UNIQUE(`username`),
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `UserQuizRecord`
--
CREATE TABLE `UserQuizRecord` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `quiz_id` int NOT NULL,
  `quiz_result_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `uqr_fk_1` (`user_id`),
  KEY `uqr_fk_2` (`quiz_id`),
  KEY `uqr_fk_3` (`quiz_result_id`),
  CONSTRAINT `uqr_fk_1` FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`),
  CONSTRAINT `uqr_fk_2` FOREIGN KEY (`quiz_id`) REFERENCES `Quiz` (`id`),
  CONSTRAINT `uqr_fk_3` FOREIGN KEY (`quiz_result_id`) REFERENCES `Result` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


/* Categories */
INSERT INTO Category (id, name, description, image_location) VALUES
(1, 'Travel', 'Quizzes about travel destinations and preferences', 'https://www.diabetes.co.uk/wp-content/uploads/2019/01/Untitled-design138.jpg'),
(2, 'Personality', 'Quizzes about various personality traits and types', 'https://media-cldnry.s-nbcnews.com/image/upload/newscms/2018_39/2582131/180928-differing-personality-mc-1541.JPG'),
(3, 'USC', 'Unlock your inner Trojan with various quizzes about USC', 'https://media.cnn.com/api/v1/images/stellar/prod/220727174432-university-of-southern-california-file.jpg?c=3x2');



/* Quizzes */
INSERT INTO Quiz (id, name, description, image_location, category_id) VALUES
(1, 'Where should you live after college?', 'Find out which region in the United States best suits your lifestyle and preferences!', 'https://lp-cms-production.imgix.net/image_browser/Cherry%20Blossoms%20and%20monument.jpg', 1),
(2, 'Which European city should you visit?', 'Discover which European city you should explore next!', 'https://s27363.pcdn.co/wp-content/uploads/2017/11/Tyn-Church.jpg.optimal.jpg', 1),
(3, 'What type of vacation suits you best?', 'Determine your ideal vacation style based on your preferences!', 'https://i0.wp.com/katestravel.com/wp-content/uploads/2017/02/Depositphotos_146081113_l-2015.jpg?fit=2000%2C1333&ssl=1', 1),
(4, 'Which exotic destination should you visit?', 'Find out which unique destination you should add to your travel bucket list!', 'https://www.libertytravel.com/sites/default/files/styles/full_size/public/iceland%20tours-hero%20%282%29.jpg?itok=qjh0todu', 1),
(5, 'Which element best represents you?', 'Discover which of the four elements - earth, water, air, or fire - best represents your personality!', 'https://earthhaven.ca/photos/custom/Four%20Elements_sm.jpg', 2),
(6, 'What type of animal are you?', 'Find out which animal shares similar personality traits with you!', 'https://mdc.mo.gov/sites/default/files/mo_nature/media/images/2013/11/great_horned_owl_closeup_11-19-13.jpg', 2);




/* Quiz Results */
-- Example: Insert Results for Quiz 1
INSERT INTO result (id, quiz_id, description, value, image_location) VALUES
(1, 1, 'Southwest', 1, 'https://upload.wikimedia.org/wikipedia/commons/5/5a/Monument_Valley_2.jpg'),
(2, 1, 'Northeast', 2, 'https://findingbeyond.com/app/uploads/2019/08/Northeastern-United-States-Road-Trip-cover.jpg'),
(3, 1, 'The South', 3, 'https://www.exploregeorgia.org/sites/default/files/2018-08/savannah.jpg'),
(4, 1, 'The Midwest', 4, 'https://a.travel-assets.com/findyours-php/viewfinder/images/res70/483000/483904-central-canal.jpg'),
(5, 1, 'Pacific Northwest', 5, 'https://www.drought.gov/sites/default/files/hero/drought-status-update/drought-status-pnw_1.jpg'),
(6, 1, 'Mountain states', 6, 'https://lp-cms-production.imgix.net/2022-11/Telluride.jpg');

-- Insert Results for Quiz 2
INSERT INTO result (id, quiz_id, description, value, image_location) VALUES
(7, 2, 'Paris, France', 1, 'https://cdn.britannica.com/36/135436-050-ED1D0FCE/skyline-Eiffel-Tower-France-Paris.jpg'),
(8, 2, 'Rome, Italy', 2, 'https://fullsuitcase.com/wp-content/uploads/2022/01/Best-things-to-do-in-Rom-Italy.jpg.webp'),
(9, 2, 'Barcelona, Spain', 3, 'https://api.time.com/wp-content/uploads/2023/03/Worlds-Greatest-Places-Barcelona-Spain.jpg'),
(10, 2, 'Berlin, Germany', 4, 'https://www.travelandleisure.com/thmb/Etq4zWgOW-z9H7ZScs5_6WDcDvQ=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/berlin-germany-aerial-lead-BERLINTG0921-475e3a333c7f4fdea7743c6fc2f261af.jpg'),
(11, 2, 'Amsterdam, Netherlands', 5, 'https://content.r9cdn.net/rimg/dimg/92/c5/5687cba1-city-1334-16e17b24601.jpg?width=1366&height=768&xhint=1722&yhint=1385&crop=true'),
(12, 2, 'Prague, Czech Republic', 6, 'https://cdn.britannica.com/21/177921-050-4529CD59/Charles-Bridge-Vltava-River-Prague.jpg');

-- Insert Results for Quiz 3
INSERT INTO result (id, quiz_id, description, value, image_location) VALUES
(13, 3, 'Beach Vacation', 1, 'https://cdn.britannica.com/69/175869-050-DFF34225/Crescent-Bay-Beach-Laguna-California.jpg'),
(14, 3, 'City Break', 2, 'https://www.travelandleisure.com/thmb/91pb8LbDAUwUN_11wATYjx5oF8Q=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/new-york-city-evening-NYCTG0221-52492d6ccab44f328a1c89f41ac02aea.jpg'),
(15, 3, 'Adventure Trip', 3, 'https://media.cntraveler.com/photos/602ad7f38951486cd995d6ff/16:9/w_2560%2Cc_limit/913068642'),
(16, 3, 'Cultural Exploration', 4, 'https://www.chichenitza.com/public/assets/img/ruins/chichen-itza-pyramid.jpg'),
(17, 3, 'Nature Retreat', 5, 'https://cdn.onekindesign.com/wp-content/uploads/2021/12/Modern-Nature-Retreat-David-Van-Galen-Architecture-01-1-Kindesign.jpg'),
(18, 3, 'Road Trip', 6, 'https://lp-cms-production.imgix.net/2021-10/GettyImages-1179664905.jpg');

-- Insert Results for Quiz 4
INSERT INTO result (id, quiz_id, description, value, image_location) VALUES
(19, 4, 'Machu Picchu, Peru', 1, 'https://media.cnn.com/api/v1/images/stellar/prod/220329015758-machu-picchu-file-11012020.jpg?c=original'),
(20, 4, 'Petra, Jordan', 2, 'https://cdn.britannica.com/88/189788-050-9B5DB3A4/Al-Dayr-Petra-Jordan.jpg'),
(21, 4, 'Galápagos Islands, Ecuador', 3, 'https://www.travelandleisure.com/thmb/WzL019sDotA4SIo4bacRrE4j_N0=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/galapagos-islands-ecuador-GALAPA1104-d013219debf14369ab5039a4eafb496e.jpg'),
(22, 4, 'Angkor Wat, Cambodia', 4, 'https://upload.wikimedia.org/wikipedia/commons/d/d4/20171126_Angkor_Wat_4712_DxO.jpg'),
(23, 4, 'Victoria Falls, Zambia/Zimbabwe', 5, 'https://smartwatermagazine.com/sites/default/files/styles/thumbnail-1180x647/public/victoria_falls_1.jpg?itok=EgKN1vl3'),
(24, 4, 'Antarctica', 6, 'https://cdn.britannica.com/08/135708-050-2346C1CF/Paradise-Bay-Antarctica.jpg');

-- Insert Results for Quiz 5
INSERT INTO result (id, quiz_id, description, value, image_location) VALUES
(25, 5, 'Earth', 1, 'https://cdn.pixabay.com/photo/2015/11/04/20/59/earth-1023859_960_720.jpg'),
(26, 5, 'Water', 2, 'https://cdn.pixabay.com/photo/2017/10/25/12/39/water-2889269_960_720.jpg'),
(27, 5, 'Air', 3, 'https://cdn.pixabay.com/photo/2016/11/29/08/00/air-1867880_960_720.jpg'),
(28, 5, 'Fire', 4, 'https://cdn.pixabay.com/photo/2015/09/02/00/20/fire-918982_960_720.jpg');

-- Insert Results for Quiz 6
INSERT INTO result (id, quiz_id, description, value, image_location) VALUES
(29, 6, 'Lion', 1, 'https://cdn.pixabay.com/photo/2015/09/22/14/34/african-lion-951778_960_720.jpg'),
(30, 6, 'Dolphin', 2, 'https://cdn.pixabay.com/photo/2017/12/08/20/02/dolphin-3007391_960_720.jpg'),
(31, 6, 'Eagle', 3, 'https://cdn.pixabay.com/photo/2017/10/07/18/53/eagle-2826657_960_720.jpg'),
(32, 6, 'Elephant', 4, 'https://cdn.pixabay.com/photo/2014/12/22/10/04/lion-576261_960_720.jpg');





/* Questions */
-- Insert Questions for Quiz 1
INSERT INTO question (id, quiz_id, question_no, description, image_location) VALUES
(1, 1, 1, 'What is your favorite type of weather?', ''),
(2, 1, 2, 'Which outdoor activity do you enjoy the most?', ''),
(3, 1, 3, 'What is your preferred type of landscape?', ''),
(4, 1, 4, 'What kind of local cuisine do you prefer?', ''),
(5, 1, 5, 'How do you handle traffic?', ''),
(6, 1, 6, 'What is your favorite type of architecture?', ''),
(7, 1, 7, 'How important is public transportation to you?', ''),
(8, 1, 8, 'What type of climate do you prefer?', ''),
(9, 1, 9, 'Which best describes your ideal living situation?', ''),
(10, 1, 10, 'What kind of local attractions interest you the most?', ''),
(11, 1, 11, 'How important is the cost of living to you?', ''),
(12, 1, 12, 'What is your ideal population size for a city or town?', '');

-- Insert Questions for Quiz 2
INSERT INTO question (id, quiz_id, question_no, description, image_location) VALUES
(13, 2, 1, 'What type of architecture do you prefer?', ''),
(14, 2, 2, 'Which cuisine do you enjoy the most?', ''),
(15, 2, 3, 'How important is history and culture to you?', ''),
(16, 2, 4, 'Which type of climate do you prefer?', ''),
(17, 2, 5, 'What is your favorite form of transportation?', ''),
(18, 2, 6, 'How important is the nightlife to you?', ''),
(19, 2, 7, 'What type of outdoor activities do you enjoy?', ''),
(20, 2, 8, 'How important is the art scene to you?', ''),
(21, 2, 9, 'Which type of shopping experience do you prefer?', ''),
(22, 2, 10, 'What kind of natural landscapes do you enjoy the most?', ''),
(23, 2, 11, 'How important is the cost of living to you?', ''),
(24, 2, 12, 'What is your ideal city size?', '');

-- Insert Questions for Quiz 3
INSERT INTO question (id, quiz_id, question_no, description, image_location) VALUES
(25, 3, 1, 'What type of environment do you prefer?', ''),
(26, 3, 2, 'How do you like to spend your free time on vacation?', ''),
(27, 3, 3, 'What is your preferred mode of transportation?', ''),
(28, 3, 4, 'Which type of accommodation do you prefer?', ''),
(29, 3, 5, 'What is your favorite travel activity?', ''),
(30, 3, 6, 'What type of food do you prefer?', ''),
(31, 3, 7, 'How important is meeting new people during your trip?', ''),
(32, 3, 8, 'What is your preferred travel group size?', ''),
(33, 3, 9, 'What do you value most in a travel destination?', ''),
(34, 3, 10, 'What type of climate do you prefer?', ''),
(35, 3, 11, 'How adventurous are you when it comes to traveling?', ''),
(36, 3, 12, 'What is your ideal vacation length?', '');

-- Insert Questions for Quiz 4
INSERT INTO question (id, quiz_id, question_no, description, image_location) VALUES
(37, 4, 1, 'How do you handle failure?', ''),
(38, 4, 2, 'What kind of goals do you set for yourself?', ''),
(39, 4, 3, 'How do you stay motivated?', ''),
(40, 4, 4, 'What is your approach to time management?', ''),
(41, 4, 5, 'Which of these traits best describes you?', ''),
(42, 4, 6, 'How do you make decisions?', ''),
(43, 4, 7, 'What is your preferred way of learning?', ''),
(44, 4, 8, 'How do you approach risk-taking?', ''),
(45, 4, 9, 'What type of tasks do you find most fulfilling?', ''),
(46, 4, 10, 'How do you handle criticism?', ''),
(47, 4, 11, 'What is your approach to networking?', ''),
(48, 4, 12, 'How do you prioritize your tasks?', '');


-- Insert Questions for Quiz 5
INSERT INTO question (id, quiz_id, question_no, description, image_location) VALUES
(49, 5, 1, 'How do you react in a conflict situation?', ''),
(50, 5, 2,'Which of these activities do you enjoy the most?', ''),
(51, 5, 3,'What is your favorite type of weather?', ''),
(52, 5, 4,'Which of these words best describes your personality?', ''),
(53, 5, 5,'How do you approach problem-solving?', ''),
(54, 5, 6,'What type of environment do you prefer?', ''),
(55, 5, 7,'How do you recharge your energy?', ''),
(56, 5, 8,'Which of these hobbies do you find most appealing?', ''),
(57, 5, 9,'What is your preferred method of communication?', ''),
(58, 5, 10,'How do you handle stress?', ''),
(59, 5, 11,'What gets you motivated?', ''),
(60, 5, 12,'If you could be an animal, what would you be?', '');

-- Insert Questions for Quiz 6
INSERT INTO question (id, quiz_id, question_no, description, image_location) VALUES
(61, 6, 1, 'How do you approach a new social situation?', ''),
(62, 6, 2, 'What is your favorite type of food?', ''),
(63, 6, 3, 'How do you spend your free time?', ''),
(64, 6, 4,'Which of these qualities do you value most in yourself?', ''),
(65, 6, 5, 'How do you approach teamwork?', ''),
(66, 6, 6, 'What is your preferred habitat?', ''),
(67, 6, 7,'How do you handle responsibility?', ''),
(68, 6, 8,'Which of these activities sounds the most fun to you?', ''),
(69, 6, 9,'How do you react to change?', ''),
(70, 6, 10,'If you had one superpower, what would it be?', ''),
(71, 6, 11,'What is your ideal first date?', ''),
(72, 6, 12,'What is your favorite time of day?', '');






/* Answers */
-- Answers for Quiz 1
INSERT INTO answer (id, question_id, answer_description, answer_value) VALUES
(1, 1, 'Sunny and warm', 1),
(2, 1, 'Cold and snowy', 2),
(3, 1, 'Mild and partly cloudy', 3),
(4, 1, 'Rainy and cool', 5),
(5, 2, 'Hiking', 6),
(6, 2, 'Skiing or snowboarding', 2),
(7, 2, 'Boating or fishing', 3),
(8, 2, 'Biking', 1),
(9, 3, 'Desert', 1),
(10, 3, 'Urban', 2),
(11, 3, 'Forest', 5),
(12, 3, 'Plains', 4),
(13, 4, 'Mexican cuisine', 1),
(14, 4, 'Seafood', 2),
(15, 4, 'Southern comfort food', 3),
(16, 4, 'Farm-to-table', 4),
(17, 5, 'I can handle traffic well', 1),
(18, 5, 'I prefer public transportation', 5),
(19, 5, 'I avoid traffic when possible', 3),
(20, 5, 'I\'d rather bike or walk', 4),
(21, 6, 'Southwestern adobe', 1),
(22, 6, 'Colonial', 2),
(23, 6, 'Antebellum', 3),
(24, 6, 'Modern', 4),
(25, 7, 'Not important, I prefer driving', 6),
(26, 7, 'Very important', 2),
(27, 7, 'Somewhat important', 3),
(28, 7, 'I can manage without it', 4),
(29, 8, 'Hot and dry', 1),
(30, 8, 'Cold and wet', 2),
(31, 8, 'Warm and humid', 3),
(32, 8, 'Mild and temperate', 5),
(33, 9, 'City apartment', 2),
(34, 9, 'Suburban house', 3),
(35, 9, 'Rural farmhouse', 4),
(36, 9, 'Off-the-grid cabin', 6),
(37, 10, 'Natural wonders', 1),
(38, 10, 'Historical landmarks', 2),
(39, 10, 'Art and culture', 4),
(40, 10, 'Outdoor recreation', 5),
(41, 11, 'Not very important', 6),
(42, 11, 'Somewhat important', 2),
(43, 11, 'Very important', 3),
(44, 11, 'A top priority', 4),
(45, 12, 'Small town', 1),
(46, 12, 'Medium-sized city', 4),
(47, 12, 'Large city', 2),
(48, 12, 'Metropolis', 5);

-- Answers for Quiz 2
INSERT INTO answer (id, question_id, answer_description, answer_value) VALUES
(49, 13, 'Gothic', 7),
(50, 13, 'Baroque', 12),
(51, 13, 'Modernist', 9),
(52, 13, 'Classical', 8),
(53, 14, 'French', 7),
(54, 14, 'Italian', 8),
(55, 14, 'Spanish', 9),
(56, 14, 'German', 10),
(57, 15, 'Very important', 8),
(58, 15, 'Somewhat important', 7),
(59, 15, 'Not very important', 9),
(60, 15, 'Not at all important', 11),
(61, 16, 'Mild and temperate', 11),
(62, 16, 'Hot and sunny', 9),
(63, 16, 'Cold and snowy', 10),
(64, 16, 'Variable with distinct seasons', 8),
(65, 17, 'Walking', 7),
(66, 17, 'Biking', 11),
(67, 17, 'Public transportation', 12),
(68, 17, 'Driving', 10),
(69, 18, 'Very important', 9),
(70, 18, 'Somewhat important', 10),
(71, 18, 'Not very important', 7),
(72, 18, 'Not at all important', 8),
(73, 19, 'Sightseeing', 7),
(74, 19, 'Beach activities', 9),
(75, 19, 'Mountain sports', 10),
(76, 19, 'City exploration', 12),
(77, 20, 'Very important', 9),
(78, 20, 'Somewhat important', 11),
(79, 20, 'Not very important', 8),
(80, 20, 'Not at all important', 7),
(81, 21, 'High-end boutiques', 7),
(82, 21, 'Local markets', 9),
(83, 21, 'Vintage stores', 11),
(84, 21, 'Large malls', 10),
(85, 22, 'Beaches', 9),
(86, 22, 'Mountains', 10),
(87, 22, 'Forests', 11),
(88, 22, 'Historic cityscapes', 8),
(89, 23, 'Not very important', 7),
(90, 23, 'Somewhat important', 10),
(91, 23, 'Very important', 9),
(92, 23, 'A top priority', 11),
(93, 24, 'Small and charming', 12),
(94, 24, 'Medium-sized and bustling', 8),
(95, 24, 'Large and cosmopolitan', 7),
(96, 24, 'Huge and overwhelming', 9);

/* Answer Options for Quiz 3 */
INSERT INTO answer (id, question_id, answer_description, answer_value) VALUES
(97, 25, 'Sandy beach', 13),
(98, 25, 'Bustling city', 14),
(99, 25, 'Mountainous terrain', 15),
(100, 25, 'Historic sites', 16),
(101, 26, 'Relaxing by the water', 13),
(102, 26, 'Exploring local attractions', 14),
(103, 26, 'Participating in adrenaline-pumping activities', 15),
(104, 26, 'Visiting museums and cultural landmarks', 16),
(105, 27, 'Walking or biking', 17),
(106, 27, 'Public transportation', 14),
(107, 27, 'Outdoor adventure vehicle', 15),
(108, 27, 'Guided tour', 16),
(109, 28, 'Beach resort', 13),
(110, 28, 'City center hotel', 14),
(111, 28, 'Adventure lodge', 15),
(112, 28, 'Historic inn', 16),
(113, 29, 'Sunbathing and swimming', 13),
(114, 29, 'Shopping and dining', 14),
(115, 29, 'Hiking and extreme sports', 15),
(116, 29, 'Exploring ancient ruins and architecture', 16),
(117, 30, 'Seafood and tropical fruits', 13),
(118, 30, 'Gourmet and fusion cuisine', 14),
(119, 30, 'Exotic local dishes', 15),
(120, 30, 'Traditional and regional specialties', 17),
(121, 31, 'Very important-I love making new friends', 18),
(122, 31, 'Somewhat important-I enjoy meeting locals and fellow travelers', 14),
(123, 31, 'Not very important-I prefer spending time with my travel companions', 15),
(124, 31, 'Not important at all-I travel for the experience, not to socialize', 16),
(125, 32, 'Solo or with a close friend', 17),
(126, 32, 'A small group of friends or family', 14),
(127, 32, 'With a guided tour group', 15),
(128, 32, 'As part of a cultural exchange program', 16),
(129, 33, 'Beautiful scenery', 17),
(130, 33, 'Vibrant nightlife and entertainment', 14),
(131, 33, 'Exciting outdoor adventures', 15),
(132, 33, 'Rich history and culture', 16),
(133, 34, 'Warm and sunny', 13),
(134, 34, 'Mild and temperate', 18),
(135, 34, 'Cool and crisp', 15),
(136, 34, 'Cold and snowy', 17),
(137, 35, 'Not at all-I prefer relaxation and familiar experiences', 13),
(138, 35, 'Somewhat-I like trying new things but within my comfort zone', 18),
(139, 35, 'Very-I love challenging myself and experiencing new adventures', 15),
(140, 35, 'Extremely-I\'m always seeking unique and thrilling experiences', 17),
(141, 36, 'A long weekend getaway', 18),
(142, 36, 'One week', 14),
(143, 36, 'Two to three weeks', 15),
(144, 36, 'A month or longer', 17);

-- Insert Answer Options for Quiz 4
INSERT INTO answer (id, question_id, answer_description, answer_value) VALUES
(145, 37, 'I learn from it and move on', 19),
(146, 37, 'I try to understand what went wrong', 20),
(147, 37, 'I take some time to reflect', 21),
(148, 37, 'I use it as motivation to improve', 22),
(149, 38, 'Long-term, ambitious goals', 23),
(150, 38, 'Short-term, achievable goals', 19),
(151, 38, 'A mix of short and long-term goals', 20),
(152, 38, 'I focus on the process rather than the outcome', 21),
(153, 39, 'Setting specific goals', 22),
(154, 39, 'Visualizing success', 23),
(155, 39, 'Finding inspiration from others', 19),
(156, 39, 'Focusing on the bigger picture', 20),
(157, 40, 'Strict scheduling', 21),
(158, 40, 'A flexible routine', 22),
(159, 40, 'Prioritizing tasks', 23),
(160, 40, 'Working with deadlines', 19),
(161, 41, 'Adventurous', 20),
(162, 41, 'Ambitious', 21),
(163, 41, 'Determined', 22),
(164, 41, 'Resilient', 23),
(165, 42, 'Quickly and decisively', 19),
(166, 42, 'After careful analysis', 20),
(167, 42, 'By seeking input from others', 21),
(168, 42, 'By considering long-term consequences', 22),
(169, 43, 'Reading and researching', 23),
(170, 43, 'Taking classes or attending workshops', 19),
(171, 43, 'Experiential learning', 20),
(172, 43, 'Collaborating with others', 21),
(173, 44, 'I embrace risks and challenges', 22),
(174, 44, 'I take calculated risks', 23),
(175, 44, 'I prefer to stay within my comfort zone', 19),
(176, 44, 'I avoid risks whenever possible', 20),
(177, 45, 'Problem-solving tasks', 21),
(178, 45, 'Creative tasks', 22),
(179, 45, 'Tasks that require teamwork', 23),
(180, 45, 'Tasks that involve learning new skills', 19),
(181, 46, 'I appreciate it as an opportunity to grow', 20),
(182, 46, 'I take it into consideration', 21),
(183, 46, 'I try not to take it personally', 22),
(184, 46, 'I use it as motivation to do better', 23),
(185, 47, 'I actively seek connections', 19),
(186, 47, 'I prefer to network organically', 20),
(187, 47, 'I rely on my existing connections', 21),
(188, 47, 'I focus on my own skills and development', 22),
(189, 48, 'I tackle the most important tasks first', 23),
(190, 48, 'I handle the easiest tasks first', 19),
(191, 48, 'I work on tasks based on deadlines', 20),
(192, 48, 'I alternate between different types of tasks', 21);

-- Answers for Quiz 5
 INSERT INTO
    answer (
        id,
        question_id,
        answer_description,
        answer_value
    )
VALUES
    (193, 49, 'I address the issue head-on', 25),
    (194, 49, 'I try to find a compromise', 26),
    (
        195,
        49,
        'I stay calm and listen to everyone',
        27
    ),
    (
        196,
        49,
        'I assert my point of view with passion',
        28
    ),
    (
        197,
        50,
        'Gardening or spending time in nature',
        25
    ),
    (198, 50, 'Swimming or sailing', 26),
    (199, 50, 'Meditation or yoga', 27),
    (
        200,
        50,
        'Cooking or creating something with my hands',
        28
    ),
    (201, 51, 'Mild and temperate', 25),
    (202, 51, 'Rainy or misty', 26),
    (203, 51, 'Windy or stormy', 27),
    (204, 51, 'Hot and sunny', 28),
    (205, 52, 'Grounded', 25),
    (206, 52, 'Adaptable', 26),
    (207, 52, 'Free-spirited', 27),
    (208, 52, 'Intense', 28),
    (
        209,
        53,
        'I start with the basics and build from there',
        25
    ),
    (
        210,
        53,
        'I look for patterns and connections',
        26
    ),
    (211, 53, 'I consider different perspectives', 27),
    (
        212,
        53,
        'I break the problem into smaller parts',
        28
    ),
    (213, 54, 'A peaceful, stable environment', 25),
    (
        214,
        54,
        'A fluid, ever-changing environment',
        26
    ),
    (215, 54, 'An open, expansive environment', 27),
    (216, 54, 'A dynamic, energetic environment', 28),
    (217, 55, 'Being in nature', 25),
    (
        218,
        55,
        'Taking a bath or spending time near water',
        26
    ),
    (
        219,
        55,
        'Breathing exercises or being outdoors',
        27
    ),
    (220, 55, 'Physical activity or exercise', 28),
    (221, 56, 'Hiking or camping', 25),
    (222, 56, 'Scuba diving or snorkeling', 26),
    (223, 56, 'Skydiving or paragliding', 27),
    (224, 56, 'Rock climbing or bungee jumping', 28),
    (225, 57, 'Reading or writing', 25),
    (
        226,
        57,
        'Listening to music or watching a movie',
        26
    ),
    (227, 57, 'Going for a walk or run', 27),
    (228, 57, 'Playing a sport or working out', 28),
    (229, 58, 'Calmly assessing the situation', 25),
    (230, 58, 'Talking it out with someone', 26),
    (231, 58, 'Taking a step back and regrouping', 27),
    (232, 58, 'Focusing on a solution', 28), (
        233,
        59,
        'Being able to control the elements',
        25
    ),
    (234, 59, 'Being able to breathe underwater', 26),
    (235, 59, 'Being able to fly', 27),
    (236, 59, 'Being able to create fire', 28),
    (237, 60, 'An elephant', 25),
    (238, 60, 'A dolphin', 26),
    (239, 60, 'An eagle', 27),
    (240, 60, 'A tiger', 28);
    

  -- Answers for Quiz 6
   INSERT INTO
    answer (
        id,
        question_id,
        answer_description,
        answer_value
    )
VALUES
    (
        241,
        61,
        'Take charge and introduce yourself to everyone',
        29
    ),
    (
        242,
        61,
        'Find someone you know and stick with them',
        30
    ),
    (
        243,
        61,
        'Observe from a distance before joining a conversation',
        31
    ),
    (244, 61, 'Wait for others to approach you', 32),
    (245, 62, 'Grilled steak', 29),
    (246, 62, 'Fresh seafood', 30),
    (247, 62, 'A hearty salad', 31),
    (248, 62, 'A delicious fruit platter', 32),
    (249, 63, 'Playing sports or working out', 29),
    (250, 63, 'Going to the beach or swimming', 30),
    (251, 63, 'Hiking or bird watching', 31),
    (
        252,
        63,
        'Visiting the zoo or a nature reserve',
        32
    ),
    (253, 64, 'Courage', 29),
    (254, 64, 'Playfulness', 30),
    (255, 64, 'Independence', 31),
    (256, 64, 'Wisdom', 32),
    (
        257,
        65,
        'Taking the lead and delegating tasks',
        29
    ),
    (
        258,
        65,
        'Building connections and keeping the team motivated',
        30
    ),
    (
        259,
        65,
        'Working independently but contributing to the team goal',
        31
    ),
    (
        260,
        65,
        'Supporting others and offering advice',
        32
    ),
    (261, 66, 'Grasslands or savannah', 29),
    (262, 66, 'Ocean or coastal areas', 30),
    (263, 66, 'Mountains or forests', 31),
    (264, 66, 'Tropical rainforests or jungles', 32),
    (265, 67, 'Embrace it and take charge', 29),
    (
        266,
        67,
        'Share the responsibility with others',
        30
    ),
    (
        267,
        67,
        'Focus on your own tasks but offer help when needed',
        31
    ),
    (
        268,
        67,
        'Offer guidance but avoid taking on too much',
        32
    ),
    (269, 68, 'Going on a thrilling adventure', 29),
    (270, 68, 'A day at the beach with friends', 30),
    (271, 68, 'Exploring nature and wildlife', 31),
    (
        272,
        68,
        'A peaceful walk through the forest',
        32
    ),
    (273, 69, 'Embrace it and adapt quickly', 29),
    (
        274,
        69,
        'Find new ways to connect with others',
        30
    ),
    (
        275,
        69,
        'Assess the situation and make a plan',
        31
    ),
    (
        276,
        69,
        'Take time to adjust and seek support',
        32
    ),
    (277, 70, 'Super strength', 29),
    (278, 70, 'Telepathy', 30),
    (279, 70, 'Flight', 31),
    (280, 70, 'Invisibility', 32),
    (281, 71, 'An adrenaline-pumping activity', 29),
    (282, 71, 'A sunset picnic on the beach', 30),
    (283, 71, 'A hike to a scenic viewpoint', 31),
    (284, 71, 'A visit to an animal sanctuary', 32),
    (285, 72, 'Dawn', 29),
    (286, 72, 'Mid-morning', 30),
    (287, 72, 'Afternoon', 31),
    (288, 72, 'Dusk', 32);
   
   
    
/* Add USC quizzes */
  INSERT INTO quiz (id, name, description, image_location, category_id) VALUES
(7, 'What Type of USC Sports Fan Are You?', 'Discover your enthusiasm and dedication level as a USC sports fan', 'https://usctrojans.com/images/2022/8/2/usc_trojans_athletics_all_21_sports_2022_2023_2_.jpg', 3),
(8, 'Which Famous USC Alumni Are You Most Like?', 'Find out which successful and well-known USC graduate you share traits, accomplishments, and values with', 'https://www.duarte.com/wp-content/uploads/will-ferrell-usc-commencement.jpeg', 3);

-- Insert Results for Quiz 7: What Type of USC Sports Fan Are You?
INSERT INTO result (id, quiz_id, description, value, image_location) VALUES
(33, 7, 'Die-Hard Fan', 1, 'https://cdn.bleacherreport.net/images_root/slides/photos/000/516/579/USC_original.jpg?1290369405'),
(34, 7, 'Enthusiastic Supporter', 2, 'https://cdn.vox-cdn.com/thumbor/YC-NY1zeZ4o-248Aw33AxUn-GAI=/0x0:4746x3449/1200x800/filters:focal(1729x378:2487x1136)/cdn.vox-cdn.com/uploads/chorus_image/image/56783591/usa_today_9784721.0.jpg'),
(35, 7, 'Casual Fan', 3, 'https://images2.minutemediacdn.com/image/upload/c_fill,w_720,ar_16:9,f_auto,q_auto,g_auto/shape/cover/sport/https-3A-2F-2Freignoftroy-com-2Fwp-content-2Fuploads-2Fgetty-images-2F2020-2F03-2F153842781-850x560-06cd7a9109a56160911c029f4de6bb81.jpg'),
(36, 7, 'Fair-Weather Fan', 4, 'https://usg.usc.edu/trojanpride/wp-content/uploads/sites/9/2020/09/pom-poms-1.jpg'),
(37, 7, 'Spectator', 5, 'https://pbs.twimg.com/media/FCLaupHVgAImH9L.jpg:large'),
(38, 7, 'Indifferent', 6, 'https://pbs.twimg.com/media/FGdHP8aXwAATFky.jpg');

-- Insert Results for Quiz 8: Which Famous USC Alumni Are You Most Like?
INSERT INTO result (id, quiz_id, description, value, image_location) VALUES
(39, 8, 'George Lucas', 1, 'https://upload.wikimedia.org/wikipedia/commons/a/a0/George_Lucas_cropped_2009.jpg'),
(40, 8, 'Neil Armstrong', 2, 'https://cdn.britannica.com/72/163272-050-1C5BC2B7/Neil-Armstrong-American.jpg'),
(41, 8, 'Will Ferrell', 3, 'https://s.yimg.com/ny/api/res/1.2/_UFOplq7GPvPciMdtyHKUA--/YXBwaWQ9aGlnaGxhbmRlcjt3PTk2MDtoPTY0MA--/https://media.zenfs.com/en/people_218/330cea53d03fac2b035a3d245c6283f2'),
(42, 8, 'Saweetie', 4, 'https://nationaltoday.com/wp-content/uploads/2022/06/4-Saweetie.jpg'),
(43, 8, 'Miranda Cosgrove', 5, 'https://www.usmagazine.com/wp-content/uploads/2022/03/Miranda-Cosgrove-25-Things-You-Dont-Know-About-Me-001.jpg?crop=0px%2C0px%2C1200px%2C679px&resize=1600%2C900&quality=86&strip=all'),
(44, 8, 'Andrew Viterbi', 6, 'https://ucsdnews.ucsd.edu/news_uploads/viterbi-hero.jpg');

-- Insert Questions for Quiz 7: What Type of USC Sports Fan Are You?
INSERT INTO question (id, quiz_id, question_no, description, image_location) VALUES
(73, 7, 1, 'How often do you attend USC sports events?', ''),
(74, 7, 2, 'How do you show your support for USC teams?', ''),
(75, 7, 3, 'How well do you know USC sports history?', ''),
(76, 7, 4, 'What is your reaction when USC loses a game?', ''),
(77, 7, 5, 'How do you stay updated on USC sports news?', ''),
(78, 7, 6, 'What is your preferred way to watch USC games?', ''),
(79, 7, 7, 'How do you feel about rival teams?', ''),
(80, 7, 8, 'What type of sports apparel do you own?', ''),
(81, 7, 9, 'How do you celebrate a USC victory?', ''),
(82, 7, 10, 'Which USC sports team do you follow most closely?', ''),
(83, 7, 11, 'How do you handle sports-related stress?', ''),
(84, 7, 12, 'Do you participate in any sports-related activities on campus?', '');

-- Insert Questions for Quiz 8: Which Famous USC Alumni Are You Most Like?
INSERT INTO question (id, quiz_id, question_no, description, image_location) VALUES
(85, 8, 1, 'What is your preferred field of study?', ''),
(86, 8, 2, 'How do you spend your free time?', ''),
(87, 8, 3, 'What type of leadership style do you have?', ''),
(88, 8, 4, 'What is your approach to problem-solving?', ''),
(89, 8, 5, 'How do you handle stress?', ''),
(90, 8, 6, 'What is your preferred way of communication?', ''),
(91, 8, 7, 'Which of these values resonates with you the most?', ''),
(92, 8, 8, 'What type of work environment do you prefer?', ''),
(93, 8, 9, 'How do you handle criticism?', ''),
(94, 8, 10, 'What is your favorite type of social event?', ''),
(95, 8, 11, 'How do you approach networking?', ''),
(96, 8, 12, 'How do you handle failure?', '');



-- Insert answer options for Quiz 7: What Type of USC Sports Fan Are You?
INSERT INTO answer (id, question_id, answer_description, answer_value) VALUES
(289, 73, 'Every single game', 33),
(290, 73, 'Most of the games', 34),
(291, 73, 'A few games a year', 35),
(292, 73, 'Rarely or never', 36),
(293, 74, 'Wear team colors and face paint', 33),
(294, 74, 'Wear a team jersey', 34),
(295, 74, 'Talk about the team with friends', 35),
(296, 74, 'Watch games on TV', 36),
(297, 75, 'Expert level', 33),
(298, 75, 'Above average', 34),
(299, 75, 'Basic knowledge', 35),
(300, 75, 'Little to none', 36),
(301, 76, 'Devastated', 33),
(302, 76, 'Disappointed', 34),
(303, 76, 'Neutral', 35),
(304, 76, 'Not bothered', 36),
(305, 77, 'Follow multiple sports news sources', 33),
(306, 77, 'Check team social media', 34),
(307, 77, 'Discuss with friends', 35),
(308, 77, 'Occasionally look up news', 36),
(309, 78, 'In-person at the stadium', 33),
(310, 78, 'Watch on TV', 34),
(311, 78, 'Stream online', 35),
(312, 78, 'Check scores later', 36),
(313, 79, 'Intense rivalry', 33),
(314, 79, 'Friendly competition', 34),
(315, 79, 'Neutral', 35),
(316, 79, 'Not concerned', 36),
(317, 80, 'Entire wardrobe of team gear', 33),
(318, 80, 'A few jerseys and hats', 34),
(319, 80, 'A shirt or two', 35),
(320, 80, 'None', 36),
(321, 81, 'Throw a big party', 33),
(322, 81, 'Celebrate with friends', 34),
(323, 81, 'Share the news on social media', 35),
(324, 81, 'Smile and move on', 36),
(325, 82, 'Football', 33),
(326, 82, 'Basketball', 34),
(327, 82, 'Baseball', 35),
(328, 82, 'Other sports', 36),
(329, 83, 'Get very emotional', 33),
(330, 83, 'Discuss with friends', 34),
(331, 83, 'Take a break and relax', 35),
(332, 83, 'Not affected', 36),
(333, 84, 'Join a sports club or intramural team', 33),
(334, 84, 'Attend sports-related events', 34),
(335, 84, 'Watch games with friends', 35),
(336, 84, 'Not involved in sports activities', 36);

-- Insert answer options for Quiz 8: Which Famous USC Alumni Are You Most Like?
INSERT INTO answer (id, question_id, answer_description, answer_value) VALUES
(337, 85, 'Film and Television', 39),
(338, 85, 'Business and Entrepreneurship', 40),
(339, 85, 'Science and Engineering', 41),
(340, 85, 'Arts and Music', 42),
(341, 86, 'Making art or music', 39),
(342, 86, 'Networking and socializing', 40),
(343, 86, 'Working on a project', 41),
(344, 86, 'Relaxing at home', 42),
(345, 87, 'Collaborative and supportive', 39),
(346, 87, 'Visionary and driven', 40),
(347, 87, 'Analytical and detail-oriented', 41),
(348, 87, 'Adaptable and flexible', 42),
(349, 88, 'Creative and intuitive', 39),
(350, 88, 'Strategic and goal-oriented', 40),
(351, 88, 'Systematic and methodical', 41),
(352, 88, 'Trial and error', 42),
(353, 89, 'Meditation or mindfulness', 39),
(354, 89, 'Planning and organization', 40),
(355, 89, 'Exercise or sports', 41),
(356, 89, 'Spending time with friends', 42),
(357, 90, 'Face-to-face conversations', 39),
(358, 90, 'Phone calls or video chats', 40),
(359, 90, 'Texts or instant messaging', 41),
(360, 90, 'Emails or letters', 42),
(361, 91, 'Creativity', 39),
(362, 91, 'Ambition', 40),
(363, 91, 'Innovation', 41),
(364, 91, 'Compassion', 42),
(365, 92, 'Collaborative and open', 39),
(366, 92, 'Structured and hierarchical', 40),
(367, 92, 'Research-oriented', 41),
(368, 92, 'Flexible and remote', 42),
(369, 93, 'Reflect and learn from it', 39),
(370, 93, 'Welcome it as a challenge', 40),
(371, 93, 'Analyze and address concerns', 41),
(372, 93, 'Ignore it', 42),
(373, 94, 'Film premiere or concert', 39),
(374, 94, 'Networking event or conference', 40),
(375, 94, 'Academic lecture or workshop', 41),
(376, 94, 'Intimate gathering with friends', 42),
(377, 95, 'Proactively seek connections', 39),
(378, 95, 'Focus on quality relationships', 40),
(379, 95, 'Attend events and join groups', 41),
(380, 95, 'Only network when necessary', 42),
(381, 96, 'Learn and grow from it', 39),
(382, 96, 'Stay persistent and focused', 40),
(383, 96, 'Analyze and adjust approach', 41),
(384, 96, 'Avoid dwelling on it', 42);