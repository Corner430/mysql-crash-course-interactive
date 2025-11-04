━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📚 第 15 章：联结表
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📖 学习目标
──────────────────────────────────────
✓ 理解关系表和联结的概念
✓ 掌握 INNER JOIN 的使用方法
✓ 学会联结多个表
✓ 了解笛卡尔积及如何避免

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📝 核心知识点
──────────────────────────────────────

1️⃣  为什么使用联结
   ────────────────────────────────────
   关系数据库设计把信息分解为多个表
   通过联结可以在一条 SELECT 语句中检索多个表的数据
   
   crashcourse 数据库示例：
   • vendors 表：供应商信息
   • products 表：产品信息（包含 vend_id）
   • 通过 vend_id 可以联结两个表


2️⃣  创建联结 - 基本语法
   ────────────────────────────────────
   SELECT vend_name, prod_name, prod_price
   FROM vendors, products
   WHERE vendors.vend_id = products.vend_id
   ORDER BY vend_name, prod_name;
   
   说明：
   • FROM 子句列出两个表
   • WHERE 子句指定联结条件
   • 使用完全限定列名避免歧义


3️⃣  INNER JOIN 语法（推荐）
   ────────────────────────────────────
   SELECT vend_name, prod_name, prod_price
   FROM vendors
   INNER JOIN products ON vendors.vend_id = products.vend_id
   ORDER BY vend_name;
   
   优点：
   • 联结条件与过滤条件分离
   • 代码更清晰易读
   • 减少错误


4️⃣  笛卡尔积（危险！）
   ────────────────────────────────────
   没有联结条件的查询会返回笛卡尔积
   
   ❌ 错误示例：
   SELECT vend_name, prod_name
   FROM vendors, products;
   
   结果：6个供应商 × 14个产品 = 84行
   
   ⚠️  始终提供联结条件！


5️⃣  联结多个表
   ────────────────────────────────────
   SELECT prod_name, vend_name, prod_price, quantity
   FROM orderitems oi
   INNER JOIN products p ON oi.prod_id = p.prod_id
   INNER JOIN vendors v ON p.vend_id = v.vend_id
   WHERE oi.order_num = 20005;
   
   说明：
   • 联结了3个表
   • 使用表别名简化代码
   • 每个联结都需要 ON 条件


6️⃣  表别名
   ────────────────────────────────────
   SELECT p.prod_name, v.vend_name
   FROM products AS p
   INNER JOIN vendors AS v ON p.vend_id = v.vend_id;
   
   别名优点：
   • 缩短 SQL 语句
   • 可以在一条 SELECT 中多次使用同一表
   • AS 关键字可选


7️⃣  实用联结示例
   ────────────────────────────────────
   查询：显示客户的订单信息
   
   SELECT c.cust_name, o.order_num, o.order_date
   FROM customers c
   INNER JOIN orders o ON c.cust_id = o.cust_id
   ORDER BY c.cust_name, o.order_date;
   
   结果：每个客户及其所有订单


8️⃣  联结与子查询对比
   ────────────────────────────────────
   找出购买了 TNT2 的客户：
   
   方法1 - 子查询：
   SELECT cust_name
   FROM customers
   WHERE cust_id IN (SELECT cust_id FROM orders
                     WHERE order_num IN (SELECT order_num 
                                        FROM orderitems
                                        WHERE prod_id='TNT2'));
   
   方法2 - 联结：
   SELECT DISTINCT cust_name
   FROM customers c
   INNER JOIN orders o ON c.cust_id = o.cust_id
   INNER JOIN orderitems oi ON o.order_num = oi.order_num
   WHERE oi.prod_id = 'TNT2';
   
   联结通常性能更好

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 实践任务
──────────────────────────────────────

📝 基础练习
──────────────────────────────────────

练习 1: 产品和供应商联结
──────────────────────────────────────
显示所有产品名称及其供应商名称

你的SQL：
  SELECT prod_name, vend_name
  FROM products p
  INNER JOIN vendors v ON p.vend_id = v.vend_id;


练习 2: 客户订单联结
──────────────────────────────────────
显示所有客户名称及其订单号

你的SQL：
  SELECT cust_name, order_num
  FROM customers c
  INNER JOIN orders o ON c.cust_id = o.cust_id
  ORDER BY cust_name;


练习 3: 订单详细信息
──────────────────────────────────────
显示订单20005的产品名称和数量

你的SQL：
  SELECT prod_name, quantity
  FROM orderitems oi
  INNER JOIN products p ON oi.prod_id = p.prod_id
  WHERE oi.order_num = 20005;


练习 4: 三表联结
──────────────────────────────────────
显示订单20005的产品名称、供应商名称和数量

你的SQL：
  SELECT p.prod_name, v.vend_name, oi.quantity
  FROM orderitems oi
  INNER JOIN products p ON oi.prod_id = p.prod_id
  INNER JOIN vendors v ON p.vend_id = v.vend_id
  WHERE oi.order_num = 20005;


练习 5: 客户订单详情
──────────────────────────────────────
显示客户名称、订单号和订单日期

你的SQL：
  SELECT c.cust_name, o.order_num, o.order_date
  FROM customers c
  INNER JOIN orders o ON c.cust_id = o.cust_id
  ORDER BY o.order_date;

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🚀 进阶挑战
──────────────────────────────────────

挑战 1: 完整订单信息
──────────────────────────────────────
显示所有订单的客户名、产品名、数量、单价

你的SQL：
  SELECT c.cust_name, p.prod_name, oi.quantity, oi.item_price
  FROM customers c
  INNER JOIN orders o ON c.cust_id = o.cust_id
  INNER JOIN orderitems oi ON o.order_num = oi.order_num
  INNER JOIN products p ON oi.prod_id = p.prod_id
  ORDER BY c.cust_name, o.order_num;


挑战 2: 供应商产品统计
──────────────────────────────────────
显示每个供应商的名称和产品数量

你的SQL：
  SELECT v.vend_name, COUNT(p.prod_id) AS num_prods
  FROM vendors v
  INNER JOIN products p ON v.vend_id = p.vend_id
  GROUP BY v.vend_id, v.vend_name
  ORDER BY num_prods DESC;


挑战 3: 产品销售情况
──────────────────────────────────────
显示每个产品的名称和总销售数量

你的SQL：
  SELECT p.prod_name, SUM(oi.quantity) AS total_sold
  FROM products p
  INNER JOIN orderitems oi ON p.prod_id = oi.prod_id
  GROUP BY p.prod_id, p.prod_name
  ORDER BY total_sold DESC;


挑战 4: 客户消费统计
──────────────────────────────────────
显示每个客户的总消费金额

你的SQL：
  SELECT c.cust_name,
         SUM(oi.quantity * oi.item_price) AS total_spent
  FROM customers c
  INNER JOIN orders o ON c.cust_id = o.cust_id
  INNER JOIN orderitems oi ON o.order_num = oi.order_num
  GROUP BY c.cust_id, c.cust_name
  ORDER BY total_spent DESC;


挑战 5: 特定供应商的订单
──────────────────────────────────────
找出购买了供应商1003产品的所有客户名称

你的SQL：
  SELECT DISTINCT c.cust_name
  FROM customers c
  INNER JOIN orders o ON c.cust_id = o.cust_id
  INNER JOIN orderitems oi ON o.order_num = oi.order_num
  INNER JOIN products p ON oi.prod_id = p.prod_id
  WHERE p.vend_id = 1003
  ORDER BY c.cust_name;

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💡 重要提示
──────────────────────────────────────

⚠️  始终提供联结条件
   忘记联结条件会产生笛卡尔积
   返回的行数 = 表1行数 × 表2行数
   可能导致严重的性能问题

⚠️  使用完全限定列名
   当多个表有相同列名时必须指定表名
   推荐始终使用完全限定列名
   示例：products.vend_id, vendors.vend_id

⚠️  INNER JOIN 优于 WHERE
   现代 SQL 推荐使用 INNER JOIN ON 语法
   优点：联结条件与过滤条件分离
   代码更清晰，减少错误

⚠️  性能考虑
   联结的表越多，性能越受影响
   确保联结列上有索引
   避免不必要的联结

⚠️  表的顺序
   在 INNER JOIN 中，表的顺序通常不影响结果
   但可能影响性能
   MySQL 优化器会尝试找到最优执行顺序

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 实战示例
──────────────────────────────────────

示例 1: 产品供应商联结
  SELECT p.prod_id, p.prod_name, v.vend_name, v.vend_city
  FROM products p
  INNER JOIN vendors v ON p.vend_id = v.vend_id
  WHERE p.prod_price >= 10
  ORDER BY p.prod_name;


示例 2: 订单统计
  SELECT c.cust_name, COUNT(o.order_num) AS num_orders
  FROM customers c
  INNER JOIN orders o ON c.cust_id = o.cust_id
  GROUP BY c.cust_id, c.cust_name
  HAVING num_orders > 1;


示例 3: 四表联结
  SELECT c.cust_name, o.order_num, p.prod_name, 
         v.vend_name, oi.quantity
  FROM customers c
  INNER JOIN orders o ON c.cust_id = o.cust_id
  INNER JOIN orderitems oi ON o.order_num = oi.order_num
  INNER JOIN products p ON oi.prod_id = p.prod_id
  INNER JOIN vendors v ON p.vend_id = v.vend_id
  WHERE o.order_num = 20005;


示例 4: 价格汇总
  SELECT v.vend_name,
         COUNT(p.prod_id) AS products,
         AVG(p.prod_price) AS avg_price,
         MAX(p.prod_price) AS max_price
  FROM vendors v
  INNER JOIN products p ON v.vend_id = p.vend_id
  GROUP BY v.vend_id, v.vend_name;


示例 5: 订单金额明细
  SELECT o.order_num,
         c.cust_name,
         SUM(oi.quantity * oi.item_price) AS order_total
  FROM orders o
  INNER JOIN customers c ON o.cust_id = c.cust_id
  INNER JOIN orderitems oi ON o.order_num = oi.order_num
  GROUP BY o.order_num, c.cust_name
  ORDER BY order_total DESC;

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎓 知识检查点
──────────────────────────────────────

□ 你理解为什么需要联结表吗？
□ 你会使用 INNER JOIN 语法吗？
□ 你知道什么是笛卡尔积吗？
□ 你会联结多个表吗？
□ 你理解表别名的作用吗？
□ 你知道何时使用完全限定列名吗？
□ 你了解联结和子查询的区别吗？
□ 你知道如何避免常见的联结错误吗？

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✨ 本章小结
──────────────────────────────────────

你已经学会了：
✓ 理解关系表和联结的概念
✓ 使用 INNER JOIN 联结两个表
✓ 使用 ON 子句指定联结条件
✓ 联结多个表查询复杂数据
✓ 使用表别名简化 SQL 语句
✓ 了解笛卡尔积及如何避免
✓ 理解联结与子查询的区别
✓ 掌握完全限定列名的使用

下一章将学习更高级的联结技术！

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💻 动手实践
──────────────────────────────────────
现在就打开 MySQL，在 crashcourse 数据库中
试试联结的强大功能吧！

