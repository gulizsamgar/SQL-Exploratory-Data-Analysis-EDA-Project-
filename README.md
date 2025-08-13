# 📊 SQL kullanarak Keşifsel Veri Analizi (EDA)

## 🚀 Projeye Genel Bakış

**Kod:** [`Exploratory_data_analysis`](scripts/Exploratory_data_analysis.sql)

**Açıklama:**  Bu proje, SQL kullanarak satış, müşteri ve ürün verileri üzerinde keşifsel veri analizi (EDA) yapılmasını kapsamaktadır.  
Analiz sürecinde veritabanı keşfi, boyut ve tarih araştırması, temel ölçümler, büyüklük analizi ve sıralama analizleri yapılmıştır.  
Üst yönetim için elde edilen bulgular ve önerilerle stratejik karar alma süreçleri desteklenmiştir.


<img width="1116" height="775" alt="image" src="https://github.com/user-attachments/assets/56fe3f40-eb93-452a-8466-9cb59e8ed9c4" />

---

## 📂 Veri Seti Bilgisi

Projede üç veri seti kullanıldı:  

- [**fact_sales**](csv-files/gold.fact_sales.csv): Sipariş bazında satış detaylarını içerir (tarih, müşteri, ürün, miktar, tutar).  
- [**report_customers**](csv-files/gold.dim_customers.csv): Müşteri bazlı özet bilgileri ve segmentlerini içerir.  
- [**dim_products**](csv-files/gold.dim_products.csv): Ürünlerin ad, kategori, alt kategori, maliyet gibi tanımlayıcı bilgilerini içerir.  

Bu tablolar, müşteri ve ürün anahtarları üzerinden ilişkilendirilerek analizler yapılmıştır.

---

## 📋 İçerik

1. Database Exploration (Veritabanı Keşfi)  
2. Dimensions Exploration (Boyut araştırması)  
3. Date Exploration (Boyut araştırması)  
4. Measures Exploration (Boyut araştırması)  
5. Magnitude Analysis (Büyüklük analizi)

---

## 🛠 Teknolojiler

- [**SQL Server**](https://www.microsoft.com/en-us/sql-server/sql-server-downloads): Veritabanı yönetimi için hızlı ve güçlü bir RDBMS.  
- [**SQL Server Management Studio (SSMS)**](https://learn.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms): Veritabanlarını yönetmek için GUI (Grafiksel Kullanıcı Arayüzü). tabanlı araç.  
- [**GitHub**](https://github.com): Kodun sürüm takibi ve işbirliği için kullanılan platform.

---

## 💡 Kullanılan SQL Teknikleri

Projede aşağıdaki SQL teknikleri aktif olarak kullanılmıştır:

- **Veritabanı Keşfi** (`INFORMATION_SCHEMA` sorguları ile tablo ve kolon bilgisi alma)  
- **JOIN** türleri: `LEFT JOIN` ile veri birleştirme  
- **Aggregation Functions**: `SUM`, `AVG`, `COUNT`, `MIN`, `MAX`  
- **Grouping**: `GROUP BY` ile kategori, ülke, müşteri bazlı gruplama  
- **Ordering**: `ORDER BY` ile artan/azalan sıralama  
- **Limiting**: `TOP` ifadesi ile en iyi/kötü performans gösteren kayıtları bulma  
- **Date Functions**: `DATEDIFF` ile tarih farkı hesaplama  
- **DISTINCT** ile benzersiz değerlerin listelenmesi  
- **UNION ALL** ile metriklerin tek tabloda birleştirilmesi  
- **Window Functions**: `RANK()` ile sıralama ve filtreleme

---

## 📌 Aşağıda belirtilen analiz için Üst Yönetim için Temel Bulgular ve Öneriler

### 1. Satış ve Gelir Analizi

**Temel Bulgular:**
- Toplam satış tutarı: 29.356.250, toplam satış adeti: 60.423, ortalama ürün fiyatı: 486.
- En yüksek gelir getiren kategori Bikes (28.316.272), ardından Accessories (700.262) ve Clothing (339.716).
- Kategori bazında en yüksek gelire sahip ürün “Mountain-200” serisi bisikletler.
- Alt kategori bazında en yüksek gelire sahip 5 ürün: Road Bikes (14.519.438) Mountain Bikes  (9.952.254), Touring Bikes (3.844.580), Tires and Tubes (244.634), Helmest (225.435).
- En düşük getirili ürünler arasında Racing Socks-L, Racing Socks-M, Patch Kit/8 Patches gibi aksesuarlar bulunuyor.

**Öneriler:**
- Yüksek getirili bisiklet modelleri stokta tutulmalı, yeni varyasyonlar ile ürün gamı genişletilmeli.
- Düşük performanslı ürünler için promosyonlar, paket satışlar veya fiyat optimizasyonu yapılmalı.
- Orta gelir getiren ürünlerde çapraz satış stratejileri (örn. bisiklet + aksesuar paketi) uygulanmalı.

---

### 2. Müşteri Analizi

**Temel Bulgular:**
- Toplam sipariş veren müşteri sayısı, Toplam müşteri sayısı ile aynı: 18.484.
- En yüksek müşteri sayısına sahip ülke: ABD (7.482), ardından Avustralya (3.591) ve Birleşik Krallık (1.913).
- Müşteri cinsiyeti: Erkek (%50,5), Kadın (%49,3), tanımsız çok düşük.
- En yüksek gelir getiren 10 müşteri, kişi başı yaklaşık 13.200 – 13.300 gelir üretiyor. Bu segment değerli müşterileri içerir.
- En düşük gelir getiren müşteriler yalnızca 2 birim gelir getirmiş, bu da düşük etkileşimli veya tek seferlik alışveriş yapan bir segment olduğunu gösteriyor.

**Öneriler:**
- ABD ve Avustralya pazarlarında pazarlama bütçesi artırılmalı, özel kampanyalar planlanmalı.
- Yüksek gelirli müşteriler için sadakat programları ve özel tekliflerle müşteri elde tutma oranı artırılmalı.
- Düşük gelir getiren müşteriler için yeniden hedefleme (retargeting) kampanyaları yapılmalı.

---

### 3. Ürün ve Stok Yönetimi

**Temel Bulgular:**
- Toplam ürün sayısı: 295.
- En fazla ürün çeşidine sahip kategori: Components (127 ürün), ardından Bikes (97 ürün).
- Ortalama ürün maliyeti en yüksek kategori: Bikes (949), en düşük: Accessories (13-24).
- Bazı kategorilerde NULL değerler var (7 ürün), bu veri kalitesinde sorun yaratabilir.

**Öneriler:**
- Stok yönetimi yüksek maliyetli ürünlerde daha etkin yapılmalı.
- Düşük maliyetli ürünlerde kâr marjı artırıcı fiyatlandırma stratejileri değerlendirilmeli.

---

### 4. Demografik ve Zaman Analizi

**Temel Bulgular:**
- İlk sipariş tarihi: 2010-12-29, son sipariş: 2014-01-28, analiz dönemi: 37 ay.
- En yaşlı müşteri: 109 yaşında, en genç müşteri: 39 yaşında (doğum yılı 1986).

**Öneriler:**
- Yaş gruplarına göre hedefli kampanyalar düzenlenmeli (örn. genç müşterilere spor amaçlı ürünler, daha ileri yaşa uygun bisiklet ve aksesuarlar).
- Sezonluk satış trendleri analiz edilerek stok planlaması yapılmalı.

---

Şirket, bu içgörülerden yararlanarak karlılığı artırabilir, müşteri memnuniyetini artırabilir ve sürdürülebilir iş büyümesi sağlayabilir.

---

## 📜 SQL Sorguları

## 1. Database Exploration (Veritabanı Keşfi)

**Veritabanındaki tüm tabloların listesini alın**
```sql
SELECT 
    TABLE_CATALOG, 
    TABLE_SCHEMA, 
    TABLE_NAME, 
    TABLE_TYPE
FROM INFORMATION_SCHEMA.TABLES;
```

**Belirli bir tablonun tüm sütunlarını alın (dim_customers)**

```sql
SELECT 
    COLUMN_NAME, 
    DATA_TYPE, 
    IS_NULLABLE, 
    CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customers';
```

## 2. Dimensions Exploration (Boyut Keşfi)

**Müşterilerin geldiği benzersiz ülkelerin bir listesini alın**

```sql
SELECT DISTINCT 
    country 
FROM gold.dim_customers
ORDER BY country;
```

**Benzersiz kategorilerin, alt kategorilerin ve ürünlerin bir listesini alın**

```sql
SELECT DISTINCT 
    category, 
    subcategory, 
    product_name 
FROM gold.dim_products
ORDER BY category, subcategory, product_name;
```

## 3. Date Range Exploration (Tarih Aralığı Keşfi)

**İlk ve son sipariş tarihini ve toplam süreyi ay olarak belirleyin**

```sql
SELECT 
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date,
    DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS order_range_months
FROM gold.fact_sales;
```

**Doğum tarihine göre en genç ve en yaşlı müşteriyi bulun**

```sql
SELECT
    MIN(birthdate) AS oldest_birthdate,
    DATEDIFF(YEAR, MIN(birthdate), GETDATE()) AS oldest_age,
    MAX(birthdate) AS youngest_birthdate,
    DATEDIFF(YEAR, MAX(birthdate), GETDATE()) AS youngest_age
FROM gold.dim_customers;
```

## 4. Measures Exploration (Key Metrics) - (Ölçüm Keşfi)

**Toplam Satışları Bulun**

```sql
SELECT SUM(sales_amount) AS total_sales FROM gold.fact_sales
```

**Kaç adet ürünün satıldığını bulun**

```sql
SELECT SUM(quantity) AS total_quantity FROM gold.fact_sales
```

**Ortalama satış fiyatını bulun**

```sql
SELECT AVG(price) AS avg_price FROM gold.fact_sales
```

**Toplam sipariş sayısını bulun**

```sql
SELECT COUNT(order_number) AS total_orders FROM gold.fact_sales
SELECT COUNT(DISTINCT order_number) AS total_orders FROM gold.fact_sales
```

**Toplam ürün sayısını bulun**

```sql
SELECT COUNT(product_name) AS total_products FROM gold.dim_products
SELECT COUNT(DISTINCT product_name) AS total_products FROM gold.dim_products
```

**Toplam müşteri sayısını bulun**

```sql
SELECT COUNT(customer_key) AS total_customers FROM gold.dim_customers;
```

**Sipariş veren toplam müşteri sayısını bulun**

```sql
SELECT COUNT(DISTINCT customer_key) AS total_customers FROM gold.fact_sales;
```

**İşletmenin tüm önemli metriklerini gösteren bir Rapor oluşturun**

```sql
SELECT 'Total Sales' AS measure_name, SUM(sales_amount) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Quantity', SUM(quantity) FROM gold.fact_sales
UNION ALL
SELECT 'Average Price', AVG(price) FROM gold.fact_sales
UNION ALL
SELECT 'Total Orders', COUNT(DISTINCT order_number) FROM gold.fact_sales
UNION ALL
SELECT 'Total Products', COUNT(DISTINCT product_name) FROM gold.dim_products
UNION ALL
SELECT 'Total Customers', COUNT(customer_key) FROM gold.dim_customers;
```

## 5. Magnitude Analysis (Büyüklük Analizi)

**Ülkelere göre toplam müşteri sayısını bulun**

```sql
SELECT
    country,
    COUNT(customer_key) AS total_customers
FROM gold.dim_customers
GROUP BY country
ORDER BY total_customers DESC;
```

**Cinsiyete göre toplam müşteri sayısını bulun**

```sql
SELECT
    gender,
    COUNT(customer_key) AS total_customers
FROM gold.dim_customers
GROUP BY gender
ORDER BY total_customers DESC;
```

**Kategoriye göre toplam ürünü bulun**

```sql
SELECT
    category,
    COUNT(product_key) AS total_products
FROM gold.dim_products
GROUP BY category
ORDER BY total_products DESC;
```

**Her kategorideki ortalama maliyetler nedir?**

```sql
SELECT
    category,
    AVG(cost) AS avg_cost
FROM gold.dim_products
GROUP BY category
ORDER BY avg_cost DESC;
```

**Her kategori için elde edilen toplam gelir nedir?**

```sql
SELECT
    p.category,
    SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
    ON p.product_key = f.product_key
GROUP BY p.category
ORDER BY total_revenue DESC;
```

**Her müşterinin elde ettiği toplam gelir nedir?**

```sql
SELECT
    c.customer_key,
    c.first_name,
    c.last_name,
    SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
    ON c.customer_key = f.customer_key
GROUP BY 
    c.customer_key,
    c.first_name,
    c.last_name
ORDER BY total_revenue DESC;
```

**Satılan ürünlerin ülkelere göre dağılımı nasıldır?**

```sql
SELECT
    c.country,
    SUM(f.quantity) AS total_sold_items
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
    ON c.customer_key = f.customer_key
GROUP BY c.country
ORDER BY total_sold_items DESC;
```

## 6. Ranking Analysis (Sıralama Analizi)

**En Yüksek Geliri Sağlayan 5 Ürün Hangileri?**
**- Basit Sıralama**

```sql
SELECT TOP 5
    p.product_name,
    SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
    ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC;
```

**- Window Functions Kullanarak Karmaşık Ama Esnek Sıralama**

```sql
SELECT *
FROM (
    SELECT
        p.product_name,
        SUM(f.sales_amount) AS total_revenue,
        RANK() OVER (ORDER BY SUM(f.sales_amount) DESC) AS rank_products
    FROM gold.fact_sales f
    LEFT JOIN gold.dim_products p
        ON p.product_key = f.product_key
    GROUP BY p.product_name
) AS ranked_products
WHERE rank_products <= 5;
```

**Satış açısından en kötü performansı gösteren 5 ürün hangileridir?**

```sql
    p.product_name,
    SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
    ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue;
```

**En yüksek geliri sağlayan ilk 10 müşteriyi bulun**

```sql
SELECT TOP 10
    c.customer_key,
    c.first_name,
    c.last_name,
    SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
    ON c.customer_key = f.customer_key
GROUP BY 
    c.customer_key,
    c.first_name,
    c.last_name
ORDER BY total_revenue DESC;
```

**En az sipariş veren 3 müşteriyi bulun**

```sql
SELECT TOP 3
    c.customer_key,
    c.first_name,
    c.last_name,
    COUNT(DISTINCT order_number) AS total_orders
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
    ON c.customer_key = f.customer_key
GROUP BY 
    c.customer_key,
    c.first_name,
    c.last_name
ORDER BY total_orders ;
```

