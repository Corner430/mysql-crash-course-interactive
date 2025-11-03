━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📚 第 16 章：创建高级联结
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📖 学习目标
──────────────────────────────────────
✓ 掌握表别名的高级用法
✓ 理解自联结、自然联结和外部联结
✓ 学会使用 LEFT JOIN 和 RIGHT JOIN
✓ 了解聚集函数与联结的组合使用

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📝 核心知识点
──────────────────────────────────────

1️⃣  使用表别名
   ────────────────────────────────────
   SELECT c.cust_name, c.cust_contact
   FROM customers AS c, orders AS o, orderitems AS oi
   WHERE c.cust_id = o.cust_id
     AND oi.order_num = o.order_num
     AND prod_id = 'TNT2';
   
   优点：
   • 缩短SQL语句
   • 允许在单条SELECT中多次使用同一表


2️⃣  自联结
   ────────────────────────────────────
   需求：找出与Jim Jones同一公司的所有客户
   
   使用子查询：
   SELECT cust_id, cust_name, cust_contact
   FROM customers
   WHERE cust_name = (SELECT cust_name
                      FROM customers
                      WHERE cust_contact = 'Jim Jones');
   
   使用自联结（更快）：
   SELECT c1.cust_id, c1.cust_name, c1.cust_contact
   FROM customers AS c1, customers AS c2
   WHERE c1.cust_name = c2.cust_name
     AND c2.cust_contact = 'Jim Jones';


3️⃣  自然联结
   ────────────────────────────────────
   自然联结排除多次出现的列
   使每个列只返回一次
   
   SELECT c.*, o.order_num, o.order_date,
          oi.prod_id, oi.quantity, oi.item_price
   FROM customers AS c
   INNER JOIN orders AS o ON c.cust_id = o.cust_id
   INNER JOIN orderitems AS oi ON o.order_num = oi.order_num
   WHERE prod_id = 'FB';
   
   说明：使用c.*确保customers的列只出现一次


4️⃣  外部联结 - LEFT JOIN
   ────────────────────────────────────
   LEFT OUTER JOIN 返回左表的所有行
   即使右表中没有匹配
   
   SELECT c.cust_id, c.cust_name, o.order_num
   FROM customers AS c
   LEFT OUTER JOIN orders AS o ON c.cust_id = o.cust_id;
   
   结果：包含所有客户，即使他们没有订单


5️⃣  外部联结 - RIGHT JOIN
   ────────────────────────────────────
   RIGHT OUTER JOIN 返回右表的所有行
   
   SELECT c.cust_id, c.cust_name, o.order_num
   FROM orders AS o
   RIGHT OUTER JOIN customers AS c ON c.cust_id = o.cust_id;
   
   说明：与LEFT JOIN效果相同，只是表的位置相反


6️⃣  INNER JOIN vs OUTER JOIN
   ────────────────────────────────────
   INNER JOIN：只返回两表都匹配的行
   LEFT JOIN：返回左表所有行 + 右表匹配行
   RIGHT JOIN：返回右表所有行 + 左表匹配行
   
   示例对比：
   INNER JOIN - 只显示有订单的客户
   LEFT JOIN - 显示所有客户（含无订单的）


7️⃣  使用带聚集函数的联结
   ────────────────────────────────────
   SELECT c.cust_name,
          c.cust_id,
          COUNT(o.order_num) AS num_ord
   FROM customers AS c
   LEFT OUTER JOIN orders AS o ON c.cust_id = o.cust_id
   GROUP BY c.cust_id, c.cust_name
   ORDER BY c.cust_name;
   
   说明：使用LEFT JOIN确保显示所有客户
   包括订单数为0的客户


8️⃣  联结条件与WHERE条件
   ────────────────────────────────────
   SELECT c.cust_name, o.order_num
   FROM customers c
   LEFT JOIN orders o ON c.cust_id = o.cust_id
   WHERE o.order_num IS NULL;
   
   说明：找出没有订单的客户
   ON指定联结条件，WHERE过滤结果

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 实践任务
──────────────────────────────────────

📝 基础练习
──────────────────────────────────────

练习 1: 所有客户及其订单
──────────────────────────────────────
显示所有客户及其订单号（包括没订单的客户）

你的SQL：
  SELECT c.cust_name, o.order_num
  FROM customers c
  LEFT JOIN orders o ON c.cust_id = o.cust_id;


练习 2: 统计客户订单数
──────────────────────────────────────
统计每个客户的订单数量（包括0个订单的客户）

你的SQL：
  SELECT c.cust_name, COUNT(o.order_num) AS num_orders
  FROM customers c
  LEFT JOIN orders o ON c.cust_id = o.cust_id
  GROUP BY c.cust_id, c.cust_name;


练习 3: 产品销售统计
──────────────────────────────────────
显示所有产品及其销售数量（包括未售出的产品）

你的SQL：
  SELECT p.prod_name, SUM(oi.quantity) AS total_sold
  FROM products p
  LEFT JOIN orderitems oi ON p.prod_id = oi.prod_id
  GROUP BY p.prod_id, p.prod_name;


练习 4: 找出未下单客户
──────────────────────────────────────
找出所有没有下过订单的客户

你的SQL：
  SELECT c.cust_id, c.cust_name
  FROM customers c
  LEFT JOIN orders o ON c.cust_id = o.cust_id
  WHERE o.order_num IS NULL;


练习 5: 自联结查询
──────────────────────────────────────
找出所有来自 'New York' 的客户所在公司的其他客户

你的SQL：
  SELECT c1.cust_name, c1.cust_city
  FROM customers c1, customers c2
  WHERE c1.cust_name = c2.cust_name
    AND c2.cust_city = 'New York';

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🚀 进阶挑战
──────────────────────────────────────

挑战 1: 完整客户订单分析
──────────────────────────────────────
显示所有客户的订单总额（无订单显示0）

你的SQL：
  SELECT c.cust_name,
         IFNULL(SUM(oi.quantity * oi.item_price), 0) AS total_amount
  FROM customers c
  LEFT JOIN orders o ON c.cust_id = o.cust_id
  LEFT JOIN orderitems oi ON o.order_num = oi.order_num
  GROUP BY c.cust_id, c.cust_name
  ORDER BY total_amount DESC;


挑战 2: 产品未售统计
──────────────────────────────────────
找出所有从未被订购过的产品

你的SQL：
  SELECT p.prod_id, p.prod_name
  FROM products p
  LEFT JOIN orderitems oi ON p.prod_id = oi.prod_id
  WHERE oi.order_num IS NULL;


挑战 3: 供应商销售统计
──────────────────────────────────────
显示每个供应商的产品销售总额（包括未售出的）

你的SQL：
  SELECT v.vend_name,
         IFNULL(SUM(oi.quantity * oi.item_price), 0) AS sales_total
  FROM vendors v
  LEFT JOIN products p ON v.vend_id = p.vend_id
  LEFT JOIN orderitems oi ON p.prod_id = oi.prod_id
  GROUP BY v.vend_id, v.vend_name
  ORDER BY sales_total DESC;


挑战 4: 自联结产品推荐
──────────────────────────────────────
找出与产品'TNT2'同一供应商的其他产品

你的SQL：
  SELECT p1.prod_id, p1.prod_name
  FROM products p1, products p2
  WHERE p1.vend_id = p2.vend_id
    AND p2.prod_id = 'TNT2'
    AND p1.prod_id <> 'TNT2';


挑战 5: 多级外联结
──────────────────────────────────────
显示所有客户、订单、产品信息（包括无订单客户）

你的SQL：
  SELECT c.cust_name, o.order_num, p.prod_name, oi.quantity
  FROM customers c
  LEFT JOIN orders o ON c.cust_id = o.cust_id
  LEFT JOIN orderitems oi ON o.order_num = oi.order_num
  LEFT JOIN products p ON oi.prod_id = p.prod_id
  ORDER BY c.cust_name;

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💡 重要提示
──────────────────────────────────────

⚠️  LEFT JOIN vs RIGHT JOIN
   大多数情况下可以互换，只需调整表顺序
   推荐统一使用LEFT JOIN，代码更一致
   A LEFT JOIN B = B RIGHT JOIN A

⚠️  外联结中的NULL
   外联结会对无匹配的行返回NULL
   使用IFNULL()或COALESCE()处理NULL值
   示例：IFNULL(COUNT(orders), 0)

⚠️  自联结的别名
   自联结必须使用表别名
   否则MySQL无法区分同一表的不同实例
   别名让表看起来像两个不同的表

⚠️  聚集函数与外联结
   COUNT(*)会计数所有行（包括NULL）
   COUNT(column)只计数非NULL值
   外联结统计时要注意区别

⚠️  性能考虑
   外联结比内联结慢
   自联结通常比子查询快
   确保联结列上有索引

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 实战示例
──────────────────────────────────────

示例 1: 客户订单完整视图
  SELECT c.cust_id, c.cust_name,
         COUNT(o.order_num) AS orders,
         IFNULL(SUM(oi.quantity * oi.item_price), 0) AS total
  FROM customers c
  LEFT JOIN orders o ON c.cust_id = o.cust_id
  LEFT JOIN orderitems oi ON o.order_num = oi.order_num
  GROUP BY c.cust_id, c.cust_name;


示例 2: 供应商产品分布
  SELECT v.vend_name,
         COUNT(p.prod_id) AS products,
         COUNT(DISTINCT oi.order_num) AS orders
  FROM vendors v
  LEFT JOIN products p ON v.vend_id = p.vend_id
  LEFT JOIN orderitems oi ON p.prod_id = oi.prod_id
  GROUP BY v.vend_id, v.vend_name;


示例 3: 自联结产品关联
  SELECT p1.prod_name AS product,
         p2.prod_name AS related_product
  FROM products p1
  JOIN products p2 ON p1.vend_id = p2.vend_id
  WHERE p1.prod_id <> p2.prod_id
  ORDER BY p1.prod_name;


示例 4: 未售产品分析
  SELECT p.prod_name, p.prod_price, v.vend_name
  FROM products p
  LEFT JOIN orderitems oi ON p.prod_id = oi.prod_id
  JOIN vendors v ON p.vend_id = v.vend_id
  WHERE oi.order_num IS NULL;


示例 5: 全联结模拟
  SELECT c.cust_name, o.order_num
  FROM customers c
  LEFT JOIN orders o ON c.cust_id = o.cust_id
  UNION
  SELECT c.cust_name, o.order_num
  FROM orders o
  LEFT JOIN customers c ON c.cust_id = o.cust_id;

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎓 知识检查点
──────────────────────────────────────

□ 你理解自联结的概念和用法吗？
□ 你知道什么是自然联结吗？
□ 你会使用LEFT JOIN吗？
□ 你理解INNER JOIN和OUTER JOIN的区别吗？
□ 你知道如何找出无匹配的行吗？
□ 你会在联结中使用聚集函数吗？
□ 你了解NULL值在外联结中的处理吗？
□ 你知道LEFT JOIN和RIGHT JOIN的关系吗？

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✨ 本章小结
──────────────────────────────────────

你已经学会了：
✓ 使用表别名简化复杂查询
✓ 使用自联结查询同一表的不同行
✓ 理解自然联结避免重复列
✓ 使用LEFT JOIN返回左表所有行
✓ 使用RIGHT JOIN返回右表所有行
✓ 理解INNER JOIN和OUTER JOIN的区别
✓ 在联结中使用聚集函数
✓ 处理外联结中的NULL值

下一章将学习如何使用UNION组合查询！

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💻 动手实践
──────────────────────────────────────
现在就打开 MySQL，在 crashcourse 数据库中
试试这些高级联结技术吧！

选择 "1. 进入 MySQL 实践" 开始练习
