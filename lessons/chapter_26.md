━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📚 第 26 章：管理事务处理
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📖 学习目标
──────────────────────────────────────
✓ 理解什么是事务处理
✓ 掌握 START TRANSACTION、COMMIT、ROLLBACK
✓ 学会使用保留点 SAVEPOINT
✓ 了解事务的 ACID 特性

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📝 核心知识点
──────────────────────────────────────

1️⃣  什么是事务处理
   ────────────────────────────────────
   事务处理（transaction processing）用来维护
   数据库的完整性，保证成批的 MySQL 操作要么
   完全执行，要么完全不执行。
   
   关键概念：
   • 事务（transaction）：一组 SQL 语句
   • 回退（rollback）：撤销指定 SQL 语句
   • 提交（commit）：将结果写入数据库
   • 保留点（savepoint）：临时占位符


2️⃣  为什么需要事务
   ────────────────────────────────────
   经典场景：银行转账
   
   第 1 步：从账户 A 扣除 100 元
   第 2 步：向账户 B 增加 100 元
   
   问题：
   如果步骤 1 成功，但步骤 2 失败会怎样？
   账户 A 少了 100 元，但 B 没有增加！
   
   解决方案：
   使用事务确保两步要么都成功，要么都失败


3️⃣  事务的 ACID 特性
   ────────────────────────────────────
   A - Atomicity（原子性）
       事务中的所有操作要么全部完成，要么全部不完成
   
   C - Consistency（一致性）
       事务前后数据库的完整性不被破坏
   
   I - Isolation（隔离性）
       多个事务并发执行时互不干扰
   
   D - Durability（持久性）
       事务提交后，修改永久保存


4️⃣  控制事务的语句
   ────────────────────────────────────
   START TRANSACTION - 开始事务
   COMMIT - 提交事务（永久保存）
   ROLLBACK - 回滚事务（撤销更改）
   SAVEPOINT - 创建保留点
   ROLLBACK TO - 回滚到保留点


5️⃣  START TRANSACTION
   ────────────────────────────────────
   START TRANSACTION;
   
   说明：
   • 标识事务的开始
   • 之后的 SQL 语句属于同一事务
   • 直到 COMMIT 或 ROLLBACK


6️⃣  ROLLBACK - 回滚
   ────────────────────────────────────
   START TRANSACTION;
   DELETE FROM orders;
   ROLLBACK;
   
   说明：
   • DELETE 执行了，但被 ROLLBACK 撤销
   • 数据没有真正被删除
   • 可以回滚 INSERT、UPDATE、DELETE
   • 不能回滚 CREATE、DROP


7️⃣  COMMIT - 提交
   ────────────────────────────────────
   START TRANSACTION;
   DELETE FROM orderitems WHERE order_num = 20010;
   DELETE FROM orders WHERE order_num = 20010;
   COMMIT;
   
   说明：
   • 删除订单及其订单项
   • COMMIT 后永久保存
   • 事务结束


8️⃣  隐含提交
   ────────────────────────────────────
   默认的 MySQL 行为：
   • 每条语句自动提交
   • 除非显式开始事务
   
   SET autocommit=0;  -- 关闭自动提交
   
   说明：
   • autocommit=0 禁用自动提交
   • 需要手动 COMMIT
   • 针对每个连接设置


9️⃣  使用保留点 - SAVEPOINT
   ────────────────────────────────────
   START TRANSACTION;
   DELETE FROM orderitems WHERE order_num = 20010;
   SAVEPOINT delete_items;
   DELETE FROM orders WHERE order_num = 20010;
   ROLLBACK TO delete_items;
   
   说明：
   • SAVEPOINT 创建占位符
   • 可以回滚到指定保留点
   • 保留点越多越好（灵活性）
   • 保留点在事务提交或回滚后自动释放


🔟  完整的事务示例
   ────────────────────────────────────
   START TRANSACTION;
   
   -- 插入订单
   INSERT INTO orders(order_date, cust_id)
   VALUES(Now(), 10001);
   
   -- 获取订单号
   SET @order_num = LAST_INSERT_ID();
   
   -- 插入订单项
   INSERT INTO orderitems(order_num, order_item, 
                          prod_id, quantity, item_price)
   VALUES(@order_num, 1, 'TNT2', 100, 10.00);
   
   INSERT INTO orderitems(order_num, order_item,
                          prod_id, quantity, item_price)
   VALUES(@order_num, 2, 'FB', 10, 2.50);
   
   -- 提交事务
   COMMIT;

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 实践任务
──────────────────────────────────────

📝 基础练习
──────────────────────────────────────

练习 1: 理解事务概念
──────────────────────────────────────
事务的 ACID 特性是什么？

答案：
  A - Atomicity（原子性）：全部成功或全部失败
  C - Consistency（一致性）：保持数据完整性
  I - Isolation（隔离性）：事务互不干扰
  D - Durability（持久性）：提交后永久保存


练习 2: 回滚演示（概念）
──────────────────────────────────────
演示回滚的作用

你的SQL（概念）：
  -- START TRANSACTION;
  -- SELECT * FROM customers;  -- 查看现有数据
  -- DELETE FROM customers WHERE cust_id = 10001;
  -- SELECT * FROM customers;  -- 数据已删除
  -- ROLLBACK;
  -- SELECT * FROM customers;  -- 数据恢复了！


练习 3: 提交演示（概念）
──────────────────────────────────────
永久保存更改

你的SQL（概念）：
  -- START TRANSACTION;
  -- UPDATE products
  -- SET prod_price = prod_price * 1.10
  -- WHERE vend_id = 1003;
  -- COMMIT;  -- 永久保存


练习 4: 查看自动提交状态
──────────────────────────────────────
检查当前的自动提交设置

你的SQL：
  SELECT @@autocommit;
  -- 返回 1 表示开启，0 表示关闭

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🚀 进阶挑战
──────────────────────────────────────

挑战 1: 使用保留点（概念）
──────────────────────────────────────
部分回滚事务

你的SQL（概念）：
  -- START TRANSACTION;
  -- 
  -- UPDATE products SET prod_price = 10 WHERE prod_id = 'ANV01';
  -- SAVEPOINT update1;
  -- 
  -- UPDATE products SET prod_price = 20 WHERE prod_id = 'ANV02';
  -- SAVEPOINT update2;
  -- 
  -- UPDATE products SET prod_price = 30 WHERE prod_id = 'ANV03';
  -- 
  -- -- 只回滚最后一个更新
  -- ROLLBACK TO update2;
  -- 
  -- COMMIT;


挑战 2: 转账事务（概念）
──────────────────────────────────────
模拟银行转账

你的SQL（概念）：
  -- START TRANSACTION;
  -- 
  -- -- 从账户 A 扣款
  -- UPDATE accounts
  -- SET balance = balance - 100
  -- WHERE account_id = 'A001';
  -- 
  -- -- 检查余额是否足够
  -- SELECT balance INTO @balance
  -- FROM accounts
  -- WHERE account_id = 'A001';
  -- 
  -- IF @balance < 0 THEN
  --     ROLLBACK;
  -- ELSE
  --     -- 向账户 B 存款
  --     UPDATE accounts
  --     SET balance = balance + 100
  --     WHERE account_id = 'B001';
  --     
  --     COMMIT;
  -- END IF;


挑战 3: 创建订单事务（概念）
──────────────────────────────────────
完整的订单创建流程

你的SQL（概念）：
  -- START TRANSACTION;
  -- 
  -- -- 创建订单
  -- INSERT INTO orders(order_date, cust_id)
  -- VALUES(NOW(), 10001);
  -- 
  -- SET @order_num = LAST_INSERT_ID();
  -- 
  -- -- 添加订单项
  -- INSERT INTO orderitems(order_num, order_item, 
  --                        prod_id, quantity, item_price)
  -- SELECT @order_num, 1, prod_id, 5, prod_price
  -- FROM products
  -- WHERE prod_id = 'TNT2';
  -- 
  -- -- 更新库存
  -- UPDATE products
  -- SET stock = stock - 5
  -- WHERE prod_id = 'TNT2';
  -- 
  -- -- 检查库存
  -- IF (SELECT stock FROM products WHERE prod_id = 'TNT2') < 0 THEN
  --     ROLLBACK;
  -- ELSE
  --     COMMIT;
  -- END IF;


挑战 4: 批量操作事务（概念）
──────────────────────────────────────
批量更新价格并验证

你的SQL（概念）：
  -- START TRANSACTION;
  -- 
  -- -- 保存原始数据
  -- CREATE TEMPORARY TABLE price_backup AS
  -- SELECT prod_id, prod_price FROM products;
  -- 
  -- -- 批量更新
  -- UPDATE products
  -- SET prod_price = prod_price * 1.15
  -- WHERE vend_id = 1003;
  -- 
  -- -- 验证更新
  -- SELECT COUNT(*) INTO @updated_count
  -- FROM products
  -- WHERE vend_id = 1003 AND prod_price > 0;
  -- 
  -- IF @updated_count > 0 THEN
  --     COMMIT;
  -- ELSE
  --     ROLLBACK;
  -- END IF;

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💡 重要提示
──────────────────────────────────────

⚠️  哪些语句可以回滚
   可以回滚：
   • INSERT
   • UPDATE
   • DELETE
   
   不能回滚：
   • CREATE
   • DROP
   • ALTER
   
   这些语句执行后自动提交

⚠️  事务只对特定引擎有效
   InnoDB：支持事务
   MyISAM：不支持事务
   
   查看表引擎：
   SHOW TABLE STATUS FROM crashcourse;

⚠️  自动提交
   MySQL 默认自动提交每条语句
   使用事务需要 START TRANSACTION
   或 SET autocommit=0

⚠️  保留点命名
   保留点名称要有意义
   同一事务中可以有多个保留点
   保留点在事务结束后自动释放

⚠️  事务嵌套
   MySQL 不支持事务嵌套
   START TRANSACTION 会隐式提交前一个事务

⚠️  超时
   事务不要运行太久
   长事务会锁定资源
   影响其他用户操作

⚠️  错误处理
   事务中如果出错
   应该 ROLLBACK
   而不是 COMMIT

⚠️  死锁
   多个事务相互等待对方释放锁
   MySQL 会自动检测并终止其中一个
   应用程序需要重试

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 实战示例
──────────────────────────────────────

示例 1: 基本回滚
  START TRANSACTION;
  DELETE FROM orders;
  ROLLBACK;
  -- orders 表的数据没有被删除


示例 2: 基本提交
  START TRANSACTION;
  DELETE FROM orderitems WHERE order_num = 20010;
  DELETE FROM orders WHERE order_num = 20010;
  COMMIT;
  -- 订单及订单项被永久删除


示例 3: 使用保留点
  START TRANSACTION;
  DELETE FROM orderitems WHERE order_num = 20010;
  SAVEPOINT delete_items;
  DELETE FROM orders WHERE order_num = 20010;
  ROLLBACK TO delete_items;
  COMMIT;
  -- 只删除了订单项，订单保留


示例 4: 完整的订单处理
  START TRANSACTION;
  
  -- 创建订单
  INSERT INTO orders(order_date, cust_id)
  VALUES(Now(), 10001);
  
  SET @order_num = LAST_INSERT_ID();
  
  -- 添加订单项
  INSERT INTO orderitems(order_num, order_item, 
                         prod_id, quantity, item_price)
  VALUES(@order_num, 1, 'TNT2', 100, 10.00),
        (@order_num, 2, 'FB', 10, 2.50);
  
  COMMIT;


示例 5: 转账模拟
  START TRANSACTION;
  
  UPDATE accounts SET balance = balance - 100
  WHERE account_id = 'A001';
  
  UPDATE accounts SET balance = balance + 100
  WHERE account_id = 'B001';
  
  COMMIT;


示例 6: 批量操作
  START TRANSACTION;
  
  UPDATE products
  SET prod_price = prod_price * 1.10
  WHERE vend_id = 1003;
  
  -- 检查更新结果
  SELECT COUNT(*) FROM products
  WHERE vend_id = 1003;
  
  -- 如果满意就提交
  COMMIT;
  -- 否则
  -- ROLLBACK;


示例 7: 关闭自动提交
  SET autocommit = 0;
  
  DELETE FROM orders WHERE order_num = 20010;
  -- 未提交，可以回滚
  
  ROLLBACK;
  -- 或
  COMMIT;
  
  SET autocommit = 1;  -- 恢复自动提交

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎓 知识检查点
──────────────────────────────────────

□ 你理解什么是事务处理吗？
□ 你知道事务的 ACID 特性吗？
□ 你会使用 START TRANSACTION 吗？
□ 你知道 COMMIT 和 ROLLBACK 的区别吗？
□ 你会使用保留点吗？
□ 你了解哪些语句不能回滚吗？
□ 你知道事务只对 InnoDB 有效吗？
□ 你理解自动提交的含义吗？

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔍 事务使用最佳实践
──────────────────────────────────────

1. 保持事务简短
   ✓ 只包含必要的操作
   ✓ 避免长时间运行
   ✓ 减少锁定时间

2. 事务中避免用户交互
   ✗ 不要在事务中等待用户输入
   ✗ 不要显示信息等待确认
   ✓ 在事务外完成交互

3. 明确的错误处理
   ✓ 使用 TRY-CATCH（在存储过程中）
   ✓ 错误时 ROLLBACK
   ✓ 成功时 COMMIT

4. 合理使用保留点
   ✓ 复杂事务使用多个保留点
   ✓ 保留点命名要清晰
   ✓ 可以部分回滚

5. 测试并发场景
   ✓ 测试多用户同时操作
   ✓ 处理死锁情况
   ✓ 设置合理的隔离级别

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✨ 本章小结
──────────────────────────────────────

你已经学会了：
✓ 理解事务处理的概念和重要性
✓ 掌握事务的 ACID 特性
✓ 使用 START TRANSACTION 开始事务
✓ 使用 COMMIT 提交事务
✓ 使用 ROLLBACK 回滚事务
✓ 使用 SAVEPOINT 创建保留点
✓ 理解自动提交机制
✓ 知道哪些语句可以/不可以回滚
✓ 了解事务只对 InnoDB 引擎有效

核心要点：
• 事务确保一组操作要么全部成功，要么全部失败
• ACID 特性保证数据完整性和一致性
• 使用 COMMIT 永久保存，ROLLBACK 撤销更改
• CREATE/DROP 等 DDL 语句不能回滚
• 保持事务简短，避免长时间锁定

下一章将学习全球化和本地化！

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💻 动手实践
──────────────────────────────────────
可以安全练习的操作：

-- 查看自动提交状态
SELECT @@autocommit;

-- 查看表的存储引擎
SHOW TABLE STATUS FROM crashcourse;

-- 演示回滚（概念，不要真正执行）
-- START TRANSACTION;
-- SELECT * FROM customers;
-- DELETE FROM customers WHERE cust_id = 10001;
-- ROLLBACK;  -- 撤销删除
-- SELECT * FROM customers;

⚠️  不要在 crashcourse 数据库中执行修改操作
    事务是强大的工具，要负责任地使用

事务是保证数据完整性的核心机制！

