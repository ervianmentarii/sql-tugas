SHOW DATABASES;
CREATE DATABASE uber;
use uber;
show TABLES;
DROP TABLE promdocode;
CREATE TABLE user(
    user_id int not null AUTO_INCREMENT,
    nama_user VARCHAR(200),
    no_tlpn_user VARCHAR(200),
    lokasi_user VARCHAR(200),
    PRIMARY KEY(user_id)

)ENGINE=Innodb;

CREATE TABLE driver(
driver_id INT not NULL AUTO_INCREMENT,
user_id int NOT null,
no_telp_driver VARCHAR(200),
lokasi_driver VARCHAR(200),
PRIMARY key(driver_id),
FOREIGN key(user_id) REFERENCES user(user_id)
)ENGINE=Innodb;

CREATE TABLE rider(
rider_id int NOT NULL AUTO_INCREMENT,
usr_id int not NULL,
no_telpn_rider VARCHAR(200),
lokasi_rider VARCHAR(200),
PRIMARY KEY(rider_id),
FOREIGN KEY(usr_id)REFERENCES USER(user_id)
)ENGINE=Innodb;

CREATE TABLE vehicletype(
    vehicle_type_id int not null AUTO_INCREMENT,
    tipe_kendaraan ENUM('motor','mobil'),
    PRIMARY KEY(vehicle_type_id)
)ENGINE=Innodb;

CREATE TABLE vehicle(
vehicle_id int NOT NULL AUTO_INCREMENT,
driver_id int not NULL,
vehicle_type_id int NOT NULL,
jenis ENUM('UberX','UberXL'),
PRIMARY KEY(vehicle_id),
FOREIGN KEY(driver_id)REFERENCES driver(driver_id),
FOREIGN KEY(vehicle_type_id)REFERENCES vehicletype(vehicle_type_id)
)ENGINE=Innodb;

CREATE TABLE license(
license_id int not null AUTO_INCREMENT,
driver_id int NOT NULL,
status_licensi VARCHAR(200),
tanggal_licensi VARCHAR(200),
jenis_licensi VARCHAR(200),
PRIMARY KEY(license_id),
FOREIGN KEY(driver_id)REFERENCES driver(driver_id)
)ENGINE=Innodb;

create table tripstatus(
    trip_status_id int NOT NULL AUTO_INCREMENT,
    nama_status ENUM('aktif','dibatalkan','selesai'),
    PRIMARY KEY(trip_status_id)
)ENGINE=Innodb;

CREATE TABLE promocode(
    promo_id int not NULL AUTO_INCREMENT,
    kode_promo VARCHAR(200),
    diskon int NOT NULL,
    batas_berlaku varchar(200),
    primary key(promo_id)
)ENGINE=Innodb;

CREATE TABLE trip(
    trip_id INT NOT NULL AUTO_INCREMENT,
    driver_id int NOT NULL,
    trip_status_id INT NOT NULL,
    promo_id int NOT NULL,
    waktu_mulai VARCHAR(200),
    waktu_selesai VARCHAR(200),
    biaya VARCHAR(200),
    lokasi_awal VARCHAR(200),
    lokasi_tujuan VARCHAR(200),
    PRIMARY key(trip_id),
    FOREIGN KEY(driver_id) REFERENCES driver(driver_id),
    FOREIGN KEY(trip_status_id) REFERENCES tripstatus(trip_status_id),
    FOREIGN KEY(promo_id) REFERENCES promocode(promo_id)

)ENGINE=Innodb;

CREATE TABLE paymentmethod(
    payment_method_id int not NULL AUTO_INCREMENT,
    nama_metode enum('tunai','qris','e-pay','transfer'),
    PRIMARY key(payment_method_id)
)ENGINE=Innodb;

CREATE TABLE payment(
    payment_id int not NULL AUTO_INCREMENT,
    trip_id int NOT null,
    payment_method_id int NOT NULL,
    jumlah INT not NULL,
    status_pembayaran VARCHAR(200),
    PRIMARY KEY(payment_id) ,
    FOREIGN key(trip_id) REFERENCES trip(trip_id),
    FOREIGN KEY(payment_method_id) REFERENCES paymentmethod(payment_method_id)
)ENGINE=Innodb;

CREATE TABLE rating(
    rating_id int NOT NULL AUTO_INCREMENT,
    trip_id int not null,
    user_id INT NOT NULL,
    nilai_rating ENUM('baik','buruk'),
    komentar VARCHAR(200),
    PRIMARY key(rating_id),
    FOREIGN key(trip_id) REFERENCES trip(trip_id),
    FOREIGN key(user_id) REFERENCES user(user_id)
)ENGINE=Innodb;

CREATE TABLE location(
    location_id int NOT null AUTO_INCREMENT,
    user_id int not NULL,
    label VARCHAR(200),
    latitude DECIMAL,
    longitude DECIMAL,
    primary KEY(location_id),
    FOREIGN KEY(user_id) REFERENCES user(user_id)
    
)ENGINE=Innodb;


CREATE TABLE triproute(
trip_route_id INT NOT NULL AUTO_INCREMENT,
trip_id int not NULL,
titik_awal VARCHAR(200),
titk_tengah VARCHAR(200),
titik_akhir VARCHAR(200),
PRIMARY KEY(trip_route_id),
FOREIGN KEY(trip_id) REFERENCES trip(trip_id)

)ENGINE=Innodb;

CREATE TABLE Notification(
notification_id INT NOT NULL AUTO_INCREMENT,
user_id int not NULL,
isi_pesan VARCHAR(200),
waktu_dikirim VARCHAR(200),
dibaca_status VARCHAR(200),
PRIMARY KEY(notification_id),
FOREIGN KEY(user_id) REFERENCES user(user_id)

)ENGINE=Innodb;

CREATE TABLE SupportCategory(
support_category_id INT NOT NULL AUTO_INCREMENT,
nama_kategori VARCHAR(200),
PRIMARY KEY(support_category_id)
)ENGINE=Innodb;

CREATE TABLE SupportTicket(
ticket_id INT NOT NULL AUTO_INCREMENT,
user_id int not NULL,
support_category_id int NOT NULL,
isi_ticket VARCHAR(200),
status_ticket VARCHAR(200),

PRIMARY KEY(ticket_id),
FOREIGN KEY(user_id) REFERENCES user(user_id),
FOREIGN KEY(support_category_id) REFERENCES SupportCategory(support_category_id)
)ENGINE=Innodb;



CREATE TABLE DriverAvailability(
availability_id INT NOT NULL AUTO_INCREMENT,
driver_id int not NULL,
status ENUM('aktif','tidak'),
waktu TIMESTAMP,
PRIMARY KEY(availability_id),
FOREIGN KEY(driver_id) REFERENCES driver(driver_id)
)ENGINE=Innodb;

CREATE TABLE  PricingPolicy(
    policy_id int NOT NULL AUTO_INCREMENT,
    dasar_harga int NOT null,
    per_km int not NULL,
    per_menit int not null,
    PRIMARY Key(policy_id)
)ENGINE=Innodb;



create table trippromo(
    trip_promo_id int not NULL AUTO_INCREMENT,
    trip_id int NOT NULL,
    promo_id INT NOT NULL,
    jumlah_diskon INT NOT NULL,
    PRIMARY KEY(trip_promo_id),
    FOREIGN KEY(trip_id) REFERENCES trip(trip_id),
    FOREIGN KEY(promo_id) REFERENCES promocode(promo_id)
    
)engine=Innodb;

create table Feedback
(
feedback_id INT not NULL AUTO_INCREMENT,
user_id int not NULL,
submitted_at VARCHAR(200) not NULL,
feedback_text TEXT,
response_status VARCHAR(200),
PRIMARY KEY(feedback_id),
FOREIGN KEY(user_id)REFERENCES user(user_id)


)ENGINE=Innodb;

create table LoginHistory
(
login_id INT not NULL AUTO_INCREMENT,
user_id int not NULL,
waktu_login VARCHAR(200) not NULL,
PRIMARY KEY(login_id),
FOREIGN KEY(user_id)REFERENCES user(user_id)
)ENGINE=Innodb;

create table  Device
(
device_id INT not NULL AUTO_INCREMENT,
user_id int not NULL,
device_type VARCHAR(200) ,
os_version VARCHAR(200),
last_login VARCHAR(200),
PRIMARY KEY(device_id),
FOREIGN KEY(user_id)REFERENCES user(user_id)


)ENGINE=Innodb;

create table Report
(
 report_id INT not NULL AUTO_INCREMENT,
 trip_id int not NULL,
user_id INT not NULL,
isi_laporan TEXT,
waktu TIMESTAMP,
PRIMARY KEY(report_id),
FOREIGN KEY(user_id)REFERENCES user(user_id),
FOREIGN key(trip_id) REFERENCES trip(trip_id)
)ENGINE=Innodb;

CREATE TABLE referal(
    referal_id int not NULL AUTO_INCREMENT,
    user_id int not null,
    reffered_user_id int ,
    kode_refferal VARCHAR(200),
    tanggal_penggunaan DATE,
    PRIMARY key(referal_id),
    FOREIGN KEY(user_id) REFERENCES user(user_id)


 )engine=Innodb;



INSERT INTO user (nama_user, no_tlpn_user, lokasi_user) VALUES
('Andi Saputra', '081234567890', 'Medan'),
('Siti Aminah', '082345678901', 'Binjai'),
('Budi Hartono', '083456789012', 'Lubuk Pakam');

INSERT INTO driver (user_id, no_telp_driver, lokasi_driver) VALUES
(1, '081234567890', 'Medan'),
(2, '082345678901', 'Binjai');

INSERT INTO rider (usr_id, no_telpn_rider, lokasi_rider) VALUES
(3, '083456789012', 'Lubuk Pakam');

INSERT INTO vehicletype (tipe_kendaraan) VALUES
('mobil'), ('motor');

INSERT INTO vehicle (driver_id, vehicle_type_id, jenis) VALUES
(1, 1, 'UberX'),
(2, 2, 'UberXL');

INSERT INTO license (driver_id, status_licensi, tanggal_licensi, jenis_licensi) VALUES
(1, 'aktif', '2024-01-10', 'SIM A'),
(2, 'aktif', '2024-02-20', 'SIM C');

INSERT INTO tripstatus (nama_status) VALUES
('aktif'), ('dibatalkan'), ('selesai');

INSERT INTO promocode (kode_promo, diskon, batas_berlaku) VALUES
('UBERHEMAT', 20000, '2025-06-30');

INSERT INTO trip (driver_id, trip_status_id, promo_id, waktu_mulai, waktu_selesai, biaya, lokasi_awal, lokasi_tujuan) VALUES
(1, 3, 1, '2025-04-25 10:00:00', '2025-04-25 10:45:00', '55000', 'Medan', 'Binjai');

INSERT INTO paymentmethod (nama_metode) VALUES
('tunai'), ('qris'), ('e-pay'), ('transfer');

INSERT INTO payment (trip_id, payment_method_id, jumlah, status_pembayaran) VALUES
(1, 1, 35000, 'selesai');

INSERT INTO rating (trip_id, user_id, nilai_rating, komentar) VALUES
(1, 3, 'baik', 'Driver sangat ramah dan cepat.');

INSERT INTO location (user_id, label, latitude, longitude) VALUES
(1, 'Rumah', 3.5897, 98.6732);

INSERT INTO triproute (trip_id, titik_awal, titk_tengah, titik_akhir) VALUES
(1, 'Medan', 'Sunggal', 'Binjai');

INSERT INTO notification (user_id, isi_pesan, waktu_dikirim, dibaca_status) VALUES
(1, 'Perjalanan Anda telah selesai.', '2025-04-25 10:50:00', 'ya');

INSERT INTO SupportCategory (nama_kategori) VALUES
('Kendala Aplikasi'), ('Pembayaran'), ('Lainnya');

INSERT INTO SupportTicket (user_id, support_category_id, isi_ticket, status_ticket) VALUES
(3, 1, 'Tidak bisa login ke aplikasi', 'terbuka');

INSERT INTO DriverAvailability (driver_id, status, waktu) VALUES
(1, 'aktif', '2025-05-01 06:25:09');

INSERT INTO Feedback (user_id, submitted_at, feedback_text, response_status) VALUES
(3, '2025-04-26 08:15:00', 'Aplikasi kadang lambat saat buka peta.', 'belum ditanggapi');

INSERT INTO Device (user_id, device_type, os_version, last_login) VALUES
(3, 'Android', 'Android 13', '2025-04-26 08:00:00'),
(1, 'iOS', 'iOS 17', '2025-04-26 07:50:00');

INSERT INTO Report (trip_id, user_id, isi_laporan, waktu) VALUES
(1, 3, 'Driver ngebut di jalan tol.', '2025-04-25 11:00:00');

INSERT INTO referal (user_id, reffered_user_id, kode_refferal, tanggal_penggunaan) VALUES
(1, 3, 'REF12345', '2025-04-20');


SELECT* from user;