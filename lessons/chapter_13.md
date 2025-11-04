━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📚 第 13 章：分组数据
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📖 学习目标
──────────────────────────────────────
✓ 理解数据分组的概念和作用
✓ 掌握 GROUP BY 子句的使用
✓ 学会使用 HAVING 子句过滤分组
✓ 理解 SELECT 子句的正确顺序

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📝 核心知识点
──────────────────────────────────────

1️⃣  数据分组的概念
   ────────────────────────────────────
   分组允许把数据分为多个逻辑组
   对每个组进行聚集计算
   
   示例场景：
   • 统计每个供应商提供的产品数量
   • 计算每个客户的订单总数
   • 按月份汇总销售额


2️⃣  创建分组 - GROUP BY
   ────────────────────────────────────
   SELECT vend_id, COUNT(*) AS num_prods
   FROM products
   GROUP BY vend_id;
   
   结果：
   vend_id  num_prods
   1001     3
   1002     2
   1003     7
   1005     2
   
   说明：按 vend_id 分组，统计每组的产品数


3️⃣  GROUP BY 重要规则
   ────────────────────────────────────
   ⚠️  GROUP BY 可以包含任意数目的列
   ⚠️  GROUP BY 中的列必须是检索列或有效表达式（不能是聚集函数）
   ⚠️  除聚集函数外，SELECT 中的列都必须出现在 GROUP BY 中
   ⚠️  如果分组列中有 NULL，NULL 将作为一个分组返回
   ⚠️  GROUP BY 必须在 WHERE 之后，ORDER BY 之前


4️⃣  过滤分组 - HAVING
   ────────────────────────────────────
   SELECT vend_id, COUNT(*) AS num_prods
   FROM products
   GROUP BY vend_id
   HAVING COUNT(*) >= 2;
   
   结果：只显示产品数量 >= 2 的供应商
   vend_id  num_prods
   1001     3
   1002     2
   1003     7
   1005     2


5️⃣  HAVING vs WHERE
   ────────────────────────────────────
   WHERE：在分组前过滤行
   HAVING：在分组后过滤组
   
   示例：
   SELECT vend_id, COUNT(*) AS num_prods
   FROM products
   WHERE prod_price >= 10
   GROUP BY vend_id
   HAVING COUNT(*) >= 2;
   
   说明：
   1. WHERE 先过滤出价格>=10的产品
   2. GROUP BY 按供应商分组
   3. HAVING 只保留产品数>=2的组


6️⃣  分组和排序
   ────────────────────────────────────
   SELECT order_num, SUM(quantity*item_price) AS ordertotal
   FROM orderitems
   GROUP BY order_num
   HAVING SUM(quantity*item_price) >= 50
   ORDER BY ordertotal;
   
   说明：
   • GROUP BY 分组数据
   • HAVING 过滤分组
   • ORDER BY 排序输出


7️⃣  SELECT 子句顺序
   ────────────────────────────────────
   完整的 SELECT 语句顺序：
   
   SELECT      要返回的列或表达式           必需
   FROM        从中检索数据的表             仅从表选择时使用
   WHERE       行级过滤                    可选
   GROUP BY    分组说明                   仅在按组计算时使用
   HAVING      组级过滤                    可选
   ORDER BY    输出排序顺序                可选
   LIMIT       要检索的行数                可选


8️⃣  多列分组
   ────────────────────────────────────
   SELECT vend_id, prod_price, COUNT(*) AS num_prods
   FROM products
   GROUP BY vend_id, prod_price;
   
   说明：按 vend_id 和 prod_price 组合分组
   只有两个字段都相同才是同一组

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 实践任务
──────────────────────────────────────

📝 基础练习
──────────────────────────────────────

练习 1: 按供应商分组统计
──────────────────────────────────────
统计每个供应商提供的产品数量

你的SQL：
  SELECT vend_id, COUNT(*) AS num_prods
  FROM products
  GROUP BY vend_id;


练习 2: 按客户统计订单
──────────────────────────────────────
统计每个客户的订单数量

你的SQL：
  SELECT cust_id, COUNT(*) AS num_orders
  FROM orders
  GROUP BY cust_id;


练习 3: 订单总价计算
──────────────────────────────────────
计算每个订单的总金额

你的SQL：
  SELECT order_num, 
         SUM(quantity * item_price) AS order_total
  FROM orderitems
  GROUP BY order_num;


练习 4: 过滤分组 - 多产品供应商
──────────────────────────────────────
只显示提供2个以上产品的供应商

你的SQL：
  SELECT vend_id, COUNT(*) AS num_prods
  FROM products
  GROUP BY vend_id
  HAVING COUNT(*) >= 2;


练习 5: 订单商品统计
──────────────────────────────────────
统计每个订单包含多少个商品项

你的SQL：
  SELECT order_num, COUNT(*) AS items
  FROM orderitems
  GROUP BY order_num;

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🚀 进阶挑战
──────────────────────────────────────

挑战 1: 大额订单筛选
──────────────────────────────────────
找出总金额 >= 50 的订单，按金额排序

你的SQL：
  SELECT order_num, SUM(quantity * item_price) AS order_total
  FROM orderitems
  GROUP BY order_num
  HAVING SUM(quantity * item_price) >= 50
  ORDER BY order_total;


挑战 2: 组合条件过滤
──────────────────────────────────────
找出价格>=10的产品中，有2个以上产品的供应商

你的SQL：
  SELECT vend_id, COUNT(*) AS num_prods
  FROM products
  WHERE prod_price >= 10
  GROUP BY vend_id
  HAVING COUNT(*) >= 2;


挑战 3: 产品价格分析
──────────────────────────────────────
按供应商分组，显示每个供应商产品的平均价格和数量

你的SQL：
  SELECT vend_id,
         COUNT(*) AS num_prods,
         AVG(prod_price) AS avg_price
  FROM products
  GROUP BY vend_id;


挑战 4: 订单详细统计
──────────────────────────────────────
显示每个订单的商品数量、总件数、总金额

你的SQL：
  SELECT order_num,
         COUNT(*) AS items,
         SUM(quantity) AS total_quantity,
         SUM(quantity * item_price) AS total_price
  FROM orderitems
  GROUP BY order_num
  ORDER BY total_price DESC;


挑战 5: 多列分组统计
──────────────────────────────────────
按供应商和价格分组，统计产品数量

你的SQL：
  SELECT vend_id, 
         prod_price,
         COUNT(*) AS num_prods
  FROM products
  GROUP BY vend_id, prod_price
  ORDER BY vend_id, prod_price;

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💡 重要提示
──────────────────────────────────────

⚠️  GROUP BY 和 SELECT 的关系
   SELECT 中的每个列都必须在 GROUP BY 中给出
   除非该列是聚集函数
   
   ❌ 错误：
   SELECT vend_id, prod_name, COUNT(*)
   FROM products
   GROUP BY vend_id;
   
   ✅ 正确：
   SELECT vend_id, COUNT(*)
   FROM products
   GROUP BY vend_id;


⚠️  WHERE 不能使用聚集函数
   ❌ 错误：WHERE COUNT(*) >= 2
   ✅ 正确：HAVING COUNT(*) >= 2


⚠️  GROUP BY 和 ORDER BY
   GROUP BY 不保证输出顺序
   需要排序时必须使用 ORDER BY
   
   一般做法：
   GROUP BY vend_id
   ORDER BY COUNT(*) DESC


⚠️  NULL 值分组
   NULL 值会作为一个单独的分组
   如果有多个 NULL，它们会分在一组


⚠️  性能考虑
   GROUP BY 会对数据进行排序
   大数据量时可能影响性能
   确保在需要时才使用分组

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 实战示例
──────────────────────────────────────

示例 1: 供应商产品统计
  SELECT vend_id, COUNT(*) AS num_prods
  FROM products
  GROUP BY vend_id
  ORDER BY num_prods DESC;
  
  结果：
  1003    7
  1001    3
  1002    2
  1005    2


示例 2: 订单金额排名
  SELECT order_num, SUM(quantity*item_price) AS total
  FROM orderitems
  GROUP BY order_num
  ORDER BY total DESC
  LIMIT 3;
  
  显示金额最高的3个订单


示例 3: 高价产品供应商
  SELECT vend_id,
         COUNT(*) AS expensive_products,
         AVG(prod_price) AS avg_price
  FROM products
  WHERE prod_price >= 10
  GROUP BY vend_id
  HAVING COUNT(*) >= 2;


示例 4: 客户订单分析
  SELECT c.cust_name,
         COUNT(o.order_num) AS num_orders
  FROM customers c
  LEFT JOIN orders o ON c.cust_id = o.cust_id
  GROUP BY c.cust_id, c.cust_name
  ORDER BY num_orders DESC;


示例 5: 完整的查询示例
  SELECT vend_id, 
         COUNT(*) AS products,
         MIN(prod_price) AS min_price,
         MAX(prod_price) AS max_price,
         AVG(prod_price) AS avg_price
  FROM products
  WHERE prod_price >= 4
  GROUP BY vend_id
  HAVING COUNT(*) >= 2
  ORDER BY products DESC;

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📋 子句执行顺序
──────────────────────────────────────

理解 SQL 语句的执行顺序很重要：

1. FROM      - 确定数据来源表
2. WHERE     - 过滤行
3. GROUP BY  - 分组
4. HAVING    - 过滤分组
5. SELECT    - 选择列
6. ORDER BY  - 排序
7. LIMIT     - 限制行数

示例：
  SELECT vend_id, COUNT(*) AS num        5️⃣
  FROM products                           1️⃣
  WHERE prod_price >= 10                  2️⃣
  GROUP BY vend_id                        3️⃣
  HAVING COUNT(*) >= 2                    4️⃣
  ORDER BY num DESC                       6️⃣
  LIMIT 3;                                7️⃣

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎓 知识检查点
──────────────────────────────────────

□ 你理解数据分组的概念吗？
□ 你会使用 GROUP BY 创建分组吗？
□ 你知道 GROUP BY 的规则吗？
□ 你会使用 HAVING 过滤分组吗？
□ 你理解 WHERE 和 HAVING 的区别吗？
□ 你知道 SELECT 子句的正确顺序吗？
□ 你会组合使用 GROUP BY 和 ORDER BY 吗？
□ 你能进行多列分组吗？

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✨ 本章小结
──────────────────────────────────────

你已经学会了：
✓ 理解数据分组的概念和应用
✓ 使用 GROUP BY 子句创建分组
✓ 使用 HAVING 子句过滤分组
✓ 理解 WHERE 和 HAVING 的区别
✓ 掌握 SELECT 子句的正确顺序
✓ 组合使用分组、过滤和排序
✓ 在分组中使用聚集函数

下一章将学习如何使用子查询！

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💻 动手实践
──────────────────────────────────────
现在就打开 MySQL，在 crashcourse 数据库中
试试数据分组的强大功能吧！

