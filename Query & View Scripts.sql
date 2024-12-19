#QUERY 1: Show all current inventory at Recruiting Office X.
SELECT p.product_id AS 'Product ID', p.product_name AS 'Product', p.description AS 'Description', inv.quantity_instock AS 'Quantity In Stock'
FROM products, inventory inv
JOIN recruiting_office ro ON ro.office_id = inv.office_id
JOIN products p ON p.product_id = inv.product_id
WHERE inv.office_id = '1'
GROUP BY p.product_id
ORDER BY p.product_id;

#QUERY 2: What Product is used at the most Events
SELECT p.product_id AS 'Product ID', p.product_name AS 'Product Type', p.description AS 'Description', SUM(quantity_used) AS 'Total Product Used', COUNT(DISTINCT event_id) AS 'Total Events Used At'
FROM products, product_event pe
JOIN products p ON p.product_id = pe.product_id
GROUP BY p.product_id
ORDER BY SUM(quantity_used) DESC;

#QUERY 3: Show all of the Products ordered from Vendor X
SELECT v.vendor_id AS 'Vendor ID', v.vendor_name AS 'Vendor Name', p.product_id AS 'Product ID', p.product_name AS 'Product Name', p.description AS 'Description'
FROM vendor, products p
JOIN vendor v ON p.vendor_id = v.vendor_id
GROUP BY p.product_id
ORDER BY v.vendor_id;

#VIEW 1: All product, category, & vendor view
CREATE OR REPLACE VIEW all_product_category_vendor AS
SELECT v.vendor_name AS 'Vendor Name', v.vendor_address AS 'Vendor Address', v.vendor_city AS 'Vendor City', v.vendor_state AS 'Vendor State', v.vendor_zip AS 'Vendor Zip Code',v.vendor_phone AS 'Vendor Phone', v.vendor_website AS 'Vendor Website', p.product_name AS 'Product Name', p.description AS 'Product Description', p.unit_cost AS 'Product Unit Cost', p.items_per_unit AS 'Product Items per Unit', pc.category_name AS 'Product Category'
FROM vendor v
JOIN products p ON p.vendor_id = v.vendor_id
JOIN product_category pc ON pc.category_id = p.category_id;
