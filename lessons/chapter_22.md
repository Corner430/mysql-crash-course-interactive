━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📚 第 22 章：使用视图
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📖 学习目标
──────────────────────────────────────
✓ 理解什么是视图以及为什么使用视图
✓ 掌握 CREATE VIEW 创建视图
✓ 学会使用视图简化复杂查询
✓ 了解视图的规则和限制

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📝 核心知识点
──────────────────────────────────────

1️⃣  什么是视图
   ────────────────────────────────────
   视图是虚拟的表，不包含实际数据
   
   特点：
   • 视图只包含查询（SELECT 语句）
   • 数据来自底层的真实表
   • 使用视图就像使用表一样
   • 视图提供了封装 SQL 查询的层
   
   简单理解：
   视图 = 保存的 SELECT 查询


2️⃣  为什么使用视图
   ────────────────────────────────────
   ✓ 重用 SQL 语句
   ✓ 简化复杂的 SQL 操作
   ✓ 使用表的部分而不是整个表
   ✓ 保护数据（只给用户访问特定数据）
   ✓ 更改数据格式和表示
   
   示例场景：
   • 复杂联结的查询经常使用
   • 限制用户只能看到某些列或行
   • 格式化或计算字段的重用


3️⃣  视图的规则和限制
   ────────────────────────────────────
   • 视图名必须唯一（不能与表名或其他视图重名）
   • 视图可以嵌套（从其他视图检索数据）
   • ORDER BY 可以用在视图中，但会被查询覆盖
   • 视图不能索引，也不能有关联的触发器
   • 视图可以和表一起使用


4️⃣  创建视图 - CREATE VIEW
   ────────────────────────────────────
   基本语法：
   CREATE VIEW view_name AS
   SELECT columns
   FROM tables
   WHERE conditions;
   
   示例：
   CREATE VIEW productcustomers AS
   SELECT cust_name, cust_contact, prod_id
   FROM customers, orders, orderitems
   WHERE customers.cust_id = orders.cust_id
     AND orderitems.order_num = orders.order_num;


5️⃣  使用视图
   ────────────────────────────────────
   使用视图就像使用表：
   
   SELECT * FROM productcustomers;
   
   可以添加 WHERE 子句：
   SELECT cust_name, cust_contact
   FROM productcustomers
   WHERE prod_id = 'TNT2';


6️⃣  利用视图简化复杂联结
   ────────────────────────────────────
   不使用视图（每次都写复杂 SQL）：
   SELECT cust_name, cust_contact
   FROM customers c, orders o, orderitems oi
   WHERE c.cust_id = o.cust_id
     AND oi.order_num = o.order_num
     AND prod_id = 'TNT2';
   
   使用视图（简单查询）：
   CREATE VIEW productcustomers AS
   SELECT cust_name, cust_contact, prod_id
   FROM customers, orders, orderitems
   WHERE customers.cust_id = orders.cust_id
     AND orderitems.order_num = orders.order_num;
   
   SELECT cust_name, cust_contact
   FROM productcustomers
   WHERE prod_id = 'TNT2';


7️⃣  用视图重新格式化检索出的数据
   ────────────────────────────────────
   CREATE VIEW vendorlocations AS
   SELECT Concat(RTrim(vend_name), ' (',
                 RTrim(vend_country), ')') AS vend_title
   FROM vendors
   ORDER BY vend_name;
   
   使用：
   SELECT * FROM vendorlocations;
   
   结果示例：
   Anvils R Us (USA)
   Furball Inc. (USA)
   Jet Set (England)


8️⃣  用视图过滤不想要的数据
   ────────────────────────────────────
   CREATE VIEW customeremaillist AS
   SELECT cust_id, cust_name, cust_email
   FROM customers
   WHERE cust_email IS NOT NULL;
   
   说明：
   • 视图过滤掉没有电子邮件的客户
   • 用户只看到有邮箱的客户
   • 简化后续查询


9️⃣  使用视图与计算字段
   ────────────────────────────────────
   CREATE VIEW orderitemsexpanded AS
   SELECT order_num,
          prod_id,
          quantity,
          item_price,
          quantity * item_price AS expanded_price
   FROM orderitems;
   
   使用：
   SELECT * FROM orderitemsexpanded
   WHERE order_num = 20005;


🔟  更新和删除视图
   ────────────────────────────────────
   删除视图：
   DROP VIEW view_name;
   
   更新视图（先删除再创建）：
   DROP VIEW productcustomers;
   CREATE VIEW productcustomers AS
   SELECT ...;
   
   或使用 CREATE OR REPLACE VIEW：
   CREATE OR REPLACE VIEW productcustomers AS
   SELECT ...;

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 实践任务
──────────────────────────────────────

📝 基础练习
──────────────────────────────────────

练习 1: 创建简单视图（概念）
──────────────────────────────────────
创建显示所有客户名称和邮箱的视图

你的SQL（概念）：
  -- CREATE VIEW customer_emails AS
  -- SELECT cust_name, cust_email
  -- FROM customers;


练习 2: 使用视图
──────────────────────────────────────
如果有上面的视图，如何查询

你的SQL（概念）：
  -- SELECT * FROM customer_emails;


练习 3: 创建过滤视图（概念）
──────────────────────────────────────
创建只显示美国客户的视图

你的SQL（概念）：
  -- CREATE VIEW usa_customers AS
  -- SELECT *
  -- FROM customers
  -- WHERE cust_country = 'USA';


练习 4: 创建联结视图（概念）
──────────────────────────────────────
创建客户订单摘要视图

你的SQL（概念）：
  -- CREATE VIEW customer_orders AS
  -- SELECT c.cust_name, o.order_num, o.order_date
  -- FROM customers c
  -- INNER JOIN orders o ON c.cust_id = o.cust_id;


练习 5: 查看现有视图
──────────────────────────────────────
查看数据库中的所有视图

你的SQL：
  SHOW FULL TABLES WHERE table_type = 'VIEW';


练习 6: 查看视图定义
──────────────────────────────────────
查看视图的创建语句

你的SQL（概念，如果有视图）：
  -- SHOW CREATE VIEW view_name;

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🚀 进阶挑战
──────────────────────────────────────

挑战 1: 创建计算字段视图（概念）
──────────────────────────────────────
创建包含订单总价的视图

你的SQL（概念）：
  -- CREATE VIEW order_totals AS
  -- SELECT order_num,
  --        SUM(quantity * item_price) AS order_total
  -- FROM orderitems
  -- GROUP BY order_num;


挑战 2: 创建格式化视图（概念）
──────────────────────────────────────
创建格式化供应商信息的视图

你的SQL（概念）：
  -- CREATE VIEW vendor_info AS
  -- SELECT vend_id,
  --        CONCAT(vend_name, ' (', vend_city, ', ', 
  --               vend_country, ')') AS vendor_location
  -- FROM vendors;


挑战 3: 嵌套视图（概念）
──────────────────────────────────────
从其他视图创建视图

你的SQL（概念）：
  -- 先创建基础视图
  -- CREATE VIEW active_customers AS
  -- SELECT * FROM customers
  -- WHERE cust_email IS NOT NULL;
  -- 
  -- 再创建嵌套视图
  -- CREATE VIEW usa_active_customers AS
  -- SELECT * FROM active_customers
  -- WHERE cust_country = 'USA';


挑战 4: 复杂联结视图（概念）
──────────────────────────────────────
创建完整的订单信息视图

你的SQL（概念）：
  -- CREATE VIEW order_details AS
  -- SELECT c.cust_name,
  --        o.order_num,
  --        o.order_date,
  --        p.prod_name,
  --        oi.quantity,
  --        oi.item_price,
  --        oi.quantity * oi.item_price AS line_total
  -- FROM customers c
  -- INNER JOIN orders o ON c.cust_id = o.cust_id
  -- INNER JOIN orderitems oi ON o.order_num = oi.order_num
  -- INNER JOIN products p ON oi.prod_id = p.prod_id;


挑战 5: 安全视图（概念）
──────────────────────────────────────
创建只显示部分敏感信息的视图

你的SQL（概念）：
  -- CREATE VIEW customer_public AS
  -- SELECT cust_id, cust_name, cust_city, cust_country
  -- FROM customers;
  -- 
  -- 隐藏了地址、联系人、邮箱等敏感信息

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💡 重要提示
──────────────────────────────────────

⚠️  视图不存储数据
   视图只是查询的封装
   数据来自底层表
   更新底层表，视图自动反映变化

⚠️  性能考虑
   复杂视图可能影响性能
   视图不能被索引
   嵌套视图要谨慎使用
   
⚠️  视图命名
   视图名必须唯一
   不能与表或其他视图重名
   建议用统一命名规范（如 v_ 前缀）

⚠️  ORDER BY 使用
   视图中可以使用 ORDER BY
   但查询视图时的 ORDER BY 会覆盖它
   如果需要特定顺序，在查询时指定

⚠️  更新视图中的数据
   某些视图可以更新（INSERT/UPDATE/DELETE）
   但有很多限制：
   • 不能有分组（GROUP BY/HAVING）
   • 不能有联结
   • 不能有子查询
   • 不能有计算字段
   • 不能有 DISTINCT
   建议：视图主要用于检索（SELECT）

⚠️  CREATE OR REPLACE VIEW
   安全地创建或更新视图
   如果视图存在则替换
   如果不存在则创建
   推荐使用

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 实战示例
──────────────────────────────────────

示例 1: 简化联结的视图
  CREATE VIEW productcustomers AS
  SELECT cust_name, cust_contact, prod_id
  FROM customers c, orders o, orderitems oi
  WHERE c.cust_id = o.cust_id
    AND oi.order_num = o.order_num;
  
  -- 使用视图
  SELECT cust_name, cust_contact
  FROM productcustomers
  WHERE prod_id = 'TNT2';


示例 2: 格式化数据的视图
  CREATE VIEW vendorlocations AS
  SELECT Concat(RTrim(vend_name), ' (',
                RTrim(vend_country), ')') AS vend_title
  FROM vendors
  ORDER BY vend_name;
  
  -- 使用视图
  SELECT * FROM vendorlocations;


示例 3: 过滤数据的视图
  CREATE VIEW customeremaillist AS
  SELECT cust_id, cust_name, cust_email
  FROM customers
  WHERE cust_email IS NOT NULL;
  
  -- 只返回有邮箱的客户
  SELECT * FROM customeremaillist;


示例 4: 计算字段的视图
  CREATE VIEW orderitemsexpanded AS
  SELECT order_num,
         prod_id,
         quantity,
         item_price,
         quantity * item_price AS expanded_price
  FROM orderitems;
  
  -- 使用视图
  SELECT * FROM orderitemsexpanded
  WHERE order_num = 20005;


示例 5: 聚合数据的视图
  CREATE VIEW order_summary AS
  SELECT order_num,
         COUNT(*) AS items_count,
         SUM(quantity) AS total_quantity,
         SUM(quantity * item_price) AS order_total
  FROM orderitems
  GROUP BY order_num;
  
  -- 使用视图
  SELECT * FROM order_summary
  WHERE order_total > 100;


示例 6: 安全限制的视图
  CREATE VIEW customer_basic_info AS
  SELECT cust_id, cust_name, cust_city, cust_country
  FROM customers;
  
  -- 给某些用户只授权访问这个视图
  -- 而不是整个 customers 表


示例 7: 更新视图
  CREATE OR REPLACE VIEW productcustomers AS
  SELECT cust_name, cust_contact, cust_email, prod_id
  FROM customers c, orders o, orderitems oi
  WHERE c.cust_id = o.cust_id
    AND oi.order_num = o.order_num;


示例 8: 删除视图
  DROP VIEW IF EXISTS productcustomers;

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎓 知识检查点
──────────────────────────────────────

□ 你理解什么是视图吗？
□ 你知道为什么要使用视图吗？
□ 你会创建视图吗？
□ 你能用视图简化复杂联结吗？
□ 你会用视图格式化数据吗？
□ 你知道视图的限制吗？
□ 你了解视图和表的区别吗？
□ 你会使用 CREATE OR REPLACE VIEW 吗？

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔍 视图 vs 表
──────────────────────────────────────

表（Table）：
✓ 存储实际数据
✓ 占用磁盘空间
✓ 可以索引
✓ 可以有触发器
✓ 全面支持 INSERT/UPDATE/DELETE

视图（View）：
✓ 不存储数据（只存储查询）
✓ 几乎不占磁盘空间
✗ 不能索引
✗ 不能有触发器
△ 有限支持 INSERT/UPDATE/DELETE

使用场景：
• 重复使用复杂查询 → 视图
• 限制用户访问某些列/行 → 视图
• 简化应用代码 → 视图
• 存储实际数据 → 表

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✨ 本章小结
──────────────────────────────────────

你已经学会了：
✓ 理解视图是虚拟表
✓ 知道使用视图的好处
✓ 使用 CREATE VIEW 创建视图
✓ 利用视图简化复杂联结
✓ 用视图重新格式化数据
✓ 用视图过滤不想要的数据
✓ 用视图创建计算字段
✓ 使用 DROP VIEW 删除视图
✓ 使用 CREATE OR REPLACE VIEW 更新视图
✓ 了解视图的规则和限制

核心要点：
• 视图 = 保存的 SELECT 查询
• 视图不存储数据，数据来自底层表
• 视图简化复杂 SQL 并提供数据安全
• 使用视图就像使用表一样
• CREATE OR REPLACE VIEW 安全更新视图

下一章将学习如何使用存储过程！

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💻 动手实践
──────────────────────────────────────
查看当前数据库的视图：

-- 查看所有视图
SHOW FULL TABLES WHERE table_type = 'VIEW';

-- 查看视图定义（如果有视图）
-- SHOW CREATE VIEW view_name;

⚠️  不要在 crashcourse 数据库中创建视图
    除非你想保留它们用于学习

想创建测试视图？建议：
1. 创建测试数据库
2. 在测试数据库中练习
3. 完成后删除测试数据库

选择 "1. 进入 MySQL 实践" 开始练习
