BEGIN TRANSACTION;

DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS potholes;
DROP TABLE IF EXISTS users_potholes;
DROP TABLE IF EXISTS locations;
DROP TABLE IF EXISTS pothole_status;
DROP TABLE IF EXISTS severity;
DROP TABLE IF EXISTS claims;
DROP TABLE IF EXISTS potholes_claims;
DROP TABLE IF EXISTS claims_status;
DROP TABLE IF EXISTS potholes_comments;
DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS potholes_images;
DROP TABLE IF EXISTS images;

DROP SEQUENCE IF EXISTS seq_user_id;
DROP SEQUENCE IF EXISTS seq_pothole_id;
DROP SEQUENCE IF EXISTS seq_location_id;
DROP SEQUENCE IF EXISTS seq_image_id;
DROP SEQUENCE IF EXISTS seq_comment_id;
DROP SEQUENCE IF EXISTS seq_claim_id;
DROP SEQUENCE IF EXISTS seq_claim_status_id;
DROP SEQUENCE IF EXISTS seq_severity_id;
DROP SEQUENCE IF EXISTS seq_pothole_status_id;


CREATE SEQUENCE seq_user_id
  INCREMENT BY 1
  NO MAXVALUE
  NO MINVALUE
  CACHE 1;
  
CREATE SEQUENCE seq_pothole_id
  INCREMENT BY 1
  NO MAXVALUE
  NO MINVALUE
  CACHE 1;
  
CREATE SEQUENCE seq_location_id
  INCREMENT BY 1
  NO MAXVALUE
  NO MINVALUE
  CACHE 1;

CREATE SEQUENCE seq_image_id
  INCREMENT BY 1
  NO MAXVALUE
  NO MINVALUE
  CACHE 1;

CREATE SEQUENCE seq_comment_id
  INCREMENT BY 1
  NO MAXVALUE
  NO MINVALUE
  CACHE 1;

CREATE SEQUENCE seq_claim_id
  INCREMENT BY 1
  NO MAXVALUE
  NO MINVALUE
  CACHE 1;
  
CREATE SEQUENCE seq_claim_status_id
  INCREMENT BY 1
  NO MAXVALUE
  NO MINVALUE
  CACHE 1;

CREATE SEQUENCE seq_severity_id
  INCREMENT BY 1
  NO MAXVALUE
  NO MINVALUE
  CACHE 1;

CREATE SEQUENCE seq_pothole_status_id
  INCREMENT BY 1
  NO MAXVALUE
  NO MINVALUE
  CACHE 1;

CREATE TABLE users (
	user_id int DEFAULT nextval('seq_user_id'::regclass) NOT NULL,
	username varchar(50) NOT NULL,
	password_hash varchar(200) NOT NULL,
	role varchar(50) NOT NULL,
	CONSTRAINT PK_user PRIMARY KEY (user_id)
);

CREATE TABLE locations (
  location_id int DEFAULT nextval('seq_location_id'::regclass) NOT NULL,
  lat numeric NOT NULL,
  lng numeric NOT NULL,
  roadname varchar(50),
  direction varchar(50),
  lane varchar(50),
  CONSTRAINT PK_location PRIMARY KEY (location_id)
);

CREATE TABLE images (
  image_id int DEFAULT nextval('seq_image_id'::regclass) NOT NULL,
  image_url varchar(500) NOT NULL,
  CONSTRAINT PK_image_id PRIMARY KEY (image_id)
);

CREATE TABLE comments (
  comment_id int DEFAULT nextval('seq_comment_id'::regclass) NOT NULL,
  user_comment varchar(280) NOT NULL,
  posted_at timestamp NOT NULL,
  CONSTRAINT PK_comment_id PRIMARY KEY (comment_id)
);

CREATE TABLE claim_status (
  claim_status_id int DEFAULT nextval('seq_claim_status_id'::regclass) NOT NULL,
  status varchar(50) NOT NULL,
  CONSTRAINT PK_claim_status_id PRIMARY KEY (claim_status_id)
);

CREATE TABLE severity (
  severity_id int DEFAULT nextval('seq_severity_id'::regclass) NOT NULL,
  severity varchar(50) NOT NULL,
  CONSTRAINT PK_severity_id PRIMARY KEY (severity_id)
);

CREATE TABLE pothole_status (
  pothole_status_id int DEFAULT nextval('seq_pothole_status_id'::regclass) NOT NULL,
  status varchar(50) NOT NULL,
  CONSTRAINT PK_pothole_status_id PRIMARY KEY (pothole_status_id)
);

CREATE TABLE claims (
  claim_id int DEFAULT nextval('seq_claim_id'::regclass) NOT NULL,
  amount money NOT NULL,
  description varchar(280) NOT NULL,
  claim_status_id int NOT NULL,
  CONSTRAINT PK_claim_id PRIMARY KEY (claim_id),
  CONSTRAINT FK_claim_status_id FOREIGN KEY (claim_status_id) REFERENCES claim_status (claim_status_id)
);

CREATE TABLE potholes (
  pothole_id int DEFAULT nextval('seq_pothole_id'::regclass) NOT NULL,
  location_id int NOT NULL,
  pothole_status_id int NOT NULL,
  severity_id int NOT NULL,
  CONSTRAINT FK_location_id FOREIGN KEY (location_id) REFERENCES locations (location_id),
  CONSTRAINT FK_pothole_status_id FOREIGN KEY (pothole_status_id) REFERENCES pothole_status (pothole_status_id),
  CONSTRAINT FK_severity_id FOREIGN KEY (severity_id) REFERENCES severity (severity_id),
  CONSTRAINT PK_potholes PRIMARY KEY (pothole_id)
);

CREATE TABLE users_potholes (
  user_id int NOT NULL,
  pothole_id int NOT NULL,
  CONSTRAINT FK_user_id FOREIGN KEY (user_id) REFERENCES users (user_id),
  CONSTRAINT FK_pothole_id FOREIGN KEY (pothole_id) REFERENCES potholes (pothole_id)
);

CREATE TABLE potholes_images (
  pothole_id int NOT NULL,
  image_id int NOT NULL,
  CONSTRAINT FK_pothole_id FOREIGN KEY (pothole_id) REFERENCES potholes (pothole_id),
  CONSTRAINT FK_image_id FOREIGN KEY (image_id) REFERENCES images (image_id)
);

CREATE TABLE potholes_comments (
  pothole_id int NOT NULL,
  comment_id int NOT NULL,
  CONSTRAINT FK_pothole_id FOREIGN KEY (pothole_id) REFERENCES potholes (pothole_id),
  CONSTRAINT FK_comment_id FOREIGN KEY (comment_id) REFERENCES comments (comment_id)
);

CREATE TABLE potholes_claims (
  pothole_id int NOT NULL,
  claim_id int NOT NULL,
  CONSTRAINT FK_pothole_id FOREIGN KEY (pothole_id) REFERENCES potholes (pothole_id),
  CONSTRAINT FK_claim_id FOREIGN KEY (claim_id) REFERENCES claims (claim_id)
);


INSERT INTO users (username,password_hash,role) VALUES ('user','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('admin','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_ADMIN');

COMMIT TRANSACTION;