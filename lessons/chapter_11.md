━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📚 第 11 章：使用数据处理函数
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📖 学习目标
──────────────────────────────────────
✓ 了解 SQL 函数的类型和用途
✓ 掌握常用的文本处理函数
✓ 学会使用日期和时间处理函数
✓ 使用数值处理函数进行计算

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📝 核心知识点
──────────────────────────────────────

1️⃣  函数的可移植性
   ────────────────────────────────────
   注意：不同 DBMS 的函数实现可能不同
   
   函数分类：
   • 文本处理函数
   • 数值处理函数
   • 日期和时间处理函数
   • 系统函数


2️⃣  文本处理函数 - 大小写转换
   ────────────────────────────────────
   Upper()  -- 转换为大写
   Lower()  -- 转换为小写
   
   SELECT vend_name, UPPER(vend_name) AS vend_name_upper
   FROM vendors
   ORDER BY vend_name;
   
   结果：
   Anvils R Us    ANVILS R US
   ACME           ACME


3️⃣  文本处理函数 - 长度和截取
   ────────────────────────────────────
   Length()     -- 返回字符串长度
   Left()       -- 返回字符串左边的字符
   Right()      -- 返回字符串右边的字符
   Substring()  -- 提取子字符串
   
   示例：
   SELECT prod_name, 
          LENGTH(prod_name) AS name_length,
          LEFT(prod_name, 5) AS first_5_chars
   FROM products;


4️⃣  文本处理函数 - Soundex
   ────────────────────────────────────
   Soundex() 返回字符串的 SOUNDEX 值
   用于按发音匹配字符串
   
   SELECT cust_name, cust_contact
   FROM customers
   WHERE Soundex(cust_contact) = Soundex('Y Lie');
   
   说明：即使拼写不完全正确，也能找到发音相似的名字


5️⃣  日期和时间处理函数
   ────────────────────────────────────
   Now()        -- 返回当前日期和时间
   CurDate()    -- 返回当前日期
   CurTime()    -- 返回当前时间
   Date()       -- 提取日期部分
   Time()       -- 提取时间部分
   Year()       -- 返回年份
   Month()      -- 返回月份
   Day()        -- 返回天数
   
   SELECT Now(), CurDate(), CurTime();


6️⃣  日期过滤示例
   ────────────────────────────────────
   查找特定日期的订单：
   
   SELECT order_num, order_date
   FROM orders
   WHERE Date(order_date) = '2005-09-01';
   
   说明：Date() 函数只比较日期部分，忽略时间


7️⃣  日期范围查询
   ────────────────────────────────────
   查找2005年9月的所有订单：
   
   SELECT order_num, order_date
   FROM orders
   WHERE Year(order_date) = 2005 
     AND Month(order_date) = 9;
   
   或使用 BETWEEN：
   SELECT order_num, order_date
   FROM orders
   WHERE order_date BETWEEN '2005-09-01' AND '2005-09-30';


8️⃣  数值处理函数
   ────────────────────────────────────
   Abs()    -- 返回绝对值
   Cos()    -- 返回余弦值
   Sin()    -- 返回正弦值
   Tan()    -- 返回正切值
   Exp()    -- 返回指数值
   Mod()    -- 返回余数
   Pi()     -- 返回圆周率
   Rand()   -- 返回随机数
   Sqrt()   -- 返回平方根
   
   SELECT Pi(), Sqrt(16), Mod(10, 3), Rand();

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 实践任务
──────────────────────────────────────

📝 基础练习
──────────────────────────────────────

练习 1: 大写转换
──────────────────────────────────────
将所有客户名称转换为大写显示

你的SQL：
  SELECT cust_name, UPPER(cust_name) AS cust_name_upper
  FROM customers;


练习 2: 产品名称长度
──────────────────────────────────────
显示产品名称及其字符长度

你的SQL：
  SELECT prod_name, LENGTH(prod_name) AS name_length
  FROM products
  ORDER BY name_length DESC;


练习 3: 提取年份
──────────────────────────────────────
显示所有订单的订单号和年份

你的SQL：
  SELECT order_num, 
         order_date,
         YEAR(order_date) AS order_year
  FROM orders;


练习 4: 当前日期时间
──────────────────────────────────────
查询当前的日期、时间和日期时间

你的SQL：
  SELECT NOW() AS current_datetime,
         CURDATE() AS current_date,
         CURTIME() AS current_time;


练习 5: 数学计算
──────────────────────────────────────
计算：圆周率、16的平方根、10除以3的余数

你的SQL：
  SELECT PI() AS pi_value,
         SQRT(16) AS sqrt_16,
         MOD(10, 3) AS mod_result;

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🚀 进阶挑战
──────────────────────────────────────

挑战 1: 产品名称格式化
──────────────────────────────────────
显示产品名称的大写版本，并取前10个字符

你的SQL：
  SELECT prod_name,
         LEFT(UPPER(prod_name), 10) AS short_name
  FROM products;


挑战 2: 月度订单统计
──────────────────────────────────────
按年份和月份分组统计订单数量

你的SQL：
  SELECT YEAR(order_date) AS order_year,
         MONTH(order_date) AS order_month,
         COUNT(*) AS order_count
  FROM orders
  GROUP BY order_year, order_month
  ORDER BY order_year, order_month;


挑战 3: 字符串截取和组合
──────────────────────────────────────
显示供应商名称的前3个字母 + 供应商ID

你的SQL：
  SELECT vend_id,
         vend_name,
         CONCAT(LEFT(vend_name, 3), '-', vend_id) AS vend_code
  FROM vendors;


挑战 4: 价格四舍五入
──────────────────────────────────────
将产品价格四舍五入到整数

你的SQL：
  SELECT prod_name,
         prod_price,
         ROUND(prod_price) AS price_rounded,
         ROUND(prod_price, 1) AS price_one_decimal
  FROM products;


挑战 5: 发音匹配搜索
──────────────────────────────────────
使用 Soundex 查找名字发音类似 "Michelle Green" 的客户

你的SQL：
  SELECT cust_name, cust_contact
  FROM customers
  WHERE Soundex(cust_contact) = Soundex('Michelle Green');

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💡 重要提示
──────────────────────────────────────

⚠️  函数的可移植性问题
   不同数据库系统的函数名称和用法可能不同
   例如：MySQL 用 LENGTH()，SQL Server 用 LEN()
   编写代码时注意数据库兼容性

⚠️  日期格式
   MySQL 日期格式：'YYYY-MM-DD'
   日期时间格式：'YYYY-MM-DD HH:MM:SS'
   始终使用标准格式避免歧义

⚠️  Date() 函数的重要性
   WHERE order_date = '2005-09-01' 可能匹配不到
   因为 order_date 可能包含时间部分
   使用 WHERE Date(order_date) = '2005-09-01' 更可靠

⚠️  NULL 值处理
   大多数函数遇到 NULL 返回 NULL
   LENGTH(NULL) = NULL
   使用 IFNULL() 或 COALESCE() 处理 NULL

⚠️  性能考虑
   在 WHERE 子句中使用函数会降低性能
   函数会对每一行执行，无法使用索引
   尽量在 SELECT 中使用函数

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 实战示例
──────────────────────────────────────

示例 1: 文本处理组合
  SELECT vend_name,
         UPPER(vend_name) AS name_upper,
         LOWER(vend_name) AS name_lower,
         LENGTH(vend_name) AS name_length
  FROM vendors;


示例 2: 邮箱域名提取
  SELECT cust_name,
         cust_email,
         SUBSTRING(cust_email, 
                   LOCATE('@', cust_email) + 1) AS email_domain
  FROM customers
  WHERE cust_email IS NOT NULL;


示例 3: 订单日期分析
  SELECT order_num,
         order_date,
         YEAR(order_date) AS year,
         MONTH(order_date) AS month,
         DAY(order_date) AS day,
         DAYNAME(order_date) AS weekday
  FROM orders;


示例 4: 价格区间标记
  SELECT prod_name,
         prod_price,
         ROUND(prod_price / 10) * 10 AS price_bracket
  FROM products
  ORDER BY price_bracket;


示例 5: 字符串清理
  SELECT prod_name,
         TRIM(UPPER(prod_name)) AS clean_name,
         REPLACE(prod_name, ' ', '_') AS url_safe_name
  FROM products;

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📚 常用函数速查表
──────────────────────────────────────

【文本函数】
CONCAT()      拼接字符串
LENGTH()      字符串长度
UPPER/LOWER() 大小写转换
TRIM()        去除空格
LEFT/RIGHT()  提取左/右部分
SUBSTRING()   提取子串
REPLACE()     替换字符
LOCATE()      查找位置

【日期函数】
NOW()         当前日期时间
CURDATE()     当前日期
DATE()        提取日期
YEAR/MONTH()  提取年/月
DATEDIFF()    日期差
DATE_ADD()    日期加法
DATE_FORMAT() 格式化日期

【数值函数】
ROUND()       四舍五入
CEIL()        向上取整
FLOOR()       向下取整
ABS()         绝对值
MOD()         取余
RAND()        随机数

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎓 知识检查点
──────────────────────────────────────

□ 你了解函数的三大类型吗？
□ 你会使用 UPPER() 和 LOWER() 吗？
□ 你能使用 LENGTH() 和 LEFT() 吗？
□ 你理解日期函数的用途吗？
□ 你会使用 Date() 进行日期比较吗？
□ 你知道如何提取年份和月份吗？
□ 你了解数值函数的使用吗？
□ 你理解函数的可移植性问题吗？

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✨ 本章小结
──────────────────────────────────────

你已经学会了：
✓ 理解 SQL 函数的分类和用途
✓ 使用文本处理函数（UPPER、LOWER、LENGTH、LEFT 等）
✓ 使用日期时间函数（NOW、Date、YEAR、MONTH 等）
✓ 使用数值处理函数（ROUND、ABS、MOD 等）
✓ 在查询中组合使用多种函数
✓ 注意函数的可移植性问题

下一章将学习如何使用聚集函数汇总数据！
（已学习：第12章，接下来是第13章分组数据）

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💻 动手实践
──────────────────────────────────────
现在就打开 MySQL，在 crashcourse 数据库中
试试各种数据处理函数吧！

