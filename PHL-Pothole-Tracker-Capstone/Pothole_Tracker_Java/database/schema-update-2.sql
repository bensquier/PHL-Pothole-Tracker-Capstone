BEGIN;
CREATE SEQUENCE seq_pothole_history_id
  INCREMENT BY 1
  NO MAXVALUE
  NO MINVALUE
  CACHE 1;

CREATE SEQUENCE seq_claim_history_id
  INCREMENT BY 1
  NO MAXVALUE
  NO MINVALUE
  CACHE 1;

CREATE TABLE potholes_history (
  pothole_history_id int DEFAULT nextval('seq_pothole_history_id'::regclass) NOT NULL,
  pothole_id int NOT NULL,
  pothole_status_id int NOT NULL,
  severity_id int NOT NULL,
  lat numeric NOT NULL,
  lng numeric NOT NULL,
  roadname varchar(50),
  direction varchar(50),
  lane varchar(50),
  datetime timestamp NOT NULL,
  CONSTRAINT FK_pothole_id FOREIGN KEY (pothole_id) REFERENCES potholes (pothole_id),
  CONSTRAINT FK_pothole_status_id FOREIGN KEY (pothole_status_id) REFERENCES pothole_status (pothole_status_id),
  CONSTRAINT FK_severity_id FOREIGN KEY (severity_id) REFERENCES severity (severity_id),
  CONSTRAINT PK_pothole_hist_id PRIMARY KEY (pothole_history_id)
);

CREATE TABLE claims_history (
  claim_history_id int DEFAULT nextval('seq_claim_history_id'::regclass) NOT NULL,
  claim_id int  NOT NULL,
  amount money NOT NULL,
  description varchar(280) NOT NULL,
  claim_status_id int NOT NULL,
  datetime timestamp NOT NULL,
  CONSTRAINT PK_claim_hist_id PRIMARY KEY (claim_history_id),
  CONSTRAINT FK_claim_id FOREIGN KEY (claim_id) REFERENCES claims (claim_id),
  CONSTRAINT FK_claim_status_id FOREIGN KEY (claim_status_id) REFERENCES claim_status (claim_status_id)

);

CREATE TABLE users_potholes_history (
  user_id int NOT NULL,
  pothole_history_id int NOT NULL,
  CONSTRAINT FK_user_id FOREIGN KEY (user_id) REFERENCES users (user_id),
  CONSTRAINT FK_pothole_hist_id FOREIGN KEY (pothole_history_id) REFERENCES potholes_history (pothole_history_id)
);

CREATE TABLE users_claims_history (
  user_id int NOT NULL,
  claim_history_id int NOT NULL,
  CONSTRAINT FK_user_id FOREIGN KEY (user_id) REFERENCES users (user_id),
  CONSTRAINT FK_claim_hist_id FOREIGN KEY (claim_history_id) REFERENCES claims_history (claim_history_id)
);

COMMIT;