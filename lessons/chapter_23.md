━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📚 第 23 章：使用存储过程
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📖 学习目标
──────────────────────────────────────
✓ 理解什么是存储过程
✓ 掌握创建和使用存储过程
✓ 学会使用参数（IN、OUT、INOUT）
✓ 了解存储过程的优缺点

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📝 核心知识点
──────────────────────────────────────

1️⃣  什么是存储过程
   ────────────────────────────────────
   存储过程是保存在数据库中的 SQL 语句集合
   
   简单理解：
   • 为以后的使用而保存的一条或多条 MySQL 语句
   • 可以看作是批文件
   • 虽然它们的作用不仅限于批处理


2️⃣  为什么使用存储过程
   ────────────────────────────────────
   优点：
   ✓ 简化复杂操作
   ✓ 保证数据一致性
   ✓ 简化对变动的管理
   ✓ 提高性能（编译一次，多次使用）
   ✓ 提供安全性（限制对基础数据的访问）
   
   缺点：
   ✗ 语法因数据库而异
   ✗ 编写比基本 SQL 复杂
   ✗ 可能需要特殊权限


3️⃣  创建存储过程 - 基本语法
   ────────────────────────────────────
   DELIMITER //
   
   CREATE PROCEDURE procedure_name()
   BEGIN
       SQL statements;
   END //
   
   DELIMITER ;
   
   说明：
   • DELIMITER 改变语句分隔符
   • 默认分隔符是 ; 但过程体内也需要用 ;
   • 所以临时改为 //
   • 创建完成后改回 ;


4️⃣  执行存储过程
   ────────────────────────────────────
   CALL procedure_name();
   
   示例：
   CALL productpricing();


5️⃣  简单的存储过程示例
   ────────────────────────────────────
   DELIMITER //
   
   CREATE PROCEDURE productpricing()
   BEGIN
       SELECT Avg(prod_price) AS priceaverage
       FROM products;
   END //
   
   DELIMITER ;
   
   -- 执行
   CALL productpricing();


6️⃣  删除存储过程
   ────────────────────────────────────
   DROP PROCEDURE IF EXISTS procedure_name;
   
   说明：
   • IF EXISTS 防止不存在时报错
   • 删除是永久性的
   • 括号不需要，即使过程有参数


7️⃣  使用参数 - IN OUT INOUT
   ────────────────────────────────────
   IN：传入参数（默认）
   OUT：传出参数
   INOUT：既传入又传出
   
   语法：
   CREATE PROCEDURE procedure_name(
       IN param1 datatype,
       OUT param2 datatype,
       INOUT param3 datatype
   )


8️⃣  OUT 参数示例
   ────────────────────────────────────
   DELIMITER //
   
   CREATE PROCEDURE productpricing(
       OUT pl DECIMAL(8,2),
       OUT ph DECIMAL(8,2),
       OUT pa DECIMAL(8,2)
   )
   BEGIN
       SELECT Min(prod_price) INTO pl FROM products;
       SELECT Max(prod_price) INTO ph FROM products;
       SELECT Avg(prod_price) INTO pa FROM products;
   END //
   
   DELIMITER ;
   
   -- 调用
   CALL productpricing(@pricelow,
                       @pricehigh,
                       @priceaverage);
   
   -- 查看结果
   SELECT @pricelow, @pricehigh, @priceaverage;


9️⃣  IN 和 OUT 参数组合
   ────────────────────────────────────
   DELIMITER //
   
   CREATE PROCEDURE ordertotal(
       IN onumber INT,
       OUT ototal DECIMAL(8,2)
   )
   BEGIN
       SELECT Sum(item_price*quantity)
       FROM orderitems
       WHERE order_num = onumber
       INTO ototal;
   END //
   
   DELIMITER ;
   
   -- 调用
   CALL ordertotal(20005, @total);
   SELECT @total;


🔟  智能存储过程 - 带逻辑
   ────────────────────────────────────
   DELIMITER //
   
   CREATE PROCEDURE ordertotal(
       IN onumber INT,
       IN taxable BOOLEAN,
       OUT ototal DECIMAL(8,2)
   )
   BEGIN
       DECLARE total DECIMAL(8,2);
       DECLARE taxrate INT DEFAULT 6;
       
       SELECT Sum(item_price*quantity)
       FROM orderitems
       WHERE order_num = onumber
       INTO total;
       
       IF taxable THEN
           SELECT total + (total/100*taxrate) INTO ototal;
       ELSE
           SELECT total INTO ototal;
       END IF;
   END //
   
   DELIMITER ;

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 实践任务
──────────────────────────────────────

📝 基础练习
──────────────────────────────────────

练习 1: 查看现有存储过程
──────────────────────────────────────
查看数据库中的所有存储过程

你的SQL：
  SHOW PROCEDURE STATUS WHERE db = 'crashcourse';


练习 2: 创建简单存储过程（概念）
──────────────────────────────────────
创建返回产品数量的存储过程

你的SQL（概念）：
  -- DELIMITER //
  -- 
  -- CREATE PROCEDURE count_products()
  -- BEGIN
  --     SELECT COUNT(*) AS product_count
  --     FROM products;
  -- END //
  -- 
  -- DELIMITER ;


练习 3: 调用存储过程（概念）
──────────────────────────────────────
调用上面创建的存储过程

你的SQL（概念）：
  -- CALL count_products();


练习 4: 使用 OUT 参数（概念）
──────────────────────────────────────
创建返回客户数量的存储过程

你的SQL（概念）：
  -- DELIMITER //
  -- 
  -- CREATE PROCEDURE get_customer_count(
  --     OUT customer_count INT
  -- )
  -- BEGIN
  --     SELECT COUNT(*) INTO customer_count
  --     FROM customers;
  -- END //
  -- 
  -- DELIMITER ;
  -- 
  -- CALL get_customer_count(@count);
  -- SELECT @count;


练习 5: 使用 IN 参数（概念）
──────────────────────────────────────
根据客户ID获取客户名称

你的SQL（概念）：
  -- DELIMITER //
  -- 
  -- CREATE PROCEDURE get_customer_name(
  --     IN cust_id INT,
  --     OUT cust_name CHAR(50)
  -- )
  -- BEGIN
  --     SELECT customers.cust_name
  --     INTO cust_name
  --     FROM customers
  --     WHERE customers.cust_id = cust_id;
  -- END //
  -- 
  -- DELIMITER ;

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🚀 进阶挑战
──────────────────────────────────────

挑战 1: 带条件逻辑的存储过程（概念）
──────────────────────────────────────
计算订单总额（含税或不含税）

你的SQL（概念）：
  -- DELIMITER //
  -- 
  -- CREATE PROCEDURE ordertotal(
  --     IN onumber INT,
  --     IN taxable BOOLEAN,
  --     OUT ototal DECIMAL(8,2)
  -- )
  -- BEGIN
  --     DECLARE total DECIMAL(8,2);
  --     
  --     SELECT Sum(item_price*quantity)
  --     FROM orderitems
  --     WHERE order_num = onumber
  --     INTO total;
  --     
  --     IF taxable THEN
  --         SET ototal = total * 1.06;
  --     ELSE
  --         SET ototal = total;
  --     END IF;
  -- END //
  -- 
  -- DELIMITER ;


挑战 2: 使用循环的存储过程（概念）
──────────────────────────────────────
使用 WHILE 循环

你的SQL（概念）：
  -- DELIMITER //
  -- 
  -- CREATE PROCEDURE sum_numbers(
  --     IN n INT,
  --     OUT total INT
  -- )
  -- BEGIN
  --     DECLARE i INT DEFAULT 1;
  --     SET total = 0;
  --     
  --     WHILE i <= n DO
  --         SET total = total + i;
  --         SET i = i + 1;
  --     END WHILE;
  -- END //
  -- 
  -- DELIMITER ;


挑战 3: 错误处理（概念）
──────────────────────────────────────
使用 DECLARE CONTINUE HANDLER

你的SQL（概念）：
  -- DELIMITER //
  -- 
  -- CREATE PROCEDURE safe_delete(
  --     IN table_id INT
  -- )
  -- BEGIN
  --     DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
  --     BEGIN
  --         -- 错误处理逻辑
  --         SELECT 'Error occurred' AS message;
  --     END;
  --     
  --     DELETE FROM some_table WHERE id = table_id;
  -- END //
  -- 
  -- DELIMITER ;


挑战 4: 复杂业务逻辑（概念）
──────────────────────────────────────
创建订单并计算总价

你的SQL（概念）：
  -- DELIMITER //
  -- 
  -- CREATE PROCEDURE create_order(
  --     IN customer_id INT,
  --     IN product_id CHAR(10),
  --     IN qty INT,
  --     OUT new_order_num INT,
  --     OUT order_total DECIMAL(8,2)
  -- )
  -- BEGIN
  --     DECLARE price DECIMAL(8,2);
  --     
  --     -- 获取产品价格
  --     SELECT prod_price INTO price
  --     FROM products
  --     WHERE prod_id = product_id;
  --     
  --     -- 创建订单
  --     INSERT INTO orders(order_date, cust_id)
  --     VALUES(NOW(), customer_id);
  --     
  --     SET new_order_num = LAST_INSERT_ID();
  --     
  --     -- 添加订单项
  --     INSERT INTO orderitems(order_num, order_item, 
  --                            prod_id, quantity, item_price)
  --     VALUES(new_order_num, 1, product_id, qty, price);
  --     
  --     -- 计算总价
  --     SET order_total = price * qty;
  -- END //
  -- 
  -- DELIMITER ;

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💡 重要提示
──────────────────────────────────────

⚠️  DELIMITER 的作用
   MySQL 默认使用 ; 作为语句结束符
   但存储过程内部也需要用 ;
   所以创建前改为 //
   创建后改回 ;

⚠️  变量使用
   DECLARE：声明局部变量（过程内部）
   SET：设置变量值
   @var：用户变量（会话级别）
   
   示例：
   DECLARE total DECIMAL(8,2);  -- 局部变量
   SET total = 100;             -- 设置值
   SELECT @total;               -- 用户变量

⚠️  参数类型
   IN：只读，传入值
   OUT：只写，返回值
   INOUT：可读可写
   
   默认是 IN，可以省略

⚠️  INTO 子句
   将 SELECT 结果赋值给变量
   
   SELECT column INTO variable
   FROM table
   WHERE condition;

⚠️  条件语句
   IF condition THEN
       statements;
   ELSEIF condition THEN
       statements;
   ELSE
       statements;
   END IF;

⚠️  循环语句
   WHILE condition DO
       statements;
   END WHILE;
   
   REPEAT
       statements;
   UNTIL condition
   END REPEAT;

⚠️  错误处理
   DECLARE handler_type HANDLER
   FOR condition_value
   statement;
   
   handler_type: CONTINUE | EXIT | UNDO

⚠️  查看存储过程
   查看所有存储过程：
   SHOW PROCEDURE STATUS;
   
   查看创建语句：
   SHOW CREATE PROCEDURE procedure_name;

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 实战示例
──────────────────────────────────────

示例 1: 简单的存储过程
  DELIMITER //
  
  CREATE PROCEDURE productpricing()
  BEGIN
      SELECT Avg(prod_price) AS priceaverage
      FROM products;
  END //
  
  DELIMITER ;
  
  CALL productpricing();


示例 2: 带 OUT 参数
  DELIMITER //
  
  CREATE PROCEDURE productpricing(
      OUT pl DECIMAL(8,2),
      OUT ph DECIMAL(8,2),
      OUT pa DECIMAL(8,2)
  )
  BEGIN
      SELECT Min(prod_price) INTO pl FROM products;
      SELECT Max(prod_price) INTO ph FROM products;
      SELECT Avg(prod_price) INTO pa FROM products;
  END //
  
  DELIMITER ;
  
  CALL productpricing(@low, @high, @avg);
  SELECT @low, @high, @avg;


示例 3: 带 IN 和 OUT 参数
  DELIMITER //
  
  CREATE PROCEDURE ordertotal(
      IN onumber INT,
      OUT ototal DECIMAL(8,2)
  )
  BEGIN
      SELECT Sum(item_price*quantity)
      FROM orderitems
      WHERE order_num = onumber
      INTO ototal;
  END //
  
  DELIMITER ;
  
  CALL ordertotal(20005, @total);
  SELECT @total;


示例 4: 带条件逻辑
  DELIMITER //
  
  CREATE PROCEDURE ordertotal(
      IN onumber INT,
      IN taxable BOOLEAN,
      OUT ototal DECIMAL(8,2)
  )
  BEGIN
      DECLARE total DECIMAL(8,2);
      DECLARE taxrate INT DEFAULT 6;
      
      SELECT Sum(item_price*quantity)
      FROM orderitems
      WHERE order_num = onumber
      INTO total;
      
      IF taxable THEN
          SELECT total + (total/100*taxrate) INTO ototal;
      ELSE
          SELECT total INTO ototal;
      END IF;
  END //
  
  DELIMITER ;
  
  -- 不含税
  CALL ordertotal(20005, 0, @total);
  SELECT @total;
  
  -- 含税
  CALL ordertotal(20005, 1, @total);
  SELECT @total;


示例 5: 使用游标（高级）
  DELIMITER //
  
  CREATE PROCEDURE processorders()
  BEGIN
      DECLARE done BOOLEAN DEFAULT 0;
      DECLARE o INT;
      DECLARE t DECIMAL(8,2);
      
      DECLARE ordernumbers CURSOR FOR
      SELECT order_num FROM orders;
      
      DECLARE CONTINUE HANDLER FOR SQLSTATE '02000'
      SET done = 1;
      
      OPEN ordernumbers;
      
      REPEAT
          FETCH ordernumbers INTO o;
          CALL ordertotal(o, 1, t);
      UNTIL done END REPEAT;
      
      CLOSE ordernumbers;
  END //
  
  DELIMITER ;


示例 6: 删除存储过程
  DROP PROCEDURE IF EXISTS productpricing;

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎓 知识检查点
──────────────────────────────────────

□ 你理解什么是存储过程吗？
□ 你知道为什么使用存储过程吗？
□ 你会创建简单的存储过程吗？
□ 你理解 DELIMITER 的作用吗？
□ 你会使用 IN、OUT 参数吗？
□ 你能在存储过程中使用条件语句吗？
□ 你知道如何查看和删除存储过程吗？
□ 你了解存储过程的优缺点吗？

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✨ 本章小结
──────────────────────────────────────

你已经学会了：
✓ 理解存储过程的概念和用途
✓ 使用 CREATE PROCEDURE 创建存储过程
✓ 使用 CALL 执行存储过程
✓ 使用 DROP PROCEDURE 删除存储过程
✓ 理解 DELIMITER 的作用
✓ 使用 IN、OUT、INOUT 参数
✓ 在存储过程中使用变量
✓ 使用 IF 条件语句
✓ 使用 WHILE/REPEAT 循环
✓ 查看存储过程定义

核心要点：
• 存储过程是保存的 SQL 语句集合
• 简化复杂操作，提高性能和安全性
• DELIMITER 用于改变语句分隔符
• 参数类型：IN（传入）、OUT（返回）、INOUT（双向）
• 可以包含变量、条件语句、循环等

下一章将学习如何使用游标！

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💻 动手实践
──────────────────────────────────────
查看现有存储过程：

-- 查看所有存储过程
SHOW PROCEDURE STATUS WHERE db = 'crashcourse';

-- 查看特定存储过程的定义
-- SHOW CREATE PROCEDURE procedure_name;

⚠️  创建存储过程需要特殊权限
    在生产环境要谨慎使用
    建议在测试环境练习

存储过程是数据库编程的重要工具！

选择 "1. 进入 MySQL 实践" 开始练习
