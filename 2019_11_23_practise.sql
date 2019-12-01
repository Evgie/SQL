/*1. WorldEvents db – создать хранимку, которая показывает все
ивенты произошедшие в Августе.*/
CREATE PROCEDURE August_Events
AS
BEGIN
	SELECT *
	FROM tblEvent
	WHERE EventDate LIKE '____-08-__'
END;

EXECUTE August_Events;

/*2. WorldEvents db – создать хранимку, которая показывает все
страны с ContinentId равным 1 в алфавитном порядке.*/
CREATE PROCEDURE ShowContinentID
AS
BEGIN
	SELECT *
	FROM tblCountry
	WHERE ContinentID = 1
	ORDER BY CountryName
END;

/*3.  Doctor Who db – Создать хранимку, которая считает все
эпизоды в которых Доктором был Matt Smith.*/
CREATE PROCEDURE DoctorMatt
AS
BEGIN
	SELECT COUNT(*)
	FROM tblEpisode
	WHERE DoctorId = (
			SELECT DoctorId
			FROM tblDoctor
			WHERE DoctorName = 'Matt Smith'
			)
END;

EXECUTE DoctorMatt;

/*4.  Doctor Who db – создать хранимку, которая выводит все
эпизоды с определённым актером (актер параметр).*/
CREATE PROCEDURE DoctorActor @name NVARCHAR(30)
AS
BEGIN
	SELECT *
	FROM tblEpisode
	WHERE DoctorId = (
			SELECT DoctorId
			FROM tblDoctor
			WHERE DoctorName = @name
			)
END;

EXECUTE DoctorActor 'Peter Capaldi';

/*5. Doctor Who db - создать хранимку, которая выводит 3
наиболее часто снимающихся companions.*/
SELECT TOP (3) CompanionName
	,COUNT(*) AS NumberOfEpisodes
FROM tblCompanion
INNER JOIN tblEpisodeCompanion ON tblCompanion.CompanionId = tblEpisodeCompanion.CompanionId
INNER JOIN tblEpisode ON tblEpisodeCompanion.EpisodeId = tblEpisode.EpisodeId
GROUP BY CompanionName
ORDER BY NumberOfEpisodes DESC;

/*Triggers
1. WorldEvents db – написать триггер, который будет
отслеживать изменение аттрибута CountryName (UPDATE) в
таблице Country. Если при приходит пустое значение, то
оставлять старое значение. Также триггер должен вносить все
изменения CountryName в отдельную таблицу.*/
CREATE TRIGGER trg_CountryName_change ON tblCountry
INSTEAD OF UPDATE
AS
BEGIN
	IF (
			(
				SELECT CountryName
				FROM inserted
				) IS NOT NULL
			)
		AND (
			(
				SELECT CountryName
				FROM inserted
				) != ''
			)
	BEGIN
		INSERT INTO CountryNameHistory
		SELECT CountryID
			,CountryName
		FROM inserted;

		UPDATE tblCountry
		SET CountryName = (
				SELECT CountryName
				FROM inserted
				)
		WHERE CountryID = (
				SELECT CountryID
				FROM inserted
				)
	END;
END;

/*2. Любая БД – создать триггер на базу данных, который будет
создавать (если не существует) таблицу и трэкать все
изменения в базе данных в формате EventType, PostTime ,
ObjectName , CommandText используя EVENTDATA() объект.*/
CREATE TRIGGER trg_WorldEvents_changes ON DATABASE
FOR CREATE_TABLE
	,ALTER_TABLE
	,DROP_TABLE AS

BEGIN
	--DECLARE @Data AS XML;
	DECLARE @EventType NVARCHAR(max);
	DECLARE @ObjectName NVARCHAR(max);
	DECLARE @CommandText NVARCHAR(max);
	DECLARE @PostTime NVARCHAR(max);

	SET @EventType = EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]', 'NVARCHAR(max)');
	SET @ObjectName = EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]', 'NVARCHAR(max)');
	SET @CommandText = EVENTDATA().value('(/EVENT_INSTANCE/TSQLCommand/CommandText)[1]', 'nvarchar(max)');
	SET @PostTime = EVENTDATA().value('(/EVENT_INSTANCE/PostTime)[1]', 'NVARCHAR(max)');

	IF NOT EXISTS (
			SELECT 1
			FROM SYSOBJECTS
			WHERE NAME = 'changes_log_2'
				AND xtype = 'U'
			)
	BEGIN
		CREATE TABLE changes_log_2 (
			Event_type NVARCHAR(max)
			,Post_time NVARCHAR(max)
			,O_bjectName NVARCHAR(max)
			,Command_text NVARCHAR(max)
			)
	END;

	INSERT changes_log_2
	VALUES (
		@EventType
		,@PostTime
		,@ObjectName
		,@CommandText
		);
END;
