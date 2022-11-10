/*PL/SQL OOP
Oracle PL/SQL NYP y�ntemine g�re geli�tirme yapmay� sa�lar.

PL/SQL ile nesnelerin tan�mland���-tarif edildi�i yap�ya s�n�f (class) denir ve a�a��daki gibi tan�mlan�r.*/

/*CREATE OR REPLACE TYPE kisi AS OBJECT (
    -- �zellik tan�mlar�
    -- prosed�r-metot tan�mlar�
) NOT FINAL; -- S�n�f nitelelikleri
--Tan�mlar yap�ld�ktan sonra BODY k�sm�nda prosed�r, fonksiyon gibi yap�lar�n i�eri�i yaz�l�r.

CREATE OR REPLACE TYPE BODY kisi
AS
    -- prosed�r-metot komutlar�
END;
--Tan�mlanan s�n�f kullan�c� tan�ml� veri t�rleri, paketler gibi kullan�labilir.

DECLARE
    v_yusuf kisi;
BEGIN
    -- v_yusuf.ozellik
    -- v_yusuf.metot()
END;
*/

--GERCEK BIR ORNEK:
CREATE OR REPLACE TYPE kisi AS OBJECT (
    kisi_sira   NUMBER,
    kisi_adi    VARCHAR2(100),
    kisi_soyadi VARCHAR2(100),
    kisi_eposta VARCHAR2(80)
);

SET SERVEROUTPUT ON;

DECLARE
    v_yusuf kisi := NEW kisi(NULL, NULL, NULL, NULL);
BEGIN
    v_yusuf.kisi_sira := 1;
    v_yusuf.kisi_adi := 'Yusuf';
    v_yusuf.kisi_soyadi := 'SEZER';
    v_yusuf.kisi_eposta := 'yusufsezer@mail.com';
    dbms_output.put_line(v_yusuf.kisi_sira);
    dbms_output.put_line(v_yusuf.kisi_adi);
    dbms_output.put_line(v_yusuf.kisi_soyadi);
    dbms_output.put_line(v_yusuf.kisi_eposta);
END;


/*Methods ve Procedures
PL/SQL s�n�f i�erisinde yer alan fonksiyonlara metot denir.

Metot ve prosed�r i�erisinde nesne ile ilgili i�lemler yer al�r.*/

CREATE OR REPLACE TYPE kisi AS OBJECT ( --BASLIK YANI METOT BASLIKLARINI ICEREN TYPE. INTERFACE GIBI METOT BASLIKLARI VAR.
    kisi_sira   NUMBER,
    kisi_adi    VARCHAR2(100),
    kisi_soyadi VARCHAR2(100),
    kisi_eposta VARCHAR2(80),
    member      procedure yazd�r,
    MEMBER FUNCTION adsoyad RETURN VARCHAR2,
    MAP MEMBER FUNCTION KARSILASTIR RETURN NUMBER
);
--SANKI JAVA TARAFINDAKI BIR INTERFACE'YI IMPELEMENTE EDEN BIR CLASS GIBI. METOT GOVDELERINI ICERIR.
CREATE OR REPLACE TYPE BODY kisi AS
    /*CONSTRUCTOR FUNCTION kisi (
        parametre1 VARCHAR2,
        parametre2 NUMBER
    ) RETURN SELF AS RESULT
        DETERMINISTIC;*/

    MEMBER PROCEDURE yazd�r IS
    BEGIN
        dbms_output.put_line(paramere1 + parametre2);
        dbms_output.put_line(self.kisi_sira);
        dbms_output.put_line(self.kisi_adi);
        dbms_output.put_line(self.kisi_soyadi);
        dbms_output.put_line(self.kisi_eposta);
    END;

    MEMBER FUNCTION adsoyad RETURN VARCHAR2 IS
    BEGIN
        RETURN self.kisi_adi || ' ' || self.kisi_soyadi;
    END;

    MAP MEMBER FUNCTION kars�last�r RETURN NUMBER IS
    BEGIN
        RETURN self.kisi_sira;
    END;
END;




--NOT: SELF anahtar kelimesi s�n�f i�erisindeki �zellik, metot ve prosed�rlere ula�mak i�in kullan�l�r.

SET SERVEROUTPUT ON;

DECLARE
    v_yusuf kisi := NEW kisi(NULL, NULL, NULL, NULL);
BEGIN
    v_yusuf.kisi_sira := 1;
    v_yusuf.kisi_adi := 'Yusuf';
    v_yusuf.kisi_soyadi := 'SEZER';
    v_yusuf.kisi_eposta := 'yusufsezer@mail.com';
    dbms_output.put_line('Ki�i ad� soyad�: ' || v_yusuf.adsoyad());
    v_yusuf.yazd�r;
END;

/*
Constructor
Nesne olu�turulurken �al��t�r�lan metot constructor veya kurucu olarak adland�r�l�r.

Oracle PL/SQL varsay�lan olarak t�m �zelliklere de�er atayan kurucuya sahiptir.

Kurucular�n metotlardan bir fark� yoktur.

Kurucular� �zel yapan nesne olu�turuldu�unda otomatik olarak �al��t�r�lmas�d�r.

Kurucu i�erisinde genellikle s�n�f i�erisinde yer alan �zelliklere de�er atan�r.

�rnek kurucu kullan�m� a�a��da yer almaktad�r.
*/

SET SERVEROUTPUT ON;
DECLARE
    v_yusuf kisi := NEW kisi(1, 'HUSEYIN', 'AYDIN', 'SELAM');  -- Kurucu ile de�erlere NULL de�eri atand�.
BEGIN
    /*v_yusuf.kisi_sira := 1;
    v_yusuf.kisi_adi := 'Yusuf';
    v_yusuf.kisi_soyadi := 'SEZER';
    v_yusuf.kisi_eposta := 'yusufsezer@mail.com';*/
    dbms_output.put_line('Ki�i ad� soyad�: ' || v_yusuf.adsoyad());
    v_yusuf.yazd�r;
END;
-- Kurucu ile de�erlere NULL de�eri atand�.
SET SERVEROUTPUT ON;

DECLARE
    v_yusuf kisi := NEW kisi(1, 'HUSEYIN', 'AYDIN', 'SELAM');
BEGIN
    /*v_yusuf.kisi_sira := 1;
    v_yusuf.kisi_adi := 'Yusuf';
    v_yusuf.kisi_soyadi := 'SEZER';
    v_yusuf.kisi_eposta := 'yusufsezer@mail.com';*/
    dbms_output.put_line('Ki�i ad� soyad�: ' || v_yusuf.adsoyad());
    v_yusuf.yazd�r;
END;

/*Kurucular varsay�lan olarak Oracle PL/SQL taraf�ndan olu�turuldu�u i�in tekrar tan�mlamaya ihtiya� yoktur.

Ancak farkl� bir kurucu tan�mlamas� i�in a�a��daki kurucu metot imzas� kullan�labilir.*/

--CONSTRUCTOR FUNCTION SINIF_ADI(PARAMETRE1, PARAMETRE2) RETURN SELF AS RESULT DETERMINISTIC;

/*
Map ve Order
Nesneler varsay�lan olarak birbiriyle kar��la�t�r�lmaz.

PL/SQL nesneleri kar��la�t�rma operat�r�yle kullanmak i�in map ve order anahtar kelimeleri kullan�r.

�rnek kullan�m a�a��daki gibidir.
*/

--MAP MEMBER FUNCTION KARSILASTIR RETURN NUMBER

















--YENI
CREATE OR REPLACE TYPE INSAN AS OBJECT (
    kisi_sira NUMBER,
    kisi_adi VARCHAR2(100),
    kisi_soyadi VARCHAR2(100),
    kisi_eposta VARCHAR2(80),
    MEMBER PROCEDURE YAZDIR,
    MEMBER FUNCTION ADSOYAD RETURN VARCHAR2,
    MAP MEMBER FUNCTION KARSILASTIR RETURN NUMBER,
    STATIC PROCEDURE YAZDIR2(METIN IN VARCHAR2)  -- Statik prosed�r tan�m�
);

CREATE OR REPLACE TYPE BODY INSAN AS
    MEMBER PROCEDURE YAZDIR IS
    BEGIN
        INSAN.YAZDIR2(SELF.kisi_sira);  -- Statik metot s�n�fad�.metot olarak �a�r�ld�.
        INSAN.YAZDIR2(SELF.kisi_adi);
        INSAN.YAZDIR2(SELF.kisi_soyadi);
        INSAN.YAZDIR2(SELF.kisi_eposta);
    END;
    MEMBER FUNCTION ADSOYAD RETURN VARCHAR2 IS
    BEGIN
        RETURN SELF.kisi_adi || ' ' || SELF.kisi_soyadi;
    END;
    MAP MEMBER FUNCTION KARSILASTIR RETURN NUMBER IS
    BEGIN
        RETURN SELF.kisi_sira;
    END;
    STATIC PROCEDURE YAZDIR2(METIN IN VARCHAR2) IS
    BEGIN
        DBMS_OUTPUT.put_line(METIN);
    END;
END;

DECLARE
    --adam INSAN := NEW INSAN(1, 'Yusuf', 'SEZER', 'yusufsezer@mail.com'); --OLMASADA OLUR (:
BEGIN 
    INSAN.yazd�r2('SELAMLAR BEN HUSO');
END;


/*
Tabloya eklenen veriye a�a��daki gibi eri�im sa�lanabilir.

DECLARE
    v_bulunan kisi;
BEGIN
    SELECT * INTO v_bulunan FROM KISILER WHERE ROWNUM = 1;
    v_bulunan.YAZDIR;
END;
*/

/*
Inheritance
S�n�f i�erisinde yer alan �zellik ve metotlar�n ba�ka s�n�f taraf�ndan devral�nmas�d�r.

PL/SQL s�n�flar�n�n kal�t�m �zelli�ini kullanabilmesi i�in NOT FINAL ile belirtilmesi gerekir.

CREATE OR REPLACE TYPE kisi AS OBJECT () NOT FINAL; -- Kal�t�m
Kal�t�m almak i�in UNDER anahtar kelimesi kullan�l�r.

CREATE OR REPLACE TYPE ogrenci UNDER kisi () NOT FINAL;
S�n�f i�erisinde yer alan prosed�r ve metotlara NOT FINAL anahtar kelimesi eklenerek prosed�r ve metotlar�n ezilmesi sa�lan�r.

Kal�t�m ile al�nan prosed�r ve metotlar�n ezilmesi i�in kal�t�m alan s�n�fta metodun ba��na OVERRIDING anahtar kelimesi eklenir.

NOT: Ezme i�lemi prosed�r ve metotlar�n i�eri�i de�i�tirilmek istendi�inde kullan�l�r.

Abstract
S�n�flardan �rnek bir nesne olu�turulmas�na izin verilmeyen s�n�flara soyut s�n�f (Abstract) denir.

Soyut s�n�flar nesneleri modellemek i�in kullan�l�r.

Bir s�n�f� soyut s�n�f olarak belirlemek i�in NOT INSTANTIABLE anahtar kelimesi kullan�l�r.

CREATE OR REPLACE TYPE insan AS OBJECT () NOT INSTANTIABLE NOT FINAL; -- Soyut s�n�f ve kal�t�m
S�n�flar� tablolarda kullanmak
PL/SQL i�erisinde yer alan s�n�flar�n �nemli bir �zelli�i tablolarda kullan�lmas�d�r.

CREATE TABLE KISILER (
    KISI KISI
);
Tabloya veri ekleme i�lemi a�a��daki gibi yap�labilir.

INSERT INTO KISILER VALUES ( new kisi(1, 'Yusuf', 'SEZER', 'yusufsezer@mail.com') );
Tabloya eklenen veriye a�a��daki gibi eri�im sa�lanabilir.

DECLARE
    v_bulunan kisi;
BEGIN
    SELECT * INTO v_bulunan FROM KISILER WHERE ROWNUM = 1;
    v_bulunan.YAZDIR;
END;
Benzer �ekilde UPDATE ve DELETE i�lemleri de yap�labilir.

Polymorphism
Kal�t�m al�nan s�n�flara taban s�n�f ile eri�meyi sa�lar.

Insan s�n�f�ndan kal�t�m alm�� Ogrenci, Ogretmen, Calisan gibi s�n�flar oldu�unu varsayal�m.

�ok bi�imlilik sayesinde bu s�n�flara taban s�n�f olan Insan s�n�f�n�n referans�yla eri�ilir.

Yani Ogrenci s�n�f�na Ogrenci olarak de�il Insan olarak eri�mek,

Ogremeten s�n�f�na Ogretmen olarak de�il Insan olarak eri�mek �rnek olarak verilebilir.

Sonu�
Oracle PL/SQL NYP �zelli�i;

Komutlar�n daha anla��l�r olmas�n� sa�lar.
Uygulamalar�n Records gibi d�zenli bir �ekilde saklanmas�n� sa�lar.
Tekrar kullan�labilirli�i artt�r�r.
Kal�t�m ile geni�letilebilir olmas�n� sa�lar.
NYP y�ntemi ile geli�tirmeyi C++, Java, C# gibi programlama dillerinde ��renmek faydal� olacakt�r.
*/


















--__






--___