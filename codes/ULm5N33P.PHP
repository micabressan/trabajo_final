$stmt = $this->pdo->prepare('UPDATE `'.\Config\Database\DBConfig::$tableCar.'` SET
				`'.\Config\Database\DBConfig\Car::$brand.'`=:brand,`'
				.\Config\Database\DBConfig\Car::$model.'`=:model, `'
				.\Config\Database\DBConfig\Car::$yearProduction.'`=:yearProduction,`'
				.\Config\Database\DBConfig\Car::$engineSize.'`=:engineSize,`'
				.\Config\Database\DBConfig\Car::$enginePower.'`=:enginePower,`'
				.\Config\Database\DBConfig\Car::$registrationNumber.'`=:registrationNumber,`'
				.\Config\Database\DBConfig\Car::$vinNumber.'`=:vinNumber,`'
				.\Config\Database\DBConfig\Car::$fuel.'`=:fuel,`'
				.\Config\Database\DBConfig\Car::$colour.'`=:colour,`'
				.\Config\Database\DBConfig\Car::$idOwner.'`=:idOwner,`'
				.\Config\Database\DBConfig\Car::$idBodyType.'`=:idBodyType WHERE  `'
				.\Config\Database\DBConfig\Car::$idCar.'`=:idCar');  

                $stmt->bindValue(':idCar', $idCar, PDO::PARAM_INT);
                $stmt->bindValue(':brand', $brand, PDO::PARAM_STR);
                $stmt->bindValue(':model', $model, PDO::PARAM_STR); 
                $stmt->bindValue(':yearProduction', $yearProduction, PDO::PARAM_STR);
                $stmt->bindValue(':engineSize', $engineSize, PDO::PARAM_STR);
				$stmt->bindValue(':enginePower', $enginePower, PDO::PARAM_INT);
				$stmt->bindValue(':registrationNumber', $registrationNumber, PDO::PARAM_STR);
				$stmt->bindValue(':vinNumber', $vinNumber, PDO::PARAM_STR);
				$stmt->bindValue(':fuel', $fuel, PDO::PARAM_STR);
				$stmt->bindValue(':colour', $colour, PDO::PARAM_STR);
				$stmt->bindValue(':idOwner', $idOwner, PDO::PARAM_INT);
				$stmt->bindValue(':idBodyType', $idBodyType, PDO::PARAM_INT);