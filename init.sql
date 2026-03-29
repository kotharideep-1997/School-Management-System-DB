CREATE DATABASE  IF NOT EXISTS `school_managemnet_system` 
USE `school_managemnet_system`;

DROP TABLE IF EXISTS `classmaster`;

CREATE TABLE `classmaster` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Class` varchar(5) NOT NULL,
  `Strength` tinyint unsigned NOT NULL,
  `CreatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `IsActive` tinyint(1) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Class` (`Class`),
  CONSTRAINT `classmaster_chk_1` CHECK ((`Strength` <= 100))
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `classmaster` WRITE;
INSERT INTO `classmaster` VALUES (4,'9A',45,'2026-03-28 18:18:54','2026-03-28 18:37:11',0),(5,'4B',65,'2026-03-28 18:57:19','2026-03-28 20:12:04',1),(6,'9S',20,'2026-03-28 20:11:38','2026-03-28 20:11:38',1);
UNLOCK TABLES;


DROP TABLE IF EXISTS `permissionmaster`;
CREATE TABLE `permissionmaster` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `PermissionName` varchar(50) NOT NULL,
  `CreatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `IsActive` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `permissionmaster` WRITE;
INSERT INTO `permissionmaster` VALUES (1,'string','2026-03-28 18:59:41','2026-03-28 19:01:14',1),(2,'Edit','2026-03-28 18:59:49','2026-03-28 18:59:49',1),(3,'Delete','2026-03-28 18:59:53','2026-03-28 18:59:53',1),(5,'View','2026-03-28 19:02:27','2026-03-28 19:02:27',1),(6,'report','2026-03-28 20:13:06','2026-03-28 20:13:06',1);
UNLOCK TABLES;

DROP TABLE IF EXISTS `studentattendances`;
CREATE TABLE `studentattendances` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `StudentId` int NOT NULL,
  `AttendanceDate` datetime NOT NULL,
  `Status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Created_At` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Updated_At` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`),
  KEY `IX_StudentAttendances_StudentId` (`StudentId`),
  KEY `IX_StudentAttendances_AttendanceDate` (`AttendanceDate`),
  CONSTRAINT `FK_StudentAttendances_Students` FOREIGN KEY (`StudentId`) REFERENCES `students` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `studentattendances` WRITE;
UNLOCK TABLES;


DROP TABLE IF EXISTS `studentclassmapping`;
CREATE TABLE `studentclassmapping` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `StudentId` int NOT NULL,
  `ClassId` int NOT NULL,
  `IsActive` tinyint(1) NOT NULL DEFAULT '1',
  `Created_At` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Updated_At` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `StudentId` (`StudentId`,`ClassId`),
  KEY `FK_StudentClass_Class` (`ClassId`),
  CONSTRAINT `FK_StudentClass_Class` FOREIGN KEY (`ClassId`) REFERENCES `classmaster` (`Id`),
  CONSTRAINT `FK_StudentClass_Student` FOREIGN KEY (`StudentId`) REFERENCES `students` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `studentclassmapping` WRITE;
UNLOCK TABLES;


DROP TABLE IF EXISTS `students`;
CREATE TABLE `students` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(40) NOT NULL,
  `LastName` varchar(40) NOT NULL,
  `RollNo` int NOT NULL,
  `Active` tinyint(1) NOT NULL DEFAULT '1',
  `CreatedDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdatedDate` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ClassId` int DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_Students_Class` (`ClassId`),
  CONSTRAINT `FK_Students_Class` FOREIGN KEY (`ClassId`) REFERENCES `classmaster` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `students` WRITE;
INSERT INTO `students` VALUES (2,'wdw','dwdwd',45,1,'2026-03-29 00:37:08','2026-03-29 00:37:08',4),(3,'wdw','dwdwd',45,1,'2026-03-29 00:42:31','2026-03-29 00:42:31',4);
UNLOCK TABLES;


DROP TABLE IF EXISTS `userpermission`;
CREATE TABLE `userpermission` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `UserId` int NOT NULL,
  `PermissionId` int NOT NULL,
  `IsActive` tinyint(1) NOT NULL DEFAULT '1',
  `CreatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UserId` (`UserId`,`PermissionId`),
  KEY `FK_UserPermission_Permission` (`PermissionId`),
  CONSTRAINT `FK_UserPermission_Permission` FOREIGN KEY (`PermissionId`) REFERENCES `permissionmaster` (`Id`),
  CONSTRAINT `FK_UserPermission_User` FOREIGN KEY (`UserId`) REFERENCES `users` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `userpermission` WRITE;
INSERT INTO `userpermission` VALUES (1,7,1,1,'2026-03-28 19:44:25','2026-03-28 19:44:25'),(2,7,2,1,'2026-03-28 19:44:34','2026-03-28 19:44:34'),(3,7,3,1,'2026-03-28 19:44:40','2026-03-28 19:44:40'),(5,7,5,1,'2026-03-28 19:44:48','2026-03-28 19:44:48'),(10,6,6,0,'2026-03-28 20:14:28','2026-03-28 20:14:51');
UNLOCK TABLES;


DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `UserName` varchar(50) NOT NULL,
  `PasswordHash` varbinary(256) NOT NULL,
  `PasswordSalt` varbinary(128) NOT NULL,
  `CreatedDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `IsActive` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UserName` (`UserName`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `users` WRITE;
INSERT INTO `users` VALUES (1,'Deep',_binary '�\�r1rY��N\�v=\�\�~\��z��ήu�k\�+',_binary '����\�x;yj2^�/','2026-03-28 11:53:58',1),(6,'wdw',_binary '!��Ȼ�\��hH��\�\��)�ݔi�\�\�*�	��#\�',_binary '�H3\�c����@��:\�','2026-03-28 13:01:02',1),(7,'Admin',_binary '�y8���\�AL5  �X\�W\�\�h�f\044��)\�i',_binary '�LX!��a�9�I\����E','2026-03-28 18:06:50',1);
UNLOCK TABLES;

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Auth_SelectPermissionNamesByUserId`(IN p_UserId INT)
BEGIN
    SELECT pm.PermissionName
    FROM UserPermission up
    INNER JOIN PermissionMaster pm ON pm.Id = up.PermissionId
    WHERE up.UserId = p_UserId AND up.IsActive = 1 AND pm.IsActive = 1;
END ;;
DELIMITER ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ClassMaster_Insert`(
    IN  p_Class VARCHAR(255),
    IN  p_Strength TINYINT,
    IN  p_CreatedAt DATETIME,
    IN  p_UpdatedAt DATETIME,
    IN  p_IsActive TINYINT,
    OUT p_NewId INT
)
BEGIN
    INSERT INTO ClassMaster (`Class`, Strength, CreatedAt, UpdatedAt, IsActive)
    VALUES (p_Class, p_Strength, p_CreatedAt, p_UpdatedAt, p_IsActive);

    SET p_NewId = LAST_INSERT_ID();
END ;;
DELIMITER ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ClassMaster_SelectAll`()
BEGIN
    SELECT * FROM ClassMaster;
END ;;
DELIMITER ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ClassMaster_SelectById`(IN p_Id INT)
BEGIN
    SELECT Id, `Class`, Strength, CreatedAt, UpdatedAt, IsActive
    FROM ClassMaster
    WHERE Id = p_Id;
END ;;
DELIMITER ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_PermissionMaster_Insert`(
    IN  p_PermissionName VARCHAR(50),
    IN  p_CreatedAt DATETIME,
    IN  p_UpdatedAt DATETIME,
    IN  p_IsActive TINYINT,
    OUT p_NewId INT
)
BEGIN
    INSERT INTO PermissionMaster (PermissionName, CreatedAt, UpdatedAt, IsActive)
    VALUES (p_PermissionName, p_CreatedAt, p_UpdatedAt, p_IsActive);

    SET p_NewId = LAST_INSERT_ID();
END ;;
DELIMITER ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_PermissionMaster_SelectAll`()
BEGIN
    SELECT * FROM PermissionMaster;
END ;;
DELIMITER ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_PermissionMaster_SelectById`(IN p_Id INT)
BEGIN
    SELECT Id, PermissionName, CreatedAt, UpdatedAt, IsActive
    FROM PermissionMaster
    WHERE Id = p_Id;
END ;;
DELIMITER ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Report_AttendanceRangeSummary`(
    IN p_From DATE,
    IN p_ToExclusive DATETIME
)
BEGIN
    SELECT
        (SELECT COUNT(DISTINCT a.StudentId)
         FROM StudentAttendances a
         INNER JOIN Students s ON s.Id = a.StudentId
         WHERE LOWER(TRIM(a.Status)) = 'present'
           AND a.AttendanceDate >= p_From
           AND a.AttendanceDate < p_ToExclusive
           AND s.Active = 1) AS PresentStudentCount,

        (SELECT COUNT(DISTINCT a.StudentId)
         FROM StudentAttendances a
         INNER JOIN Students s ON s.Id = a.StudentId
         WHERE LOWER(TRIM(a.Status)) = 'absent'
           AND a.AttendanceDate >= p_From
           AND a.AttendanceDate < p_ToExclusive
           AND s.Active = 1) AS AbsentStudentCount;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Report_AttendanceStudentsByStatusPaged`(
    IN p_Status VARCHAR(20),
    IN p_From DATE,
    IN p_ToExclusive DATETIME,
    IN p_Name VARCHAR(100),
    IN p_RollNo INT,
    IN p_Offset INT,
    IN p_PageSize INT
)
BEGIN

    SELECT COUNT(*) AS TotalCount 
    FROM (
        SELECT DISTINCT s.Id
        FROM StudentAttendances a
        INNER JOIN Students s ON s.Id = a.StudentId
        WHERE LOWER(TRIM(a.Status)) = LOWER(TRIM(p_Status))
          AND a.AttendanceDate >= p_From
          AND a.AttendanceDate < p_ToExclusive
          AND s.Active = 1
          AND (
                p_Name IS NULL OR TRIM(p_Name) = '' 
                OR s.FirstName LIKE CONCAT('%', p_Name, '%')
                OR s.LastName LIKE CONCAT('%', p_Name, '%')
                OR CONCAT(s.FirstName, ' ', s.LastName) LIKE CONCAT('%', p_Name, '%')
              )
          AND (p_RollNo IS NULL OR s.RollNo = p_RollNo)
    ) t;

    SELECT DISTINCT
        s.Id AS StudentId,
        s.FirstName,
        s.LastName,
        s.RollNo,
        s.ClassId,
        cm.`Class` AS ClassLabel
    FROM StudentAttendances a
    INNER JOIN Students s ON s.Id = a.StudentId
    LEFT JOIN ClassMaster cm ON cm.Id = s.ClassId
    WHERE LOWER(TRIM(a.Status)) = LOWER(TRIM(p_Status))
      AND a.AttendanceDate >= p_From
      AND a.AttendanceDate < p_ToExclusive
      AND s.Active = 1
      AND (
            p_Name IS NULL OR TRIM(p_Name) = '' 
            OR s.FirstName LIKE CONCAT('%', p_Name, '%')
            OR s.LastName LIKE CONCAT('%', p_Name, '%')
            OR CONCAT(s.FirstName, ' ', s.LastName) LIKE CONCAT('%', p_Name, '%')
          )
      AND (p_RollNo IS NULL OR s.RollNo = p_RollNo)
    ORDER BY s.LastName, s.FirstName, s.Id
    LIMIT p_Offset, p_PageSize;

END ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Report_CountActiveStudents`()
BEGIN
    SELECT COUNT(*) AS TotalCount 
    FROM Students 
    WHERE Active = 1;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Report_CountActiveUsers`()
BEGIN
    SELECT COUNT(*) AS TotalCount 
    FROM Users 
    WHERE IsActive = 1;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_StudentAttendances_Insert`(
    IN  p_StudentId      INT,
    IN  p_AttendanceDate DATETIME,
    IN  p_Status         VARCHAR(20),
    OUT p_NewId INT
)
BEGIN
    INSERT INTO StudentAttendances (StudentId, AttendanceDate, Status, Created_At, Updated_At)
    VALUES (p_StudentId, p_AttendanceDate, p_Status, UTC_TIMESTAMP(), UTC_TIMESTAMP());
    SET p_NewId = LAST_INSERT_ID();
END ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_StudentAttendances_SelectAll`()
BEGIN
    SELECT Id, StudentId, AttendanceDate, Status, Created_At, Updated_At
    FROM StudentAttendances
    ORDER BY AttendanceDate DESC, Id DESC;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_StudentAttendances_SelectByDate`(IN p_Date DATE)
BEGIN
    SELECT * FROM StudentAttendances
    WHERE DATE(AttendanceDate) = p_Date;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_StudentAttendances_SelectById`(IN p_Id INT)
BEGIN
    SELECT * FROM StudentAttendances WHERE Id = p_Id;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_StudentAttendances_SelectByStudentAndDateRange`(
    IN p_StudentId INT,
    IN p_From DATE,
    IN p_ToExclusive DATETIME
)
BEGIN
    SELECT * FROM StudentAttendances
    WHERE StudentId = p_StudentId
      AND AttendanceDate >= p_From
      AND AttendanceDate < p_ToExclusive;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_StudentAttendances_SelectSummaryByDate`(IN p_Date DATE)
BEGIN
    SELECT Status, COUNT(*) AS Cnt
    FROM StudentAttendances
    WHERE DATE(AttendanceDate) = p_Date
    GROUP BY Status;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Students_Insert`(
    IN  p_FirstName VARCHAR(40),
    IN  p_LastName  VARCHAR(40),
    IN  p_RollNo    INT,
    IN  p_ClassId   INT,
    IN  p_Active    TINYINT(1),
    IN  p_CreatedDate DATETIME,
    OUT p_NewId INT
)
BEGIN
    IF p_ClassId IS NULL OR p_ClassId < 1 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'ClassId is required and must be a positive integer.';
    END IF;

    IF NOT EXISTS (SELECT 1 FROM ClassMaster WHERE Id = p_ClassId) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'ClassId does not exist in ClassMaster.';
    END IF;

    INSERT INTO Students (FirstName, LastName, RollNo, ClassId, Active, CreatedDate)
    VALUES (
        p_FirstName,
        p_LastName,
        p_RollNo,
        p_ClassId,
        p_Active,
        IFNULL(p_CreatedDate, CURRENT_TIMESTAMP)
    );
    SET p_NewId = LAST_INSERT_ID();
END ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Students_Search`(
    IN p_Name   VARCHAR(100),
    IN p_RollNo INT,
    IN p_Offset INT,
    IN p_PageSize INT
)
BEGIN
    SELECT * FROM Students
    WHERE (p_Name IS NULL OR FirstName LIKE CONCAT('%', p_Name, '%'))
      AND (p_RollNo IS NULL OR RollNo = p_RollNo)
    LIMIT p_Offset, p_PageSize;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Students_SelectAll`()
BEGIN
    SELECT * FROM Students;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Students_SelectById`(IN p_Id INT)
BEGIN
    SELECT * FROM Students WHERE Id = p_Id;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Students_SelectPaged`(IN p_Offset INT, IN p_PageSize INT)
BEGIN
    SELECT * FROM Students
    LIMIT p_Offset, p_PageSize;

    SELECT COUNT(*) AS TotalCount FROM Students;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_UserPermission_DeleteByUserId`(IN p_UserId INT)
BEGIN
    DELETE FROM UserPermission WHERE UserId = p_UserId;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_UserPermission_Insert`(
    IN p_UserId INT,
    IN p_PermissionId INT,
    IN p_IsActive TINYINT,
    IN p_CreatedAt DATETIME,
    IN p_UpdatedAt DATETIME,
    OUT p_NewId INT
)
BEGIN
    INSERT INTO UserPermission (UserId, PermissionId, IsActive, CreatedAt, UpdatedAt)
    VALUES (p_UserId, p_PermissionId, p_IsActive, p_CreatedAt, p_UpdatedAt);

    SET p_NewId = LAST_INSERT_ID();
END ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_UserPermission_ReplaceForUser_Json`(
    IN p_UserId INT,
    IN p_PermissionIdsJson JSON
)
BEGIN
    DECLARE v_idx INT DEFAULT 0;
    DECLARE v_len INT;
    DECLARE v_pid INT;
    DECLARE v_now DATETIME DEFAULT UTC_TIMESTAMP();

    START TRANSACTION;

    DELETE FROM UserPermission WHERE UserId = p_UserId;

    SET v_len = IFNULL(JSON_LENGTH(p_PermissionIdsJson), 0);

    WHILE v_idx < v_len DO
        SET v_pid = CAST(JSON_UNQUOTE(JSON_EXTRACT(p_PermissionIdsJson, CONCAT('$[', v_idx, ']'))) AS UNSIGNED);

        INSERT INTO UserPermission (UserId, PermissionId, IsActive, CreatedAt, UpdatedAt)
        VALUES (p_UserId, v_pid, 1, v_now, v_now);

        SET v_idx = v_idx + 1;
    END WHILE;

    COMMIT;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_UserPermission_SelectAll`()
BEGIN
    SELECT
        up.Id,
        up.UserId,
        up.PermissionId,
        pm.PermissionName AS PermissionName,
        up.IsActive,
        up.CreatedAt,
        up.UpdatedAt
    FROM UserPermission up
    INNER JOIN PermissionMaster pm ON pm.Id = up.PermissionId
    ORDER BY up.UserId, up.PermissionId;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_UserPermission_SelectByUserId`(IN p_UserId INT)
BEGIN
    SELECT
        up.Id,
        up.UserId,
        up.PermissionId,
        pm.PermissionName AS PermissionName,
        up.IsActive,
        up.CreatedAt,
        up.UpdatedAt
    FROM UserPermission up
    INNER JOIN PermissionMaster pm ON pm.Id = up.PermissionId
    WHERE up.UserId = p_UserId
    ORDER BY up.PermissionId;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_UserPermission_SelectPermissionIdsByUserId`(IN p_UserId INT)
BEGIN
    SELECT PermissionId
    FROM UserPermission
    WHERE UserId = p_UserId AND IsActive = 1;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_UserPermission_Set`(
    IN p_UserId       INT,
    IN p_PermissionId INT,
    IN p_IsActive     TINYINT(1)
)
BEGIN
    DECLARE v_now DATETIME DEFAULT UTC_TIMESTAMP();
    DECLARE v_cnt INT DEFAULT 0;

    SELECT COUNT(*) INTO v_cnt
    FROM UserPermission
    WHERE UserId = p_UserId AND PermissionId = p_PermissionId;

    IF v_cnt = 0 THEN
        INSERT INTO UserPermission (UserId, PermissionId, IsActive, CreatedAt, UpdatedAt)
        VALUES (p_UserId, p_PermissionId, p_IsActive, v_now, v_now);
    ELSE
        UPDATE UserPermission
        SET IsActive = p_IsActive, UpdatedAt = v_now
        WHERE UserId = p_UserId AND PermissionId = p_PermissionId;
    END IF;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_UserPermission_UpdateActive`(
    IN p_UserId       INT,
    IN p_PermissionId INT,
    IN p_IsActive     TINYINT(1),
    OUT p_RowCount    INT
)
BEGIN
    UPDATE UserPermission
    SET IsActive = p_IsActive, UpdatedAt = UTC_TIMESTAMP()
    WHERE UserId = p_UserId AND PermissionId = p_PermissionId;
    SET p_RowCount = ROW_COUNT();
END ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Users_Insert`(
    IN  p_UserName     VARCHAR(50),
    IN  p_PasswordHash BLOB,
    IN  p_PasswordSalt BLOB,
    IN  p_CreatedDate  DATETIME,
    IN  p_IsActive     TINYINT(1),
    OUT p_NewId INT
)
BEGIN
    INSERT INTO Users (UserName, PasswordHash, PasswordSalt, CreatedDate, IsActive)
    VALUES (
        p_UserName,
        p_PasswordHash,
        p_PasswordSalt,
        IFNULL(p_CreatedDate, CURRENT_TIMESTAMP),
        p_IsActive
    );

    SET p_NewId = LAST_INSERT_ID();
END ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Users_SelectAll`()
BEGIN
    SELECT Id, UserName, PasswordHash, PasswordSalt, CreatedDate, IsActive
    FROM Users;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Users_SelectById`(IN p_Id INT)
BEGIN
    SELECT Id, UserName, PasswordHash, PasswordSalt, CreatedDate, IsActive
    FROM Users
    WHERE Id = p_Id;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Users_SelectByUserName`(IN p_UserName VARCHAR(50))
BEGIN
    SELECT * FROM Users WHERE UserName = p_UserName;
END ;;
DELIMITER ;


-- ---------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS sp_AttendanceReport_SelectDayRows;
DELIMITER $$
CREATE PROCEDURE sp_AttendanceReport_SelectDayRows(
    IN p_From DATE,
    IN p_ToExclusive DATE
)
BEGIN
    SELECT s.RollNo,
           s.FirstName,
           s.LastName,
           cm.`Class` AS Class,
           sa.AttendanceDate,
           CASE LOWER(TRIM(sa.Status))
               WHEN 'present' THEN 'Present'
               WHEN 'absent' THEN 'Absent'
               ELSE TRIM(IFNULL(sa.Status, ''))
           END AS Attendance
    FROM StudentAttendances sa
    INNER JOIN Students s ON s.Id = sa.StudentId
    INNER JOIN ClassMaster cm ON cm.Id = s.ClassId
    WHERE sa.AttendanceDate >= p_From
      AND sa.AttendanceDate < p_ToExclusive
    ORDER BY s.RollNo;
END $$
DELIMITER ;

-- ---------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS sp_AttendanceReport_SelectGridFiltered;
DELIMITER $$
CREATE PROCEDURE sp_AttendanceReport_SelectGridFiltered(
    IN p_AttFrom DATE,
    IN p_AttToExclusive DATE,
    IN p_NameLike VARCHAR(255),
    IN p_RollNo INT
)
BEGIN
    SELECT s.RollNo,
           s.FirstName,
           s.LastName,
           cm.`Class` AS Class,
           sa.AttendanceDate,
           CASE LOWER(TRIM(sa.Status))
               WHEN 'present' THEN 'Present'
               WHEN 'absent' THEN 'Absent'
               ELSE TRIM(IFNULL(sa.Status, ''))
           END AS Attendance
    FROM StudentAttendances sa
    INNER JOIN Students s ON s.Id = sa.StudentId
    INNER JOIN ClassMaster cm ON cm.Id = s.ClassId
    WHERE sa.AttendanceDate >= p_AttFrom
      AND sa.AttendanceDate < p_AttToExclusive
      AND (
          p_NameLike IS NULL
          OR s.FirstName LIKE p_NameLike
          OR s.LastName LIKE p_NameLike
          OR CONCAT(TRIM(IFNULL(s.FirstName, '')), ' ', TRIM(IFNULL(s.LastName, ''))) LIKE p_NameLike
      )
      AND (p_RollNo IS NULL OR s.RollNo = p_RollNo)
    ORDER BY sa.AttendanceDate DESC, s.RollNo;
END $$
DELIMITER ;

-- ---------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS sp_Students_CountActiveInClass;
DELIMITER $$
CREATE PROCEDURE sp_Students_CountActiveInClass(
    IN p_ClassId INT,
    IN p_ExcludeStudentId INT
)
BEGIN
    SELECT COUNT(*) AS Cnt
    FROM Students
    WHERE ClassId = p_ClassId
      AND Active = 1
      AND (p_ExcludeStudentId IS NULL OR Id <> p_ExcludeStudentId);
END $$
DELIMITER ;

-- ---------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS sp_Students_CountByClassAndRollNo;
DELIMITER $$
CREATE PROCEDURE sp_Students_CountByClassAndRollNo(
    IN p_ClassId INT,
    IN p_RollNo INT,
    IN p_ExcludeStudentId INT
)
BEGIN
    SELECT COUNT(*) AS Cnt
    FROM Students
    WHERE ClassId = p_ClassId
      AND RollNo = p_RollNo
      AND (p_ExcludeStudentId IS NULL OR Id <> p_ExcludeStudentId);
END $$
DELIMITER ;

-- ---------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS sp_Generic_SelectAll;
DELIMITER $$
CREATE PROCEDURE sp_Generic_SelectAll(IN p_Table VARCHAR(64))
BEGIN
    IF p_Table = 'Students' THEN
        SELECT * FROM Students;
    ELSEIF p_Table = 'Users' THEN
        SELECT * FROM Users;
    ELSE
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'sp_Generic_SelectAll: table not allowed (use Students or Users).';
    END IF;
END $$
DELIMITER ;

-- ---------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS sp_Generic_SelectById;
DELIMITER $$
CREATE PROCEDURE sp_Generic_SelectById(IN p_Table VARCHAR(64), IN p_Id INT)
BEGIN
    IF p_Table = 'Students' THEN
        SELECT * FROM Students WHERE Id = p_Id LIMIT 1;
    ELSEIF p_Table = 'Users' THEN
        SELECT * FROM Users WHERE Id = p_Id LIMIT 1;
    ELSE
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'sp_Generic_SelectById: table not allowed (use Students or Users).';
    END IF;
END $$
DELIMITER ;
