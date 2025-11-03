━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📚 第 20 章：更新和删除数据
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📖 学习目标
──────────────────────────────────────
✓ 掌握 UPDATE 语句更新数据
✓ 掌握 DELETE 语句删除数据
✓ 理解 WHERE 子句的重要性
✓ 学习安全操作的最佳实践

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📝 核心知识点
──────────────────────────────────────

1️⃣  UPDATE 基本语法
   ────────────────────────────────────
   UPDATE table_name
   SET column1 = value1, column2 = value2, ...
   WHERE condition;
   
   三个组成部分：
   • 要更新的表名
   • 列名和它们的新值（SET子句）
   • 确定要更新行的过滤条件（WHERE子句）


2️⃣  更新单个列
   ────────────────────────────────────
   UPDATE customers
   SET cust_email = 'elmer@fudd.com'
   WHERE cust_id = 10005;
   
   说明：
   • 只更新 cust_id 为 10005 的客户
   • 只修改 cust_email 列
   • WHERE 子句确保只更新一行


3️⃣  更新多个列
   ────────────────────────────────────
   UPDATE customers
   SET cust_name = 'The Fudds',
       cust_email = 'elmer@fudd.com'
   WHERE cust_id = 10005;
   
   注意：
   • 使用单个 SET 命令
   • 多个列之间用逗号分隔
   • 最后一列后面不用逗号


4️⃣  DELETE 基本语法
   ────────────────────────────────────
   DELETE FROM table_name
   WHERE condition;
   
   组成部分：
   • 要删除数据的表名
   • 确定要删除行的过滤条件


5️⃣  删除特定行
   ────────────────────────────────────
   DELETE FROM customers
   WHERE cust_id = 10006;
   
   说明：
   • 删除 cust_id 为 10006 的客户
   • WHERE 子句指定要删除的行
   • 删除整行，不是部分列


6️⃣  删除所有行
   ────────────────────────────────────
   DELETE FROM customers;
   
   ⚠️  危险操作！
   • 删除表中所有行
   • 不删除表本身
   • 慎用！


7️⃣  TRUNCATE TABLE - 更快的删除
   ────────────────────────────────────
   TRUNCATE TABLE customers;
   
   说明：
   • 删除表中所有行
   • 比 DELETE 更快
   • 实际是删除原表并重新创建
   • 不能用 WHERE 子句


8️⃣  使用子查询更新
   ────────────────────────────────────
   UPDATE customers
   SET cust_email = (
       SELECT email FROM new_emails 
       WHERE customer_id = customers.cust_id
   )
   WHERE cust_id IN (
       SELECT customer_id FROM new_emails
   );
   
   说明：可以在 UPDATE 中使用子查询


9️⃣  IGNORE 关键字
   ────────────────────────────────────
   UPDATE IGNORE customers
   SET cust_email = 'test@test.com'
   WHERE cust_state = 'CA';
   
   说明：
   • 即使发生错误也继续更新
   • 跳过产生错误的行
   • 继续处理其他行

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 实践任务
──────────────────────────────────────

📝 基础练习
──────────────────────────────────────

练习 1: 查看现有数据
──────────────────────────────────────
先查看要修改的数据

你的SQL：
  SELECT * FROM customers WHERE cust_id = 10005;


练习 2: 更新单个字段
──────────────────────────────────────
更新客户 10005 的电子邮件
（注意：这是示例，实际操作会修改数据）

你的SQL（概念）：
  -- UPDATE customers
  -- SET cust_email = 'newemail@example.com'
  -- WHERE cust_id = 10005;


练习 3: 更新多个字段
──────────────────────────────────────
同时更新客户的名称和邮箱

你的SQL（概念）：
  -- UPDATE customers
  -- SET cust_name = 'Updated Name',
  --     cust_email = 'updated@example.com'
  -- WHERE cust_id = 10005;


练习 4: 使用计算值更新
──────────────────────────────────────
将所有产品价格上涨10%

你的SQL（概念）：
  -- UPDATE products
  -- SET prod_price = prod_price * 1.10;
  -- ⚠️ 注意：没有 WHERE 子句会更新所有行！


练习 5: 条件更新
──────────────────────────────────────
只更新特定供应商的产品价格

你的SQL（概念）：
  -- UPDATE products
  -- SET prod_price = prod_price * 1.10
  -- WHERE vend_id = 1003;


练习 6: 先用 SELECT 测试条件
──────────────────────────────────────
在删除前先测试 WHERE 子句

你的SQL：
  -- 第一步：测试
  SELECT * FROM customers WHERE cust_state = 'XX';
  
  -- 第二步：确认后删除
  -- DELETE FROM customers WHERE cust_state = 'XX';


练习 7: 删除特定行
──────────────────────────────────────
删除特定客户（概念练习）

你的SQL（概念）：
  -- DELETE FROM customers
  -- WHERE cust_id = 10999;

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🚀 进阶挑战
──────────────────────────────────────

挑战 1: 使用子查询更新
──────────────────────────────────────
将所有已下订单客户的联系方式更新

你的SQL（概念）：
  -- UPDATE customers
  -- SET cust_contact = 'VIP Customer'
  -- WHERE cust_id IN (
  --   SELECT DISTINCT cust_id FROM orders
  -- );


挑战 2: 基于联结的更新
──────────────────────────────────────
更新特定供应商的所有产品价格

你的SQL（概念）：
  -- UPDATE products p
  -- INNER JOIN vendors v ON p.vend_id = v.vend_id
  -- SET p.prod_price = p.prod_price * 1.15
  -- WHERE v.vend_name = 'Anvils R Us';


挑战 3: 条件删除
──────────────────────────────────────
删除没有订单的客户（概念）

你的SQL（概念）：
  -- DELETE FROM customers
  -- WHERE cust_id NOT IN (
  --   SELECT DISTINCT cust_id FROM orders
  -- );


挑战 4: 批量更新
──────────────────────────────────────
根据不同条件批量更新

你的SQL（概念）：
  -- UPDATE products
  -- SET prod_price = CASE
  --   WHEN prod_price < 10 THEN prod_price * 1.20
  --   WHEN prod_price < 20 THEN prod_price * 1.15
  --   ELSE prod_price * 1.10
  -- END;


挑战 5: 使用 LIMIT 安全删除
──────────────────────────────────────
限制删除的行数

你的SQL（概念）：
  -- DELETE FROM customers
  -- WHERE cust_state = 'CA'
  -- LIMIT 10;
  -- 
  -- 说明：即使WHERE匹配多行，也只删除10行

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💡 重要提示 - 安全指导原则
──────────────────────────────────────

⚠️  绝对不要省略 WHERE 子句
   除非确实要更新/删除所有行
   否则必须使用 WHERE 子句
   稍不注意就会修改整个表

⚠️  先用 SELECT 测试
   在执行 UPDATE 或 DELETE 之前
   先用相同的 WHERE 子句执行 SELECT
   确认选择的是正确的记录

⚠️  使用主键
   尽可能使用主键作为 WHERE 条件
   主键唯一，不会误操作其他行
   例如：WHERE cust_id = 10005

⚠️  MySQL 没有撤销按钮
   UPDATE 和 DELETE 是永久性的
   没有 UNDO 功能
   操作前务必备份或测试

⚠️  使用事务（高级）
   对于重要操作使用事务
   可以在确认前回滚
   详见第 26 章

⚠️  引用完整性
   使用外键约束保护数据
   防止删除被引用的行
   详见第 15 章

⚠️  权限控制
   限制 UPDATE 和 DELETE 权限
   不是所有用户都应该有这些权限
   详见第 28 章

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 实战示例
──────────────────────────────────────

示例 1: 标准更新
  -- 更新单个客户的电子邮件
  UPDATE customers
  SET cust_email = 'kim@thetoystore.com'
  WHERE cust_id = 10005;


示例 2: 更新多列
  -- 同时更新多个字段
  UPDATE customers
  SET cust_name = 'The Fudds',
      cust_email = 'elmer@fudd.com',
      cust_contact = 'E Fudd'
  WHERE cust_id = 10005;


示例 3: 使用表达式更新
  -- 所有产品价格上涨 10%
  UPDATE products
  SET prod_price = prod_price * 1.10
  WHERE vend_id = 1003;


示例 4: 设置为 NULL
  -- 清除客户的电子邮件
  UPDATE customers
  SET cust_email = NULL
  WHERE cust_id = 10005;


示例 5: 标准删除
  -- 删除特定客户
  DELETE FROM customers
  WHERE cust_id = 10006;


示例 6: 使用子查询删除
  -- 删除没有订单的客户
  DELETE FROM customers
  WHERE cust_id NOT IN (
    SELECT DISTINCT cust_id FROM orders
  );


示例 7: 查看受影响的行数
  -- 执行更新后
  UPDATE customers
  SET cust_state = 'CA'
  WHERE cust_city = 'Los Angeles';
  
  -- MySQL 会显示：Query OK, 2 rows affected


示例 8: TRUNCATE 清空表
  -- 快速删除所有行
  TRUNCATE TABLE temp_table;
  -- 比 DELETE FROM temp_table 更快

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎓 知识检查点
──────────────────────────────────────

□ 你知道 UPDATE 的基本语法吗？
□ 你会同时更新多个列吗？
□ 你理解 WHERE 子句的重要性吗？
□ 你知道如何删除特定行吗？
□ 你了解 DELETE 和 TRUNCATE 的区别吗？
□ 你会在操作前用 SELECT 测试吗？
□ 你知道 MySQL 没有撤销功能吗？
□ 你理解为什么要使用主键作为条件吗？

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔍 常见错误
──────────────────────────────────────

❌ 错误 1: 忘记 WHERE 子句
  UPDATE customers
  SET cust_email = 'test@test.com';
  -- 会更新所有客户！

✅ 正确：
  UPDATE customers
  SET cust_email = 'test@test.com'
  WHERE cust_id = 10005;


❌ 错误 2: WHERE 条件错误
  DELETE FROM customers
  WHERE cust_name = 'Coyote Inc.';
  -- 如果有多个同名客户会删除所有

✅ 正确：
  DELETE FROM customers
  WHERE cust_id = 10005;
  -- 使用主键更安全


❌ 错误 3: 不测试就执行
  DELETE FROM orders WHERE order_date < '2005-01-01';
  -- 没有先查看会删除多少行

✅ 正确：
  -- 先测试
  SELECT COUNT(*) FROM orders WHERE order_date < '2005-01-01';
  -- 确认后再删除
  DELETE FROM orders WHERE order_date < '2005-01-01';


❌ 错误 4: 多列更新语法错误
  UPDATE customers
  SET cust_name = 'New Name'
  SET cust_email = 'new@email.com';  -- 错误！多个SET

✅ 正确：
  UPDATE customers
  SET cust_name = 'New Name',
      cust_email = 'new@email.com'
  WHERE cust_id = 10005;

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✨ 本章小结
──────────────────────────────────────

你已经学会了：
✓ 使用 UPDATE 语句更新单列或多列
✓ 使用 DELETE 语句删除行
✓ 理解 WHERE 子句的关键重要性
✓ 掌握 TRUNCATE TABLE 快速清空表
✓ 在操作前用 SELECT 测试条件
✓ 了解 UPDATE 和 DELETE 的安全原则
✓ 知道如何避免常见错误
✓ 理解引用完整性和权限控制的重要性

核心要点：
• 永远不要忘记 WHERE 子句（除非确实要操作所有行）
• 操作前先用 SELECT 测试
• MySQL 没有撤销功能，要小心操作
• 使用主键作为 WHERE 条件更安全

下一章将学习如何创建和操纵表！

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💻 动手实践
──────────────────────────────────────
⚠️  警告：UPDATE 和 DELETE 会永久修改数据！
建议只在测试环境练习

可以在命令行中执行以下安全查询：

-- 查看所有客户
SELECT * FROM customers;

-- 查看特定客户
SELECT * FROM customers WHERE cust_id = 10001;

-- 模拟更新（只是查看会影响哪些行）
SELECT * FROM customers WHERE cust_state = 'CA';

选择 "1. 进入 MySQL 实践" 开始练习
