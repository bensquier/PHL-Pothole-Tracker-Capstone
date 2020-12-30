BEGIN;
CREATE TABLE users_images (
  user_id int NOT NULL,
  image_id int NOT NULL,
  CONSTRAINT FK_user_id FOREIGN KEY (user_id) REFERENCES users (user_id),
  CONSTRAINT FK_image_id FOREIGN KEY (image_id) REFERENCES images (image_id)
);
CREATE TABLE users_comments (
  user_id int NOT NULL,
  comment_id int NOT NULL,
  CONSTRAINT FK_user_id FOREIGN KEY (user_id) REFERENCES users (user_id),
  CONSTRAINT FK_comment_id FOREIGN KEY (comment_id) REFERENCES comments (comment_id)
);
CREATE TABLE users_claims (
  user_id int NOT NULL,
  claim_id int NOT NULL,
  CONSTRAINT FK_user_id FOREIGN KEY (user_id) REFERENCES users (user_id),
  CONSTRAINT FK_claim_id FOREIGN KEY (claim_id) REFERENCES claims (claim_id)

);
COMMIT;