-- Tabel Dosen
CREATE TABLE dosen (
    id_dosen INT PRIMARY KEY,
    nama_dosen VARCHAR(100),
    bidang_keahlian VARCHAR(50)
);

-- Tabel Mahasiswa
CREATE TABLE mahasiswa (
    id_mahasiswa INT PRIMARY KEY,
    nama_mahasiswa VARCHAR(100),
    program_studi VARCHAR(50),
    angkatan INT
);

-- Tabel Mata Kuliah
CREATE TABLE mata_kuliah (
    id_mk VARCHAR(10) PRIMARY KEY,
    nama_mk VARCHAR(100),
    sks INT,
    id_dosen INT,
    
    FOREIGN KEY (id_dosen) 
    REFERENCES dosen(id_dosen)
);

-- Tabel KRS (Transaksi)
CREATE TABLE krs (
    id_krs INT PRIMARY KEY,
    id_mahasiswa INT,
    id_mk VARCHAR(10),
    semester_ambil INT,
    
    FOREIGN KEY (id_mahasiswa) 
    REFERENCES mahasiswa(id_mahasiswa),
    FOREIGN KEY (id_mk) 
    REFERENCES mata_kuliah (id_mk)
);

-- isi tabel dosen
INSERT INTO dosen VALUES
(1, 'Dr. Budi', 'Pemrograman'),
(2, 'Prof. Siti', 'Basis Data'),
(3, 'Ir. Ahmad', 'Jaringan'),
(4, 'Dian, M.Kom', 'Pemrograman'),
(5, 'Eko, S.T', 'Kecerdasan Buatan'),
(6, 'Rina, M.T', 'Basis Data'),
(7, 'Hadi, Ph.D', 'Keamanan Siber'),
(8, 'Siska, M.SI', 'Sistem Informasi'),
(9, 'Bambang, M.Kom', 'Pemrograman'),
(10, 'Laila, M.T', 'Manajemen Proyek');

-- isi tabel mahasiswa
INSERT INTO mahasiswa VALUES
(2201, 'Dhani Kusuma', 'Sistem Informasi', 2022),
(2202, 'Rizky Pratama', 'Sistem Informasi', 2022),
(2301, 'Andi Wijaya', 'Sistem Informasi', 2023),
(2302, 'Bunga Citra', 'Sistem Informasi', 2023),
(2303, 'Dimas Anggara', 'Sistem Informasi', 2023),
(2401, 'Candra Gupta', 'Sistem Informasi', 2024),
(2402, 'Dedi Kurniawan', 'Sistem Informasi', 2024),
(2501, 'Farah Nabila', 'Sistem Informasi', 2025),
(2502, 'Gibran Rakabumi', 'Sistem Informasi', 2025),
(2503, 'Hani Safira', 'Sistem Informasi', 2025),
(2504, 'Irfan Bachdim', 'Sistem Informasi', 2025),
(2505, 'Joko Anwar', 'Sistem Informasi', 2025);

-- isi tabel mata kuliah
INSERT INTO mata_kuliah VALUES
('MK01', 'Algoritma & Pemrograman', 4, 1),
('MK02', 'Basis Data Terdistribusi', 3, 2),
('MK03', 'Struktur Data', 3, 4),
('MK04', 'Jaringan Komputer', 3, 3),
('MK05', 'Kecerdasan Buatan', 3, 5),
('MK06', 'Sistem Informasi Akuntansi', 2, 8),
('MK07', 'Pemrograman Web Native', 3, 9),
('MK08', 'Keamanan Informasi', 3, 7),
('MK09', 'Etika Profesi IT', 2, 10),
('MK10', 'Administrasi Basis Data', 3, 6);

-- isi tabel krs
INSERT INTO krs VALUES
(101, 2301, 'MK01', 3),
(102, 2301, 'MK02', 3),
(103, 2201, 'MK05', 5),
(104, 2302, 'MK04', 3),
(105, 2401, 'MK01', 1),
(106, 2402, 'MK07', 2),
(107, 2202, 'MK10', 5),
(108, 2303, 'MK06', 4),
(109, 2201, 'MK08', 6),
(110, 2401, 'MK03', 1);


-- soal 1
SELECT mata_kuliah.nama_mk, mata_kuliah.sks, dosen.nama_dosen
FROM mata_kuliah
INNER JOIN dosen
ON mata_kuliah.id_dosen = dosen.id_dosen
WHERE dosen.bidang_keahlian IN ('Pemrograman', 'Basis Data');

-- soal 2
SELECT mahasiswa.nama_mahasiswa, krs.id_mk
FROM mahasiswa
LEFT JOIN krs
ON mahasiswa.id_mahasiswa = krs.id_mahasiswa;

-- soal 3
SELECT mahasiswa.nama_mahasiswa, mata_kuliah.nama_mk, krs.semester_ambil
FROM krs
INNER JOIN mahasiswa
ON krs.id_mahasiswa = mahasiswa.id_mahasiswa
INNER JOIN mata_kuliah
ON krs.id_mk = mata_kuliah.id_mk
WHERE krs.semester_ambil BETWEEN 3 AND 5
ORDER BY krs.semester_ambil ASC;

-- soal 4
SELECT m.nama_mahasiswa, mk.nama_mk, mk.sks
FROM krs k
INNER JOIN mahasiswa m
ON k.id_mahasiswa = m.id_mahasiswa
INNER JOIN mata_kuliah mk
ON k.id_mk = mk.id_mk
WHERE m.program_studi = 'Sistem Informasi'
AND mk.sks > 2
ORDER BY mk.sks DESC, m.nama_mahasiswa ASC;

-- soal 5
SELECT m.nama_mahasiswa, m.angkatan, mk.nama_mk, d.nama_dosen
FROM krs k
INNER JOIN mahasiswa m 
ON k.id_mahasiswa = m.id_mahasiswa
INNER JOIN mata_kuliah mk 
ON k.id_mk = mk.id_mk
INNER JOIN dosen d 
ON mk.id_dosen = d.id_dosen
WHERE m.angkatan BETWEEN 2023 AND 2025
AND d.nama_dosen IN ('Dr. Budi', 'Prof. Siti')
ORDER BY m.angkatan DESC;


-- tugas
SELECT d.nama_dosen, mk.nama_mk, k.semester_ambil
FROM krs k
INNER JOIN mata_kuliah mk
ON k.id_mk = mk.id_mk
INNER JOIN dosen d
ON mk.id_dosen = d.id_dosen
WHERE k.semester_ambil = 3
ORDER BY d.nama_dosen ASC;