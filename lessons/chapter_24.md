━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📚 第 24 章：使用游标
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📖 学习目标
──────────────────────────────────────
✓ 理解什么是游标
✓ 掌握游标的创建和使用
✓ 学会遍历查询结果
✓ 了解游标的限制

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📝 核心知识点
──────────────────────────────────────

1️⃣  什么是游标
   ────────────────────────────────────
   游标（Cursor）是一个存储在 MySQL 服务器上的
   数据库查询，它不是一条 SELECT 语句，而是被该
   语句检索出来的结果集。
   
   简单理解：
   • 游标允许逐行处理查询结果
   • 类似于数组的指针
   • 可以向前或向后移动


2️⃣  为什么使用游标
   ────────────────────────────────────
   有时需要在检索出来的行中前进或后退一行或多行：
   
   ✓ 逐行处理数据
   ✓ 对每一行执行不同操作
   ✓ 处理复杂的业务逻辑
   
   注意：
   • MySQL 游标只能用于存储过程（和函数）
   • 不能在普通查询中使用


3️⃣  使用游标的步骤
   ────────────────────────────────────
   1. 声明游标（DECLARE CURSOR）
   2. 打开游标（OPEN）
   3. 提取数据（FETCH）
   4. 关闭游标（CLOSE）


4️⃣  声明游标
   ────────────────────────────────────
   DECLARE cursor_name CURSOR FOR
   SELECT statement;
   
   示例：
   DECLARE ordernumbers CURSOR FOR
   SELECT order_num FROM orders;
   
   说明：
   • 定义游标和要检索的数据
   • 此时不会检索数据
   • 只是定义了查询


5️⃣  打开游标
   ────────────────────────────────────
   OPEN cursor_name;
   
   示例：
   OPEN ordernumbers;
   
   说明：
   • 执行查询，检索数据
   • 数据存储在游标中
   • 准备好被访问


6️⃣  提取数据 - FETCH
   ────────────────────────────────────
   FETCH cursor_name INTO variables;
   
   示例：
   FETCH ordernumbers INTO o;
   
   说明：
   • 检索当前行的数据
   • 存储到指定变量
   • 自动移动到下一行


7️⃣  关闭游标
   ────────────────────────────────────
   CLOSE cursor_name;
   
   示例：
   CLOSE ordernumbers;
   
   说明：
   • 释放游标使用的资源
   • 游标关闭后不能使用
   • 可以重新打开


8️⃣  完整的游标示例
   ────────────────────────────────────
   DELIMITER //
   
   CREATE PROCEDURE processorders()
   BEGIN
       -- 声明局部变量
       DECLARE done BOOLEAN DEFAULT 0;
       DECLARE o INT;
       
       -- 声明游标
       DECLARE ordernumbers CURSOR FOR
       SELECT order_num FROM orders;
       
       -- 声明 CONTINUE HANDLER
       DECLARE CONTINUE HANDLER FOR SQLSTATE '02000'
       SET done = 1;
       
       -- 打开游标
       OPEN ordernumbers;
       
       -- 遍历所有行
       REPEAT
           FETCH ordernumbers INTO o;
           IF NOT done THEN
               -- 处理数据
               SELECT o;
           END IF;
       UNTIL done END REPEAT;
       
       -- 关闭游标
       CLOSE ordernumbers;
   END //
   
   DELIMITER ;


9️⃣  CONTINUE HANDLER
   ────────────────────────────────────
   DECLARE CONTINUE HANDLER FOR SQLSTATE '02000'
   SET done = 1;
   
   说明：
   • SQLSTATE '02000' 表示没有更多行
   • 当 FETCH 找不到数据时触发
   • 设置 done = 1 表示结束循环
   • 这是处理游标结束的标准方法


🔟  实用的游标示例
   ────────────────────────────────────
   DELIMITER //
   
   CREATE PROCEDURE processorders()
   BEGIN
       DECLARE done BOOLEAN DEFAULT 0;
       DECLARE o INT;
       DECLARE t DECIMAL(8,2);
       
       -- 创建表存储结果
       CREATE TABLE IF NOT EXISTS ordertotals
       (order_num INT, total DECIMAL(8,2));
       
       -- 声明游标
       DECLARE ordernumbers CURSOR FOR
       SELECT order_num FROM orders;
       
       -- 声明处理器
       DECLARE CONTINUE HANDLER FOR SQLSTATE '02000'
       SET done = 1;
       
       -- 打开游标
       OPEN ordernumbers;
       
       -- 遍历所有订单
       REPEAT
           FETCH ordernumbers INTO o;
           IF NOT done THEN
               -- 调用存储过程计算总额
               CALL ordertotal(o, 1, t);
               -- 插入结果
               INSERT INTO ordertotals(order_num, total)
               VALUES(o, t);
           END IF;
       UNTIL done END REPEAT;
       
       -- 关闭游标
       CLOSE ordernumbers;
   END //
   
   DELIMITER ;

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 实践任务
──────────────────────────────────────

📝 基础练习
──────────────────────────────────────

练习 1: 理解游标概念
──────────────────────────────────────
游标的作用是什么？

答案：
  游标允许逐行处理 SELECT 查询的结果集
  可以对每一行执行不同的操作
  只能在存储过程中使用


练习 2: 游标使用的四个步骤
──────────────────────────────────────
列出使用游标的完整步骤

答案：
  1. DECLARE - 声明游标
  2. OPEN - 打开游标
  3. FETCH - 提取数据
  4. CLOSE - 关闭游标


练习 3: 简单游标示例（概念）
──────────────────────────────────────
创建遍历所有客户的游标

你的SQL（概念）：
  -- DELIMITER //
  -- 
  -- CREATE PROCEDURE list_customers()
  -- BEGIN
  --     DECLARE done INT DEFAULT 0;
  --     DECLARE cname CHAR(50);
  --     
  --     DECLARE customer_cursor CURSOR FOR
  --     SELECT cust_name FROM customers;
  --     
  --     DECLARE CONTINUE HANDLER FOR NOT FOUND
  --     SET done = 1;
  --     
  --     OPEN customer_cursor;
  --     
  --     read_loop: LOOP
  --         FETCH customer_cursor INTO cname;
  --         IF done THEN
  --             LEAVE read_loop;
  --         END IF;
  --         SELECT cname;
  --     END LOOP;
  --     
  --     CLOSE customer_cursor;
  -- END //
  -- 
  -- DELIMITER ;


练习 4: CONTINUE HANDLER 的作用
──────────────────────────────────────
为什么需要 CONTINUE HANDLER？

答案：
  当游标到达结果集末尾时
  FETCH 会触发 NOT FOUND 条件
  CONTINUE HANDLER 捕获这个条件
  设置标志变量以退出循环

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🚀 进阶挑战
──────────────────────────────────────

挑战 1: 游标统计（概念）
──────────────────────────────────────
使用游标计算所有订单的总金额

你的SQL（概念）：
  -- DELIMITER //
  -- 
  -- CREATE PROCEDURE sum_all_orders(
  --     OUT grand_total DECIMAL(10,2)
  -- )
  -- BEGIN
  --     DECLARE done INT DEFAULT 0;
  --     DECLARE onum INT;
  --     DECLARE ototal DECIMAL(8,2);
  --     
  --     SET grand_total = 0;
  --     
  --     DECLARE order_cursor CURSOR FOR
  --     SELECT order_num FROM orders;
  --     
  --     DECLARE CONTINUE HANDLER FOR NOT FOUND
  --     SET done = 1;
  --     
  --     OPEN order_cursor;
  --     
  --     REPEAT
  --         FETCH order_cursor INTO onum;
  --         IF NOT done THEN
  --             CALL ordertotal(onum, 0, ototal);
  --             SET grand_total = grand_total + ototal;
  --         END IF;
  --     UNTIL done END REPEAT;
  --     
  --     CLOSE order_cursor;
  -- END //
  -- 
  --DELIMITER ;


挑战 2: 游标更新（概念）
──────────────────────────────────────
使用游标批量更新数据

你的SQL（概念）：
  -- DELIMITER //
  -- 
  -- CREATE PROCEDURE update_prices()
  -- BEGIN
  --     DECLARE done INT DEFAULT 0;
  --     DECLARE pid CHAR(10);
  --     DECLARE pprice DECIMAL(8,2);
  --     
  --     DECLARE prod_cursor CURSOR FOR
  --     SELECT prod_id, prod_price FROM products;
  --     
  --     DECLARE CONTINUE HANDLER FOR NOT FOUND
  --     SET done = 1;
  --     
  --     OPEN prod_cursor;
  --     
  --     REPEAT
  --         FETCH prod_cursor INTO pid, pprice;
  --         IF NOT done THEN
  --             UPDATE products
  --             SET prod_price = pprice * 1.10
  --             WHERE prod_id = pid;
  --         END IF;
  --     UNTIL done END REPEAT;
  --     
  --     CLOSE prod_cursor;
  -- END //
  -- 
  -- DELIMITER ;


挑战 3: 嵌套游标（概念）
──────────────────────────────────────
在游标中使用另一个游标

你的SQL（概念）：
  -- 复杂且不推荐
  -- 可能导致性能问题
  -- 通常可以用 JOIN 替代

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💡 重要提示
──────────────────────────────────────

⚠️  游标只能用于存储过程
   MySQL 游标只能在存储过程（和函数）中使用
   不能在普通的 SELECT 语句中使用

⚠️  性能考虑
   游标逐行处理数据，性能较低
   能用 SELECT 解决的不要用游标
   大数据量时要谨慎使用

⚠️  必须关闭游标
   使用完毕后必须关闭游标
   释放占用的服务器资源
   CLOSE cursor_name;

⚠️  CONTINUE HANDLER 必需
   处理游标结束的标准方法
   SQLSTATE '02000' 或 NOT FOUND
   设置标志变量控制循环

⚠️  变量声明顺序
   在存储过程中的顺序：
   1. 声明局部变量（DECLARE variables）
   2. 声明游标（DECLARE CURSOR）
   3. 声明处理器（DECLARE HANDLER）

⚠️  游标的限制
   • 只读，不能直接更新游标中的数据
   • 只能向前移动（不能后退）
   • 不能滚动（不能跳到特定行）

⚠️  替代方案
   很多时候可以不用游标：
   • 使用 JOIN 代替嵌套查询
   • 使用 WHERE 子句过滤
   • 使用聚合函数统计
   只在必须逐行处理时才用游标

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 实战示例
──────────────────────────────────────

示例 1: 基本游标结构
  DELIMITER //
  
  CREATE PROCEDURE demo_cursor()
  BEGIN
      DECLARE done INT DEFAULT 0;
      DECLARE var_name DATATYPE;
      
      DECLARE cursor_name CURSOR FOR
      SELECT column FROM table;
      
      DECLARE CONTINUE HANDLER FOR NOT FOUND
      SET done = 1;
      
      OPEN cursor_name;
      
      REPEAT
          FETCH cursor_name INTO var_name;
          -- 处理数据
      UNTIL done END REPEAT;
      
      CLOSE cursor_name;
  END //
  
  DELIMITER ;


示例 2: 遍历订单号
  DELIMITER //
  
  CREATE PROCEDURE list_orders()
  BEGIN
      DECLARE done INT DEFAULT 0;
      DECLARE o INT;
      
      DECLARE ordernumbers CURSOR FOR
      SELECT order_num FROM orders;
      
      DECLARE CONTINUE HANDLER FOR SQLSTATE '02000'
      SET done = 1;
      
      OPEN ordernumbers;
      
      REPEAT
          FETCH ordernumbers INTO o;
          IF NOT done THEN
              SELECT o;
          END IF;
      UNTIL done END REPEAT;
      
      CLOSE ordernumbers;
  END //
  
  DELIMITER ;


示例 3: 处理订单总额
  DELIMITER //
  
  CREATE PROCEDURE processorders()
  BEGIN
      DECLARE done BOOLEAN DEFAULT 0;
      DECLARE o INT;
      DECLARE t DECIMAL(8,2);
      
      CREATE TABLE IF NOT EXISTS ordertotals
      (order_num INT, total DECIMAL(8,2));
      
      DECLARE ordernumbers CURSOR FOR
      SELECT order_num FROM orders;
      
      DECLARE CONTINUE HANDLER FOR SQLSTATE '02000'
      SET done = 1;
      
      OPEN ordernumbers;
      
      REPEAT
          FETCH ordernumbers INTO o;
          IF NOT done THEN
              CALL ordertotal(o, 1, t);
              INSERT INTO ordertotals(order_num, total)
              VALUES(o, t);
          END IF;
      UNTIL done END REPEAT;
      
      CLOSE ordernumbers;
  END //
  
  DELIMITER ;


示例 4: 使用 LOOP 代替 REPEAT
  DELIMITER //
  
  CREATE PROCEDURE loop_example()
  BEGIN
      DECLARE done INT DEFAULT 0;
      DECLARE cname CHAR(50);
      
      DECLARE cust_cursor CURSOR FOR
      SELECT cust_name FROM customers;
      
      DECLARE CONTINUE HANDLER FOR NOT FOUND
      SET done = 1;
      
      OPEN cust_cursor;
      
      read_loop: LOOP
          FETCH cust_cursor INTO cname;
          IF done THEN
              LEAVE read_loop;
          END IF;
          SELECT cname;
      END LOOP;
      
      CLOSE cust_cursor;
  END //
  
  DELIMITER ;

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎓 知识检查点
──────────────────────────────────────

□ 你理解什么是游标吗？
□ 你知道游标只能在存储过程中使用吗？
□ 你会声明和打开游标吗？
□ 你知道如何提取游标数据吗？
□ 你理解 CONTINUE HANDLER 的作用吗？
□ 你知道游标使用的四个步骤吗？
□ 你了解游标的性能影响吗？
□ 你知道什么时候应该避免使用游标吗？

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔍 游标 vs 普通查询
──────────────────────────────────────

普通查询（推荐）：
✓ 一次性返回所有结果
✓ 性能高
✓ 语法简单
✓ 可以直接使用

示例：
SELECT order_num, SUM(quantity * item_price)
FROM orderitems
GROUP BY order_num;


使用游标：
✓ 逐行处理
✓ 复杂的业务逻辑
△ 性能较低
△ 语法复杂
△ 只能在存储过程中使用

示例：
需要对每个订单执行不同的操作
需要根据当前行决定下一步
无法用单个 SQL 完成的操作


何时使用游标：
• 必须逐行处理每条记录
• 每行需要执行复杂计算
• 需要调用其他存储过程处理每行
• 无法用集合操作（JOIN/GROUP BY）解决

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✨ 本章小结
──────────────────────────────────────

你已经学会了：
✓ 理解游标的概念和用途
✓ 知道游标只能在存储过程中使用
✓ 掌握使用游标的四个步骤
✓ 使用 DECLARE CURSOR 声明游标
✓ 使用 OPEN 打开游标
✓ 使用 FETCH 提取数据
✓ 使用 CLOSE 关闭游标
✓ 使用 CONTINUE HANDLER 处理结束
✓ 了解游标的性能影响
✓ 知道何时应该避免使用游标

核心要点：
• 游标允许逐行处理查询结果
• 只能在存储过程中使用
• 使用步骤：DECLARE → OPEN → FETCH → CLOSE
• 性能较低，能不用就不用
• CONTINUE HANDLER 处理游标结束

下一章将学习如何使用触发器！

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💻 动手实践
──────────────────────────────────────
游标必须在存储过程中使用，无法直接测试

建议：
1. 先学习存储过程（第23章）
2. 理解游标的概念
3. 在测试环境创建存储过程练习

记住：
• 大多数情况下不需要游标
• 能用 SELECT 解决的就不要用游标
• 游标是最后的选择

选择 "1. 进入 MySQL 实践" 查看相关内容
