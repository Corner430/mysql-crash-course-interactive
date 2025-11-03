━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📚 第 4 章：检索数据
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📖 学习目标
──────────────────────────────────────
✓ 掌握 SELECT 语句的基本用法
✓ 学会检索单个列、多个列和所有列
✓ 使用 DISTINCT 去除重复值
✓ 使用 LIMIT 限制结果数量

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📝 核心知识点
──────────────────────────────────────

1️⃣  SELECT 语句基础
   SELECT 是 SQL 中最常用的语句，用于从表中检索数据

   基本语法：
   SELECT 列名 FROM 表名;


2️⃣  检索单个列
   ────────────────────────────────────
   SELECT prod_name FROM products;
   
   说明：检索 products 表的 prod_name 列


3️⃣  检索多个列
   ────────────────────────────────────
   SELECT prod_id, prod_name, prod_price FROM products;
   
   说明：用逗号分隔多个列名


4️⃣  检索所有列
   ────────────────────────────────────
   SELECT * FROM products;
   
   警告：* 会检索所有列，影响性能，生产环境慎用


5️⃣  检索不同的行 (DISTINCT)
   ────────────────────────────────────
   SELECT DISTINCT vend_id FROM products;
   
   说明：去除重复值，只返回不同的供应商 ID


6️⃣  限制结果 (LIMIT)
   ────────────────────────────────────
   SELECT prod_name FROM products LIMIT 5;
   
   说明：只返回前 5 行结果
   
   ⚠️ 重要：行数从 0 开始计数！
   - 第 1 行是 0，第 2 行是 1，以此类推
   - LIMIT 5, 3  表示从第 6 行（索引5）开始，返回 3 行
   - LIMIT 3 OFFSET 5  同上，MySQL 5+ 语法（推荐）
   
   💡 如果行数不够：
   - LIMIT 100 但只有 14 行 → 返回全部 14 行，不报错
   - LIMIT 10 OFFSET 20 但只有 14 行 → 返回空结果集

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 实践任务
──────────────────────────────────────

📝 基础练习
──────────────────────────────────────

练习 1: 检索客户名称
──────────────────────────────────────
从 customers 表中检索所有客户的名称(cust_name)

你的SQL：
  SELECT cust_name FROM customers;


练习 2: 检索产品信息
──────────────────────────────────────
从 products 表中检索产品ID、名称和价格三个字段

你的SQL：
  SELECT prod_id, prod_name, prod_price FROM products;


练习 3: 查看客户的完整信息
──────────────────────────────────────
检索 customers 表的所有列

你的SQL：
  SELECT * FROM customers;


练习 4: 查找有哪些供应商
──────────────────────────────────────
从 products 表中检索所有不同的供应商ID (vend_id)

你的SQL：
  SELECT DISTINCT vend_id FROM products;


练习 5: 只看前3个产品
──────────────────────────────────────
从 products 表中检索产品名称，但只显示前3个

你的SQL：
  SELECT prod_name FROM products LIMIT 3;


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🚀 进阶挑战
──────────────────────────────────────

挑战 1: 分页查询
──────────────────────────────────────
显示第4到第6个产品的名称和价格
(提示：使用 LIMIT 和 OFFSET)

你的SQL：
  SELECT prod_name, prod_price FROM products LIMIT 3 OFFSET 3;


挑战 2: 去重组合
──────────────────────────────────────
查看有多少种不同的价格（去重）

你的SQL：
  SELECT DISTINCT prod_price FROM products;


挑战 3: 实用查询
──────────────────────────────────────
显示所有客户的邮箱地址（cust_email），不重复

你的SQL：
  SELECT DISTINCT cust_email FROM customers;


挑战 4: 完全限定表名
──────────────────────────────────────
使用完全限定的表名和列名查询产品名称
(格式：数据库名.表名 和 表名.列名)

你的SQL：
  SELECT products.prod_name FROM crashcourse.products;


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💡 重要提示
──────────────────────────────────────

1. SQL 语句不区分大小写
   SELECT = select = SeLeCt
   但是建议关键字大写，列名表名小写

2. 多余的空格会被忽略
   SELECT prod_name FROM products;
   等同于
   SELECT    prod_name
   FROM      products;

3. SQL 语句以分号(;)结束
   在命令行中必须使用分号

4. DISTINCT 应用于所有列
   SELECT DISTINCT vend_id, prod_price FROM products;
   只有 vend_id 和 prod_price 都不同时才算不同

5. LIMIT 的关键要点
   - 行数从 0 开始计数（第1行是0，第2行是1）
   - LIMIT 5, 3  表示从索引5（第6行）开始取3行
   - LIMIT 3 OFFSET 5  同上（推荐使用此语法）
   - 如果请求的行数超过实际行数，返回所有可用行，不报错

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎓 知识检查点
──────────────────────────────────────

□ 你能写出检索单个列的 SELECT 语句吗？
□ 你知道如何检索多个列吗？
□ 你了解 * 的作用和风险吗？
□ 你会使用 DISTINCT 去重吗？
□ 你能用 LIMIT 限制返回的行数吗？
□ 你理解 OFFSET 的作用吗？

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 实战示例
──────────────────────────────────────

示例 1: 查看所有产品名称
  SELECT prod_name FROM products;

示例 2: 查看产品的基本信息
  SELECT prod_id, prod_name, prod_price FROM products;

示例 3: 查看前5个最常用的查询
  SELECT * FROM products LIMIT 5;

示例 4: 有多少个供应商
  SELECT DISTINCT vend_id FROM products;
  -- 结果会显示：1001, 1002, 1003, 1005

示例 5: 分页显示（每页5条，显示第2页）
  SELECT prod_name FROM products LIMIT 5 OFFSET 5;
  -- OFFSET 5 表示跳过前5行（索引0-4），从索引5开始

示例 6: LIMIT 超出范围的情况
  SELECT prod_name FROM products LIMIT 100;
  -- 即使只有14个产品，也不会报错，返回全部14行
  
  SELECT prod_name FROM products LIMIT 5 OFFSET 20;
  -- 起始位置超出总行数，返回空结果集（0行）

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✨ 本章小结
──────────────────────────────────────

你已经学会了：
✓ 使用 SELECT 检索数据
✓ 检索单个、多个或全部列
✓ 使用 DISTINCT 去除重复
✓ 使用 LIMIT 限制结果
✓ 使用完全限定的表名和列名

下一章将学习如何对检索结果进行排序！

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💻 动手实践
──────────────────────────────────────
现在就打开 MySQL，在 crashcourse 数据库中
试试上面的所有SQL语句吧！

选择 "1. 进入 MySQL 实践" 开始练习
