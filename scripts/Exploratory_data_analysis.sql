/*
===============================================================================
1. Database Exploration (Veritabanı Keşfi)
===============================================================================
Amaç:
- Tabloların listesi ve şemaları dahil olmak üzere veritabanının yapısını incelemek.
- Belirli tabloların sütunlarını ve meta verilerini incelemek.

Tablo kullanımı:
    - INFORMATION_SCHEMA.TABLES
    - INFORMATION_SCHEMA.COLUMNS
===============================================================================
*/

-- Veritabanındaki tüm tabloların listesini alın
SELECT 
    TABLE_CATALOG, 
    TABLE_SCHEMA, 
    TABLE_NAME, 
    TABLE_TYPE
FROM INFORMATION_SCHEMA.TABLES;

-- Belirli bir tablonun tüm sütunlarını alın (dim_customers)
SELECT 
    COLUMN_NAME, 
    DATA_TYPE, 
    IS_NULLABLE, 
    CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customers';



/*
===============================================================================
2. Dimensions Exploration (Boyut Keşfi)
===============================================================================
Amaç:
- Boyut tablolarının yapısını incelemek.

Kullanılan SQL Fonksiyonları:
    - DISTINCT
    - ORDER BY
===============================================================================
*/

-- Müşterilerin geldiği benzersiz ülkelerin bir listesini alın
SELECT DISTINCT 
    country 
FROM gold.dim_customers
ORDER BY country;

-- Benzersiz kategorilerin, alt kategorilerin ve ürünlerin bir listesini alın
SELECT DISTINCT 
    category, 
    subcategory, 
    product_name 
FROM gold.dim_products
ORDER BY category, subcategory, product_name;



/*
===============================================================================
3. Date Range Exploration (Tarih Aralığı Keşfi)
===============================================================================
Amaç:
- Temel veri noktalarının zamansal sınırlarını belirlemek.
- Geçmiş verilerin aralığını anlamak.

Kullanılan SQL Fonksiyonları:
    - MIN(), MAX(), DATEDIFF()
===============================================================================
*/

-- İlk ve son sipariş tarihini ve toplam süreyi ay olarak belirleyin
SELECT 
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date,
    DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS order_range_months
FROM gold.fact_sales;

-- Doğum tarihine göre en genç ve en yaşlı müşteriyi bulun
SELECT
    MIN(birthdate) AS oldest_birthdate,
    DATEDIFF(YEAR, MIN(birthdate), GETDATE()) AS oldest_age,
    MAX(birthdate) AS youngest_birthdate,
    DATEDIFF(YEAR, MAX(birthdate), GETDATE()) AS youngest_age
FROM gold.dim_customers;



/*
===============================================================================
4. Measures Exploration (Key Metrics) - (Ölçüm Keşfi)
===============================================================================
Amaç:
- Hızlı içgörüler için toplu metrikleri (örneğin, toplamlar, ortalamalar) hesaplamak.
- Genel eğilimleri belirlemek veya anormallikleri tespit etmek.

Kullanılan SQL Fonksiyonları:
    - COUNT(), SUM(), AVG()
===============================================================================
*/

-- Toplam Satışları Bulun
SELECT SUM(sales_amount) AS total_sales FROM gold.fact_sales

-- Kaç adet ürünün satıldığını bulun
SELECT SUM(quantity) AS total_quantity FROM gold.fact_sales

-- Ortalama satış fiyatını bulun
SELECT AVG(price) AS avg_price FROM gold.fact_sales

-- Toplam sipariş sayısını bulun
SELECT COUNT(order_number) AS total_orders FROM gold.fact_sales
SELECT COUNT(DISTINCT order_number) AS total_orders FROM gold.fact_sales

-- Toplam ürün sayısını bulun
SELECT COUNT(product_name) AS total_products FROM gold.dim_products
SELECT COUNT(DISTINCT product_name) AS total_products FROM gold.dim_products

-- Toplam müşteri sayısını bulun
SELECT COUNT(customer_key) AS total_customers FROM gold.dim_customers;

-- Sipariş veren toplam müşteri sayısını bulun
SELECT COUNT(DISTINCT customer_key) AS total_customers FROM gold.fact_sales;

-- İşletmenin tüm önemli metriklerini gösteren bir Rapor oluşturun
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



/*
===============================================================================
5. Magnitude Analysis (Büyüklük Analizi)
===============================================================================
Amaç:
- Verileri ölçmek ve sonuçları belirli boyutlara göre gruplandırmak.
- Kategoriler arası veri dağılımını anlamak.

Kullanılan SQL Fonksiyonları:
    - Aggregate Functions: SUM(), COUNT(), AVG()
    - GROUP BY, ORDER BY
===============================================================================
*/

-- Ülkelere göre toplam müşteri sayısını bulun
SELECT
    country,
    COUNT(customer_key) AS total_customers
FROM gold.dim_customers
GROUP BY country
ORDER BY total_customers DESC;

--Cinsiyete göre toplam müşteri sayısını bulun
SELECT
    gender,
    COUNT(customer_key) AS total_customers
FROM gold.dim_customers
GROUP BY gender
ORDER BY total_customers DESC;

-- Kategoriye göre toplam ürünü bulun
SELECT
    category,
    COUNT(product_key) AS total_products
FROM gold.dim_products
GROUP BY category
ORDER BY total_products DESC;

-- Her kategorideki ortalama maliyetler nedir?
SELECT
    category,
    AVG(cost) AS avg_cost
FROM gold.dim_products
GROUP BY category
ORDER BY avg_cost DESC;

-- Her kategori için elde edilen toplam gelir nedir?
SELECT
    p.category,
    SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
    ON p.product_key = f.product_key
GROUP BY p.category
ORDER BY total_revenue DESC;

-- Her müşterinin elde ettiği toplam gelir nedir?
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

-- Satılan ürünlerin ülkelere göre dağılımı nasıldır?
SELECT
    c.country,
    SUM(f.quantity) AS total_sold_items
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
    ON c.customer_key = f.customer_key
GROUP BY c.country
ORDER BY total_sold_items DESC;



/*
===============================================================================
6. Ranking Analysis (Sıralama Analizi)
===============================================================================
Amaç:
- Ürünleri (örneğin ürünler, müşteriler) performans veya diğer ölçütlere göre sıralamak.
- En iyi performans gösterenleri veya geride kalanları belirlemek.

Kullanılan SQL Fonksiyonları:
    - Window Ranking Functions: RANK(), DENSE_RANK(), ROW_NUMBER(), TOP
    - Clauses: GROUP BY, ORDER BY
===============================================================================
*/

-- En Yüksek Geliri Sağlayan 5 Ürün Hangileri?
-- Basit Sıralama
SELECT TOP 5
    p.product_name,
    SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
    ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC;

-- Window Functions Kullanarak Karmaşık Ama Esnek Sıralama
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

-- Satış açısından en kötü performansı gösteren 5 ürün hangileridir?
SELECT TOP 5
    p.product_name,
    SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
    ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue;

-- En yüksek geliri sağlayan ilk 10 müşteriyi bulun
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

-- En az sipariş veren 3 müşteriyi bulun
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
