-- MySQL dump 10.13  Distrib 8.0.19, for osx10.15 (x86_64)
--
-- Host: localhost    Database: codesandwich
-- ------------------------------------------------------
-- Server version	8.0.19

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `allergens`
--

DROP TABLE IF EXISTS `allergens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `allergens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `allergens`
--

LOCK TABLES `allergens` WRITE;
/*!40000 ALTER TABLE `allergens` DISABLE KEYS */;
INSERT INTO `allergens` VALUES (1,'밀'),(2,'계란'),(3,'우유'),(4,'대두'),(5,'토마토'),(6,'쇠고기'),(7,'돼지고기'),(8,'닭고기'),(9,'새우'),(10,'조개류'),(11,'땅콩'),(12,'호두'),(13,'아황산');
/*!40000 ALTER TABLE `allergens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_ingredients`
--

DROP TABLE IF EXISTS `cart_ingredients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_ingredients` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cart_id` int DEFAULT NULL,
  `ingredient_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cart_ingredients_cart_id_d51d38c6_fk_carts_id` (`cart_id`),
  KEY `cart_ingredients_ingredient_id_5ca9d94f_fk_ingredients_id` (`ingredient_id`),
  CONSTRAINT `cart_ingredients_cart_id_d51d38c6_fk_carts_id` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`),
  CONSTRAINT `cart_ingredients_ingredient_id_5ca9d94f_fk_ingredients_id` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredients` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_ingredients`
--

LOCK TABLES `cart_ingredients` WRITE;
/*!40000 ALTER TABLE `cart_ingredients` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_ingredients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carts`
--

DROP TABLE IF EXISTS `carts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `price` int DEFAULT NULL,
  `amount` int DEFAULT NULL,
  `order_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `carts_order_id_89a6b74a_fk_orders_id` (`order_id`),
  KEY `carts_product_id_02913eac_fk_products_id` (`product_id`),
  CONSTRAINT `carts_order_id_89a6b74a_fk_orders_id` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `carts_product_id_02913eac_fk_products_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carts`
--

LOCK TABLES `carts` WRITE;
/*!40000 ALTER TABLE `carts` DISABLE KEYS */;
/*!40000 ALTER TABLE `carts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'샌드위치'),(2,'랩'),(3,'찹샐러드'),(4,'스마일 썹');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `phone` varchar(45) COLLATE utf8mb4_general_ci NOT NULL,
  `username` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `destination_locations`
--

DROP TABLE IF EXISTS `destination_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `destination_locations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `address` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `destination_locations`
--

LOCK TABLES `destination_locations` WRITE;
/*!40000 ALTER TABLE `destination_locations` DISABLE KEYS */;
/*!40000 ALTER TABLE `destination_locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (3,'account','customer'),(1,'contenttypes','contenttype'),(5,'order','cart'),(9,'order','cartingredient'),(6,'order','destinationlocation'),(8,'order','order'),(7,'order','orderstatus'),(10,'product','allergen'),(11,'product','category'),(12,'product','ingredient'),(20,'product','ingredientallergen'),(13,'product','ingredientcategory'),(19,'product','ingredientplaceoforigin'),(14,'product','nutrition'),(15,'product','placeoforigin'),(16,'product','product'),(18,'product','productingredient'),(17,'product','subcategory'),(2,'sessions','session'),(4,'store','store');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'account','0001_initial','2020-05-30 07:46:37.133733'),(2,'contenttypes','0001_initial','2020-05-30 07:46:37.149516'),(3,'contenttypes','0002_remove_content_type_name','2020-05-30 07:46:37.171784'),(4,'store','0001_initial','2020-05-30 07:46:37.180651'),(5,'product','0001_initial','2020-05-30 07:46:37.330802'),(6,'order','0001_initial','2020-05-30 07:46:37.544655'),(7,'sessions','0001_initial','2020-05-30 07:46:37.645363');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `session_data` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingredient_categories`
--

DROP TABLE IF EXISTS `ingredient_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ingredient_categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingredient_categories`
--

LOCK TABLES `ingredient_categories` WRITE;
/*!40000 ALTER TABLE `ingredient_categories` DISABLE KEYS */;
INSERT INTO `ingredient_categories` VALUES (1,'빵'),(2,'미트,가금류,계란'),(3,'야채'),(4,'치즈'),(5,'드레싱 & 컨디먼트'),(6,'수프'),(7,'쿠키'),(8,'감자 & 나초');
/*!40000 ALTER TABLE `ingredient_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingredients`
--

DROP TABLE IF EXISTS `ingredients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ingredients` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `image_url` varchar(2000) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `ingredient_category_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ingredients_ingredient_category__e9563919_fk_ingredien` (`ingredient_category_id`),
  CONSTRAINT `ingredients_ingredient_category__e9563919_fk_ingredien` FOREIGN KEY (`ingredient_category_id`) REFERENCES `ingredient_categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=273 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingredients`
--

LOCK TABLES `ingredients` WRITE;
/*!40000 ALTER TABLE `ingredients` DISABLE KEYS */;
INSERT INTO `ingredients` VALUES (1,'이탈리안 화이트 (top)','https://media.subway.com/digital/Account_Updates/Assets/App-Base/Web_Images/Subway/en-us/Options/o_BreadItalian_customizer_large.png',0.00,1),(2,'이탈리안 화이트 (bottom)','https://media.subway.com/digital/Account_Updates/Assets/App-Base/Web_Images/Subway/en-us/Options/o_BreadItalian_customizer_large_bottom.png',0.00,1),(3,'위트 (top)','https://media.subway.com/digital/Account_Updates/Assets/App-Base/Web_Images/Subway/en-us/Options/o_BreadWheat_customizer_large.png',0.00,1),(4,'위트 (bottom)','https://media.subway.com/digital/Account_Updates/Assets/App-Base/Web_Images/Subway/en-us/Options/o_BreadWheat_customizer_large_bottom.png',0.00,1),(5,'플랫 브레드 (bottom)','https://media.subway.com/digital/Account_Updates/Assets/App-Base/Web_Images/Subway/en-us/Options/o_BreadFlat_customizer_large_bottom.png',0.00,1),(6,'하티 이탈리안 (top)','https://media.subway.com/digital/Account_Updates/Assets/App-Base/Web_Images/Subway/en-us/Options/o_BreadItalianHerb_customizer_large.png',0.00,1),(7,'하티 이탈리안 (bottom)','https://media.subway.com/digital/Account_Updates/Assets/App-Base/Web_Images/Subway/en-us/Options/o_BreadItalianHerb_customizer_large_bottom.png',0.00,1),(8,'허니 오트 (top)','https://media.subway.com/digital/Account_Updates/Assets/App-Base/Web_Images/Subway/en-us/Options/o_BreadHOWheat_customizer_large.png',0.00,1),(9,'허니 오트 (bottom)','https://media.subway.com/digital/Account_Updates/Assets/App-Base/Web_Images/Subway/en-us/Options/o_BreadHOWheat_customizer_large_bottom.png',0.00,1),(10,'통밀 또띠아 (bottom)','https://media.subway.com/digital/Account_Updates/Assets/App-Base/Web_Images/Subway/en-us/Options/o_BreadMultiGrainFlat_customizer_large_bottom.png',0.00,1),(11,'미트볼','https://media.subway.com/digital/Account_Updates/Assets/App-Base/Web_Images/Subway/en-us/Options/o_Meatballs_customizer_large.png',0.00,2),(12,'스테이크','https://media.subway.com/digital/Account_Updates/Assets/App-Base/Web_Images/Subway/en-us/Options/o_ShavedSteak_customizer_large.png',0.00,2),(13,'로스트비프','https://media.subway.com/digital/Account_Updates/Assets/App-Base/Web_Images/Subway/en-us/Options/o_RoastBeef_customizer_large.png',0.00,2),(14,'치킨스트립','https://media.subway.com/digital/Account_Updates/Assets/App-Base/Web_Images/Subway/en-us/Options/o_ChickenStrips_customizer_large.png',0.00,2),(15,'로티세리 바비큐 치킨','https://media.subway.com/digital/Account_Updates/Assets/App-Base/Web_Images/Subway/en-us/Options/o_RotisserieStyleChicken_customizer_large.png',0.00,2),(16,'베이컨','https://media.subway.com/digital/Account_Updates/Assets/App-Base/Web_Images/Subway/en-us/Options/o_Bacon_customizer_large.png',1800.00,2),(17,'햄(블랙포레스트)','https://media.subway.com/digital/Account_Updates/Assets/App-Base/Web_Images/Subway/en-us/Options/o_BlackForestHam_customizer_large.png',0.00,2),(18,'살라미','https://media.subway.com/digital/Account_Updates/Assets/App-Base/Web_Images/Subway/en-us/Options/o_TurkeyBasedHamSalamiBologna_customizer_large.png',0.00,2),(19,'페퍼로니','https://media.subway.com/digital/Account_Updates/Assets/App-Base/Web_Images/Subway/en-us/Options/o_Pepperoni_customizer_large.png',1800.00,2),(20,'터키','https://media.subway.com/digital/Account_Updates/Assets/App-Base/Web_Images/Subway/en-us/Options/o_TurkeyBreast_customizer_large.png',0.00,2),(21,'참치','https://media.subway.com/digital/Account_Updates/Assets/App-Base/Web_Images/Subway/en-us/Options/o_Tuna_customizer_large.png',0.00,2),(22,'양상추','https://media.subway.com/digital/Account_Updates/Assets/App-Base/Web_Images/Subway/en-us/OptionsIds/10132_customizer_large.png',0.00,3),(23,'토마토','https://media.subway.com/digital/Account_Updates/Assets/App-Base/Web_Images/Subway/en-us/OptionsIds/10133_customizer_large.png',0.00,3),(24,'오이','https://media.subway.com/digital/Account_Updates/Assets/App-Base/Web_Images/Subway/en-us/OptionsIds/10141_customizer_large.png',0.00,3),(25,'피망','https://media.subway.com/digital/Account_Updates/Assets/App-Base/Web_Images/Subway/en-us/OptionsIds/10134_customizer_large.png',0.00,3),(26,'양파','https://media.subway.com/digital/Account_Updates/Assets/App-Base/Web_Images/Subway/en-us/OptionsIds/10135_customizer_large.png',0.00,3),(27,'피클','https://media.subway.com/digital/Account_Updates/Assets/App-Base/Web_Images/Subway/en-us/OptionsIds/10136_customizer_large.png',0.00,3),(28,'올리브','https://media.subway.com/digital/Account_Updates/Assets/App-Base/Web_Images/Subway/en-us/OptionsIds/10137_customizer_large.png',0.00,3),(29,'할라피뇨','https://media.subway.com/digital/Account_Updates/Assets/App-Base/Web_Images/Subway/en-us/OptionsIds/10139_customizer_large.png',0.00,3),(30,'아보카도','https://media.subway.com/digital/Account_Updates/Assets/App-Base/Web_Images/Subway/en-us/OptionsIds/10126_customizer_large.png',2600.00,3),(31,'아메리칸 치즈','https://media.subway.com/digital/Account_Updates/Assets/App-Base/Web_Images/Subway/en-us/Options/o_CheeseAmerWhite_customizer_large.png',1800.00,4),(32,'슈레드 몬터레이 체다 치즈','https://media.subway.com/digital/Account_Updates/Assets/App-Base/Web_Images/Subway/en-us/Options/o_CheeseMonterery_customizer_large.png',1800.00,4),(33,'모차렐라 치즈','https://media.subway.com/digital/Account_Updates/Assets/App-Base/Web_Images/Subway/en-us/Options/o_CheeseMozza_customizer_large.png',1800.00,4),(34,'마요네즈','https://media.subway.com/digital/Account_Updates/Assets/App-Base/Web_Images/Subway/en-us/OptionsIds/10152_customizer_large.png',0.00,5),(35,'렌치 드레싱','https://media.subway.com/digital/Account_Updates/Assets/App-Base/Web_Images/Subway/en-us/OptionsIds/10158_customizer_large.png',0.00,5),(36,'마리나라','https://media.subway.com/digital/Account_Updates/Assets/App-Base/Web_Images/Subway/en-us/OptionsIds/1020426_customizer_large.png',0.00,5),(37,'허니 머스타드','https://media.subway.com/digital/Account_Updates/Assets/App-Base/Web_Images/Subway/en-us/OptionsIds/10155_customizer_large.png',0.00,5),(38,'바비큐 소스','https://media.subway.com/digital/Account_Updates/Assets/App-Base/Web_Images/Subway/en-us/OptionsIds/10168_customizer_large.png',0.00,5),(39,'핫 칠리','https://media.subway.com/digital/Account_Updates/Assets/App-Base/Web_Images/Subway/en-us/OptionsIds/10161_customizer_large.png',0.00,5),(40,'치폴레 사우스 웨스트','https://media.subway.com/digital/Account_Updates/Assets/App-Base/Web_Images/Subway/en-us/OptionsIds/10156_customizer_large.png',0.00,5),(41,'레드와인 식초','https://media.subway.com/digital/Account_Updates/Assets/App-Base/Web_Images/Subway/en-us/OptionsIds/10160_customizer_large.png',0.00,5),(42,'머스타드','https://media.subway.com/digital/Account_Updates/Assets/App-Base/Web_Images/Subway/en-us/OptionsIds/10154_customizer_large.png',0.00,5),(43,'올리브 오일','https://media.subway.com/digital/Account_Updates/Assets/App-Base/Web_Images/Subway/en-us/OptionsIds/10159_customizer_large.png',0.00,5),(259,'브로콜리 체다 수프','',0.00,6),(260,'베이크 포테이토 수프','',0.00,6),(261,'초코칩 쿠키','',0.00,7),(262,'더블 초코칩 쿠키','',0.00,7),(263,'오트밀 레이즌 쿠키','',0.00,7),(264,'라즈베리 치즈케이크 쿠키','',0.00,7),(265,'화이트 초코 마카다미아 쿠키','',0.00,7),(266,'민트 초코 쿠키','',0.00,7),(267,'웨지 포테이토','',0.00,8),(268,'해쉬브라운','',0.00,8),(269,'Cheesy 웨지 포테이토','',0.00,8),(270,'나초 with sauce','',0.00,8),(271,'더블치즈 나초 with sauce','',0.00,8),(272,'살사 더블치즈 나초','',0.00,8);
/*!40000 ALTER TABLE `ingredients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingredients_allergens`
--

DROP TABLE IF EXISTS `ingredients_allergens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ingredients_allergens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `allergen_id` int NOT NULL,
  `ingredient_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ingredients_allergens_allergen_id_ecf6ecea_fk_allergens_id` (`allergen_id`),
  KEY `ingredients_allergens_ingredient_id_ef7c40b6_fk_ingredients_id` (`ingredient_id`),
  CONSTRAINT `ingredients_allergens_allergen_id_ecf6ecea_fk_allergens_id` FOREIGN KEY (`allergen_id`) REFERENCES `allergens` (`id`),
  CONSTRAINT `ingredients_allergens_ingredient_id_ef7c40b6_fk_ingredients_id` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredients` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingredients_allergens`
--

LOCK TABLES `ingredients_allergens` WRITE;
/*!40000 ALTER TABLE `ingredients_allergens` DISABLE KEYS */;
INSERT INTO `ingredients_allergens` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,1,5),(6,1,6),(7,1,7),(8,1,8),(9,1,9),(10,1,10),(11,3,5),(12,4,11),(13,6,11),(14,6,12),(15,6,13),(16,8,14),(17,8,15),(18,4,15),(19,7,16),(20,7,17),(21,7,18),(22,7,19),(23,5,23),(24,13,29),(25,3,31),(26,4,31),(27,3,32),(28,3,33),(29,2,34),(30,4,34),(31,2,35),(32,3,35),(33,4,35),(34,5,36),(35,2,37),(36,3,37),(37,4,37),(38,1,38),(39,4,38),(40,5,38),(41,6,38),(42,1,39),(43,4,39),(44,5,39),(45,2,40),(46,4,40),(47,5,40),(48,4,41),(49,13,41);
/*!40000 ALTER TABLE `ingredients_allergens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingredients_placeoforigins`
--

DROP TABLE IF EXISTS `ingredients_placeoforigins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ingredients_placeoforigins` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ingredient_id` int NOT NULL,
  `place_of_origin_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ingredients_placeofo_ingredient_id_08432d47_fk_ingredien` (`ingredient_id`),
  KEY `ingredients_placeofo_place_of_origin_id_3aee65c0_fk_place_of_` (`place_of_origin_id`),
  CONSTRAINT `ingredients_placeofo_ingredient_id_08432d47_fk_ingredien` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredients` (`id`),
  CONSTRAINT `ingredients_placeofo_place_of_origin_id_3aee65c0_fk_place_of_` FOREIGN KEY (`place_of_origin_id`) REFERENCES `place_of_origins` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingredients_placeoforigins`
--

LOCK TABLES `ingredients_placeoforigins` WRITE;
/*!40000 ALTER TABLE `ingredients_placeoforigins` DISABLE KEYS */;
INSERT INTO `ingredients_placeoforigins` VALUES (1,21,5),(2,16,2),(3,18,2),(4,19,2),(5,14,2),(6,15,2),(7,11,1),(8,13,1),(9,12,2),(10,17,3),(11,20,4);
/*!40000 ALTER TABLE `ingredients_placeoforigins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nutritions`
--

DROP TABLE IF EXISTS `nutritions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nutritions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `size_g` int DEFAULT NULL,
  `calories_kcal` int DEFAULT NULL,
  `sugar_g` int DEFAULT NULL,
  `protein_g` int DEFAULT NULL,
  `saturated_fat_g` int DEFAULT NULL,
  `sodium_g` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nutritions`
--

LOCK TABLES `nutritions` WRITE;
/*!40000 ALTER TABLE `nutritions` DISABLE KEYS */;
INSERT INTO `nutritions` VALUES (1,187,253,12,5,1,355),(2,247,350,29,7,2,660),(3,276,420,23,24,2,980),(4,247,480,17,7,5,450),(5,226,410,20,8,6,1260),(6,165,380,20,7,5,1130),(7,301,480,21,12,7,1000),(8,219,290,18,8,1,800),(9,237,480,20,7,5,580),(10,233,320,23,8,2,610),(11,240,310,23,8,2,840),(12,219,280,18,7,1,760),(13,162,230,8,7,1,280),(14,245,380,26,9,5,1030),(15,270,420,24,8,4,1190),(16,235,365,23,10,4,1200),(17,222,480,20,8,9,1490),(18,269,370,25,16,1,770),(19,203,400,24,6,5,1150),(20,174,370,19,5,5,880),(21,190,450,25,6,7,1310),(22,217,440,28,6,6,1210),(23,248,451,22,3,12,933),(24,253,459,16,4,9,945),(25,160,376,20,5,8,1010),(26,232,478,14,7,10,1243),(27,309,108,4,0,0,295),(28,372,170,23,6,1,460),(29,397,265,15,18,4,910),(30,351,230,14,8,6,1060),(31,317,220,15,8,5,920),(32,426,310,15,12,7,790),(33,344,110,12,8,1,600),(34,362,310,15,6,4,380),(35,372,310,11,7,1,250),(36,358,150,17,7,1,410),(37,366,140,18,7,1,640),(38,344,110,12,7,1,560),(39,287,60,3,6,1,80),(40,370,210,20,8,4,830),(41,380,238,17,9,4,860),(42,359,195,18,9,5,1000),(43,347,310,14,8,9,1290),(44,415,230,19,23,1,650),(45,500,320,24,15,12,250),(46,35,168,0,2,3,109),(47,105,233,1,7,8,504),(48,141,251,4,7,8,592),(49,45,215,20,2,6,130),(50,160,376,5,20,8,1010),(51,232,478,7,14,10,1243),(52,100,143,1,2,2,396),(53,114,187,1,5,4,451),(54,124,238,1,9,6,676),(55,255,170,4,5,5,630),(56,255,210,4,5,7,800),(57,45,210,20,2,5,130),(58,45,200,18,2,5,130),(59,45,200,16,3,4,130),(60,45,200,16,2,5,120),(61,45,220,17,2,5,130),(62,0,0,0,0,0,0),(63,0,0,0,0,0,0),(64,0,0,0,0,0,0),(65,68,139,0,1,2,403);
/*!40000 ALTER TABLE `nutritions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_status`
--

DROP TABLE IF EXISTS `order_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_status`
--

LOCK TABLES `order_status` WRITE;
/*!40000 ALTER TABLE `order_status` DISABLE KEYS */;
INSERT INTO `order_status` VALUES (1,'submitted'),(2,'not_submitted');
/*!40000 ALTER TABLE `order_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `creditcard_number` varchar(16) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `creditcard_cvc` varchar(3) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `creditcard_expiraion_date` varchar(4) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `creditcard_fullname` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `order_date` datetime(6) DEFAULT NULL,
  `total_price` int DEFAULT NULL,
  `customer_id` int DEFAULT NULL,
  `destination_location_id` int DEFAULT NULL,
  `order_status_id_id` int DEFAULT NULL,
  `store_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `orders_customer_id_b7016332_fk_customers_id` (`customer_id`),
  KEY `orders_destination_location_a85bcdd1_fk_destinati` (`destination_location_id`),
  KEY `orders_order_status_id_id_18dc621d_fk_order_status_id` (`order_status_id_id`),
  KEY `orders_store_id_04cf6eb1_fk_stores_id` (`store_id`),
  CONSTRAINT `orders_customer_id_b7016332_fk_customers_id` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  CONSTRAINT `orders_destination_location_a85bcdd1_fk_destinati` FOREIGN KEY (`destination_location_id`) REFERENCES `destination_locations` (`id`),
  CONSTRAINT `orders_order_status_id_id_18dc621d_fk_order_status_id` FOREIGN KEY (`order_status_id_id`) REFERENCES `order_status` (`id`),
  CONSTRAINT `orders_store_id_04cf6eb1_fk_stores_id` FOREIGN KEY (`store_id`) REFERENCES `stores` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `place_of_origins`
--

DROP TABLE IF EXISTS `place_of_origins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `place_of_origins` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `place_of_origins`
--

LOCK TABLES `place_of_origins` WRITE;
/*!40000 ALTER TABLE `place_of_origins` DISABLE KEYS */;
INSERT INTO `place_of_origins` VALUES (1,'호주산'),(2,'미국산'),(3,'외국산과 국내산 섞음'),(4,'외국산'),(5,'태국산');
/*!40000 ALTER TABLE `place_of_origins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_productingredient`
--

DROP TABLE IF EXISTS `product_productingredient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_productingredient` (
  `id` int NOT NULL AUTO_INCREMENT,
  `is_default` tinyint(1) DEFAULT NULL,
  `ingredient_id` int NOT NULL,
  `product_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_productingre_ingredient_id_bce8ab56_fk_ingredien` (`ingredient_id`),
  KEY `product_productingredient_product_id_6fd25e9d_fk_products_id` (`product_id`),
  CONSTRAINT `product_productingre_ingredient_id_bce8ab56_fk_ingredien` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredients` (`id`),
  CONSTRAINT `product_productingredient_product_id_6fd25e9d_fk_products_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_productingredient`
--

LOCK TABLES `product_productingredient` WRITE;
/*!40000 ALTER TABLE `product_productingredient` DISABLE KEYS */;
INSERT INTO `product_productingredient` VALUES (1,1,3,2),(2,1,4,2),(3,1,22,2),(4,1,23,2),(5,1,24,2),(6,1,25,2),(7,1,26,2),(8,1,15,2),(9,1,1,5),(10,1,2,5),(11,1,23,5),(12,1,24,5),(13,1,25,5),(14,1,26,5),(15,1,17,5),(16,1,18,5),(17,1,19,5),(18,1,1,6),(19,1,2,6),(20,1,22,6),(21,1,23,6),(22,1,16,6),(23,1,1,7),(24,1,2,7),(25,1,31,7),(26,1,11,7),(27,1,3,8),(28,1,4,8),(29,1,22,8),(30,1,23,8),(31,1,24,8),(32,1,25,8),(33,1,26,8),(34,1,17,8),(35,1,1,9),(36,1,2,9),(37,1,22,9),(38,1,23,9),(39,1,24,9),(40,1,25,9),(41,1,26,9),(42,1,21,9),(43,1,3,10),(44,1,4,10),(45,1,22,10),(46,1,23,10),(47,1,24,10),(48,1,25,10),(49,1,26,10),(50,1,15,10),(51,1,3,11),(52,1,4,11),(53,1,22,11),(54,1,23,11),(55,1,24,11),(56,1,25,11),(57,1,26,11),(58,1,17,11),(59,1,13,11),(60,1,20,11),(61,1,3,12),(62,1,4,12),(63,1,23,12),(64,1,24,12),(65,1,25,12),(66,1,26,12),(67,1,20,12),(68,1,3,13),(69,1,4,13),(70,1,22,13),(71,1,23,13),(72,1,24,13),(73,1,25,13),(74,1,26,13),(75,1,1,14),(76,1,2,14),(77,1,31,14),(78,1,25,14),(79,1,26,14),(80,1,12,14),(81,1,1,17),(82,1,2,17),(83,1,23,17),(84,1,24,17),(85,1,25,17),(86,1,26,17),(87,1,18,17),(88,1,19,17),(89,1,3,18),(90,1,4,18),(91,1,22,18),(92,1,23,18),(93,1,24,18),(94,1,25,18),(95,1,26,18),(96,1,14,18),(97,1,3,19),(98,1,4,19),(99,1,22,19),(100,1,23,19),(101,1,24,19),(102,1,25,19),(103,1,26,19),(104,1,17,19),(105,1,31,19);
/*!40000 ALTER TABLE `product_productingredient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `name_en` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `image_url` varchar(2000) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` longtext COLLATE utf8mb4_general_ci,
  `default_price` decimal(10,2) DEFAULT NULL,
  `toasted` tinyint(1) DEFAULT NULL,
  `customization_true` tinyint(1) DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `nutrition_id` int DEFAULT NULL,
  `subcategory_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nutrition_id` (`nutrition_id`),
  KEY `products_subcategory_id_6acd45e4_fk_sub_categories_id` (`subcategory_id`),
  KEY `products_category_id_a7a3a156_fk_categories_id` (`category_id`),
  CONSTRAINT `products_category_id_a7a3a156_fk_categories_id` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  CONSTRAINT `products_nutrition_id_a91941d8_fk_nutritions_id` FOREIGN KEY (`nutrition_id`) REFERENCES `nutritions` (`id`),
  CONSTRAINT `products_subcategory_id_6acd45e4_fk_sub_categories_id` FOREIGN KEY (`subcategory_id`) REFERENCES `sub_categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'쉬림프','Shrimp','http://subway.co.kr/images/menu/sandwich_pm10.jpg','탱글한 식감이 그대로 살아있는 통새우가\n5마리 들어가 한 입 베어 먹을 때 마다\n진짜 새우의 풍미가 가득',9000.00,NULL,0,1,NULL,3),(2,'로티세리 바비큐 치킨','Rotisserie Barbecue Chicken','http://subway.co.kr/images/menu/sandwich_fl01.jpg','촉촉한 바비큐 치킨의 풍미가득. 손으로 찢어 더욱 부드러운 치킨의 혁명',10500.00,NULL,1,1,NULL,2),(3,'풀드포크','Pulled Pork','http://subway.co.kr/images/menu/sandwich_pm08.jpg','7시간 저온 훈연한 미국 정통 스타일의 리얼 바비큐 풀드포크는\n오직 써브웨이에서',8000.00,NULL,0,1,NULL,3),(4,'에그마요','Egg Mayo','http://subway.co.kr/images/menu/sandwich_cl06.jpg','친환경 인증 받은 농장에서 생산된 달걀과 고소한 마요네즈가 만나 더 부드러운 스테디셀러',9000.00,NULL,0,1,NULL,1),(5,'이탈리안 비엠티','Italian B.M.T.','http://subway.co.kr/images/menu/sandwich_cl01.jpg','7시간 숙성된 페퍼로니, 살라미 그리고 햄이 만들어내는 최상의 조화!\n전세계가 사랑하는 No.1 베스트셀러! Biggest Meatiest Tastiest, It\'s B.M.T.!',9200.00,NULL,1,1,NULL,1),(6,'비엘티','B.L.T.','http://subway.co.kr/images/menu/sandwich_cl02.jpg','오리지널 아메리칸 베이컨의 풍미와 바삭함 그대로~',9200.00,NULL,1,1,NULL,1),(7,'미트볼','Meatball','http://subway.co.kr/images/menu/sandwich_cl03.jpg','이탈리안 스타일 비프 미트볼에 써브웨이만의 풍부한 토마토 향이\n살아있는 마리나라소스를 듬뿍',9200.00,NULL,1,1,NULL,1),(8,'햄','HAM','http://subway.co.kr/images/menu/sandwich_cl04.jpg','기본 중에 기본! 풍부한 햄이 만들어내는 입 안 가득 넘치는 맛의 향연',8600.00,NULL,1,1,NULL,1),(9,'참치','Tuna','http://subway.co.kr/images/menu/sandwich_cl05.jpg','남녀노소 누구나 좋아하는 담백한 참치와 고소한 마요네즈의 완벽한 조화',8700.00,NULL,1,1,NULL,1),(10,'로스트 치킨','Roasted Chicken','http://subway.co.kr/images/menu/sandwich_fl02.jpg','오븐에 구워 담백한 저칼로리 닭가슴살의 건강한 풍미',10500.00,NULL,1,1,NULL,2),(11,'써브웨이 클럽','Subway Club','http://subway.co.kr/images/menu/sandwich_fl04.jpg','명실공히 시그니처 써브! 터키, 비프, 포크 햄의 완벽한 앙상블',10100.00,NULL,1,1,NULL,2),(12,'터키','Turkey','http://subway.co.kr/images/menu/sandwich_fl05.jpg','280kcal로 슬림하게 즐기는 오리지날 터키 샌드위치',9200.00,NULL,1,1,NULL,2),(13,'베지','Veggie Delite','http://subway.co.kr/images/menu/sandwich_fl06.jpg','갓 구운 빵과 신선한 7가지 야채로 즐기는 깔끔한 한끼',7400.00,NULL,1,1,NULL,2),(14,'스테이크 & 치즈','Steak & Cheese','http://subway.co.kr/images/menu/sandwich_pm01.jpg','육즙이 쫙~풍부한 비프 스테이크의 풍미가 입안 한가득',10900.00,NULL,1,1,NULL,3),(15,'터키 베이컨 아보카도','Turkey Bacon Avocado','http://subway.co.kr/images/menu/sandwich_pm02.jpg','담백한 터키와 바삭한 베이컨 환상조합에 부드러운 아보카도는 신의 한수',10000.00,NULL,0,1,NULL,3),(16,'써브웨이 멜트','Subway Melt','http://subway.co.kr/images/menu/sandwich_pm04.jpg','자신있게 추천하는 터키, 햄, 베이컨의 완벽한 맛의 밸런스',9000.00,NULL,0,1,NULL,3),(17,'스파이시 이탈리안','Spicy Italian','http://subway.co.kr/images/menu/sandwich_pm06.jpg','살라미, 페퍼로니가 입안 한가득! 쏘 핫한 이탈리아의 맛',10100.00,NULL,1,1,NULL,3),(18,'치킨 데리야끼','Chicken Teriyaki','http://subway.co.kr/images/menu/sandwich_pm07.jpg','담백한 치킨 스트립에 달콤짭쪼름한 써브웨이 특제 데리야끼 소스와의\n환상적인 만남',10100.00,NULL,1,1,NULL,3),(19,'블랙 포레스트햄 & 에그, 치즈','Black Forest Ham & Egg, Cheese','http://subway.co.kr/images/menu/sandwich_bf01.jpg','푹신한 오믈렛과 햄의 가장 클래식한 조화\n※아침메뉴 제공시간 : 오전 11시까지',7800.00,NULL,1,1,NULL,4),(20,'웨스턴, 에그 & 치즈','Western, Egg & Cheese','http://subway.co.kr/images/menu/sandwich_bf02.jpg','토마토, 피망, 양파 세가지 야채가 더해져 더욱 신선한 하루 시작\n※아침메뉴 제공시간 : 오전 11시까지',7800.00,NULL,0,1,NULL,4),(21,'베이컨, 에그 & 치즈','Bacon, Egg & Cheese','http://subway.co.kr/images/menu/sandwich_bf03.jpg','오리지널 아메리칸 베이컨으로 더욱 풍성한 아침 식사\n※아침메뉴 제공시간 : 오전 11시까지',8000.00,NULL,0,1,NULL,4),(22,'스테이크, 에그 & 치즈','Steak, Egg & Cheese','http://subway.co.kr/images/menu/sandwich_bf04.jpg','육즙 가득 비프 스테이크로 든든한 아침 식사\n※아침메뉴 제공시간 : 오전 11시까지',8300.00,NULL,0,1,NULL,4),(23,'스테이크 & 치즈 아보카도 랩','Steak & Cheese Avocado Wrap','http://subway.co.kr/images/menu/wrap_sw01.jpg','육즙 가득 스테이크에 프레쉬함을 더해줄\n아보카도와 슈레드치즈 그리고\n모차렐라치즈까지!\n최상의 야채와 소스 조합으로 탄생한\n스테이크 & 치즈 아보카도 랩!\n\n써브웨이 랩은 최상의 맛을 위해 개발된 고정 레시피로 제공됩니다.\n양상추, 토마토, 양파, 피망이 제공되며 야채 추가는 불가합니다.',8500.00,NULL,NULL,2,NULL,1),(24,'쉬림프 에그마요 랩','Shrimp Egg Mayo Wrap','http://subway.co.kr/images/menu/wrap_sw02.jpg','부드럽고 고소한 에그마요 안에\n탱글한 통새우가 푹~!\n최상의 야채와 소스 조합으로 탄생한\n쉬림프 에그마요 랩!!\n\n써브웨이 랩은 최상의 맛을 위해 개발된 고정 레시피로 제공됩니다.\n양상추, 토마토가 제공되며 야채 추가는 불가합니다.',9000.00,NULL,NULL,2,NULL,1),(25,'치킨 베이컨 미니 랩','Chicken Bacon Mini Wrap','http://subway.co.kr/images/menu/wrap_mw01.jpg','담백한 치킨, 바삭한 베이컨 비츠가\n쫀득한 통밀 랩에 쏘옥!\n치킨 베이컨 미니 랩\n\n써브웨이 랩은 최상의 맛을 위해 개발된 고정 레시피로 제공됩니다.\n양상추가 제공되며 야채 추가는 불가합니다.',9000.00,NULL,NULL,2,NULL,2),(26,'베이컨 웨지 미니 랩','Bacon Wedge Mini Wrap','http://subway.co.kr/images/menu/wrap_mw02.jpg','써브웨이 인기 사이드!\n웨지 포테이토가 통밀랩과 만났다.\n베이컨 비츠로 풍미를 더한\n베이컨 웨지 미니 랩!\n\n써브웨이 랩은 최상의 맛을 위해 개발된 고정 레시피로 제공됩니다.\n양상추가 제공되며 야채 추가는 불가합니다.',9000.00,NULL,NULL,2,NULL,2),(27,'쉬림프','Shrimp','http://subway.co.kr/images/menu/salad_pm10.jpg','탱글한 식감이 그대로 살아있는\n통새우가 5마리가\n찹샐러드에 쏙 ! Fresh함이 그대로~',6000.00,NULL,NULL,3,NULL,3),(28,'로티세리 치킨','Rotisserie Chicken','http://subway.co.kr/images/menu/salad_fl01.jpg','촉촉한 바비큐 치킨의 풍미가득. 손으로 찢어 더욱 부드러운 치킨이 찹 샐러드에 쏙',6000.00,NULL,NULL,3,NULL,2),(29,'풀드포크','Pulled Pork','http://subway.co.kr/images/menu/salad_pm08.jpg','7시간 저온 훈연한 미국 정통바비큐 풀드포크가 가득 올라간 풍미 가득한 풀드포크 찹 샐러드',6000.00,NULL,NULL,3,NULL,3),(30,'이탈리안 비엠티','Italian B.M.T.','http://subway.co.kr/images/menu/salad_cl01.jpg','7시간 숙성된 페퍼로니, 살라미 그리고 햄이 만들어내는 최상의 조화!\n전세계가 사랑하는 No.1 베스트셀러! Biggest Meatiest Tastiest, It\'s B.M.T. 찹 샐러드',5700.00,NULL,NULL,3,NULL,1),(31,'비엘티','B.L.T.','http://subway.co.kr/images/menu/salad_cl02.jpg','오리지널 아메리칸 베이컨의 풍미와 바삭함이 찹 샐러드에 그대로',6000.00,NULL,NULL,3,NULL,1),(32,'미트볼','Meatball','http://subway.co.kr/images/menu/salad_cl03.jpg','이탈리안 스타일 비프 미트볼이 토핑된 찹 샐러드',5700.00,NULL,NULL,3,NULL,1),(33,'햄','HAM','http://subway.co.kr/images/menu/salad_cl04.jpg','기본 중에 기본! 풍부한 햄 토핑 가득 찹 샐러드',6000.00,NULL,NULL,3,NULL,1),(34,'참치','Tuna','http://subway.co.kr/images/menu/salad_cl05.jpg','남녀노소 누구나 좋아하는 담백한 참치와 고소한 마요네즈의 완벽한 조화',6000.00,NULL,NULL,3,NULL,1),(35,'에그마요','Egg Mayo','http://subway.co.kr/images/menu/salad_cl06.jpg','친환경 인증 받은 농장에서 생산된 달걀과\n고소한 마요네즈가 만나 더 부드러운 에그마요 찹 샐러드',6000.00,NULL,NULL,3,NULL,1),(36,'로스트 치킨','Roasted Chicken','http://subway.co.kr/images/menu/salad_fl02.jpg','오븐에 구워 담백한 저칼로리 닭가슴살의 건강한 풍미',6000.00,NULL,NULL,3,NULL,2),(37,'써브웨이 클럽','Subway Club','http://subway.co.kr/images/menu/salad_fl04.jpg','터키, 비프, 포크 햄의 완벽한 앙상블과 즐기는 찹 샐러드',6000.00,NULL,NULL,3,NULL,2),(38,'터키','Turkey','http://subway.co.kr/images/menu/salad_fl05.jpg','더 슬림하게 즐기자! 오리지날 터키 찹 샐러드',6000.00,NULL,NULL,3,NULL,2),(39,'베지','Veggie Delite','http://subway.co.kr/images/menu/salad_fl06.jpg','7가지 야채만으로도 깔끔한 조화! 기본에 충실한 베지 찹 샐러드',6000.00,NULL,NULL,3,NULL,2),(40,'스테이크 & 치즈','Steak & Cheese','http://subway.co.kr/images/menu/salad_pm01.jpg','육즙이 쫙~풍부한 비프 스테이크의 풍미 가득 스테이크 & 치즈 찹 샐러드!',6600.00,NULL,NULL,3,NULL,3),(41,'터키 베이컨 아보카도','Turkey Bacon Avocado','http://subway.co.kr/images/menu/salad_pm02.jpg','담백한 터키와 바삭한 베이컨 환상조합에 부드러운 아보카도는 신의 한수',7400.00,NULL,NULL,3,NULL,3),(42,'써브웨이 멜트','Subway Melt','http://subway.co.kr/images/menu/salad_pm04.jpg','자신있게 추천하는 터키, 햄, 베이컨의 발란스로 완성된 멜트 찹 샐러드',6000.00,NULL,NULL,3,NULL,3),(43,'스파이시 이탈리안','Spicy Italian','http://subway.co.kr/images/menu/salad_pm06.jpg','살라미, 페퍼로니가 입안 한가득! 진짜 이탈리아의 맛 가득한 찹 샐러드',6000.00,NULL,NULL,3,NULL,3),(44,'치킨 데리야끼','Chicken Teriyaki','http://subway.co.kr/images/menu/salad_pm07.jpg','담백한 치킨 스트립에 달콤짭쪼름한 써브웨이 특제 데리야끼 소스 토핑으로\n더 풍성한 찹 샐러드',6000.00,NULL,NULL,3,NULL,3),(45,'우유','Milk','http://subway.co.kr/images/menu/img_sides_18.jpg','* 매장 별 판매 여부는 상이할 수 있습니다.',2000.00,NULL,NULL,4,NULL,1),(46,'나초','Nacho','http://subway.co.kr/images/menu/img_sides_15.jpg','바삭바삭 나초와\n써브웨이 시그니처 소스\n홀스래디쉬 소스의 환상 궁합',3500.00,NULL,NULL,4,NULL,1),(47,'더블치즈 나초','Double Cheese Nacho','http://subway.co.kr/images/menu/img_sides_16.jpg','바삭한 나초에\n써브웨이 슈레드 & 모차렐라 치즈가 듬뿍!\n할라피뇨 토핑이 포인트!',5000.00,NULL,NULL,4,NULL,1),(48,'살사 더블치즈 나초','Salsa Double Cheese Nacho','http://subway.co.kr/images/menu/img_sides_17.jpg','더 풍성한 나초맛을 느끼고 싶다면?\n더블 치즈는 물론 살사 & 사워크림 꿀조합을 더한\n매콤 상큼 프리미엄 나초!',6000.00,NULL,NULL,4,NULL,1),(49,'민트 초코','Mint Choco','http://subway.co.kr/images/menu/img_sides_14.jpg','진한 초콜릿에 상쾌한 민트가 퐁당!\n특별한 달콤함에 푹 빠져보세요.\n\n※ 1월 20일부터 소진시까지 한정판매 됩니다.\n판매 시작 및 종료 일정은 매장별로 상이할 수 있습니다.',1000.00,NULL,NULL,4,NULL,1),(50,'치킨 베이컨 미니 랩','Chicken Bacon Mini Wrap','http://subway.co.kr/images/menu/wrap_mw01.jpg','담백한 치킨, 바삭한 베이컨 비츠가\n쫀득한 통밀 랩에 쏘옥!\n치킨 베이컨 미니 랩\n\n써브웨이 랩은 최상의 맛을 위해 개발된 고정 레시피로 제공됩니다.\n양상추가 제공되며 야채 추가는 불가합니다.',2000.00,NULL,NULL,4,NULL,1),(51,'베이컨 웨지 미니 랩','Bacon Wedge Mini Wrap','http://subway.co.kr/images/menu/wrap_mw02.jpg','써브웨이 인기 사이드!\n웨지 포테이토가 통밀랩과 만났다.\n베이컨 비츠로 풍미를 더한\n베이컨 웨지 미니 랩!\n\n써브웨이 랩은 최상의 맛을 위해 개발된 고정 레시피로 제공됩니다.\n양상추가 제공되며 야채 추가는 불가합니다.',2000.00,NULL,NULL,4,NULL,1),(52,'웨지 포테이토','Ovenbaked Wedge Potatoes','http://subway.co.kr/images/menu/img_sides_09.jpg','오븐에 구워 더 담백,\n겉은 바삭 속은 촉촉한 건강한 사이드\n※제공시간 : 오전 11시 ~',2000.00,NULL,NULL,4,NULL,1),(53,'Cheesy 웨지 포테이토','Cheesy Ovenbaked Wedge Potatoes','http://subway.co.kr/images/menu/img_sides_11.jpg','치즈 풍미 한가득, 오븐에 구워\n더 담백한 겉은 바삭\n속은 촉촉한 건강한 사이드\n※제공시간 : 오전 11시 ~',3000.00,NULL,NULL,4,NULL,1),(54,'Bacon Cheesy 웨지 포테이토','Bacon Cheesy Ovenbaked Wedge Potatoes','http://subway.co.kr/images/menu/img_sides_12.jpg','짭쪼름한 베이컨과 치즈의 궁합을 더한,\n오븐에 구워 더 담백한 겉은 바삭\n속은 촉촉한 건강한 사이드\n※제공시간 : 오전 11시 ~',3000.00,NULL,NULL,4,NULL,1),(55,'브로콜리 체다 수프','Broccoli Cheddar Soup','http://subway.co.kr/images/menu/img_sides_01.jpg','건강한 브로콜리와 짭쪼름한 체다치즈의\n환상적인 조합',2500.00,NULL,NULL,4,NULL,1),(56,'베이크 포테이토 수프','Baked Potato Soup','http://subway.co.kr/images/menu/img_sides_02.jpg','부드럽고 담백한 감자에 바삭한 베이컨의 찰떡궁합',2500.00,NULL,NULL,4,NULL,1),(57,'더블 초코칩','Double Chocolate Chip','http://subway.co.kr/images/menu/img_sides_03.jpg','부드러운 화이트초콜릿과 다크 초콜릿의\n절묘한 조화로 더욱 풍부한 달콤함',1000.00,NULL,NULL,4,NULL,1),(58,'초코칩','Chocolate Chip','http://subway.co.kr/images/menu/img_sides_04.jpg','알알이 가득한 초코의가장 클래식한 달콤함',1000.00,NULL,NULL,4,NULL,1),(59,'오트밀 레이즌','Oatmeal Raisin','http://subway.co.kr/images/menu/img_sides_05.jpg','캘리포니아 건포도와 귀리에\n살짝더해진 계피향의 환상적인 조화',1000.00,NULL,NULL,4,NULL,1),(60,'라즈베리 치즈케익','Raspberry Cheese Cake','http://subway.co.kr/images/menu/img_sides_06.jpg','부드럽고 풍부한 치즈와 새콤달콤 라즈베리의\n달콤한 만남',1000.00,NULL,NULL,4,NULL,1),(61,'화이트 초코 마카다미아','White Choco Macadamia','http://subway.co.kr/images/menu/img_sides_07.jpg','고소함 가득한 마카다미아와\n달콤한 화이트 초콜릿의 환상 궁합',1000.00,NULL,NULL,4,NULL,1),(62,'칩','Chip','http://subway.co.kr/images/menu/img_sides_08.jpg','바삭바삭한 칩을 추가해 써브웨이를 즐겨보세요',1000.00,NULL,NULL,4,NULL,1),(63,'탄산음료','Soda','http://subway.co.kr/images/menu/img_drink_01.jpg','',1000.00,NULL,NULL,4,NULL,1),(64,'커피','Coffee','http://subway.co.kr/images/menu/img_drink_02.jpg','',2000.00,NULL,NULL,4,NULL,1),(65,'해쉬브라운','Hash Brown','http://subway.co.kr/images/menu/img_sides_10.jpg','잘게 썬 감자를 노릇하게 구워\n바삭하고 쫀득하게 즐기는 모닝 파트너\n※아침메뉴 제공시간 : 오전 11시까지',2000.00,NULL,NULL,4,NULL,1);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stores`
--

DROP TABLE IF EXISTS `stores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `address` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone` (`phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stores`
--

LOCK TABLES `stores` WRITE;
/*!40000 ALTER TABLE `stores` DISABLE KEYS */;
/*!40000 ALTER TABLE `stores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sub_categories`
--

DROP TABLE IF EXISTS `sub_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sub_categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `category_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sub_categories_category_id_dc42080e_fk_categories_id` (`category_id`),
  CONSTRAINT `sub_categories_category_id_dc42080e_fk_categories_id` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_categories`
--

LOCK TABLES `sub_categories` WRITE;
/*!40000 ALTER TABLE `sub_categories` DISABLE KEYS */;
INSERT INTO `sub_categories` VALUES (1,'클래식',1),(2,'프레쉬&라이트',1),(3,'프리미엄',1),(4,'아침메뉴',1),(5,'추가 선택',1),(6,'시그니처 랩',2),(7,'미니 랩',2),(8,'클래식',3),(9,'프레쉬&라이트',3),(10,'프리미엄',3),(11,'추가선택',3);
/*!40000 ALTER TABLE `sub_categories` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-01 20:26:54
