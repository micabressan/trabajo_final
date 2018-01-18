DELIMITER //

DROP TRIGGER checkQuantity;
//
CREATE TRIGGER checkQuantity BEFORE INSERT ON orderitems
	FOR EACH ROW BEGIN
		IF ((SELECT QuantityInStock + QuantityInStore 
				 FROM products 
				 WHERE products.ProductId = new.Product_ProductId) < new.Quantity)
		THEN
			SIGNAL SQLSTATE '02001'
            SET message_text = 'Not enough products';
		END IF;
	END;
//
DROP TRIGGER decrementQuantity;
//
CREATE TRIGGER decrementQuantity AFTER INSERT ON orderitems
	FOR EACH ROW BEGIN
		DECLARE LeastQuantity INT;
        DECLARE d INT;
        SELECT LEAST(QuantityInStore, new.Quantity) INTO LeastQuantity FROM Products WHERE ProductId = new.Product_ProductId;
        DELETE FROM test_table WHERE Id = 1 OR Id = 2;
        INSERT INTO test_table VALUES(1, LeastQuantity);
        SELECT QuantityInStock - (new.Quantity - LeastQuantity) INTO d FROM Products WHERE ProductId = new.Product_ProductId;
        INSERT INTO test_table VALUES(2, d);
        
		UPDATE products
			SET QuantityInStore = QuantityInStore - LeastQuantity
			WHERE ProductId = new.Product_ProductId;
		UPDATE products
			SET QuantityInStock = QuantityInStock - (new.Quantity - LeastQuantity)
            WHERE ProductId = new.Product_ProductId;
    END;
//
DROP TRIGGER deleteDeliveryBeforeOrder;
//
CREATE TRIGGER deleteDeliveryBeforeOrder AFTER DELETE ON orders
	FOR EACH ROW BEGIN
		DELETE FROM deliveries
			WHERE DeliveryId = old.Delivery_DeliveryId;
	END;
//
DROP TRIGGER deleteDeliveryAfterUpdateOrder;
//
CREATE TRIGGER deleteDeliveryBeforeUpdateOrder BEFORE UPDATE ON orders
	FOR EACH ROW BEGIN
		IF (new.IsDeliveryRequired = 0) THEN
			SET new.Delivery_DeliveryId = NULL;
		END IF;
	END;
//
CREATE TRIGGER deleteDeliveryAfterUpdateOrder AFTER UPDATE ON orders
	FOR EACH ROW BEGIN
		IF (new.IsDeliveryRequired = 0) THEN
			DELETE FROM deliveries
				WHERE DeliveryId = old.Delivery_DeliveryId;
		END IF;
	END;
//
CREATE TRIGGER changeCategoryBeforeDeleteCategory BEFORE DELETE ON categories
	FOR EACH ROW BEGIN
		UPDATE productinfoes
			SET Category_CategoryId = (SELECT CategoryId FROM categories WHERE categories.Name = 'Без категории')
            WHERE Category_CategoryId = old.CategoryId;
		END;
//
CREATE TRIGGER cannotDeleteWithoutCategory BEFORE DELETE ON categories
	FOR EACH ROW BEGIN
		IF (old.CategoryId = (SELECT CategoryId FROM categories WHERE categories.Name = 'Без категории')) THEN
			SIGNAL SQLSTATE '02002'
            SET message_text = 'Cannot delete "Without category"';
		END IF;
	END;
//
DROP TRIGGER defaultProductName;
//
CREATE TRIGGER defaultProductName BEFORE INSERT ON products
	FOR EACH ROW BEGIN
        IF (new.Name = '' OR new.Name IS NULL) THEN BEGIN
			DECLARE modelName, categoryName VARCHAR(100);
            SELECT Name INTO categoryName
				FROM categories
				WHERE CategoryId = (SELECT Category_CategoryId FROM productinfoes WHERE ProductInfoId = new.ProductInfo_ProductInfoId);
			SELECT Model INTO modelName
				FROM productinfoes
                WHERE ProductInfoId = new.ProductInfo_ProductInfoId;
                
			DELETE FROM test_table WHERE Id = 1 OR Id = 2;
			INSERT INTO test_table VALUES(1, categoryName);
			INSERT INTO test_table VALUES(2, modelName);
        
            SET new.Name = CONCAT(categoryName, ' ', modelName);
            END;
		END IF;
	END;
//