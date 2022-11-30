create table GENRE
(
    ID_GENRE smallint unsigned auto_increment
        primary key,
    GENRE    varchar(45) not null
);

create table KECAMATAN
(
    ID_KECAMATAN smallint unsigned auto_increment
        primary key,
    KECAMATAN    varchar(45) not null
);

create table KELURAHAN
(
    ID_KELURAHAN smallint unsigned auto_increment
        primary key,
    ID_KECAMATAN smallint unsigned not null,
    KELURAHAN    varchar(45)       not null,
    constraint KELURAHAN_ibfk_1
        foreign key (ID_KECAMATAN) references KECAMATAN (ID_KECAMATAN)
);

create index KELURAHAN_FKIndex1
    on KELURAHAN (ID_KECAMATAN);

create table MOVIE
(
    KODE_DVD    varchar(10) not null
        primary key,
    JUDUL       varchar(60) not null,
    HARGA_SEWA  double      not null,
    DENDA       double      not null,
    TAHUN_RILIS year        null
);

create table GENRE_MOVIE
(
    ID_GENRE smallint unsigned not null,
    KODE_DVD varchar(10)       not null,
    primary key (ID_GENRE, KODE_DVD),
    constraint GENRE_MOVIE_ibfk_1
        foreign key (ID_GENRE) references GENRE (ID_GENRE),
    constraint GENRE_MOVIE_ibfk_2
        foreign key (KODE_DVD) references MOVIE (KODE_DVD)
);

create index GENRE_has_MOVIE_FKIndex1
    on GENRE_MOVIE (ID_GENRE);

create index GENRE_has_MOVIE_FKIndex2
    on GENRE_MOVIE (KODE_DVD);

create table PELANGGAN
(
    KODE_PELANGGAN varchar(10)       not null
        primary key,
    ID_KELURAHAN   smallint unsigned not null,
    NAMA           varchar(45)       not null,
    ALAMAT         varchar(60)       not null,
    JENIS_KELAMIN  char              not null,
    constraint PELANGGAN_ibfk_1
        foreign key (ID_KELURAHAN) references KELURAHAN (ID_KELURAHAN),
    constraint JENIS_KELAMIN
        check (`JENIS_KELAMIN` in ('L', 'P'))
);

create table KONTAK_PELANGGAN
(
    KODE_PELANGGAN varchar(10) not null,
    NO_HP          varchar(25) not null,
    constraint KONTAK_PELANGGAN_UNIQUE
        unique (NO_HP),
    constraint KONTAK_PELANGGAN_ibfk_1
        foreign key (KODE_PELANGGAN) references PELANGGAN (KODE_PELANGGAN)
);

create index KONTAK_PELANGGAN_FKIndex1
    on KONTAK_PELANGGAN (KODE_PELANGGAN);

create index PELANGGAN_FKIndex1
    on PELANGGAN (ID_KELURAHAN);

create table TRANSAKSI
(
    TANGGAL_SEWA              date        not null,
    KODE_DVD                  varchar(10) not null,
    KODE_PELANGGAN            varchar(10) not null,
    TANGGAL_WAJIB_KEMBALI     date        not null,
    TANGGAL_REALISASI_KEMBALI date        not null,
    primary key (TANGGAL_SEWA, KODE_DVD, KODE_PELANGGAN),
    constraint TRANSAKSI_ibfk_1
        foreign key (KODE_DVD) references MOVIE (KODE_DVD),
    constraint TRANSAKSI_ibfk_2
        foreign key (KODE_PELANGGAN) references PELANGGAN (KODE_PELANGGAN)
);

create index TRANSAKSI_FKIndex1
    on TRANSAKSI (KODE_DVD);

create index TRANSAKSI_FKIndex2
    on TRANSAKSI (KODE_PELANGGAN);


