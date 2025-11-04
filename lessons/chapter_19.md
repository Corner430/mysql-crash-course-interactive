━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📚 第 19 章：插入数据
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📖 学习目标
──────────────────────────────────────
✓ 掌握 INSERT 语句的使用
✓ 学会插入完整的行和部分列
✓ 了解如何插入多行数据
✓ 理解插入检索出的数据

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📝 核心知识点
──────────────────────────────────────

1️⃣  INSERT 基本语法
   ────────────────────────────────────
   INSERT INTO table_name (column1, column2, ...)
   VALUES (value1, value2, ...);
   
   注意：
   • 指定表名和列名
   • VALUES 提供对应的值
   • 列名和值的顺序必须对应


2️⃣  插入完整的行
   ────────────────────────────────────
   INSERT INTO customers
   VALUES(NULL,
          'Pep E. LaPew',
          '100 Main Street',
          'Los Angeles',
          'CA',
          '90046',
          'USA',
          NULL,
          NULL);
   
   ⚠️  不推荐！依赖表的列顺序，易出错


3️⃣  更安全的方式 - 明确列名
   ────────────────────────────────────
   INSERT INTO customers(cust_name,
                         cust_address,
                         cust_city,
                         cust_state,
                         cust_zip,
                         cust_country,
                         cust_contact,
                         cust_email)
   VALUES('Pep E. LaPew',
          '100 Main Street',
          'Los Angeles',
          'CA',
          '90046',
          'USA',
          NULL,
          NULL);
   
   优点：
   • 不依赖列顺序
   • 可以省略某些列
   • 代码更清晰


4️⃣  插入部分行
   ────────────────────────────────────
   INSERT INTO customers(cust_name,
                         cust_address,
                         cust_city,
                         cust_state,
                         cust_zip,
                         cust_country)
   VALUES('Pep E. LaPew',
          '100 Main Street',
          'Los Angeles',
          'CA',
          '90046',
          'USA');
   
   说明：
   • 省略的列必须允许 NULL 或有默认值
   • 主键列如有 AUTO_INCREMENT 可省略


5️⃣  插入多行
   ────────────────────────────────────
   INSERT INTO customers(cust_name,
                         cust_address,
                         cust_city,
                         cust_state,
                         cust_zip,
                         cust_country)
   VALUES('Pep E. LaPew',
          '100 Main Street',
          'Los Angeles',
          'CA',
          '90046',
          'USA'),
         ('M. Martian',
          '42 Galaxy Way',
          'New York',
          'NY',
          '11213',
          'USA');
   
   优点：提高性能（单条 INSERT 比多条快）


6️⃣  插入检索出的数据 - INSERT SELECT
   ────────────────────────────────────
   INSERT INTO customers(cust_id,
                         cust_contact,
                         cust_email,
                         cust_name,
                         cust_address,
                         cust_city,
                         cust_state,
                         cust_zip,
                         cust_country)
   SELECT cust_id,
          cust_contact,
          cust_email,
          cust_name,
          cust_address,
          cust_city,
          cust_state,
          cust_zip,
          cust_country
   FROM custnew;
   
   说明：从custnew表检索数据插入到customers


7️⃣  INSERT SELECT 的规则
   ────────────────────────────────────
   • SELECT 中的列名可以不同
   • MySQL 只关心列的位置，不关心列名
   • 可以包含 WHERE 子句过滤数据
   • 可以使用聚集函数、联结等


8️⃣  LOW_PRIORITY 关键字
   ────────────────────────────────────
   INSERT LOW_PRIORITY INTO ...
   
   说明：
   • 降低 INSERT 语句的优先级
   • 等待其他操作完成后再执行
   • 适用于高并发场景

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 实践任务
──────────────────────────────────────

📝 基础练习
──────────────────────────────────────

练习 1: 插入客户记录
──────────────────────────────────────
插入一个新客户（请勿在生产数据库执行）

你的SQL（示例）：
  -- 注意：这会修改数据库，仅用于学习
  INSERT INTO customers(cust_name,
                       cust_city,
                       cust_country)
  VALUES('Test Customer',
         'Beijing',
         'China');


练习 2: 查看插入的数据
──────────────────────────────────────
查询刚插入的客户（假设ID为10006）

你的SQL：
  SELECT * FROM customers WHERE cust_id = 10006;


练习 3: 插入多行数据
──────────────────────────────────────
一次插入多个客户记录

你的SQL（示例）：
  INSERT INTO customers(cust_name, cust_city, cust_country)
  VALUES('Customer 1', 'Shanghai', 'China'),
        ('Customer 2', 'Guangzhou', 'China'),
        ('Customer 3', 'Shenzhen', 'China');


练习 4: 理解AUTO_INCREMENT
──────────────────────────────────────
查看最后插入的AUTO_INCREMENT ID

你的SQL：
  SELECT LAST_INSERT_ID();


练习 5: INSERT SELECT 示例
──────────────────────────────────────
（概念练习）将所有CA州的客户复制到新表

你的SQL（概念）：
  -- 假设有一个备份表customers_backup
  -- INSERT INTO customers_backup
  -- SELECT * FROM customers WHERE cust_state = 'CA';

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🚀 进阶挑战
──────────────────────────────────────

挑战 1: 带计算的插入
──────────────────────────────────────
（概念）插入带有计算值的数据

你的SQL（概念）：
  -- INSERT INTO summary_table(date, total_sales)
  -- VALUES(CURDATE(), 
  --        (SELECT SUM(quantity * item_price) FROM orderitems));


挑战 2: 条件插入
──────────────────────────────────────
使用INSERT SELECT只插入符合条件的数据

你的SQL（概念）：
  -- INSERT INTO high_value_customers
  -- SELECT * FROM customers
  -- WHERE cust_id IN (
  --   SELECT cust_id FROM orders
  --   GROUP BY cust_id
  --   HAVING COUNT(*) > 2
  -- );


挑战 3: 从不同表组合插入
──────────────────────────────────────
从多个表组合数据插入新表

你的SQL（概念）：
  -- INSERT INTO customer_orders(cust_name, order_count)
  -- SELECT c.cust_name, COUNT(o.order_num)
  -- FROM customers c
  -- LEFT JOIN orders o ON c.cust_id = o.cust_id
  -- GROUP BY c.cust_id, c.cust_name;


挑战 4: 插入默认值
──────────────────────────────────────
使用DEFAULT关键字插入默认值

你的SQL（示例）：
  INSERT INTO customers(cust_name, cust_email)
  VALUES('Default Test', DEFAULT);


挑战 5: 批量插入优化
──────────────────────────────────────
（概念）理解批量插入的性能优势

你的理解：
  -- 单条插入（慢）：
  -- INSERT INTO ... VALUES (...);
  -- INSERT INTO ... VALUES (...);
  -- INSERT INTO ... VALUES (...);
  
  -- 批量插入（快）：
  -- INSERT INTO ... VALUES (...), (...), (...);

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💡 重要提示
──────────────────────────────────────

⚠️  始终指定列名
   不要依赖默认的列顺序
   表结构变化时会导致错误
   明确列名使SQL更安全、更易读

⚠️  NULL 和默认值
   省略的列必须满足以下条件之一：
   • 允许 NULL 值
   • 定义了 DEFAULT 值
   否则 INSERT 会失败

⚠️  AUTO_INCREMENT
   主键列如果是 AUTO_INCREMENT，可以省略
   MySQL 会自动生成值
   使用 LAST_INSERT_ID() 获取最后插入的ID

⚠️  批量插入性能
   一次插入多行比多次插入单行快得多
   INSERT INTO ... VALUES (...), (...), (...);
   减少了数据库通信开销

⚠️  INSERT SELECT 注意事项
   INSERT SELECT 可以插入大量数据
   确保目标表结构与SELECT结果兼容
   使用 WHERE 子句避免插入不需要的数据

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 实战示例
──────────────────────────────────────

示例 1: 标准插入
  -- 不要在crashcourse执行，仅供参考
  INSERT INTO customers(cust_name,
                       cust_address,
                       cust_city,
                       cust_state,
                       cust_zip,
                       cust_country)
  VALUES('ABC Company',
         '123 Any Street',
         'New York',
         'NY',
         '10001',
         'USA');


示例 2: 批量插入
  INSERT INTO products(prod_id,
                      vend_id,
                      prod_name,
                      prod_price)
  VALUES('TEST1', 1001, 'Test Product 1', 9.99),
        ('TEST2', 1001, 'Test Product 2', 14.99),
        ('TEST3', 1002, 'Test Product 3', 19.99');


示例 3: INSERT SELECT
  -- 复制所有订单到备份表
  INSERT INTO orders_backup
  SELECT * FROM orders;


示例 4: 有条件的INSERT SELECT
  INSERT INTO recent_orders
  SELECT * FROM orders
  WHERE order_date >= '2005-09-01';


示例 5: 使用函数
  INSERT INTO customers(cust_name,
                       cust_contact,
                       cust_email)
  VALUES(UPPER('new customer'),
         'Contact Name',
         LOWER('EMAIL@EXAMPLE.COM'));

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎓 知识检查点
──────────────────────────────────────

□ 你会使用INSERT语句吗？
□ 你知道为什么要指定列名吗？
□ 你理解NULL和默认值的关系吗？
□ 你会插入多行数据吗？
□ 你了解AUTO_INCREMENT的作用吗？
□ 你会使用INSERT SELECT吗？
□ 你知道如何获取最后插入的ID吗？
□ 你理解批量插入的性能优势吗？

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✨ 本章小结
──────────────────────────────────────

你已经学会了：
✓ 使用INSERT语句插入数据
✓ 指定列名进行安全插入
✓ 插入完整的行或部分列
✓ 一次插入多行数据
✓ 使用INSERT SELECT插入查询结果
✓ 理解AUTO_INCREMENT和LAST_INSERT_ID()
✓ 掌握插入数据的最佳实践

下一章将学习如何更新和删除数据！

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💻 动手实践
──────────────────────────────────────
⚠️  注意：INSERT 会修改数据库！
建议在测试环境练习，或练习后恢复数据

