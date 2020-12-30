BEGIN;
ALTER TABLE potholes
  ADD COLUMN lat numeric NOT NULL,
  ADD COLUMN lng numeric NOT NULL,
  ADD COLUMN roadname varchar(50),
  ADD COLUMN direction varchar(50),
  ADD COLUMN lane varchar(50),
  DROP CONSTRAINT FK_location_id,
  DROP COLUMN location_id;
  DROP TABLE IF EXISTS locations;
COMMIT;
