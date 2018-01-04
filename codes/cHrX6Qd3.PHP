			/**
			 * PHPExcel
			 *
			 * Copyright (c) 2006 - 2015 PHPExcel
			 *
			 * This library is free software; you can redistribute it and/or
			 * modify it under the terms of the GNU Lesser General Public
			 * License as published by the Free Software Foundation; either
			 * version 2.1 of the License, or (at your option) any later version.
			 *
			 * This library is distributed in the hope that it will be useful,
			 * but WITHOUT ANY WARRANTY; without even the implied warranty of
			 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
			 * Lesser General Public License for more details.
			 *
			 * You should have received a copy of the GNU Lesser General Public
			 * License along with this library; if not, write to the Free Software
			 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
			 *
			 * @category   PHPExcel
			 * @package    PHPExcel
			 * @copyright  Copyright (c) 2006 - 2015 PHPExcel (http://www.codeplex.com/PHPExcel)
			 * @license    http://www.gnu.org/licenses/old-licenses/lgpl-2.1.txt	LGPL
			 * @version    ##VERSION##, ##DATE##
			 */
			header( "Content-type: application/vnd.ms-excel; charset=UTF-8" );

			date_default_timezone_set('Europe/London');

			if (PHP_SAPI == 'cli')
				die('This example should only be run from a Web Browser');

			/** Include PHPExcel */
			require_once dirname(__FILE__) . '/PHPExcel-1.8/Classes/PHPExcel.php';

			// Create new PHPExcel object
			$objPHPExcel = new PHPExcel();

			// Set document properties
			$objPHPExcel->getProperties()->setCreator("Yachtize automated data download")
										 ->setLastModifiedBy("Yachtize automated data download at" . time())
										 ->setTitle("User data")
										 ->setSubject("User data")
										 ->setDescription("Users data")
										 ->setKeywords("None")
										 ->setCategory("Test result file");

			// Add some data
			$objPHPExcel->setActiveSheetIndex(0)
			            ->setCellValue('A1', $curret_first_name)
			            ->setCellValue('B2', $curret_last_name)
			            ->setCellValue('C1', $curret_user_rep)
			            ->setCellValue('D2', 'this is a test!');


			$filename = $curret_first_name . "_" . $curret_last_name . "_data";


			// Set active sheet index to the first sheet, so Excel opens this as the first sheet
			$objPHPExcel->setActiveSheetIndex(0);


			// Redirect output to a client’s web browser (Excel5)
			header('Content-Type: application/vnd.ms-excel');
			header('Content-Disposition: attachment;filename="'.$filename.'.xls"');
			header('Cache-Control: max-age=0');
			// If you're serving to IE 9, then the following may be needed
			header('Cache-Control: max-age=1');

			// If you're serving to IE over SSL, then the following may be needed
			header ('Expires: Mon, 26 Jul 1997 05:00:00 GMT'); // Date in the past
			header ('Last-Modified: '.gmdate('D, d M Y H:i:s').' GMT'); // always modified
			header ('Cache-Control: cache, must-revalidate'); // HTTP/1.1
			header ('Pragma: public'); // HTTP/1.0

			$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');
			$objWriter->save('php://output');
			exit;