DROP DATABASE IF EXISTS Project_uber;
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
    user_id int not NULL,
    no_telpn_rider VARCHAR(200),
    lokasi_rider VARCHAR(200),
    PRIMARY KEY(rider_id),
    constraint Fk_user_id_rider foreign KEY(user_id)REFERENCES USER(user_id)
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
    tanggal_licensi DATE,
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
    rider_id int NOT NULL,
    driver_id int NOT NULL,
    trip_status_id INT NOT NULL,
    promo_id int NOT NULL,
    waktu_mulai DATETIME,
    waktu_selesai DATETIME,
    biaya DECIMAL(10,2),
    lokasi_awal VARCHAR(200),
    lokasi_tujuan VARCHAR(200),
    PRIMARY key(trip_id),
    CONSTRAINT Fk_rider_id_trip FOREIGN KEY(rider_id) REFERENCES rider(rider_id),
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
    status_pembayaran ENUM('lunas','belum'),
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
    latitude DECIMAL(10,6),
    longitude DECIMAL(10,6),
    primary KEY(location_id),
    constraint Fk_user_id_location FOREIGN KEY(user_id) REFERENCES user(user_id)
    
)ENGINE=Innodb;

DROP TABLE IF EXISTS  triproute;
CREATE TABLE triproute(
    trip_route_id INT NOT NULL AUTO_INCREMENT,
    trip_id int not NULL,
    titik_awal VARCHAR(200),
    titik_tengah VARCHAR(200),
    titik_akhir VARCHAR(200),
    PRIMARY KEY(trip_route_id),
    constraint Fk_trip_id_triproute FOREIGN KEY(trip_id) REFERENCES trip(trip_id)
)ENGINE=Innodb;

DROP TABLE IF EXISTS Notification;
CREATE TABLE Notification(
    notification_id INT NOT NULL AUTO_INCREMENT,
    user_id int not NULL,
    isi_pesan VARCHAR(200),
    waktu_dikirim TIMESTAMP,
    dibaca_status ENUM('dibaca','belum dibaca'),
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
    status_ticket ENUM("baru","proses","selesai"),
    PRIMARY KEY(ticket_id),
    constraint Fk_user_id_supportticket FOREIGN KEY(user_id) REFERENCES user(user_id),
    constraint Fk_support_category_id FOREIGN KEY(support_category_id) REFERENCES SupportCategory(support_category_id)
)ENGINE=Innodb;

DROP TABLE IF EXISTS DriverAvailability;
CREATE TABLE DriverAvailability(
    availability_id INT NOT NULL AUTO_INCREMENT,
    driver_id int not NULL,
    status ENUM('aktif','tidak') DEFAULT "aktif",
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
    jumlah_diskon DECIMAL(5,2),
    PRIMARY KEY(trip_promo_id),
    constraint Fk_trip_id_trippromo FOREIGN KEY(trip_id) REFERENCES trip(trip_id),
    constraint fk_promo_id_trippromo FOREIGN KEY(promo_id) REFERENCES promocode(promo_id)
)ENGINE=Innodb;

DROP TABLE IF EXISTS  Feedback;
create table Feedback(
    feedback_id INT not NULL AUTO_INCREMENT,
    user_id int not NULL,
    submitted_at DATETIME,
    feedback_text TEXT,
    response_status ENUM("dijawab","belum"),
    PRIMARY KEY(feedback_id),
    constraint Fk_user_id_feedback FOREIGN KEY(user_id)REFERENCES user(user_id)
)ENGINE=Innodb;

DROP TABLE IF EXISTS LoginHistory;
create table LoginHistory(
    login_id INT not NULL AUTO_INCREMENT,
    user_id int not NULL,   
    waktu_login DATETIME,
    PRIMARY KEY(login_id),
    constraint Fk_user_id_loginhistory FOREIGN KEY(user_id)REFERENCES user(user_id)
)ENGINE=Innodb;

DROP TABLE IF EXISTS Device;
create table  Device(
    device_id INT not NULL AUTO_INCREMENT,
    user_id int not NULL,
    device_type VARCHAR(200) ,
    os_version VARCHAR(200),
    last_login DATETIME,
    PRIMARY KEY(device_id),
    constraint Fk_user_id_device FOREIGN KEY(user_id)REFERENCES user(user_id)
)ENGINE=Innodb;

DROP TABLE IF EXISTS Report;
create table Report(
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
    constraint Fk_user_id_referal FOREIGN KEY(user_id) REFERENCES user(user_id),
    CONSTRAINT Fk_reffered_user_id FOREIGN KEY(reffered_user_id) REFERENCES user(user_id)

 )ENGINE=Innodb;

INSERT INTO user(nama_user,no_tlpn_user,lokasi_user) VALUES
('Andi Saputra','0812-1234-5678','Jakarta'),
('Budi Santoso','0821-8765-4321','Bandung'),
('Citra Dewi','0852-3333-5566','Surabaya'),
('Deni Pratama','0838-1122-3344','Medan'),
('Eka Lestari','0813-9988-7766','Yogyarkarta'),
('Farhan Hidayat','0851-6677-8899','Palembang'),
('Gita Ramahani','0851-6677-8899','Semarang'),
('Hendra Wijaya','0812-4455-6677','Makasar'),
('Intan Maulinda','0899-1234-5678',"Balikpapan"),
('Joko Susilo','0877-2345-6789','Pontianak');


INSERT INTO driver(user_id,no_telp_driver,lokasi_driver) VALUES
(1,'(0210) 609 5718','Pangkalpinang'),
(2,'(0239) 127 6823','Cilegon'),
(3,'+62 192-513-6228','Tarakan'),
(4,'(0357) 987 2279','Banjarbaru'),
(5,'+62 813-2211-4455','Padang'),
(6,'+62 813-2211-4455','Padang'),
(7,'0812-3344-5566','Makasar'),
(8,'(0274) 223 9941','yogyarkarta'),
(9,'+62 812-9876-1234','Surabaya'),
(10,'0853-9876-1234','Medan');

INSERT INTO rider(user_id,no_telpn_rider,lokasi_rider) VALUES
(1,'0812-7654-3210','Jakarta'),
(2,'0823-1234-5678','Bandung'),
(3,'0856-7788-9900','Surabaya'),
(4,'0813-1122-3344','Medan'),
(5,'0813-4455-6677','Yogyarkarta'),
(6,'0822-9988-7766','Palembang'),
(7,'0851-3344-5566','Palembang'),
(8,'0817-5566-7788','Makasar'),
(9,'0899-1234-7788','Makasar'),
(10,'0877-8888-1234','Pontianak');

INSERT INTO vehicletype(tipe_kendaraan) VALUES
('motor'),
('mobil'),
('motor'),
('mobil'),
('motor'),
('mobil'),
('motor'),
('mobil'),
('motor'),
('mobil');

INSERT INTO vehicle(driver_id,vehicle_type_id,jenis) VALUES
(1,1,'UberX'),
(2,2,'UberXL'),
(3,3,'UberX'),
(4,4,'UberX'),
(5,5,'UberXL'),
(6,6,'UberX'),
(7,7,'UberXL'),
(8,8,'UberX'),
(9,9,'UberXL'),
(10,10,'UberX');

INSERT INTO license (driver_id,status_licensi,tanggal_licensi,jenis_licensi) VALUES
(1,'aktif','2022-01-15','Sim A'),
(2,'aktif','2022-06-10','Sim C'),
(3,'nonaktif','2021-12-01','Sim A'),
(4,'aktif','2023-07-19','Sim C'),
(5,'aktif','2023-03-25','Sim A'),
(6,'nonaktif','2021-08-05','Sim C'),
(7,'aktif','2023-09-10','Sim A'),
(8,'aktif','2022-11-30','Sim C'),
(9,'nonaktif','2021-10-20','Sim A'),
(10,'aktif','2024-01-01','Sim C');

INSERT INTO tripstatus(nama_status) VALUES
('aktif'),
('dibatalkan'),
('selesai'),
('aktif'),
('dibatalkan'),
('selesai'),
('aktif'),
('dibatalkan'),
('selesai'),
('aktif'),
('dibatalkan'),
('selesai'),
('aktif');
