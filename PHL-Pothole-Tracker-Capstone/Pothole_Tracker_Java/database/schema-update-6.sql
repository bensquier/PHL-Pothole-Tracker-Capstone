BEGIN;
ALTER TABLE claims
  DROP COLUMN amount;
ALTER TABLE claims
  ADD COLUMN amount numeric(10,2);
ALTER TABLE claims_history
  DROP COLUMN amount;
ALTER TABLE claims_history
  ADD COLUMN amount numeric(10,2);
COMMIT;