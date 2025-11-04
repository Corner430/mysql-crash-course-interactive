━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📚 第 17 章：组合查询
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📖 学习目标
──────────────────────────────────────
✓ 理解组合查询的概念和用途
✓ 掌握 UNION 操作符的使用
✓ 了解 UNION 和 UNION ALL 的区别
✓ 学会对组合查询结果排序

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📝 核心知识点
──────────────────────────────────────

1️⃣  组合查询的概念
   ────────────────────────────────────
   组合查询（compound query）也称并（union）
   执行多个查询，将结果作为单个查询结果集返回
   
   使用场景：
   • 在单个查询中从不同表返回数据
   • 对单个表执行多个查询，按单个查询返回数据


2️⃣  创建组合查询 - UNION
   ────────────────────────────────────
   SELECT vend_id, prod_id, prod_price
   FROM products
   WHERE prod_price <= 5
   UNION
   SELECT vend_id, prod_id, prod_price
   FROM products
   WHERE vend_id IN (1001, 1002);
   
   说明：返回价格<=5的产品 和 供应商1001、1002的产品


3️⃣  UNION 规则
   ────────────────────────────────────
   1. UNION 必须由两条或以上的SELECT语句组成
   2. 每个查询必须包含相同的列、表达式或聚集函数
   3. 列数据类型必须兼容（可以不完全相同）
   4. UNION 自动去除重复的行


4️⃣  UNION vs WHERE
   ────────────────────────────────────
   UNION 方式：
   SELECT vend_id, prod_id, prod_price
   FROM products
   WHERE prod_price <= 5
   UNION
   SELECT vend_id, prod_id, prod_price
   FROM products
   WHERE vend_id IN (1001, 1002);
   
   WHERE 方式（等价）：
   SELECT vend_id, prod_id, prod_price
   FROM products
   WHERE prod_price <= 5
      OR vend_id IN (1001, 1002);
   
   说明：简单的UNION可以用WHERE替代


5️⃣  UNION ALL - 包含重复行
   ────────────────────────────────────
   SELECT vend_id, prod_id, prod_price
   FROM products
   WHERE prod_price <= 5
   UNION ALL
   SELECT vend_id, prod_id, prod_price
   FROM products
   WHERE vend_id IN (1001, 1002);
   
   区别：
   • UNION 自动去除重复行
   • UNION ALL 返回所有匹配行
   • UNION ALL 性能更好（不需要去重）


6️⃣  对组合查询结果排序
   ────────────────────────────────────
   SELECT vend_id, prod_id, prod_price
   FROM products
   WHERE prod_price <= 5
   UNION
   SELECT vend_id, prod_id, prod_price
   FROM products
   WHERE vend_id IN (1001, 1002)
   ORDER BY vend_id, prod_price;
   
   注意：
   • ORDER BY 只能出现在最后一条SELECT后面
   • 对整个结果集排序，不是对单个SELECT


7️⃣  组合不同的表
   ────────────────────────────────────
   SELECT cust_name, cust_contact, cust_email
   FROM customers
   WHERE cust_state IN ('IL', 'IN', 'MI')
   UNION
   SELECT cust_name, cust_contact, cust_email
   FROM customers
   WHERE cust_name = 'Coyote Inc.';
   
   说明：也可以组合来自不同表的数据
   只要列结构兼容即可


8️⃣  UNION 的实际应用
   ────────────────────────────────────
   SELECT prod_id, prod_name, 'Low Price' AS price_category
   FROM products
   WHERE prod_price < 5
   UNION
   SELECT prod_id, prod_name, 'Medium Price'
   FROM products
   WHERE prod_price BETWEEN 5 AND 10
   UNION
   SELECT prod_id, prod_name, 'High Price'
   FROM products
   WHERE prod_price > 10
   ORDER BY prod_name;
   
   说明：为不同价格区间的产品添加分类标签

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 实践任务
──────────────────────────────────────

📝 基础练习
──────────────────────────────────────

练习 1: 简单的UNION
──────────────────────────────────────
组合价格<5的产品和供应商1003的产品

你的SQL：
  SELECT prod_id, prod_name, prod_price
  FROM products
  WHERE prod_price < 5
  UNION
  SELECT prod_id, prod_name, prod_price
  FROM products
  WHERE vend_id = 1003;


练习 2: UNION ALL 示例
──────────────────────────────────────
使用UNION ALL显示所有低价和中价产品（包含重复）

你的SQL：
  SELECT prod_name, prod_price
  FROM products
  WHERE prod_price < 5
  UNION ALL
  SELECT prod_name, prod_price
  FROM products
  WHERE prod_price BETWEEN 5 AND 10;


练习 3: 带排序的UNION
──────────────────────────────────────
组合两个查询并按价格排序

你的SQL：
  SELECT prod_name, prod_price
  FROM products
  WHERE vend_id = 1001
  UNION
  SELECT prod_name, prod_price
  FROM products
  WHERE vend_id = 1002
  ORDER BY prod_price;


练习 4: 客户数据合并
──────────────────────────────────────
查找IL州的客户 或 名字包含'Inc'的客户

你的SQL：
  SELECT cust_name, cust_state
  FROM customers
  WHERE cust_state = 'IL'
  UNION
  SELECT cust_name, cust_state
  FROM customers
  WHERE cust_name LIKE '%Inc%';


练习 5: 多条件组合
──────────────────────────────────────
组合三个不同条件的产品查询

你的SQL：
  SELECT prod_id, prod_name FROM products WHERE prod_price < 4
  UNION
  SELECT prod_id, prod_name FROM products WHERE vend_id = 1002
  UNION
  SELECT prod_id, prod_name FROM products WHERE prod_name LIKE '%TNT%';

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🚀 进阶挑战
──────────────────────────────────────

挑战 1: 产品分类标签
──────────────────────────────────────
为产品添加价格分类标签（低/中/高）

你的SQL：
  SELECT prod_name, prod_price, 'Cheap' AS category
  FROM products WHERE prod_price < 5
  UNION
  SELECT prod_name, prod_price, 'Normal'
  FROM products WHERE prod_price BETWEEN 5 AND 10
  UNION
  SELECT prod_name, prod_price, 'Expensive'
  FROM products WHERE prod_price > 10
  ORDER BY prod_price;


挑战 2: 供应商和客户联系人
──────────────────────────────────────
创建一个包含所有供应商和客户联系信息的列表

你的SQL：
  SELECT vend_name AS name, vend_city AS city, 'Vendor' AS type
  FROM vendors
  UNION
  SELECT cust_name, cust_city, 'Customer'
  FROM customers
  ORDER BY name;


挑战 3: 复杂条件组合
──────────────────────────────────────
查找：1) 价格>10的产品 2) 供应商1001的产品 3) 名称含'anvil'的产品

你的SQL：
  SELECT prod_id, prod_name, prod_price, vend_id
  FROM products WHERE prod_price > 10
  UNION
  SELECT prod_id, prod_name, prod_price, vend_id
  FROM products WHERE vend_id = 1001
  UNION
  SELECT prod_id, prod_name, prod_price, vend_id
  FROM products WHERE prod_name LIKE '%anvil%'
  ORDER BY prod_name;


挑战 4: 订单状态汇总
──────────────────────────────────────
组合显示：大额订单(>100)和小额订单(<20)

你的SQL：
  SELECT order_num, SUM(quantity * item_price) AS total, 'Large' AS size
  FROM orderitems
  GROUP BY order_num
  HAVING total > 100
  UNION
  SELECT order_num, SUM(quantity * item_price), 'Small'
  FROM orderitems
  GROUP BY order_num
  HAVING SUM(quantity * item_price) < 20
  ORDER BY total DESC;


挑战 5: 产品可用性报告
──────────────────────────────────────
组合显示：已售产品和未售产品

你的SQL：
  SELECT p.prod_name, 'Sold' AS status, SUM(oi.quantity) AS qty
  FROM products p
  JOIN orderitems oi ON p.prod_id = oi.prod_id
  GROUP BY p.prod_id, p.prod_name
  UNION
  SELECT p.prod_name, 'Not Sold', 0
  FROM products p
  LEFT JOIN orderitems oi ON p.prod_id = oi.prod_id
  WHERE oi.order_num IS NULL
  ORDER BY status, prod_name;

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💡 重要提示
──────────────────────────────────────

⚠️  列的数量和顺序
   UNION中的每个SELECT必须有相同数量的列
   列的顺序必须相同
   数据类型不必完全相同，但必须兼容

⚠️  UNION vs UNION ALL
   UNION：自动去除重复行（性能较慢）
   UNION ALL：保留所有行（性能更快）
   如果确定没有重复，优先使用UNION ALL

⚠️  ORDER BY 位置
   ORDER BY只能出现在最后
   它对整个UNION结果排序
   不能对各个SELECT单独排序

⚠️  列名
   返回结果使用第一条SELECT中的列名
   后续SELECT的列名会被忽略
   使用AS别名统一命名

⚠️  性能考虑
   复杂的UNION可能影响性能
   如果可以用WHERE OR替代，考虑使用WHERE
   UNION ALL比UNION快，因为不需要去重

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 实战示例
──────────────────────────────────────

示例 1: 价格筛选组合
  SELECT prod_id, prod_name, prod_price
  FROM products
  WHERE prod_price <= 5
  UNION
  SELECT prod_id, prod_name, prod_price
  FROM products
  WHERE vend_id IN (1001, 1002)
  ORDER BY prod_price;


示例 2: 客户地区汇总
  SELECT cust_name, cust_city, cust_state, 'East' AS region
  FROM customers
  WHERE cust_state IN ('NY', 'NJ')
  UNION
  SELECT cust_name, cust_city, cust_state, 'West'
  FROM customers
  WHERE cust_state IN ('CA', 'OR')
  ORDER BY region, cust_name;


示例 3: 产品状态统计
  SELECT 'Total Products' AS description, COUNT(*) AS count
  FROM products
  UNION
  SELECT 'Products Sold', COUNT(DISTINCT prod_id)
  FROM orderitems
  UNION
  SELECT 'Products Not Sold', 
         (SELECT COUNT(*) FROM products) - COUNT(DISTINCT prod_id)
  FROM orderitems;


示例 4: 多表联系信息
  SELECT CONCAT('Vendor: ', vend_name) AS contact_info, 
         vend_city AS city
  FROM vendors
  UNION
  SELECT CONCAT('Customer: ', cust_name), cust_city
  FROM customers
  ORDER BY city;


示例 5: 价格区间分析
  SELECT 'Under $5' AS price_range, COUNT(*) AS products,
         AVG(prod_price) AS avg_price
  FROM products WHERE prod_price < 5
  UNION
  SELECT '$5-$10', COUNT(*), AVG(prod_price)
  FROM products WHERE prod_price BETWEEN 5 AND 10
  UNION
  SELECT 'Over $10', COUNT(*), AVG(prod_price)
  FROM products WHERE prod_price > 10;

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎓 知识检查点
──────────────────────────────────────

□ 你理解什么是组合查询吗？
□ 你会使用UNION操作符吗？
□ 你知道UNION的规则吗？
□ 你理解UNION和UNION ALL的区别吗？
□ 你知道何时使用UNION代替WHERE吗？
□ 你会对UNION结果排序吗？
□ 你了解UNION的性能影响吗？
□ 你知道如何组合不同表的数据吗？

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✨ 本章小结
──────────────────────────────────────

你已经学会了：
✓ 理解组合查询的概念和应用
✓ 使用UNION组合多个SELECT语句
✓ 理解UNION的规则和限制
✓ 区分UNION和UNION ALL的用法
✓ 对组合查询结果进行排序
✓ 使用UNION组合不同表的数据
✓ 了解UNION的性能考虑

下一章将学习MySQL的全文本搜索功能！

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💻 动手实践
──────────────────────────────────────
现在就打开 MySQL，在 crashcourse 数据库中
试试组合查询的强大功能吧！

