/*PL/SQL OOP
Oracle PL/SQL NYP yöntemine göre geliþtirme yapmayý saðlar.

PL/SQL ile nesnelerin tanýmlandýðý-tarif edildiði yapýya sýnýf (class) denir ve aþaðýdaki gibi tanýmlanýr.*/

/*CREATE OR REPLACE TYPE kisi AS OBJECT (
    -- özellik tanýmlarý
    -- prosedür-metot tanýmlarý
) NOT FINAL; -- Sýnýf nitelelikleri
--Tanýmlar yapýldýktan sonra BODY kýsmýnda prosedür, fonksiyon gibi yapýlarýn içeriði yazýlýr.

CREATE OR REPLACE TYPE BODY kisi
AS
    -- prosedür-metot komutlarý
END;
--Tanýmlanan sýnýf kullanýcý tanýmlý veri türleri, paketler gibi kullanýlabilir.

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
PL/SQL sýnýf içerisinde yer alan fonksiyonlara metot denir.

Metot ve prosedür içerisinde nesne ile ilgili iþlemler yer alýr.*/

CREATE OR REPLACE TYPE kisi AS OBJECT ( --BASLIK YANI METOT BASLIKLARINI ICEREN TYPE. INTERFACE GIBI METOT BASLIKLARI VAR.
    kisi_sira   NUMBER,
    kisi_adi    VARCHAR2(100),
    kisi_soyadi VARCHAR2(100),
    kisi_eposta VARCHAR2(80),
    member      procedure yazdýr,
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

    MEMBER PROCEDURE yazdýr IS
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

    MAP MEMBER FUNCTION karsýlastýr RETURN NUMBER IS
    BEGIN
        RETURN self.kisi_sira;
    END;
END;




--NOT: SELF anahtar kelimesi sýnýf içerisindeki özellik, metot ve prosedürlere ulaþmak için kullanýlýr.

SET SERVEROUTPUT ON;

DECLARE
    v_yusuf kisi := NEW kisi(NULL, NULL, NULL, NULL);
BEGIN
    v_yusuf.kisi_sira := 1;
    v_yusuf.kisi_adi := 'Yusuf';
    v_yusuf.kisi_soyadi := 'SEZER';
    v_yusuf.kisi_eposta := 'yusufsezer@mail.com';
    dbms_output.put_line('Kiþi adý soyadý: ' || v_yusuf.adsoyad());
    v_yusuf.yazdýr;
END;

/*
Constructor
Nesne oluþturulurken çalýþtýrýlan metot constructor veya kurucu olarak adlandýrýlýr.

Oracle PL/SQL varsayýlan olarak tüm özelliklere deðer atayan kurucuya sahiptir.

Kurucularýn metotlardan bir farký yoktur.

Kurucularý özel yapan nesne oluþturulduðunda otomatik olarak çalýþtýrýlmasýdýr.

Kurucu içerisinde genellikle sýnýf içerisinde yer alan özelliklere deðer atanýr.

Örnek kurucu kullanýmý aþaðýda yer almaktadýr.
*/

SET SERVEROUTPUT ON;
DECLARE
    v_yusuf kisi := NEW kisi(1, 'HUSEYIN', 'AYDIN', 'SELAM');  -- Kurucu ile deðerlere NULL deðeri atandý.
BEGIN
    /*v_yusuf.kisi_sira := 1;
    v_yusuf.kisi_adi := 'Yusuf';
    v_yusuf.kisi_soyadi := 'SEZER';
    v_yusuf.kisi_eposta := 'yusufsezer@mail.com';*/
    dbms_output.put_line('Kiþi adý soyadý: ' || v_yusuf.adsoyad());
    v_yusuf.yazdýr;
END;
-- Kurucu ile deðerlere NULL deðeri atandý.
SET SERVEROUTPUT ON;

DECLARE
    v_yusuf kisi := NEW kisi(1, 'HUSEYIN', 'AYDIN', 'SELAM');
BEGIN
    /*v_yusuf.kisi_sira := 1;
    v_yusuf.kisi_adi := 'Yusuf';
    v_yusuf.kisi_soyadi := 'SEZER';
    v_yusuf.kisi_eposta := 'yusufsezer@mail.com';*/
    dbms_output.put_line('Kiþi adý soyadý: ' || v_yusuf.adsoyad());
    v_yusuf.yazdýr;
END;

/*Kurucular varsayýlan olarak Oracle PL/SQL tarafýndan oluþturulduðu için tekrar tanýmlamaya ihtiyaç yoktur.

Ancak farklý bir kurucu tanýmlamasý için aþaðýdaki kurucu metot imzasý kullanýlabilir.*/

--CONSTRUCTOR FUNCTION SINIF_ADI(PARAMETRE1, PARAMETRE2) RETURN SELF AS RESULT DETERMINISTIC;

/*
Map ve Order
Nesneler varsayýlan olarak birbiriyle karþýlaþtýrýlmaz.

PL/SQL nesneleri karþýlaþtýrma operatörüyle kullanmak için map ve order anahtar kelimeleri kullanýr.

Örnek kullaným aþaðýdaki gibidir.
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
    STATIC PROCEDURE YAZDIR2(METIN IN VARCHAR2)  -- Statik prosedür tanýmý
);

CREATE OR REPLACE TYPE BODY INSAN AS
    MEMBER PROCEDURE YAZDIR IS
    BEGIN
        INSAN.YAZDIR2(SELF.kisi_sira);  -- Statik metot sýnýfadý.metot olarak çaðrýldý.
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
    INSAN.yazdýr2('SELAMLAR BEN HUSO');
END;


/*
Tabloya eklenen veriye aþaðýdaki gibi eriþim saðlanabilir.

DECLARE
    v_bulunan kisi;
BEGIN
    SELECT * INTO v_bulunan FROM KISILER WHERE ROWNUM = 1;
    v_bulunan.YAZDIR;
END;
*/

/*
Inheritance
Sýnýf içerisinde yer alan özellik ve metotlarýn baþka sýnýf tarafýndan devralýnmasýdýr.

PL/SQL sýnýflarýnýn kalýtým özelliðini kullanabilmesi için NOT FINAL ile belirtilmesi gerekir.

CREATE OR REPLACE TYPE kisi AS OBJECT () NOT FINAL; -- Kalýtým
Kalýtým almak için UNDER anahtar kelimesi kullanýlýr.

CREATE OR REPLACE TYPE ogrenci UNDER kisi () NOT FINAL;
Sýnýf içerisinde yer alan prosedür ve metotlara NOT FINAL anahtar kelimesi eklenerek prosedür ve metotlarýn ezilmesi saðlanýr.

Kalýtým ile alýnan prosedür ve metotlarýn ezilmesi için kalýtým alan sýnýfta metodun baþýna OVERRIDING anahtar kelimesi eklenir.

NOT: Ezme iþlemi prosedür ve metotlarýn içeriði deðiþtirilmek istendiðinde kullanýlýr.

Abstract
Sýnýflardan örnek bir nesne oluþturulmasýna izin verilmeyen sýnýflara soyut sýnýf (Abstract) denir.

Soyut sýnýflar nesneleri modellemek için kullanýlýr.

Bir sýnýfý soyut sýnýf olarak belirlemek için NOT INSTANTIABLE anahtar kelimesi kullanýlýr.

CREATE OR REPLACE TYPE insan AS OBJECT () NOT INSTANTIABLE NOT FINAL; -- Soyut sýnýf ve kalýtým
Sýnýflarý tablolarda kullanmak
PL/SQL içerisinde yer alan sýnýflarýn önemli bir özelliði tablolarda kullanýlmasýdýr.

CREATE TABLE KISILER (
    KISI KISI
);
Tabloya veri ekleme iþlemi aþaðýdaki gibi yapýlabilir.

INSERT INTO KISILER VALUES ( new kisi(1, 'Yusuf', 'SEZER', 'yusufsezer@mail.com') );
Tabloya eklenen veriye aþaðýdaki gibi eriþim saðlanabilir.

DECLARE
    v_bulunan kisi;
BEGIN
    SELECT * INTO v_bulunan FROM KISILER WHERE ROWNUM = 1;
    v_bulunan.YAZDIR;
END;
Benzer þekilde UPDATE ve DELETE iþlemleri de yapýlabilir.

Polymorphism
Kalýtým alýnan sýnýflara taban sýnýf ile eriþmeyi saðlar.

Insan sýnýfýndan kalýtým almýþ Ogrenci, Ogretmen, Calisan gibi sýnýflar olduðunu varsayalým.

Çok biçimlilik sayesinde bu sýnýflara taban sýnýf olan Insan sýnýfýnýn referansýyla eriþilir.

Yani Ogrenci sýnýfýna Ogrenci olarak deðil Insan olarak eriþmek,

Ogremeten sýnýfýna Ogretmen olarak deðil Insan olarak eriþmek örnek olarak verilebilir.

Sonuç
Oracle PL/SQL NYP özelliði;

Komutlarýn daha anlaþýlýr olmasýný saðlar.
Uygulamalarýn Records gibi düzenli bir þekilde saklanmasýný saðlar.
Tekrar kullanýlabilirliði arttýrýr.
Kalýtým ile geniþletilebilir olmasýný saðlar.
NYP yöntemi ile geliþtirmeyi C++, Java, C# gibi programlama dillerinde öðrenmek faydalý olacaktýr.
*/


















--__






--___