USE 782groupw1;

DELIMITER $$
CREATE TRIGGER check_date
	BEFORE INSERT ON orders
	FOR EACH ROW
BEGIN
	IF new.date_ordered > Curdate() THEN
	SIGNAL SQLSTATE '45000' SET message_text = 
	'TriggerError: The order date cannot be before today.';
END IF;
END$$
DELIMITER ;