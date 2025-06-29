DROP DATABASE IF EXISTS Project_uber;
CREATE DATABASE Project_uber;

use Project_uber;

set FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS user;
CREATE TABLE user(
    user_id int not null AUTO_INCREMENT,
    nama_user VARCHAR(200) NOT NULL DEFAULT 'N/A',
    no_tlpn_user VARCHAR(200) NOT NULL DEFAULT 'N/A' UNIQUE,
    lokasi_user VARCHAR(200) NOT NULL DEFAULT 'N/A',
    PRIMARY KEY(user_id)
)ENGINE=Innodb;

DROP TABLE IF EXISTS driver;
CREATE TABLE driver(
    driver_id INT not NULL AUTO_INCREMENT,
    user_id int NOT null,
    no_telp_driver VARCHAR(200) NOT NULL DEFAULT 'N/A' UNIQUE,
    lokasi_driver VARCHAR(200) NOT NULL DEFAULT 'N/A',
    PRIMARY key(driver_id),
    constraint Fk_user_id_driver FOREIGN key(user_id) REFERENCES user(user_id) ON UPDATE CASCADE ON DELETE CASCADE
)ENGINE=Innodb;

DROP TABLE IF EXISTS rider;
CREATE TABLE rider(
    rider_id int NOT NULL AUTO_INCREMENT,
    user_id int not NULL,
    no_telpn_rider VARCHAR(200) NOT NULL DEFAULT 'N/A' UNIQUE,
    lokasi_rider VARCHAR(200) NOT NULL DEFAULT 'N/A',
    PRIMARY KEY(rider_id),
    constraint Fk_user_id_rider foreign KEY(user_id)REFERENCES USER(user_id) ON UPDATE CASCADE ON DELETE CASCADE
)ENGINE=Innodb;

DROP TABLE IF EXISTS vehicletype;
CREATE TABLE vehicletype(
    vehicle_type_id int not null AUTO_INCREMENT,
    tipe_kendaraan ENUM('motor','mobil') NOT NULL DEFAULT 'motor',
    PRIMARY KEY(vehicle_type_id)
)ENGINE=Innodb;

DROP TABLE IF EXISTS vehicle;
CREATE TABLE vehicle(
    vehicle_id int NOT NULL AUTO_INCREMENT,
    driver_id int not NULL,
    vehicle_type_id int NOT NULL,
    jenis ENUM('UberX','UberXL') not NULL DEFAULT 'UberX',
    PRIMARY KEY(vehicle_id),
    constraint Fk_driver_id_vehicle foreign  KEY(driver_id)REFERENCES driver(driver_id) ON UPDATE CASCADE ON DELETE CASCADE,
    constraint Fk_vehicle_type_id FOREIGN KEY(vehicle_type_id)REFERENCES vehicletype(vehicle_type_id) ON UPDATE CASCADE ON DELETE CASCADE
)ENGINE=Innodb;

DROP TABLE IF EXISTS license;
CREATE TABLE license(
    license_id int not null AUTO_INCREMENT,
    driver_id int NOT NULL,
    status_licensi VARCHAR(200) NOT NULL DEFAULT 'N/A',
    tanggal_licensi DATE NOT NULL,
    jenis_licensi VARCHAR(200) NOT NULL DEFAULT 'N/A',
    PRIMARY KEY(license_id),
    constraint Fk_driver_id_license FOREIGN KEY(driver_id)REFERENCES driver(driver_id) ON UPDATE CASCADE ON DELETE CASCADE
)ENGINE=Innodb;

DROP TABLE IF EXISTS tripstatus;
create table tripstatus(
    trip_status_id int NOT NULL AUTO_INCREMENT,
    nama_status ENUM('aktif','dibatalkan','selesai') NOT NULL DEFAULT 'dibatalkan',
    PRIMARY KEY(trip_status_id)
)ENGINE=Innodb;

DROP TABLE IF EXISTS promocode;
CREATE TABLE promocode(
    promo_id int not NULL AUTO_INCREMENT,
    kode_promo VARCHAR(200) NOT NULL DEFAULT 'N/A' UNIQUE,
    diskon int NOT NULL ,
    batas_berlaku varchar(200) NOT NULL DEFAULT 'N/A',
    primary key(promo_id)
)ENGINE=Innodb;

DROP TABLE IF EXISTS trip;
CREATE TABLE trip(
    trip_id INT NOT NULL AUTO_INCREMENT,
    rider_id int NOT NULL,
    driver_id int NOT NULL,
    trip_status_id INT NOT NULL,
    promo_id int NOT NULL,
    waktu_mulai DATETIME NOT NULL ,
    waktu_selesai DATETIME NOT NULL,
    biaya DECIMAL(10,2) NOT NULL,
    lokasi_awal VARCHAR(200) NOT NULL DEFAULT 'N/A',
    lokasi_tujuan VARCHAR(200) NOT NULL DEFAULT 'N/A',
    PRIMARY key(trip_id),
    CONSTRAINT Fk_rider_id_trip FOREIGN KEY(rider_id) REFERENCES rider(rider_id) ON UPDATE CASCADE ON DELETE CASCADE,
    constraint Fk_driver_id_trip FOREIGN KEY(driver_id) REFERENCES driver(driver_id) ON UPDATE CASCADE ON DELETE CASCADE,
    constraint Fk_trip_status_id FOREIGN KEY(trip_status_id) REFERENCES tripstatus(trip_status_id) ON UPDATE CASCADE ON DELETE CASCADE,
    constraint Fk_promo_id_trip FOREIGN KEY(promo_id) REFERENCES promocode(promo_id) ON UPDATE CASCADE ON DELETE CASCADE

)ENGINE=Innodb;

DROP TABLE IF EXISTS paymentmethod;
CREATE TABLE paymentmethod(
    payment_method_id int not NULL AUTO_INCREMENT,
    nama_metode enum('tunai','qris','e-pay','transfer') NOT NULL DEFAULT 'tunai',
    PRIMARY key(payment_method_id)
)ENGINE=Innodb;

DROP TABLE IF EXISTS payment;
CREATE TABLE payment(
    payment_id int not NULL AUTO_INCREMENT,
    trip_id int NOT null,
    payment_method_id int NOT NULL,
    jumlah INT not NULL,
    status_pembayaran ENUM('lunas','belum') NOT NULL DEFAULT 'belum',
    PRIMARY KEY(payment_id) ,
    constraint Fk_trip_id_payment FOREIGN key(trip_id) REFERENCES trip(trip_id) ON UPDATE CASCADE ON DELETE CASCADE,
    constraint Fk_payment_method_id FOREIGN KEY(payment_method_id) REFERENCES paymentmethod(payment_method_id) ON UPDATE CASCADE ON DELETE CASCADE
)ENGINE=Innodb;

DROP TABLE IF EXISTS rating;
CREATE TABLE rating(
    rating_id int NOT NULL AUTO_INCREMENT,
    trip_id int not null,
    user_id INT NOT NULL,
    nilai_rating ENUM('baik','buruk') NOT NULL DEFAULT 'baik',
    komentar TEXT ,
    PRIMARY key(rating_id),
    constraint Fk_trip_id_rating FOREIGN key(trip_id) REFERENCES trip(trip_id) ON UPDATE CASCADE ON DELETE CASCADE,
    constraint FK_user_id_rating FOREIGN key(user_id) REFERENCES user(user_id) ON UPDATE CASCADE ON DELETE CASCADE
)ENGINE=Innodb;

DROP TABLE IF EXISTS location;
CREATE TABLE location(
    location_id int NOT null AUTO_INCREMENT,
    user_id int not NULL,
    label VARCHAR(200) NOT NULL DEFAULT 'N/A',
    latitude DECIMAL(10,6) NOT NULL ,
    longitude DECIMAL(10,6) NOT NULL,
    primary KEY(location_id),
    constraint Fk_user_id_location FOREIGN KEY(user_id) REFERENCES user(user_id) ON UPDATE CASCADE ON DELETE CASCADE
    
)ENGINE=Innodb;

DROP TABLE IF EXISTS  triproute;
CREATE TABLE triproute(
    trip_route_id INT NOT NULL AUTO_INCREMENT,
    trip_id int not NULL,
    titik_awal VARCHAR(200) NOT NULL DEFAULT 'N/A',
    titik_tengah VARCHAR(200) NOT NULL DEFAULT 'N/A',
    titik_akhir VARCHAR(200) NOT NULL DEFAULT 'N/A',
    PRIMARY KEY(trip_route_id),
    constraint Fk_trip_id_triproute FOREIGN KEY(trip_id) REFERENCES trip(trip_id) ON UPDATE CASCADE ON DELETE CASCADE
)ENGINE=Innodb;

DROP TABLE IF EXISTS Notification;
CREATE TABLE Notification(
    notification_id INT NOT NULL AUTO_INCREMENT,
    user_id int not NULL,
    isi_pesan VARCHAR(200) NOT NULL DEFAULT 'N/A',
    waktu_dikirim TIMESTAMP NOT NULL ,
    dibaca_status ENUM('dibaca','belum dibaca') NOT NULL DEFAULT 'belum dibaca',
    PRIMARY KEY(notification_id),
    constraint Fk_user_id_notification FOREIGN KEY(user_id) REFERENCES user(user_id) ON UPDATE CASCADE ON DELETE CASCADE
)ENGINE=Innodb;

DROP TABLE IF EXISTS SupportCategory;
CREATE TABLE SupportCategory(
    support_category_id INT NOT NULL AUTO_INCREMENT,
    nama_kategori VARCHAR(200) NOT NULL DEFAULT 'N/A',
    PRIMARY KEY(support_category_id)
)ENGINE=Innodb;

DROP TABLE IF EXISTS SupportTicket;
CREATE TABLE SupportTicket(
    ticket_id INT NOT NULL AUTO_INCREMENT,
    user_id int not NULL,
    support_category_id int NOT NULL,
    isi_ticket VARCHAR(200) NOT NULL DEFAULT 'N/A',
    status_ticket ENUM("baru","proses","selesai") NOT NULL DEFAULT 'selesai',
    PRIMARY KEY(ticket_id),
    constraint Fk_user_id_supportticket FOREIGN KEY(user_id) REFERENCES user(user_id) ON UPDATE CASCADE ON DELETE CASCADE,
    constraint Fk_support_category_id FOREIGN KEY(support_category_id) REFERENCES SupportCategory(support_category_id) ON UPDATE CASCADE ON DELETE CASCADE
)ENGINE=Innodb;

DROP TABLE IF EXISTS DriverAvailability;
CREATE TABLE DriverAvailability(
    availability_id INT NOT NULL AUTO_INCREMENT,
    driver_id int not NULL,
    status ENUM('aktif','tidak') not NULL DEFAULT "aktif",
    waktu TIMESTAMP not NULL,
    PRIMARY KEY(availability_id),
    constraint Fk_user_id_driveravailability FOREIGN KEY(driver_id) REFERENCES driver(driver_id) ON UPDATE CASCADE ON DELETE CASCADE
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
    jumlah_diskon INT  NULL,
    PRIMARY KEY(trip_promo_id),
    constraint Fk_trip_id_trippromo FOREIGN KEY(trip_id) REFERENCES trip(trip_id) ON UPDATE CASCADE ON DELETE CASCADE,
    constraint fk_promo_id_trippromo FOREIGN KEY(promo_id) REFERENCES promocode(promo_id) ON UPDATE CASCADE ON DELETE CASCADE
)ENGINE=Innodb;

DROP TABLE IF EXISTS  Feedback;
create table Feedback(
    feedback_id INT not NULL AUTO_INCREMENT,
    user_id int not NULL,
    submitted_at DATETIME not NULL,
    feedback_text TEXT ,
    response_status ENUM("dijawab","belum") NOT NULL DEFAULT 'belum',
    PRIMARY KEY(feedback_id),
    constraint Fk_user_id_feedback FOREIGN KEY(user_id)REFERENCES user(user_id) ON UPDATE CASCADE ON DELETE CASCADE
)ENGINE=Innodb;

DROP TABLE IF EXISTS LoginHistory;
create table LoginHistory(
    login_id INT not NULL AUTO_INCREMENT,
    user_id int not NULL,   
    waktu_login DATETIME NOT NULL,
    PRIMARY KEY(login_id),
    constraint Fk_user_id_loginhistory FOREIGN KEY(user_id)REFERENCES user(user_id) ON UPDATE CASCADE ON DELETE CASCADE
)ENGINE=Innodb;

DROP TABLE IF EXISTS Device;
create table  Device(
    device_id INT not NULL AUTO_INCREMENT,
    user_id int not NULL,
    device_type VARCHAR(200) NOT NULL DEFAULT 'N/A',
    os_version VARCHAR(200) NOT NULL DEFAULT 'N/A',
    last_login DATETIME,
    PRIMARY KEY(device_id),
    constraint Fk_user_id_device FOREIGN KEY(user_id)REFERENCES user(user_id) ON UPDATE CASCADE ON DELETE CASCADE
)ENGINE=Innodb;

DROP TABLE IF EXISTS Report;
create table Report(
    report_id INT not NULL AUTO_INCREMENT,
    trip_id int not NULL,
    user_id INT not NULL,
    isi_laporan TEXT,
    waktu TIMESTAMP,
    PRIMARY KEY(report_id),
    constraint Fk_user_id_report FOREIGN KEY(user_id)REFERENCES user(user_id) ON UPDATE CASCADE ON DELETE CASCADE,
    constraint Fk_trip_id_report FOREIGN key(trip_id) REFERENCES trip(trip_id) ON UPDATE CASCADE ON DELETE CASCADE
)ENGINE=Innodb;

DROP TABLE IF EXISTS referal;
CREATE TABLE referal(
    referal_id int not NULL AUTO_INCREMENT,
    user_id int not null,
    reffered_user_id int ,
    kode_refferal VARCHAR(200) NOT NULL DEFAULT 'N/A' UNIQUE,
    tanggal_penggunaan DATE not NULL,
    PRIMARY key(referal_id),
    constraint Fk_user_id_referal FOREIGN KEY(user_id) REFERENCES user(user_id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT Fk_reffered_user_id FOREIGN KEY(reffered_user_id) REFERENCES user(user_id) ON UPDATE CASCADE ON DELETE CASCADE

 )ENGINE=Innodb;

INSERT INTO user(nama_user,no_tlpn_user,lokasi_user) VALUES --1
('Andi Saputra','0812-1234-5678','Jakarta'),
('Budi Santoso','0821-8765-4321','Bandung'),
('Citra Dewi','0852-3333-5566','Surabaya'),
('Deni Pratama','0838-1122-3344','Medan'),
('Eka Lestari','0813-9988-7766','Yogyakarta'),
('Farhan Hidayat','0851-6677-8899','Palembang'),
('Gita Ramahani','0851-6677-8890','Semarang'), 
('Hendra Wijaya','0812-4455-6677','Makasar'),
('Intan Maulinda','0899-1234-5678','Balikpapan'),
('Joko Susilo','0877-2345-6789','Pontianak'),
('Kiki Amelia','0812-3344-5566','Malang'),
('Lukman Hakim','0822-7788-9900','Pekanbaru'),
('Maya Putri','0831-2233-4455','Batam'),
('Nando Siregar','0853-1122-3344','Padang'),
('Olivia Natalia','0819-6677-8899','Denpasar'), 
('Pandu Wijaya','0878-5566-7788','Banjarmasin'),
('Qori Alamsyah','0856-9988-1122','Manado'),
('Rina Kartika','0881-2233-4455','Tangerang'),
('Surya Dharma','0814-5566-7788','Cirebon'),
('Tasya Adina','0833-6677-8899','Bogor');

INSERT INTO driver(user_id,no_telp_driver,lokasi_driver) VALUES --2
(1, '(0210) 609 5718', 'Pangkalpinang'),
(2, '(0239) 127 6823', 'Cilegon'),
(3, '+62 192-513-6228', 'Tarakan'),
(4, '(0357) 987 2279', 'Banjarbaru'),
(5, '+62 813-2211-4455', 'Padang'),
(6, '+62 813-2211-4456', 'Padang'),         
(7, '0812-3344-5566', 'Makasar'),
(8, '(0274) 223 9941', 'Yogyakarta'),       
(9, '+62 812-9876-1234', 'Surabaya'),
(10, '0853-9876-1234', 'Medan'),
(11, '0812-9988-7766', 'Malang'),
(12, '0822-3344-5566', 'Pekanbaru'),
(13, '0852-1122-3344', 'Batam'),
(14, '0813-6677-8899', 'Padang'),
(15, '0813-6677-8898', 'Denpasar'),         
(16, '0878-5566-7788', 'Banjarmasin'),
(17, '0856-9988-1122', 'Manado'),
(18, '0881-4455-6677', 'Tangerang'),        
(19, '0814-7788-9900', 'Cirebon'),
(20, '0833-5566-7788', 'Bogor');

INSERT INTO rider(user_id,no_telpn_rider,lokasi_rider) VALUES --3
(1,'0812-7654-3210','Jakarta'),
(2,'0823-1234-5678','Bandung'),
(3,'0856-7788-9900','Surabaya'),
(4,'0813-1122-3344','Medan'),
(5,'0813-4455-6677','Yogyarkarta'),
(6,'0822-9988-7766','Palembang'),
(7,'0851-3344-5566','Palembang'),
(8,'0817-5566-7788','Makasar'),
(9,'0899-1234-7788','Makasar'),
(10,'0877-8888-1234','Pontianak'),
(11,'0812-1122-3344','Malang'),
(12,'0822-7788-6655','Pekanbaru'),
(13,'0852-9911-2233','Batam'),
(14,'0853-3344-2211','Padang'),
(15,'0813-8899-7766','Denpasar'),
(16,'0878-5566-3344','Banjarmasin'),
(17,'0856-1122-9988','Manado'),
(18,'08881-6677-1234','Tangerang'),
(19,'0814-3344-8899','Cirebon'),
(20,'0833-4455-1122','Bogor');

INSERT INTO vehicletype(tipe_kendaraan) VALUES --4
('motor'),
('mobil'),
('motor'),
('mobil'),
('motor'),
('mobil'),
('motor'),
('mobil'),
('motor'),
('mobil'),
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

INSERT INTO vehicle(driver_id,vehicle_type_id,jenis) VALUES --5
(1,1,'UberX'),
(2,2,'UberXL'),
(3,3,'UberX'),
(4,4,'UberX'),
(5,5,'UberXL'),
(6,6,'UberX'),
(7,7,'UberXL'),
(8,8,'UberX'),
(9,9,'UberXL'),
(10,10,'UberX'),
(11,11,'UberX'),
(12,12,'UberXL'),
(13,13,'UberX'),
(14,14,'UberX'),
(15,15,'UberXL'),
(16,16,'UberX'),
(17,17,'UberXL'),
(18,18,'UberX'),
(19,19,'UberXL'),
(20,20,'UberX');

INSERT INTO license (driver_id,status_licensi,tanggal_licensi,jenis_licensi) VALUES --6
(1,'aktif','2022-01-15','Sim A'),
(2,'aktif','2022-06-10','Sim C'),
(3,'nonaktif','2021-12-01','Sim A'),
(4,'aktif','2023-07-19','Sim C'),
(5,'aktif','2023-03-25','Sim A'),
(6,'nonaktif','2021-08-05','Sim C'),
(7,'aktif','2023-09-10','Sim A'),
(8,'aktif','2022-11-30','Sim C'),
(9,'nonaktif','2021-10-20','Sim A'),
(10,'aktif','2024-01-01','Sim C'),
(11,'aktif','2023-05-14','Sim A'),
(12,'nonaktif','2022-02-18','Sim C'),
(13,'aktif','2024-03-22','Sim A'),
(14,'aktif','2023-11-05','Sim C'),
(15,'nonaktif','2021-09-09','Sim A'),
(16,'aktif','2024-06-01','Sim C'),
(17,'aktif','2022-08-28','Sim A'),
(18,'nonaktif','2020-12-15','Sim C'),
(19,'aktif','2024-02-12','Sim A'),
(20,'aktif','2023-10-30','Sim C');

INSERT INTO tripstatus(nama_status) VALUES --7
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
('aktif'),
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

INSERT INTO promocode(kode_promo,diskon,batas_berlaku) VALUES --8
('HEMAT10', 10, '2025-07-31'),
('GOJEK20', 20, '2025-08-15'),
('GRAB15', 15, '2025-07-10'),
('PROMO30', 30, '2025-09-01'),
('ONGKIR50', 50, '2025-07-05'),
('RIDEFREE', 100, '2025-07-20'),
('CASHBACK25', 25, '2025-08-01'),
('AKHIRTAHUN', 40, '2025-12-31'),
('HEBOH22', 22, '2025-07-25'),
('LIBUR60', 60, '2025-08-20'),
('TRIPHEMAT', 18, '2025-09-15'),
('JALANBEBAS', 35, '2025-10-01'),
('DISKONMERDEKA', 45, '2025-08-17'),
('RAMADHAN50', 50, '2025-03-31'),
('MUDIKHEMAT', 20, '2025-04-10'),
('TRAVELMORE', 28, '2025-11-11'),
('ONGKIRGRATIS', 100, '2025-07-06'),
('WEEKEND20', 20, '2025-07-13'),
('BONUSONGKIR', 30, '2025-08-05'),
('HAPPYRIDES', 15, '2025-09-30');

INSERT INTO trip(rider_id,driver_id,trip_status_id,promo_id,waktu_mulai,waktu_selesai,biaya,lokasi_awal, lokasi_tujuan) VALUES --9
(1, 1, 1, 1, '2025-06-01 08:00:00', '2025-06-01 08:45:00', 25000.00, 'Jakarta', 'Depok'),
(2, 2, 2, 2, '2025-06-02 09:15:00', '2025-06-02 09:50:00', 32000.00, 'Bandung', 'Cimahi'),
(3, 3, 3, 3, '2025-06-03 14:00:00', '2025-06-03 14:35:00', 28000.00, 'Surabaya', 'Sidoarjo'),
(4, 4, 4, 4, '2025-06-04 07:00:00', '2025-06-04 07:40:00', 30000.00, 'Medan', 'Binjai'),
(5, 5, 5, 5, '2025-06-05 17:30:00', '2025-06-05 18:10:00', 27000.00, 'Yogyakarta', 'Sleman'),
(6, 6, 6, 6, '2025-06-06 11:20:00', '2025-06-06 12:05:00', 29000.00, 'Palembang', 'Plaju'),
(7, 7, 7, 7, '2025-06-07 12:00:00', '2025-06-07 12:45:00', 31000.00, 'Palembang', 'Jakabaring'),
(8, 8, 8, 8, '2025-06-08 13:00:00', '2025-06-08 13:50:00', 33000.00, 'Makasar', 'Gowa'),
(9, 9, 9, 9, '2025-06-09 10:00:00', '2025-06-09 10:40:00', 26000.00, 'Makasar', 'Maros'),
(10, 10, 10, 10, '2025-06-10 19:00:00', '2025-06-10 19:35:00', 24000.00, 'Pontianak', 'Sungai Raya'),
(11, 11, 11, 11, '2025-06-11 08:10:00', '2025-06-11 08:55:00', 27000.00, 'Malang', 'Batu'),
(12, 12, 12, 12, '2025-06-12 16:00:00', '2025-06-12 16:50:00', 35000.00, 'Pekanbaru', 'Simpang Tiga'),
(13, 13, 13, 13, '2025-06-13 07:45:00', '2025-06-13 08:30:00', 26500.00, 'Batam', 'Nongsa'),
(14, 14, 14, 14, '2025-06-14 15:30:00', '2025-06-14 16:15:00', 27500.00, 'Padang', 'Lubuk Begalung'),
(15, 15, 15, 15, '2025-06-15 10:30:00', '2025-06-15 11:20:00', 34000.00, 'Denpasar', 'Kuta'),
(16, 16, 16, 16, '2025-06-16 13:20:00', '2025-06-16 14:00:00', 29500.00, 'Banjarmasin', 'Banjarbaru'),
(17, 17, 17, 17, '2025-06-17 18:00:00', '2025-06-17 18:40:00', 31000.00, 'Manado', 'Tomohon'),
(18, 18, 18, 18, '2025-06-18 09:00:00', '2025-06-18 09:45:00', 28500.00, 'Tangerang', 'Serpong'),
(19, 19, 19, 19, '2025-06-19 06:30:00', '2025-06-19 07:15:00', 25000.00, 'Cirebon', 'Majalengka'),
(20, 20, 20, 20, '2025-06-20 08:30:00', '2025-06-20 09:15:00', 29500.00, 'Bogor', 'Depok');

INSERT INTO paymentmethod(nama_metode) VALUES --10
('tunai'),
('qris'),
('e-pay'),
('transfer'),
('tunai'),
('qris'),
('e-pay'),
('transfer'),
('tunai'),
('qris'),
('e-pay'),
('transfer'),
('tunai'),
('qris'),
('e-pay'),
('transfer'),
('tunai'),
('qris'),
('e-pay'),
('transfer');

INSERT INTO payment (trip_id, payment_method_id, jumlah, status_pembayaran) VALUES --11
(1,1,30000,'lunas'), (2,2,40000,'lunas'), (3,1,0,'belum'), (4,1,25000,'lunas'), (5,3,45000,'lunas'),
(6,1,0,'belum'), (7,4,20000,'lunas'), (8,2,35000,'lunas'), (9,1,30000,'lunas'), (10,2,0,'belum'),
(11,2,50000,'lunas'), (12,3,22000,'lunas'), (13,3,0,'belum'), (14,1,15000,'lunas'), (15,4,37000,'lunas'),
(16,3,53000,'lunas'), (17,2,24000,'lunas'), (18,4,33000,'lunas'), (19,1,40000,'lunas'), (20,2,48000,'lunas');

INSERT INTO rating (trip_id, user_id, nilai_rating, komentar) VALUES--12
(1, 1, 'baik', 'Pelayanan sangat baik'),
(2, 2, 'baik', 'Sopir ramah'),
(4, 4, 'baik', 'Cepat dan aman'),
(5, 5, 'baik', 'Cukup baik'),
(7, 7, 'baik', 'Driver on-time'),
(8, 8, 'baik', 'Sangat nyaman'),
(9, 9, 'baik', 'Agak lambat'),
(11, 11, 'baik', 'Luar biasa!'),
(12, 12, 'baik', 'Bagus'),
(14, 14, 'baik', 'Driver terbaik'),
(15, 15, 'baik', 'Rapi dan cepat'),
(16, 16, 'baik', 'Baik dan sopan'),
(17, 17, 'buruk', 'Kurang memuaskan'),
(18, 18, 'baik', 'Sopan dan cepat'),
(19, 19, 'baik', 'Memuaskan'),
(20, 20, 'baik', 'Layanan oke'),
(3, 3, 'baik', 'Belum ada ulasan'),
(6, 6, 'baik', 'Belum ada ulasan'),
(10, 10, 'baik', 'Belum ada ulasan'),
(13, 13, 'baik', 'Belum ada ulasan');

INSERT INTO location (user_id, label, latitude, longitude) VALUES --13
(1,'Rumah','-6.200000','106.816666'), (2,'Kantor','-6.914744','107.609810'), (3,'Kos','-7.257472','112.752090'),
(4,'Stasiun','-6.241586','106.992416'), (5,'Bandara','3.595196','98.672226'), (6,'Mall','-5.147665','119.432732'),
(7,'Taman','-2.990934','104.756554'), (8,'Kampus','-7.005145','110.438125'), (9,'Pasar','-7.801389','110.364722'),
(10,'Terminal','-5.1479','119.4326'), (11,'Pelabuhan','-2.9761','104.7754'), (12,'Restoran','-7.0014','110.4289'),
(13,'Pantai','-8.4095','115.1889'), (14,'Hotel','-0.0263','109.3425'), (15,'Klinik','0.5333','101.4500'),
(16,'Sekolah','1.4748','124.8421'), (17,'Stadion','-0.9492','100.3543'), (18,'Toko','1.1441','104.0145'),
(19,'Masjid','-6.7325','108.5523'), (20,'Perpustakaan','-7.9797','112.6304');

INSERT INTO triproute (trip_id, titik_awal, titik_tengah, titik_akhir) VALUES --14
(1,'Jakarta','Cawang','Depok'), (2,'Bandung','Cimahi','Bekasi'), (3,'Surabaya','Wonokromo','Sidoarjo'),
(4,'Bekasi','Cibitung','Jakarta'), (5,'Medan','Tuntungan','Binjai'), (6,'Makassar','Panakkukang','Gowa'),
(7,'Palembang','Seberang Ulu','Plaju'), (8,'Semarang','Tembalang','Ungaran'), (9,'Yogyakarta','Kaliurang','Sleman'),
(10,'Makassar','Somba Opu','Maros'), (11,'Palembang','Jakabaring','Banyuasin'), (12,'Semarang','Gajahmungkur','Demak'),
(13,'Bali','Sanur','Gianyar'), (14,'Pontianak','Pontianak Selatan','Singkawang'), (15,'Pekanbaru','Tampan','Bangkinang'),
(16,'Manado','Sario','Bitung'), (17,'Padang','Padang Timur','Bukittinggi'), (18,'Batam','Batu Aji','Tanjungpinang'),
(19,'Cirebon','Kejaksan','Indramayu'), (20,'Malang','Klojen','Blitar');

INSERT INTO Notification (user_id, isi_pesan, waktu_dikirim, dibaca_status) VALUES --15
(1,'Promo baru untukmu!',NOW(),'belum dibaca'), (2,'Perjalanan selesai',NOW(),'dibaca'),
(3,'Driver dalam perjalanan',NOW(),'belum dibaca'), (4,'Dapatkan diskon!',NOW(),'belum dibaca'),
(5,'Pembayaran berhasil',NOW(),'dibaca'), (6,'Akun login berhasil',NOW(),'dibaca'),
(7,'Driver tiba di lokasi',NOW(),'belum dibaca'), (8,'Kode promo berlaku',NOW(),'dibaca'),
(9,'Penilaian diterima',NOW(),'dibaca'), (10,'Selesaikan perjalanan anda',NOW(),'belum dibaca'),
(11,'Terima kasih telah menggunakan layanan kami',NOW(),'dibaca'), (12,'Perjalanan telah dimulai',NOW(),'dibaca'),
(13,'Pembayaran ditolak',NOW(),'belum dibaca'), (14,'Driver membatalkan perjalanan',NOW(),'dibaca'),
(15,'Promo eksklusif untuk anda',NOW(),'belum dibaca'), (16,'Saldo dompet bertambah',NOW(),'dibaca'),
(17,'Mohon beri rating driver anda',NOW(),'belum dibaca'), (18,'Laporan berhasil dikirim',NOW(),'dibaca'),
(19,'Pengaturan akun diperbarui',NOW(),'dibaca'), (20,'Cek perjalanan terakhir anda',NOW(),'belum dibaca');

INSERT INTO SupportCategory(nama_kategori) VALUES --16
('Akun'),
('Pembayaran'),
('Perjalanan'),
('Promo'),
('Lainnya'),
('Akun'),
('Pembayaran'),
('Perjalanan'),
('Promo'),
('Lainnya'),
('Akun'),
('Pembayaran'),
('Perjalanan'),
('Promo'),
('Lainnya'),
('Akun'),
('Pembayaran'),
('Perjalanan'),
('Promo'),
('Lainnya');

INSERT INTO SupportTicket (user_id, support_category_id, isi_ticket, status_ticket) VALUES --17
(1,1,'Tidak bisa bayar','baru'), (2,2,'Driver kasar','proses'), (3,3,'Promo tidak bisa dipakai','selesai'),
(4,4,'Aplikasi error','proses'), (5,5,'Ingin kasih saran','baru'), (6,6,'Refund saya belum masuk','selesai'),
(7,7,'Dana belum kembali','proses'), (8,8,'Perjalanan saya tidak sesuai','selesai'),
(9,9,'Driver tidak bisa temukan lokasi','baru'), (10,10,'Keluhan umum','baru'),
(11,11,'Tidak bisa login','proses'), (12,12,'Tidak bisa pesan','selesai'), (13,13,'Saya beri rating buruk','proses'),
(14,14,'Bayar gagal','baru'), (15,15,'Akun saya dihapus?','proses'), (16,16,'Trip tidak sesuai','selesai'),
(17,17,'Driver telat','baru'), (18,18,'Tidak ada driver tersedia','selesai'),
(19,19,'Promo saya hilang','proses'), (20,20,'Poin tidak masuk','selesai');

INSERT INTO DriverAvailability(driver_id,status,waktu) VALUES --18
(1, 'aktif', '2025-06-29 08:00:00'),
(2, 'tidak', '2025-06-29 08:10:00'),
(3, 'aktif', '2025-06-29 08:15:00'),
(4, 'aktif', '2025-06-29 08:20:00'),
(5, 'tidak', '2025-06-29 08:25:00'),
(1, 'tidak', '2025-06-29 09:00:00'),
(2, 'aktif', '2025-06-29 09:05:00'),
(3, 'tidak', '2025-06-29 09:10:00'),
(4, 'aktif', '2025-06-29 09:15:00'),
(5, 'aktif', '2025-06-29 09:20:00'),
(1, 'aktif', '2025-06-29 10:00:00'),
(2, 'aktif', '2025-06-29 10:10:00'),
(3, 'aktif', '2025-06-29 10:20:00'),
(4, 'tidak', '2025-06-29 10:30:00'),
(5, 'tidak', '2025-06-29 10:35:00'),
(1, 'aktif', '2025-06-29 11:00:00'),
(2, 'tidak', '2025-06-29 11:05:00'),
(3, 'aktif', '2025-06-29 11:10:00'),
(4, 'aktif', '2025-06-29 11:15:00'),
(5, 'aktif', '2025-06-29 11:20:00');

INSERT INTO PricingPolicy(dasar_harga,per_km,per_menit) VALUES --19
(7000, 3000, 500),
(5000, 2500, 400),
(10000, 4000, 600),
(8000, 3500, 550),
(6000, 2000, 450),
(9000, 3800, 700),
(11000, 4200, 750),
(7500, 3100, 520),
(8500, 3300, 530),
(9500, 3700, 580),
(10000, 3000, 500),
(7000, 2700, 480),
(8000, 3400, 510),
(6000, 2200, 470),
(7500, 3100, 520),
(6500, 2600, 490),
(7000, 2800, 500),
(9000, 3900, 600),
(8500, 3600, 550),
(9500, 4000, 580);
 
INSERT INTO trippromo (trip_id, promo_id, jumlah_diskon) VALUES --20
(1,1,3000),(2,2,8000),(4,4,3750),(5,5,22500),(7,7,2000),(8,8,10500),
(9,9,1500),(11,11,10000),(12,12,2200),(14,14,3000),(15,15,14800),
(16,16,18550),(17,17,3600),(18,18,4950),(19,19,2000),(20,20,4800),
(3,3,10000),(6,6,1500),(10,10,7200),(13,13,1300);

INSERT INTO Feedback (user_id, submitted_at, feedback_text, response_status) VALUES --21
(1,NOW(),'Aplikasi bagus','dijawab'), (2,NOW(),'Driver ramah','belum'), (3,NOW(),'Harga terlalu mahal','dijawab'),
(4,NOW(),'Waktu tunggu lama','belum'), (5,NOW(),'Diskon menarik','dijawab'), (6,NOW(),'Saya suka fiturnya','belum'),
(7,NOW(),'Harap tambahkan fitur baru','belum'), (8,NOW(),'Saya tidak puas','dijawab'), (9,NOW(),'Layanan mantap','belum'),
(10,NOW(),'Berharap lebih cepat','dijawab'), (11,NOW(),'Sangat berguna','dijawab'), (12,NOW(),'Lambat dalam login','belum'),
(13,NOW(),'UI/UX nyaman','dijawab'), (14,NOW(),'Promo kurang banyak','belum'), (15,NOW(),'Butuh metode pembayaran lain','dijawab'),
(16,NOW(),'Map tidak akurat','belum'), (17,NOW(),'Bagus tapi mahal','belum'), (18,NOW(),'Terima kasih','dijawab'),
(19,NOW(),'Fitur keamanan bagus','belum'), (20,NOW(),'Driver sangat profesional','dijawab');

INSERT INTO LoginHistory (user_id, waktu_login) VALUES --22
(1,NOW()), (2,NOW()), (3,NOW()), (4,NOW()), (5,NOW()), (6,NOW()), (7,NOW()), (8,NOW()), (9,NOW()), (10,NOW()),
(11,NOW()), (12,NOW()), (13,NOW()), (14,NOW()), (15,NOW()), (16,NOW()), (17,NOW()), (18,NOW()), (19,NOW()), (20,NOW());

INSERT INTO Device (user_id, device_type, os_version, last_login) VALUES --23
(1,'Android','11','2025-06-01 08:00:00'), (2,'iOS','14','2025-06-01 09:00:00'),
(3,'Android','10','2025-06-02 10:00:00'), (4,'iOS','13','2025-06-02 11:00:00'),
(5,'Android','12','2025-06-03 12:00:00'), (6,'Android','11','2025-06-04 13:00:00'),
(7,'iOS','14','2025-06-05 14:00:00'), (8,'Android','9','2025-06-06 15:00:00'),
(9,'iOS','13','2025-06-07 16:00:00'), (10,'Android','10','2025-06-08 17:00:00'),
(11,'iOS','12','2025-06-09 18:00:00'), (12,'Android','8','2025-06-10 19:00:00'),
(13,'Android','7','2025-06-11 20:00:00'), (14,'iOS','15','2025-06-12 21:00:00'),
(15,'Android','6','2025-06-13 22:00:00'), (16,'iOS','14','2025-06-14 23:00:00'),
(17,'Android','9','2025-06-15 08:00:00'), (18,'iOS','13','2025-06-16 09:00:00'),
(19,'Android','10','2025-06-17 10:00:00'), (20,'iOS','14','2025-06-18 11:00:00');

INSERT INTO Report (trip_id, user_id, isi_laporan, waktu) VALUES --24
(1,1,'Driver ugal-ugalan',NOW()), (2,2,'Biaya tidak sesuai',NOW()), (3,3,'Promo tidak bisa digunakan',NOW()),
(4,4,'Perjalanan dibatalkan sepihak',NOW()), (5,5,'Driver telat',NOW()), (6,6,'Mobil bau asap rokok',NOW()),
(7,7,'Sopir tidak ramah',NOW()), (8,8,'Waktu tempuh terlalu lama',NOW()), (9,9,'Aplikasi crash saat booking',NOW()),
(10,10,'Lokasi tujuan salah',NOW()), (11,11,'Rute terlalu jauh',NOW()), (12,12,'Perjalanan tidak sesuai estimasi',NOW()),
(13,13,'Pembatalan mendadak',NOW()), (14,14,'Diskon tidak masuk',NOW()), (15,15,'Driver tidak tahu rute',NOW()),
(16,16,'Kendaraan tidak layak',NOW()), (17,17,'Driver tidak datang',NOW()), (18,18,'Pengemudi melanggar lalu lintas',NOW()),
(19,19,'Aplikasi lambat',NOW()), (20,20,'Peta tidak akurat',NOW());

INSERT INTO referal (user_id, reffered_user_id, kode_refferal, tanggal_penggunaan) VALUES --25
(1,2,'REF001','2025-06-01'), (3,4,'REF002','2025-06-02'), (5,6,'REF003','2025-06-03'), (7,8,'REF004','2025-06-04'),
(9,10,'REF005','2025-06-05'), (11,12,'REF006','2025-06-06'), (13,14,'REF007','2025-06-07'), (15,16,'REF008','2025-06-08'),
(17,18,'REF009','2025-06-09'), (19,20,'REF010','2025-06-10'), (2,1,'REF011','2025-06-11'), (4,3,'REF012','2025-06-12'),
(6,5,'REF013','2025-06-13'), (8,7,'REF014','2025-06-14'), (10,9,'REF015','2025-06-15'), (12,11,'REF016','2025-06-16'),
(14,13,'REF017','2025-06-17'), (16,15,'REF018','2025-06-18'), (18,17,'REF019','2025-06-19'), (20,19,'REF020','2025-06-20');


UPDATE user--1
SET nama_user ='Budi Kurniawan' , lokasi_user ='Medan'
WHERE user_id = 1;
SELECT * from user;

UPDATE driver--2
SET  no_telp_driver='+62 821 9892 2016' , lokasi_driver ='Tangerang'
WHERE driver_id = 2;
SELECT * from driver;

UPDATE rider--3
SET  no_telpn_rider='+62 821 9892 2016' , lokasi_rider ='Cempaka'
WHERE rider_id = 2;
SELECT * from rider;

UPDATE vehicletype--4
SET  tipe_kendaraan="mobil"
WHERE vehicle_type_id = 1;
SELECT * from vehicletype;

UPDATE vehicle--5
SET  jenis='UberXL'
WHERE vehicle_id = 1;
SELECT * from vehicle;

DELETE FROM user WHERE user_id=5;--1
SELECT * from user;

DELETE FROM trippromo WHERE jumlah_diskon>5000;--2
SELECT * from trippromo;

DELETE FROM location WHERE longitude<100 ;--3
SELECT * FROM location;

DELETE FROM  license WHERE status_licensi='nonaktif';--4
SELECT * from license;

DELETE FROM  payment WHERE jumlah<1;--5
SELECT * from payment;

CREATE VIEW view_info_user_and_driver_1 AS
SELECT u.user_id,u.nama_user,u.no_tlpn_user,u.lokasi_user,d.driver_id,
d.no_telp_driver,d.lokasi_driver,v.jenis,t.tipe_kendaraan
FROM driver d 
INNER JOIN user u on d.user_id=u.user_id
INNER JOIN location l on u.user_id=l.user_id
inner join vehicle v on d.driver_id = v.driver_id
inner join  vehicletype t on t.vehicle_type_id=v.vehicle_type_id;
select * from view_info_user_and_driver_1;

CREATE VIEW view_info_trip_2 AS
SELECT r.trip_id,r.trip_route_id,r.titik_awal,r.titik_akhir,o.promo_id,o.jumlah_diskon,
m.nama_metode,p.jumlah,p.status_pembayaran 
from trip t
INNER JOIN payment p ON t.trip_id=p.trip_id
INNER JOIN paymentmethod m ON m.payment_method_id=p.payment_method_id
INNER JOIN triproute r ON r.trip_id=t.trip_id
INNER JOIN trippromo o on o.trip_id=t.trip_id;
SELECT * FROM view_info_trip_2;

CREATE VIEW view_info_review_user_3 AS
SELECT u.user_id,u.nama_user,r.nilai_rating,r.komentar,l.waktu_login,
f.submitted_at,f.feedback_text,f.response_status,p.trip_id,p.isi_laporan
FROM user u 
INNER JOIN rating r ON r.user_id=u.user_id
INNER JOIN LoginHistory l ON l.user_id=u.user_id
INNER JOIN Feedback f ON f.user_id=u.user_id
INNER JOIN Report p ON p.user_id=u.user_id ;
SELECT * FROM view_info_review_user_3;

CREATE VIEW view_info_Device_4 AS
SELECT u.user_id,u.nama_user,d.device_type,d.os_version,d.last_login
FROM user u
INNER JOIN Notification n ON n.user_id=u.user_id
INNER JOIN Device d ON d.user_id=u.user_id;
SELECT * FROM view_info_Device_4;

