BEGIN TRANSACTION;

INSERT INTO pothole_status (status) Values('Inspected');
INSERT INTO pothole_status (status) Values('Reported');
INSERT INTO pothole_status (status) Values('Completed');
INSERT INTO pothole_status (status) Values('Deleted');

INSERT INTO severity (severity) Values ('Low');
INSERT INTO severity (severity) Values ('Medium');
INSERT INTO severity (severity) Values ('High');
INSERT INTO severity (severity) Values ('Not Inspected');


COMMIT;