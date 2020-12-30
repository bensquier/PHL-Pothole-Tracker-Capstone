Begin;

INSERT INTO potholes (pothole_id, pothole_status_id, severity_id, lat, lng) VALUES(DEFAULT, 1, 4, 39.9451, -75.1702);
INSERT INTO potholes (pothole_id, pothole_status_id, severity_id, lat, lng) VALUES(DEFAULT, 1, 4, 39.9468, -75.1666);
INSERT INTO potholes (pothole_id, pothole_status_id, severity_id, lat, lng) VALUES(DEFAULT, 1, 4, 39.9594, -75.1499);
INSERT INTO potholes (pothole_id, pothole_status_id, severity_id, lat, lng) VALUES(DEFAULT, 1, 4, 39.9654, -75.1660);


INSERT INTO potholes_history (pothole_id, pothole_status_id, severity_id, lat, lng, datetime) VALUES((Select pothole_id From potholes where lat = 39.9451), 1, 4, 39.9451, -75.1702, CURRENT_TIMESTAMP);
INSERT INTO potholes_history (pothole_id, pothole_status_id, severity_id, lat, lng, datetime) VALUES((Select pothole_id From potholes where lat = 39.9468), 1, 4, 39.9468, -75.1666, CURRENT_TIMESTAMP);
INSERT INTO potholes_history (pothole_id, pothole_status_id, severity_id, lat, lng, datetime) VALUES((Select pothole_id From potholes where lat = 39.9594), 1, 4, 39.9594, -75.1499, CURRENT_TIMESTAMP);
INSERT INTO potholes_history (pothole_id, pothole_status_id, severity_id, lat, lng, datetime) VALUES((Select pothole_id From potholes where lat = 39.9654), 1, 4, 39.9654, -75.1660, CURRENT_TIMESTAMP);

Commit;