━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📚 第 10 章：创建计算字段
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📖 学习目标
──────────────────────────────────────
✓ 理解什么是计算字段以及如何创建
✓ 掌握字符串拼接函数 CONCAT()
✓ 学会使用算术运算符进行计算
✓ 使用别名 AS 为计算字段命名

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📝 核心知识点
──────────────────────────────────────

1️⃣  什么是计算字段
   ────────────────────────────────────
   计算字段是在运行时在 SELECT 语句内创建的字段
   
   用途：
   • 拼接字段（如：姓 + 名）
   • 执行算术计算（如：价格 * 数量）
   • 格式化数据
   
   注意：计算字段并不存在于数据库表中


2️⃣  拼接字段 - CONCAT()
   ────────────────────────────────────
   SELECT CONCAT(vend_name, ' (', vend_country, ')') 
   FROM vendors
   ORDER BY vend_name;
   
   结果示例：
   ACME (USA)
   Anvils R Us (USA)
   Furball Inc. (USA)
   
   说明：CONCAT() 将多个字符串连接成一个字符串


3️⃣  去除空格 - Trim 函数
   ────────────────────────────────────
   RTrim()  -- 去除右边空格
   LTrim()  -- 去除左边空格
   Trim()   -- 去除两边空格
   
   示例：
   SELECT CONCAT(RTrim(vend_name), ' (', RTrim(vend_country), ')')
   FROM vendors;


4️⃣  使用别名 (AS)
   ────────────────────────────────────
   SELECT CONCAT(vend_name, ' (', vend_country, ')') AS vend_title
   FROM vendors
   ORDER BY vend_name;
   
   说明：
   • AS 为计算字段指定别名
   • 别名也称为导出列（derived column）
   • 客户端可以用别名引用这个字段


5️⃣  执行算术计算
   ────────────────────────────────────
   支持的算术操作符：
   +  加法
   -  减法
   *  乘法
   /  除法
   
   示例：计算订单项总价
   SELECT prod_id,
          quantity,
          item_price,
          quantity * item_price AS expanded_price
   FROM orderitems
   WHERE order_num = 20005;


6️⃣  实用计算示例
   ────────────────────────────────────
   SELECT prod_id,
          prod_price,
          prod_price * 0.9 AS sale_price
   FROM products;
   
   说明：计算打9折后的价格


7️⃣  组合多种计算
   ────────────────────────────────────
   SELECT CONCAT(prod_name, ' - $', prod_price) AS product_info,
          prod_price * 1.1 AS price_with_tax
   FROM products;
   
   说明：可以在同一查询中使用多个计算字段


8️⃣  测试计算
   ────────────────────────────────────
   SELECT 3 * 2;        -- 返回 6
   SELECT Trim(' abc '); -- 返回 'abc'
   SELECT Now();         -- 返回当前日期时间
   
   说明：可以省略 FROM 子句来测试函数和计算

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 实践任务
──────────────────────────────────────

📝 基础练习
──────────────────────────────────────

练习 1: 供应商完整信息
──────────────────────────────────────
将供应商名称和城市拼接，格式："名称 (城市)"

你的SQL：
  SELECT CONCAT(vend_name, ' (', vend_city, ')') AS vend_info
  FROM vendors;


练习 2: 客户完整地址
──────────────────────────────────────
拼接客户的姓名和地址，用逗号分隔

你的SQL：
  SELECT CONCAT(cust_name, ', ', cust_address) AS customer_address
  FROM customers;


练习 3: 计算订单项总价
──────────────────────────────────────
计算每个订单项的总价（数量 * 单价）

你的SQL：
  SELECT order_num,
         prod_id,
         quantity,
         item_price,
         quantity * item_price AS total_price
  FROM orderitems;


练习 4: 产品价格含税计算
──────────────────────────────────────
计算所有产品加10%税后的价格

你的SQL：
  SELECT prod_name,
         prod_price,
         prod_price * 1.10 AS price_with_tax
  FROM products;


练习 5: 简单算术测试
──────────────────────────────────────
测试以下计算：2 + 2, 10 - 3, 5 * 4, 20 / 4

你的SQL：
  SELECT 2 + 2 AS addition,
         10 - 3 AS subtraction,
         5 * 4 AS multiplication,
         20 / 4 AS division;

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🚀 进阶挑战
──────────────────────────────────────

挑战 1: 完整供应商信息卡
──────────────────────────────────────
创建格式化的供应商信息：
"供应商名 - 城市, 州 国家"

你的SQL：
  SELECT CONCAT(vend_name, ' - ', vend_city, ', ', 
                vend_state, ' ', vend_country) AS vendor_card
  FROM vendors;


挑战 2: 订单总价汇总
──────────────────────────────────────
计算订单 20005 的所有订单项总价之和
(提示：需要用到后续章节的 SUM 函数)

你的SQL：
  SELECT order_num,
         SUM(quantity * item_price) AS order_total
  FROM orderitems
  WHERE order_num = 20005
  GROUP BY order_num;


挑战 3: 产品折扣价格表
──────────────────────────────────────
显示产品名、原价、9折价、8折价

你的SQL：
  SELECT prod_name,
         prod_price AS original_price,
         prod_price * 0.9 AS discount_10,
         prod_price * 0.8 AS discount_20
  FROM products;


挑战 4: 格式化产品显示
──────────────────────────────────────
创建格式："产品名 ($价格) - 供应商ID"

你的SQL：
  SELECT CONCAT(prod_name, ' ($', prod_price, ') - VID:', vend_id) 
         AS product_display
  FROM products;


挑战 5: 客户邮件标题
──────────────────────────────────────
创建邮件地址显示格式："姓名 <email>"
只显示有邮箱的客户

你的SQL：
  SELECT CONCAT(cust_name, ' <', cust_email, '>') AS email_format
  FROM customers
  WHERE cust_email IS NOT NULL;

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💡 重要提示
──────────────────────────────────────

⚠️  别名的重要性
   没有别名的计算字段很难在客户端引用
   始终使用 AS 为计算字段命名

⚠️  空格的影响
   数据库中存储的字符串可能包含空格
   使用 Trim() 函数去除多余空格

⚠️  运算符优先级
   乘除优先于加减
   使用括号明确计算顺序
   示例：(10 + 5) * 2 = 30
        10 + 5 * 2 = 20

⚠️  NULL 值处理
   任何与 NULL 的计算结果都是 NULL
   NULL * 10 = NULL
   CONCAT('text', NULL) = NULL

⚠️  数据类型匹配
   MySQL 会自动进行类型转换
   '10' + 5 = 15 (字符串转为数字)
   但最好保持数据类型一致

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 实战示例
──────────────────────────────────────

示例 1: 供应商位置信息
  SELECT vend_name,
         CONCAT(vend_city, ', ', vend_country) AS location
  FROM vendors
  ORDER BY vend_name;
  
  结果：
  ACME              Los Angeles, USA
  Anvils R Us       Southfield, USA
  Furball Inc.      New York, USA


示例 2: 订单明细计算
  SELECT order_num,
         prod_id,
         quantity AS qty,
         item_price AS price,
         quantity * item_price AS total
  FROM orderitems
  WHERE order_num = 20005;
  
  结果：
  order_num  prod_id    qty  price   total
  20005      ANV01      10   5.99    59.90
  20005      ANV02      3    9.99    29.97


示例 3: 产品价格区间
  SELECT prod_name,
         prod_price,
         CASE 
           WHEN prod_price < 5 THEN 'Budget'
           WHEN prod_price < 10 THEN 'Standard'
           ELSE 'Premium'
         END AS price_category
  FROM products;


示例 4: 百分比计算
  SELECT prod_name,
         prod_price,
         CONCAT(ROUND(prod_price * 0.9, 2), ' (10% off)') AS sale
  FROM products
  WHERE prod_price > 10;


示例 5: 多字段组合
  SELECT CONCAT(cust_name, ' - ', cust_city) AS customer,
         cust_email,
         CONCAT(cust_city, ', ', cust_state) AS location
  FROM customers;

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎓 知识检查点
──────────────────────────────────────

□ 你理解什么是计算字段吗？
□ 你会使用 CONCAT() 拼接字符串吗？
□ 你知道 Trim() 函数的作用吗？
□ 你会使用 AS 创建别名吗？
□ 你能进行基本的算术运算吗？
□ 你了解运算符优先级吗？
□ 你知道如何处理 NULL 值吗？

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✨ 本章小结
──────────────────────────────────────

你已经学会了：
✓ 理解计算字段的概念和用途
✓ 使用 CONCAT() 拼接字符串
✓ 使用 Trim() 函数去除空格
✓ 使用 AS 为计算字段创建别名
✓ 执行算术运算（+、-、*、/）
✓ 组合使用多种计算

下一章将学习 MySQL 的各种数据处理函数！

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💻 动手实践
──────────────────────────────────────
现在就打开 MySQL，在 crashcourse 数据库中
试试创建自己的计算字段吧！

选择 "1. 进入 MySQL 实践" 开始练习
