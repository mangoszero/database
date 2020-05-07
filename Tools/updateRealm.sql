    -- Get the Latest RealmID
    SET @RealmCount := (SELECT `AUTO_INCREMENT` FROM `information_schema`.`tables` WHERE `table_name`='realmlist' AND `table_schema`=(SELECT DATABASE()));
    SET @RealmName = 'MaNGOS Zero Server #';

    -- Insert a new unique Row
    INSERT INTO `realmlist` SET `NAME`=CONCAT(@RealmName,CAST(@RealmCount AS CHAR));

    -- Get the id of the inserted row
    SET @NewRealm := (SELECT MAX(`id`) FROM `realmlist`);

    -- Update the information
    UPDATE `realmlist` SET `realmbuilds`='5875 6005 6141' WHERE `id`=@NewRealm;

    -- Display the Realm Info
    SELECT CONCAT('Realm Name: ',@RealmName,CAST(@RealmCount AS CHAR),'  Realm ID: ',CAST(@NewRealm AS CHAR)) AS 'Realm Information';