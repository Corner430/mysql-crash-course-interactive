━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📚 第 12 章：汇总数据
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📖 学习目标
──────────────────────────────────────
✓ 理解聚集函数的作用
✓ 掌握 AVG()、COUNT()、MAX()、MIN()、SUM()
✓ 使用 DISTINCT 与聚集函数
✓ 组合多个聚集函数

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📝 核心知识点
──────────────────────────────────────

聚集函数 (Aggregate Functions)
   作用：对一组数据进行汇总统计
   特点：返回单个值而不是多行


1️⃣  AVG() - 平均值函数
   ────────────────────────────────────
   SELECT AVG(prod_price) AS avg_price 
   FROM products;
   
   说明：计算所有产品的平均价格
   注意：自动忽略 NULL 值


2️⃣  COUNT() - 计数函数
   ────────────────────────────────────
   两种用法：
   
   a) COUNT(*) - 计算所有行
   SELECT COUNT(*) AS num_cust 
   FROM customers;
   
   说明：统计表中的总行数（包括NULL）
   
   b) COUNT(列名) - 计算特定列
   SELECT COUNT(cust_email) AS num_email 
   FROM customers;
   
   说明：统计有邮箱的客户数（忽略NULL）


3️⃣  MAX() - 最大值函数
   ────────────────────────────────────
   SELECT MAX(prod_price) AS max_price 
   FROM products;
   
   说明：找出最高价格
   用途：数值、日期、文本都可以


4️⃣  MIN() - 最小值函数
   ────────────────────────────────────
   SELECT MIN(prod_price) AS min_price 
   FROM products;
   
   说明：找出最低价格


5️⃣  SUM() - 求和函数
   ────────────────────────────────────
   SELECT SUM(quantity) AS items_ordered 
   FROM orderitems
   WHERE order_num = 20005;
   
   说明：计算订单20005的商品总数量
   
   示例2：计算总金额
   SELECT SUM(quantity * item_price) AS total_price 
   FROM orderitems
   WHERE order_num = 20005;


6️⃣  DISTINCT 与聚集函数
   ────────────────────────────────────
   SELECT AVG(DISTINCT prod_price) AS avg_price 
   FROM products
   WHERE vend_id = 1003;
   
   说明：计算不重复价格的平均值

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 实践任务
──────────────────────────────────────

📝 基础练习
──────────────────────────────────────

练习 1: 计算平均价格
──────────────────────────────────────
计算所有产品的平均价格

你的SQL：
  SELECT AVG(prod_price) AS avg_price 
  FROM products;


练习 2: 统计客户数量
──────────────────────────────────────
统计 customers 表中有多少个客户

你的SQL：
  SELECT COUNT(*) AS num_customers 
  FROM customers;


练习 3: 找出最高价和最低价
──────────────────────────────────────
在一个查询中找出产品的最高价和最低价

你的SQL：
  SELECT MAX(prod_price) AS max_price,
         MIN(prod_price) AS min_price 
  FROM products;


练习 4: 计算总数量
──────────────────────────────────────
计算订单项表中的商品总数量

你的SQL：
  SELECT SUM(quantity) AS total_quantity 
  FROM orderitems;


练习 5: 统计有邮箱的客户
──────────────────────────────────────
统计有电子邮箱地址的客户数量

你的SQL：
  SELECT COUNT(cust_email) AS num_with_email 
  FROM customers;


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🚀 进阶挑战
──────────────────────────────────────

挑战 1: 供应商1003的产品统计
──────────────────────────────────────
计算供应商1003的产品数量、平均价格、最高价、最低价

你的SQL：
  SELECT COUNT(*) AS num_products,
         AVG(prod_price) AS avg_price,
         MAX(prod_price) AS max_price,
         MIN(prod_price) AS min_price
  FROM products
  WHERE vend_id = 1003;


挑战 2: 计算订单总金额
──────────────────────────────────────
计算订单20005的总金额（数量×单价的总和）

你的SQL：
  SELECT SUM(quantity * item_price) AS order_total 
  FROM orderitems
  WHERE order_num = 20005;


挑战 3: 去重计算
──────────────────────────────────────
计算产品表中有多少种不同的价格

你的SQL：
  SELECT COUNT(DISTINCT prod_price) AS num_prices 
  FROM products;


挑战 4: 计算平均订单量
──────────────────────────────────────
计算每个订单项的平均数量

你的SQL：
  SELECT AVG(quantity) AS avg_quantity 
  FROM orderitems;


挑战 5: 综合统计
──────────────────────────────────────
对所有订单项进行统计：
- 总订单项数
- 商品总数量
- 总金额
- 平均单价
- 最高单价
- 最低单价

你的SQL：
  SELECT COUNT(*) AS total_items,
         SUM(quantity) AS total_quantity,
         SUM(quantity * item_price) AS total_amount,
         AVG(item_price) AS avg_price,
         MAX(item_price) AS max_price,
         MIN(item_price) AS min_price
  FROM orderitems;


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💡 重要提示
──────────────────────────────────────

⚠️  NULL 值处理
    
    大多数聚集函数忽略 NULL 值
    
    COUNT(*) 例外：
    • COUNT(*) 计算所有行，包括 NULL
    • COUNT(列名) 忽略该列的 NULL 值
    
    示例：
    SELECT COUNT(*) AS total,           -- 5
           COUNT(cust_email) AS has_email -- 3
    FROM customers;


⚠️  DISTINCT 的使用
    
    只能用于列名，不能用于计算
    
    ✓ AVG(DISTINCT prod_price)
    ✗ AVG(DISTINCT prod_price * 2)
    
    DISTINCT 必须用列名
    ✗ COUNT(DISTINCT *)


⚠️  聚集函数与 WHERE
    
    WHERE 过滤行，然后计算聚集值
    
    SELECT AVG(prod_price) AS avg_price 
    FROM products
    WHERE vend_id = 1003;
    
    执行顺序：
    1. WHERE 过滤出 vend_id=1003 的行
    2. AVG() 计算这些行的平均值


⚠️  聚集函数不能嵌套
    
    ✗ SELECT AVG(MAX(prod_price)) FROM products;
    
    需要使用子查询实现

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 实战示例
──────────────────────────────────────

示例 1: 产品价格统计
  SELECT COUNT(*) AS num_products,
         AVG(prod_price) AS avg_price,
         MAX(prod_price) AS max_price,
         MIN(prod_price) AS min_price,
         SUM(prod_price) AS sum_price
  FROM products;
  
  结果：
  14 | 16.13 | 55.00 | 2.50 | 225.86


示例 2: 订单统计
  SELECT order_num,
         COUNT(*) AS num_items,
         SUM(quantity) AS total_quantity
  FROM orderitems
  WHERE order_num = 20005;
  
  结果：
  20005 | 4 | 19


示例 3: 计算总金额
  SELECT order_num,
         SUM(quantity * item_price) AS order_total
  FROM orderitems
  GROUP BY order_num;
  
  (注：这里用到了下一章的 GROUP BY)


示例 4: 去重统计
  SELECT COUNT(vend_id) AS total_vendors,
         COUNT(DISTINCT vend_id) AS unique_vendors
  FROM products;
  
  结果：
  14 | 4  (14个产品来自4个不同供应商)


示例 5: 客户邮箱统计
  SELECT COUNT(*) AS total_customers,
         COUNT(cust_email) AS customers_with_email,
         COUNT(*) - COUNT(cust_email) AS no_email
  FROM customers;
  
  结果：
  5 | 3 | 2

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎓 聚集函数速查表
──────────────────────────────────────

┌──────────┬────────────────┬────────────┐
│ 函数     │ 说明           │ 忽略NULL   │
├──────────┼────────────────┼────────────┤
│ AVG()    │ 平均值         │ 是         │
│ COUNT()  │ 计数           │ 视情况     │
│ MAX()    │ 最大值         │ 是         │
│ MIN()    │ 最小值         │ 是         │
│ SUM()    │ 求和           │ 是         │
└──────────┴────────────────┴────────────┘

COUNT(*) vs COUNT(列名)
• COUNT(*) - 统计所有行
• COUNT(列) - 统计非NULL行

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✨ 本章小结
──────────────────────────────────────

你已经学会了：
✓ 使用 AVG() 计算平均值
✓ 使用 COUNT() 统计数量
✓ 使用 MAX() 和 MIN() 查找极值
✓ 使用 SUM() 求和
✓ 结合 DISTINCT 去重统计
✓ 组合多个聚集函数

下一章将学习如何对数据进行分组统计！

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💻 实践要点
──────────────────────────────────────
• 理解每个聚集函数的用途
• 注意 NULL 值的处理
• 练习组合多个函数
• 为结果起有意义的别名

