-- phpMyAdmin SQL Dump
-- version 4.7.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 17, 2017 at 06:02 PM
-- Server version: 5.5.58-cll
-- PHP Version: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `spachemc_dbase`
--

-- --------------------------------------------------------

--
-- Table structure for table `kes`
--

CREATE TABLE `kes` (
  `id` int(11) NOT NULL,
  `bulan` varchar(20) NOT NULL,
  `tahun` varchar(5) NOT NULL,
  `produk` varchar(30) NOT NULL,
  `kesepakatan` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `kes`
--

INSERT INTO `kes` (`id`, `bulan`, `tahun`, `produk`, `kesepakatan`) VALUES
(1, 'May', '2017', '17-88', 840),
(11, 'May', '2017', 'AS-60', 800),
(10, 'May', '2017', 'MIMOSA 10XT', 1000),
(12, 'June', '2017', 'MIMOSA 10XT', 4000);

-- --------------------------------------------------------

--
-- Table structure for table `latency`
--

CREATE TABLE `latency` (
  `start` int(11) NOT NULL,
  `end` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `latency`
--

INSERT INTO `latency` (`start`, `end`) VALUES
(1, 22);

-- --------------------------------------------------------

--
-- Table structure for table `member`
--

CREATE TABLE `member` (
  `ID` int(100) NOT NULL,
  `Username` varchar(100) NOT NULL,
  `Password` varchar(500) NOT NULL,
  `Name` varchar(300) NOT NULL,
  `Privilege` varchar(100) NOT NULL,
  `last_login` timestamp NULL DEFAULT NULL,
  `last_logout` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `member`
--

INSERT INTO `member` (`ID`, `Username`, `Password`, `Name`, `Privilege`, `last_login`, `last_logout`) VALUES
(1, 'Admin', '4e7afebcfbae000b22c7c85e5560f89a2a0280b4', 'Admin', 'Super User', '2017-12-04 02:04:13', '2017-12-02 03:12:06'),
(27, 'Andi@spachem', '7019d3d513f77723d3ca37725b7c9d73703009fd', 'Andi', 'Admin User', '2017-11-20 08:02:03', '2017-11-20 08:02:25'),
(28, 'Budi@spachem', '6cc0f7b81d8dec3c2ee5ee3a0c70d01fa6fc0be7', 'Budi', 'Normal User', NULL, NULL),
(29, 'Rahman@spachem', '2ea601b62028ce73b120b8efc625d5ede58ccfdd', 'Rahman', 'Normal User', NULL, NULL),
(26, 'Agustin@spachem', '44093bfd4834073de24c7e408c2ab0c6a33cfaa1', 'Agustin', 'Normal User', NULL, NULL),
(25, 'Admin2', '48efc4851e15940af5d477d3c0ce99211a70a3be', 'Admin2', 'Super User', '2017-12-05 07:10:54', '2017-11-29 04:57:29'),
(32, 'Darma@spachem', '20e53642751684b0cc2124bb7fd9184bcb112bd8', 'Darma', 'Normal User', NULL, NULL),
(33, 'Petrus@spachem', '2fb32a99dc01414eef3677bc522c8936408cd9f0', 'Petrus', 'Normal User', NULL, NULL),
(34, 'Stefanus@spachem', 'a0fcbd994fba0ac91dc83f85fb24431474bd986d', 'Stefanus', 'Normal User', NULL, NULL),
(41, 'Andri', '85f4675094d94bca63064d484d5584219a00cec7', 'Andriyanto', 'Normal User', NULL, NULL),
(46, 'ntest', '18cfaaa1ad2de10e23b82344e61a97b0164ff7e1', 'testnorm', 'Normal User', '2017-12-02 02:57:35', '2017-12-02 03:11:58'),
(45, 'test', 'a94a8fe5ccb19ba61c4c0873d391e987982fbbd3', 'test', 'Admin User', '2017-11-30 03:20:45', '2017-11-30 03:19:51');

-- --------------------------------------------------------

--
-- Table structure for table `request`
--

CREATE TABLE `request` (
  `req_id` int(11) NOT NULL,
  `req_name` varchar(255) NOT NULL,
  `req_email` varchar(255) NOT NULL,
  `req_company` varchar(255) NOT NULL,
  `req_category` varchar(255) NOT NULL,
  `req_message` text NOT NULL,
  `req_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `request`
--

INSERT INTO `request` (`req_id`, `req_name`, `req_email`, `req_company`, `req_category`, `req_message`, `req_date`) VALUES
(1, 'Halim', 'halim@spachem.co.id', 'SPA', 'Water Treatment', 'Please send 250KG of PAC to India.', '2017-09-10 16:15:57');

-- --------------------------------------------------------

--
-- Table structure for table `tb_customer`
--

CREATE TABLE `tb_customer` (
  `id` int(11) NOT NULL,
  `Customer` varchar(100) NOT NULL,
  `Code` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tb_customer`
--

INSERT INTO `tb_customer` (`id`, `Customer`, `Code`) VALUES
(5, 'PT.AWS 2', 'AW*(&'),
(4, 'ARIS BARECORE', NULL),
(6, 'CV.GARUDA SOLO PERKASA', NULL),
(7, 'CV.NUANSA KAYU BEKAS', NULL),
(8, 'CV.SAPI GUNUNG', NULL),
(9, 'IBU ANNA', NULL),
(10, 'PT.KUSUMA MULYA ( IBU SARI )', NULL),
(11, 'PT.KNP', NULL),
(12, 'PT.KSM', NULL),
(13, 'PT.MULIA JEFADANE', NULL),
(14, 'PT.NAGATEX MASARAN', NULL),
(15, 'PT.INNATEX', NULL),
(16, 'PT.SAMITEX SEWON', NULL),
(17, 'PT.USMAN JAYA MEKAR', NULL),
(18, 'PT.BAMATEX', NULL),
(19, 'PT.BHAKTI PANCAWARNA', NULL),
(20, 'PT.CANDI MEKAR', NULL),
(21, 'PT.DAYA MANUNGGAL', NULL),
(22, 'PT.DELTA 1', NULL),
(23, 'PT.DELTA 2', NULL),
(24, 'PT.DELTA 3', NULL),
(25, 'PT.DELTA 4', NULL),
(26, 'PT.DELTA 5', NULL),
(27, 'PT.DELTA 6', NULL),
(28, 'PT.DELTA 7', NULL),
(29, 'PT.DSSA 2', NULL),
(30, 'PT.DSSA 3', NULL),
(31, 'PT.DUNIATEX', NULL),
(32, 'PT.INDATEX', NULL),
(33, 'PT.ISKANDARTEX', NULL),
(34, 'PT.KENARIA', NULL),
(35, 'PT.LOJITEX', NULL),
(36, 'PT.LOKATEX', NULL),
(37, 'PT.MAFAHTEX', NULL),
(38, 'PT.NEW SUBURTEX', NULL),
(39, 'PT.PISMATEX', NULL),
(40, 'PT.PROSPEK CHEMICAL', NULL),
(41, 'PT.SUKORINTEX', NULL),
(42, 'PT.TIGA DARA', NULL),
(43, 'PT.TRIANGGA DEWI', NULL),
(44, 'PT.TYFOUNTEX', NULL),
(45, 'PT.UNGGUL REJO', NULL),
(46, 'PT.SRITEX', NULL),
(47, 'PT.SK 1', NULL),
(48, 'PT.SK 2', NULL),
(49, 'PT.DJOHARTEX', NULL),
(50, 'PT.SUKOHARJOTEX', NULL),
(51, 'PT.SAFARI JUNI', NULL),
(52, 'PT.DIAN KIMIA', NULL),
(53, 'PT.DUTATEX', NULL),
(54, 'PT.WAHANA TATA INSANI', NULL),
(55, 'PT.HASNATEX', NULL),
(56, 'PT.ASATEX', NULL),
(57, 'PT.KBN', NULL),
(58, 'PT.SEKARLIMA', NULL),
(59, 'PT.BATI', NULL),
(60, 'PT.SUKUNTEX', NULL),
(61, 'FALTATEX', NULL),
(62, 'BATIK MEKARSARI', NULL),
(63, 'KUSUMATEX', NULL),
(64, 'BATIK HUDA', NULL),
(65, 'PENINDO', NULL),
(66, 'PT.GANDA MAJU JAYA', NULL),
(67, 'PT.JACKYTEX', NULL),
(68, 'PT.AJM', NULL),
(69, 'PT.ALBASI KAYU PRIMA', NULL),
(70, 'PT.ALBASI KAYU PRIANGAN', NULL),
(71, 'GKBI', NULL),
(72, 'PT.TIRTA UNGU', NULL),
(73, 'CV.PRIMA REJEKI', NULL),
(74, 'UD.PUTERA MANDIRI JAYA', NULL),
(75, 'UD.YOHANES BARECORE', NULL),
(76, 'SWP', NULL),
(77, 'PT.MUARA KAYU SENGON', NULL),
(78, 'PT.FUJINDO MEGAH', NULL),
(79, 'UD.GENTONG MAKMUR', NULL),
(80, 'SUMBER JAYA GARMENT', NULL),
(81, 'PT.LOKATEX', NULL),
(83, 'PT.DSSA 4', NULL),
(84, 'PT.SARI WARNA ASLI', NULL),
(87, 'PT. Sinar Bunga', 'Asd123125');

-- --------------------------------------------------------

--
-- Table structure for table `tb_forecast`
--

CREATE TABLE `tb_forecast` (
  `id` int(11) NOT NULL,
  `bulan` varchar(12) NOT NULL,
  `tahun` varchar(5) NOT NULL,
  `marketing` varchar(60) NOT NULL,
  `customer` varchar(255) NOT NULL,
  `item` varchar(255) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tb_forecast`
--

INSERT INTO `tb_forecast` (`id`, `bulan`, `tahun`, `marketing`, `customer`, `item`, `quantity`) VALUES
(1, 'December', '2017', 'Admin2', 'GKBI', 'AS-60', 2000),
(2, 'December', '2017', 'Admin', 'ARIS BARECORE', '17-88', 3),
(3, 'December', '2017', 'testnorm', 'ARIS BARECORE', '17-88', 1000),
(4, 'December', '2017', 'test', 'ARIS BARECORE', '17-88', 1000);

-- --------------------------------------------------------

--
-- Table structure for table `tb_item`
--

CREATE TABLE `tb_item` (
  `ID` int(10) NOT NULL,
  `Nama` varchar(100) NOT NULL,
  `SKU` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tb_item`
--

INSERT INTO `tb_item` (`ID`, `Nama`, `SKU`) VALUES
(7, '17-88', NULL),
(5, '17-99', NULL),
(21, 'AFTERWAX TD', NULL),
(9, 'AFTERWAX LQ', NULL),
(10, 'ALFASIZE', NULL),
(11, 'AS-60', NULL),
(12, 'AS-80', NULL),
(13, 'BIO-SR', NULL),
(14, 'COMPOUND PH10', NULL),
(15, 'COMPOUND R80', NULL),
(16, 'DLSR YT', NULL),
(23, 'ETHYL ACETATE', NULL),
(24, 'FN SUPER', NULL),
(25, 'GM-SR', NULL),
(26, 'GAMA SIZE', NULL),
(27, 'MA-50', NULL),
(28, 'MA-50AT', NULL),
(29, 'MA-50XP', NULL),
(30, 'MIMOSA 10XT', NULL),
(31, 'NA-08', NULL),
(32, 'NA-30', NULL),
(33, 'POLYNOL P90LV', NULL),
(34, 'POLYNOL T90', NULL),
(35, 'SIZE SP', NULL),
(36, 'SIZE XP', NULL),
(37, 'SR MT 1', NULL),
(38, 'SR MT', NULL),
(39, 'SR SIZE 50', NULL),
(40, 'SR WAX 90', NULL),
(41, 'SUN FP', NULL),
(42, 'SUN HC 810', NULL),
(43, 'SUN HT RC 35', NULL),
(44, 'SUNBOND 708', NULL),
(45, 'SUNTEX F', NULL),
(46, 'SUNVAC 04', NULL),
(47, 'SUNVAC 05XT', NULL),
(48, 'SUNWAX 908', NULL),
(49, 'SIZE GX', NULL),
(50, 'COMPOUND RA7A', NULL),
(51, 'SR WAX NA 80', NULL),
(52, 'ZT SR', NULL),
(53, 'SR-AS', NULL),
(54, 'AFTERWAX ST', NULL),
(55, 'SUN HT RC 30', NULL),
(56, 'MIMOSA 10XTC', NULL),
(57, 'SD-15 ( SCOURING DESIZING )', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tb_realisasi`
--

CREATE TABLE `tb_realisasi` (
  `ID` int(10) NOT NULL,
  `Tanggal` varchar(100) NOT NULL,
  `Grup` varchar(100) NOT NULL,
  `Marketing` varchar(60) NOT NULL,
  `SO` int(100) NOT NULL,
  `Customer` varchar(255) NOT NULL,
  `SJ` int(100) NOT NULL,
  `Produk` varchar(255) NOT NULL,
  `PO` int(100) NOT NULL,
  `Tonase` int(100) NOT NULL,
  `Harga` int(100) NOT NULL,
  `Discount` int(100) NOT NULL,
  `PPN` tinyint(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tb_realisasi`
--

INSERT INTO `tb_realisasi` (`ID`, `Tanggal`, `Grup`, `Marketing`, `SO`, `Customer`, `SJ`, `Produk`, `PO`, `Tonase`, `Harga`, `Discount`, `PPN`) VALUES
(1, '14-12-2017', '', 'Admin2', 0, 'GKBI', 0, 'AS-60', 0, 1250, 1000, 0, 0),
(2, '29-11-2017', '', 'Admin2', 0, 'GKBI', 0, 'AS-60', 0, 100, 1020, 0, 0),
(3, '11-01-2018', '', 'Admin2', 0, 'GKBI', 0, 'AS-60', 0, 250, 1020, 0, 0),
(4, '07-12-2017', '', '', 0, 'awf', 0, 'AS-60', 0, 1000, 123, 1, 0),
(5, '05-12-2017', '', '', 12, 'asd', 12, 'AFTERWAX TD', 12, 1000, 123, 1, 0),
(6, '23-11-2017', '', '', 0, 'ARIS BARECORE', 0, '17-88', 0, 10, 0, 0, 0),
(7, '15-12-2017', 'Asdkjnhkjashgoinoi', 'Admin2', 0, 'Asfpoajsgpojpoajspogjpojsaogjpoajspgojaposjgposajpogjp', 0, 'AS-80', 0, 1097, 120, 0, 0),
(8, '23-11-2017', '', '', 0, 'aws', 0, '17-99', 0, 1000, 0, 0, 0),
(9, '21-12-2017', 'asfd', '', 0, 'Asdasd', 0, 'ALFASIZE', 0, 1000, 2005, 0, 0),
(10, '05-01-2018', '', 'test', 0, 'aws', 0, 'MIMOSA 10XT', 0, 1000, 10, 0, 0),
(11, '09-12-2017', '', '', 0, 'aws', 0, 'BIO-SR', 0, 1000, 10, 0, 0),
(12, '08-12-2017', '', '', 0, 'aws', 0, 'GAMA SIZE', 0, 1000, 10, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tolerance`
--

CREATE TABLE `tolerance` (
  `percent` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tolerance`
--

INSERT INTO `tolerance` (`percent`) VALUES
(100000);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `kes`
--
ALTER TABLE `kes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `member`
--
ALTER TABLE `member`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `request`
--
ALTER TABLE `request`
  ADD PRIMARY KEY (`req_id`);

--
-- Indexes for table `tb_customer`
--
ALTER TABLE `tb_customer`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_forecast`
--
ALTER TABLE `tb_forecast`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_item`
--
ALTER TABLE `tb_item`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tb_realisasi`
--
ALTER TABLE `tb_realisasi`
  ADD UNIQUE KEY `ID` (`ID`),
  ADD KEY `ID_2` (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `kes`
--
ALTER TABLE `kes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `member`
--
ALTER TABLE `member`
  MODIFY `ID` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;
--
-- AUTO_INCREMENT for table `request`
--
ALTER TABLE `request`
  MODIFY `req_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `tb_customer`
--
ALTER TABLE `tb_customer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=88;
--
-- AUTO_INCREMENT for table `tb_forecast`
--
ALTER TABLE `tb_forecast`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `tb_item`
--
ALTER TABLE `tb_item`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;
--
-- AUTO_INCREMENT for table `tb_realisasi`
--
ALTER TABLE `tb_realisasi`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;