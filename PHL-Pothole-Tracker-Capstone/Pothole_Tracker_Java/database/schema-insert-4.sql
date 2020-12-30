BEGIN TRANSACTION;

INSERT INTO claims (claim_id, amount, description, claim_status_id) VALUES(DEFAULT, 500.00, 'My car hit a large pothole at 12th and Arch', 5);
INSERT INTO claims (claim_id, amount, description, claim_status_id) VALUES(DEFAULT, 200.00, 'My car smashed a large pothole at 5th and Washington', 7);
INSERT INTO claims (claim_id, amount, description, claim_status_id) VALUES(DEFAULT, 300.00, 'My car hit a large pothole at 12th and Arch', 5);
INSERT INTO claims (claim_id, amount, description, claim_status_id) VALUES(DEFAULT, 350.00, 'My car hit a large pothole at 12th and Arch', 5);

INSERT INTO claims_history(claim_history_id, claim_id, amount, description, claim_status_id, datetime) VALUES(DEFAULT,(SELECT claim_id FROM claims WHERE amount = '500.00'), 500.00, 'My car hit a large pothole at 12th and Arch', 5, CURRENT_TIMESTAMP);
INSERT INTO claims_history(claim_history_id, claim_id, amount, description, claim_status_id, datetime) VALUES(DEFAULT,(SELECT claim_id FROM claims WHERE amount = '200.00'), 200.00, 'My car smashed a large pothole at 5th and Washington', 7, CURRENT_TIMESTAMP);
INSERT INTO claims_history(claim_history_id, claim_id, amount, description, claim_status_id, datetime) VALUES(DEFAULT,(SELECT claim_id FROM claims WHERE amount = '300.00'), 300.00, 'My car hit a large pothole at 12th and Arch', 5, CURRENT_TIMESTAMP);
INSERT INTO claims_history(claim_history_id, claim_id, amount, description, claim_status_id, datetime) VALUES(DEFAULT,(SELECT claim_id FROM claims WHERE amount = '350.00'), 350.00, 'My car hit a large pothole at 12th and Arch', 5, CURRENT_TIMESTAMP);

COMMIT;