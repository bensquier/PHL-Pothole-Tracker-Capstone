BEGIN;
GRANT SELECT, INSERT, UPDATE, DELETE
  ON ALL TABLES IN SCHEMA public
  TO final_capstone_appuser;
ALTER TABLE claims_history
  DROP CONSTRAINT fk_claim_id;
COMMIT;