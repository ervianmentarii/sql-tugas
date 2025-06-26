CREATE DATABASE Project_uber;

use Project_uber;

set FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS user;
CREATE TABLE user(
    user_id int not null AUTO_INCREMENT,
    nama_user VARCHAR(200),
    no_tlpn_user VARCHAR(200),
    lokasi_user VARCHAR(200),
    PRIMARY KEY(user_id)
)ENGINE=Innodb;

DROP TABLE IF EXISTS driver;
CREATE TABLE driver(
driver_id INT not NULL AUTO_INCREMENT,
user_id int NOT null,
no_telp_driver VARCHAR(200),
lokasi_driver VARCHAR(200),
PRIMARY key(driver_id),
constraint Fk_user_id_driver FOREIGN key(user_id) REFERENCES user(user_id)
)ENGINE=Innodb;

DROP TABLE IF EXISTS rider;
CREATE TABLE rider(
rider_id int NOT NULL AUTO_INCREMENT,
usr_id int not NULL,
no_telpn_rider VARCHAR(200),
lokasi_rider VARCHAR(200),
PRIMARY KEY(rider_id),
constraint Fk_user_id_rider foreign KEY(usr_id)REFERENCES USER(user_id)
)ENGINE=Innodb;

DROP TABLE IF EXISTS vehicletype;
CREATE TABLE vehicletype(
    vehicle_type_id int not null AUTO_INCREMENT,
    tipe_kendaraan ENUM('motor','mobil'),
    PRIMARY KEY(vehicle_type_id)
)ENGINE=Innodb;

DROP TABLE IF EXISTS vehicle;
CREATE TABLE vehicle(
vehicle_id int NOT NULL AUTO_INCREMENT,
driver_id int not NULL,
vehicle_type_id int NOT NULL,
jenis ENUM('UberX','UberXL'),
PRIMARY KEY(vehicle_id),
constraint Fk_driver_id_vehicle foreign  KEY(driver_id)REFERENCES driver(driver_id),
constraint Fk_vehicle_type_id FOREIGN KEY(vehicle_type_id)REFERENCES vehicletype(vehicle_type_id)
)ENGINE=Innodb;

DROP TABLE IF EXISTS license;
CREATE TABLE license(
license_id int not null AUTO_INCREMENT,
driver_id int NOT NULL,
status_licensi VARCHAR(200),
tanggal_licensi VARCHAR(200),
jenis_licensi VARCHAR(200),
PRIMARY KEY(license_id),
constraint Fk_driver_id_license FOREIGN KEY(driver_id)REFERENCES driver(driver_id)
)ENGINE=Innodb;

DROP TABLE IF EXISTS tripstatus;
create table tripstatus(
    trip_status_id int NOT NULL AUTO_INCREMENT,
    nama_status ENUM('aktif','dibatalkan','selesai'),
    PRIMARY KEY(trip_status_id)
)ENGINE=Innodb;

DROP TABLE IF EXISTS promocode;
CREATE TABLE promocode(
    promo_id int not NULL AUTO_INCREMENT,
    kode_promo VARCHAR(200),
    diskon int NOT NULL,
    batas_berlaku varchar(200),
    primary key(promo_id)
)ENGINE=Innodb;

DROP TABLE IF EXISTS trip;
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
    constraint Fk_driver_id_trip FOREIGN KEY(driver_id) REFERENCES driver(driver_id),
    constraint Fk_trip_status_id FOREIGN KEY(trip_status_id) REFERENCES tripstatus(trip_status_id),
    constraint Fk_promo_id_trip FOREIGN KEY(promo_id) REFERENCES promocode(promo_id)

)ENGINE=Innodb;

DROP TABLE IF EXISTS paymentmethod;
CREATE TABLE paymentmethod(
    payment_method_id int not NULL AUTO_INCREMENT,
    nama_metode enum('tunai','qris','e-pay','transfer'),
    PRIMARY key(payment_method_id)
)ENGINE=Innodb;

DROP TABLE IF EXISTS payment;
CREATE TABLE payment(
    payment_id int not NULL AUTO_INCREMENT,
    trip_id int NOT null,
    payment_method_id int NOT NULL,
    jumlah INT not NULL,
    status_pembayaran VARCHAR(200),
    PRIMARY KEY(payment_id) ,
    constraint Fk_trip_id_payment FOREIGN key(trip_id) REFERENCES trip(trip_id),
    constraint Fk_payment_method_id FOREIGN KEY(payment_method_id) REFERENCES paymentmethod(payment_method_id)
)ENGINE=Innodb;

DROP TABLE IF EXISTS rating;
CREATE TABLE rating(
    rating_id int NOT NULL AUTO_INCREMENT,
    trip_id int not null,
    user_id INT NOT NULL,
    nilai_rating ENUM('baik','buruk'),
    komentar VARCHAR(200),
    PRIMARY key(rating_id),
    constraint Fk_trip_id_rating FOREIGN key(trip_id) REFERENCES trip(trip_id),
    constraint FK_user_id_rating FOREIGN key(user_id) REFERENCES user(user_id)
)ENGINE=Innodb;

DROP TABLE IF EXISTS location;
CREATE TABLE location(
    location_id int NOT null AUTO_INCREMENT,
    user_id int not NULL,
    label VARCHAR(200),
    latitude DECIMAL,
    longitude DECIMAL,
    primary KEY(location_id),
    constraint Fk_user_id_location FOREIGN KEY(user_id) REFERENCES user(user_id)
    
)ENGINE=Innodb;

DROP TABLE IF EXISTS  triproute;
CREATE TABLE triproute(
trip_route_id INT NOT NULL AUTO_INCREMENT,
trip_id int not NULL,
titik_awal VARCHAR(200),
titk_tengah VARCHAR(200),
titik_akhir VARCHAR(200),
PRIMARY KEY(trip_route_id),
constraint Fk_trip_id_triproute FOREIGN KEY(trip_id) REFERENCES trip(trip_id)
)ENGINE=Innodb;

DROP TABLE IF EXISTS Notification;
CREATE TABLE Notification(
notification_id INT NOT NULL AUTO_INCREMENT,
user_id int not NULL,
isi_pesan VARCHAR(200),
waktu_dikirim VARCHAR(200),
dibaca_status VARCHAR(200),
PRIMARY KEY(notification_id),
constraint Fk_user_id_notification FOREIGN KEY(user_id) REFERENCES user(user_id)
)ENGINE=Innodb;

DROP TABLE IF EXISTS SupportCategory;
CREATE TABLE SupportCategory(
support_category_id INT NOT NULL AUTO_INCREMENT,
nama_kategori VARCHAR(200),
PRIMARY KEY(support_category_id)
)ENGINE=Innodb;

DROP TABLE IF EXISTS SupportTicket;
CREATE TABLE SupportTicket(
ticket_id INT NOT NULL AUTO_INCREMENT,
user_id int not NULL,
support_category_id int NOT NULL,
isi_ticket VARCHAR(200),
status_ticket VARCHAR(200),

PRIMARY KEY(ticket_id),
constraint Fk_user_id_supportticket FOREIGN KEY(user_id) REFERENCES user(user_id),
constraint Fk_support_category_id FOREIGN KEY(support_category_id) REFERENCES SupportCategory(support_category_id)
)ENGINE=Innodb;

DROP TABLE IF EXISTS DriverAvailability;
CREATE TABLE DriverAvailability(
availability_id INT NOT NULL AUTO_INCREMENT,
driver_id int not NULL,
status ENUM('aktif','tidak'),
waktu TIMESTAMP,
PRIMARY KEY(availability_id),
constraint Fk_user_id_driveravailability FOREIGN KEY(driver_id) REFERENCES driver(driver_id)
)ENGINE=Innodb;

DROP TABLE IF EXISTS PricingPolicy;
CREATE TABLE  PricingPolicy(
    policy_id int NOT NULL AUTO_INCREMENT,
    dasar_harga int NOT null,
    per_km int not NULL,
    per_menit int not null,
    PRIMARY Key(policy_id)
)ENGINE=Innodb;

DROP TABLE IF EXISTS  trippromo;
create table trippromo(
    trip_promo_id int not NULL AUTO_INCREMENT,
    trip_id int NOT NULL,
    promo_id INT NOT NULL,
    jumlah_diskon INT NOT NULL,
    PRIMARY KEY(trip_promo_id),
    constraint Fk_trip_id_trippromo FOREIGN KEY(trip_id) REFERENCES trip(trip_id),
    constraint fk_trip_id_promo_id FOREIGN KEY(promo_id) REFERENCES promocode(promo_id)
    
)engine=Innodb;

DROP TABLE IF EXISTS  Feedback;
create table Feedback
(
feedback_id INT not NULL AUTO_INCREMENT,
user_id int not NULL,
submitted_at VARCHAR(200) not NULL,
feedback_text TEXT,
response_status VARCHAR(200),
PRIMARY KEY(feedback_id),
constraint Fk_user_id_feedback FOREIGN KEY(user_id)REFERENCES user(user_id)

)ENGINE=Innodb;

DROP TABLE IF EXISTS LoginHistory;
create table LoginHistory
(
login_id INT not NULL AUTO_INCREMENT,
user_id int not NULL,
waktu_login VARCHAR(200) not NULL,
PRIMARY KEY(login_id),
constraint Fk_user_id_loginhistory FOREIGN KEY(user_id)REFERENCES user(user_id)
)ENGINE=Innodb;

DROP TABLE IF EXISTS Device;
create table  Device
(
device_id INT not NULL AUTO_INCREMENT,
user_id int not NULL,
device_type VARCHAR(200) ,
os_version VARCHAR(200),
last_login VARCHAR(200),
PRIMARY KEY(device_id),
constraint Fk_user_id_device FOREIGN KEY(user_id)REFERENCES user(user_id)
)ENGINE=Innodb;

DROP TABLE IF EXISTS Report;
create table Report
(
 report_id INT not NULL AUTO_INCREMENT,
 trip_id int not NULL,
user_id INT not NULL,
isi_laporan TEXT,
waktu TIMESTAMP,
PRIMARY KEY(report_id),
constraint Fk_user_id_report FOREIGN KEY(user_id)REFERENCES user(user_id),
constraint Fk_trip_id_report FOREIGN key(trip_id) REFERENCES trip(trip_id)
)ENGINE=Innodb;

DROP TABLE IF EXISTS referal;
CREATE TABLE referal(
    referal_id int not NULL AUTO_INCREMENT,
    user_id int not null,
    reffered_user_id int ,
    kode_refferal VARCHAR(200),
    tanggal_penggunaan DATE,
    PRIMARY key(referal_id),
    constraint Fk_user_id_referal FOREIGN KEY(user_id) REFERENCES user(user_id)

 )engine=Innodb;

