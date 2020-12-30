BEGIN TRANSACTION;

INSERT INTO claim_status(status) VALUES('Submitted');
INSERT INTO claim_status(status) VALUES('Approved');
INSERT INTO claim_status(status) VALUES('Denied');
INSERT INTO claim_status(status) VALUES('Completed');

COMMIT;