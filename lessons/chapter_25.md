━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📚 第 25 章：使用触发器
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📖 学习目标
──────────────────────────────────────
✓ 理解什么是触发器
✓ 掌握创建和使用触发器
✓ 了解不同类型的触发器
✓ 学会删除触发器

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📝 核心知识点
──────────────────────────────────────

1️⃣  什么是触发器
   ────────────────────────────────────
   触发器是 MySQL 响应以下任意语句而自动执行的
   一条 MySQL 语句（或位于 BEGIN 和 END 之间的
   一组语句）：
   
   • DELETE
   • INSERT
   • UPDATE
   
   其他 MySQL 语句不支持触发器


2️⃣  触发器的特点
   ────────────────────────────────────
   • 自动执行（无需手动调用）
   • 与特定表关联
   • 响应特定操作（INSERT/UPDATE/DELETE）
   • 可以在操作前（BEFORE）或后（AFTER）执行


3️⃣  触发器的用途
   ────────────────────────────────────
   ✓ 保证数据一致性
   ✓ 自动生成派生列值
   ✓ 防止错误或不一致的数据
   ✓ 审计和日志记录
   ✓ 同步表数据
   ✓ 实现复杂的业务规则


4️⃣  创建触发器
   ────────────────────────────────────
   CREATE TRIGGER trigger_name
   trigger_time trigger_event
   ON table_name FOR EACH ROW
   trigger_body
   
   参数说明：
   • trigger_time: BEFORE 或 AFTER
   • trigger_event: INSERT, UPDATE 或 DELETE
   • table_name: 触发器关联的表
   • FOR EACH ROW: 行级触发器
   • trigger_body: 触发器执行的 SQL 语句


5️⃣  INSERT 触发器
   ────────────────────────────────────
   在 INSERT 操作执行前或后触发
   
   特点：
   • BEFORE INSERT: 插入前执行
   • AFTER INSERT: 插入后执行
   • NEW 关键字：访问新插入的行
   
   示例：
   CREATE TRIGGER neworder AFTER INSERT ON orders
   FOR EACH ROW SELECT NEW.order_num;


6️⃣  DELETE 触发器
   ────────────────────────────────────
   在 DELETE 操作执行前或后触发
   
   特点：
   • BEFORE DELETE: 删除前执行
   • AFTER DELETE: 删除后执行
   • OLD 关键字：访问被删除的行
   
   示例：
   CREATE TRIGGER deleteorder BEFORE DELETE ON orders
   FOR EACH ROW
   BEGIN
       INSERT INTO archive_orders(order_num, order_date)
       VALUES(OLD.order_num, OLD.order_date);
   END;


7️⃣  UPDATE 触发器
   ────────────────────────────────────
   在 UPDATE 操作执行前或后触发
   
   特点：
   • BEFORE UPDATE: 更新前执行
   • AFTER UPDATE: 更新后执行
   • OLD 关键字：访问更新前的值
   • NEW 关键字：访问更新后的值
   
   示例：
   CREATE TRIGGER updatevendor BEFORE UPDATE ON vendors
   FOR EACH ROW SET NEW.vend_state = Upper(NEW.vend_state);


8️⃣  查看触发器
   ────────────────────────────────────
   查看所有触发器：
   SHOW TRIGGERS;
   
   查看特定数据库的触发器：
   SHOW TRIGGERS FROM database_name;
   
   查看触发器创建语句：
   SHOW CREATE TRIGGER trigger_name;


9️⃣  删除触发器
   ────────────────────────────────────
   DROP TRIGGER IF EXISTS trigger_name;
   
   注意：
   • 触发器不能更新或覆盖
   • 要修改触发器，必须先删除后重建


🔟  触发器的限制
   ────────────────────────────────────
   • 每个表最多支持 6 个触发器
     （BEFORE/AFTER × INSERT/UPDATE/DELETE）
   • 单一触发器不能与多个事件关联
   • 触发器不能调用存储过程返回结果集
   • BEFORE 触发器可以修改 NEW 的值
   • AFTER 触发器不能修改数据

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 实践任务
──────────────────────────────────────

📝 基础练习
──────────────────────────────────────

练习 1: 查看现有触发器
──────────────────────────────────────
查看数据库中的所有触发器

你的SQL：
  SHOW TRIGGERS;
  -- 或
  SHOW TRIGGERS FROM crashcourse;


练习 2: INSERT 触发器（概念）
──────────────────────────────────────
插入后自动显示订单号

你的SQL（概念）：
  -- CREATE TRIGGER neworder
  -- AFTER INSERT ON orders
  -- FOR EACH ROW
  -- SELECT NEW.order_num;


练习 3: DELETE 触发器归档（概念）
──────────────────────────────────────
删除前备份数据

你的SQL（概念）：
  -- 先创建归档表
  -- CREATE TABLE orders_archive LIKE orders;
  -- 
  -- 创建触发器
  -- DELIMITER //
  -- CREATE TRIGGER archive_deleted_orders
  -- BEFORE DELETE ON orders
  -- FOR EACH ROW
  -- BEGIN
  --     INSERT INTO orders_archive
  --     VALUES(OLD.order_num, OLD.order_date, OLD.cust_id);
  -- END //
  -- DELIMITER ;


练习 4: UPDATE 触发器（概念）
──────────────────────────────────────
更新前自动转换为大写

你的SQL（概念）：
  -- CREATE TRIGGER uppercase_state
  -- BEFORE UPDATE ON vendors
  -- FOR EACH ROW
  -- SET NEW.vend_state = UPPER(NEW.vend_state);

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🚀 进阶挑战
──────────────────────────────────────

挑战 1: 审计日志触发器（概念）
──────────────────────────────────────
记录所有数据变更

你的SQL（概念）：
  -- 创建日志表
  -- CREATE TABLE audit_log (
  --     log_id INT AUTO_INCREMENT PRIMARY KEY,
  --     table_name VARCHAR(50),
  --     action VARCHAR(10),
  --     old_data TEXT,
  --     new_data TEXT,
  --     changed_by VARCHAR(50),
  --     changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  -- );
  -- 
  -- 创建触发器
  -- DELIMITER //
  -- CREATE TRIGGER products_audit
  -- AFTER UPDATE ON products
  -- FOR EACH ROW
  -- BEGIN
  --     INSERT INTO audit_log(table_name, action, old_data, new_data)
  --     VALUES('products', 'UPDATE',
  --            CONCAT('Price:', OLD.prod_price),
  --            CONCAT('Price:', NEW.prod_price));
  -- END //
  -- DELIMITER ;


挑战 2: 数据验证触发器（概念）
──────────────────────────────────────
防止无效数据插入

你的SQL（概念）：
  -- DELIMITER //
  -- CREATE TRIGGER validate_product_price
  -- BEFORE INSERT ON products
  -- FOR EACH ROW
  -- BEGIN
  --     IF NEW.prod_price < 0 THEN
  --         SIGNAL SQLSTATE '45000'
  --         SET MESSAGE_TEXT = 'Price cannot be negative';
  --     END IF;
  -- END //
  -- DELIMITER ;


挑战 3: 自动更新汇总表（概念）
──────────────────────────────────────
维护汇总统计数据

你的SQL（概念）：
  -- 创建汇总表
  -- CREATE TABLE order_summary (
  --     order_num INT PRIMARY KEY,
  --     total_items INT,
  --     total_amount DECIMAL(10,2)
  -- );
  -- 
  -- 插入订单项时更新汇总
  -- DELIMITER //
  -- CREATE TRIGGER update_order_summary
  -- AFTER INSERT ON orderitems
  -- FOR EACH ROW
  -- BEGIN
  --     UPDATE order_summary
  --     SET total_items = total_items + NEW.quantity,
  --         total_amount = total_amount + 
  --                       (NEW.quantity * NEW.item_price)
  --     WHERE order_num = NEW.order_num;
  -- END //
  -- DELIMITER ;


挑战 4: 级联删除触发器（概念）
──────────────────────────────────────
删除主记录时删除相关记录

你的SQL（概念）：
  -- DELIMITER //
  -- CREATE TRIGGER cascade_delete_customer
  -- BEFORE DELETE ON customers
  -- FOR EACH ROW
  -- BEGIN
  --     DELETE FROM orders WHERE cust_id = OLD.cust_id;
  -- END //
  -- DELIMITER ;
  -- 
  -- 注意：现代MySQL应该使用外键的ON DELETE CASCADE

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💡 重要提示
──────────────────────────────────────

⚠️  触发器自动执行
   触发器由操作自动触发
   不需要也不能手动调用
   无法跳过触发器的执行

⚠️  OLD 和 NEW
   INSERT 触发器：只有 NEW
   DELETE 触发器：只有 OLD
   UPDATE 触发器：既有 OLD 又有 NEW
   
   NEW：访问新值（可以在 BEFORE 中修改）
   OLD：访问旧值（只读）

⚠️  BEFORE vs AFTER
   BEFORE：
   • 可以修改 NEW 的值
   • 可以阻止操作（抛出错误）
   • 用于数据验证和清理
   
   AFTER：
   • 不能修改数据
   • 用于日志记录
   • 用于更新其他表

⚠️  触发器不能返回数据
   触发器不能使用 SELECT 返回结果
   （除非是 INSERT 触发器的特例）
   只能执行操作，不能查询结果

⚠️  性能影响
   触发器会影响性能
   每次操作都会执行触发器
   复杂触发器可能显著降低速度
   谨慎使用

⚠️  调试困难
   触发器错误可能难以追踪
   建议保持触发器简单
   充分测试后再部署

⚠️  修改触发器
   触发器不能直接修改
   必须先 DROP 再重新 CREATE
   
   DROP TRIGGER trigger_name;
   CREATE TRIGGER trigger_name ...;

⚠️  命名规范
   建议使用清晰的命名
   例如：
   • tr_tablename_after_insert
   • tr_tablename_before_update
   便于管理和维护

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 实战示例
──────────────────────────────────────

示例 1: INSERT 触发器
  CREATE TRIGGER neworder
  AFTER INSERT ON orders
  FOR EACH ROW
  SELECT NEW.order_num;
  
  -- 说明：插入新订单后显示订单号


示例 2: DELETE 触发器（归档）
  DELIMITER //
  
  CREATE TRIGGER deleteorder
  BEFORE DELETE ON orders
  FOR EACH ROW
  BEGIN
      INSERT INTO archive_orders(order_num, order_date, cust_id)
      VALUES(OLD.order_num, OLD.order_date, OLD.cust_id);
  END //
  
  DELIMITER ;


示例 3: UPDATE 触发器（自动转换）
  CREATE TRIGGER updatevendor
  BEFORE UPDATE ON vendors
  FOR EACH ROW
  SET NEW.vend_state = Upper(NEW.vend_state);
  
  -- 说明：更新前自动将州名转为大写


示例 4: 数据验证触发器
  DELIMITER //
  
  CREATE TRIGGER check_quantity
  BEFORE INSERT ON orderitems
  FOR EACH ROW
  BEGIN
      IF NEW.quantity <= 0 THEN
          SIGNAL SQLSTATE '45000'
          SET MESSAGE_TEXT = 'Quantity must be positive';
      END IF;
  END //
  
  DELIMITER ;


示例 5: 审计触发器
  DELIMITER //
  
  CREATE TRIGGER audit_price_change
  AFTER UPDATE ON products
  FOR EACH ROW
  BEGIN
      IF OLD.prod_price <> NEW.prod_price THEN
          INSERT INTO price_history(prod_id, old_price, 
                                   new_price, changed_at)
          VALUES(NEW.prod_id, OLD.prod_price, 
                 NEW.prod_price, NOW());
      END IF;
  END //
  
  DELIMITER ;


示例 6: 自动时间戳
  CREATE TRIGGER set_update_time
  BEFORE UPDATE ON customers
  FOR EACH ROW
  SET NEW.last_updated = NOW();


示例 7: 维护计数器
  DELIMITER //
  
  CREATE TRIGGER increment_order_count
  AFTER INSERT ON orders
  FOR EACH ROW
  BEGIN
      UPDATE customers
      SET order_count = order_count + 1
      WHERE cust_id = NEW.cust_id;
  END //
  
  DELIMITER ;


示例 8: 删除触发器
  DROP TRIGGER IF EXISTS neworder;

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎓 知识检查点
──────────────────────────────────────

□ 你理解什么是触发器吗？
□ 你知道触发器支持哪些操作吗？
□ 你了解 BEFORE 和 AFTER 的区别吗？
□ 你知道 OLD 和 NEW 的用法吗？
□ 你会创建触发器吗？
□ 你知道如何查看触发器吗？
□ 你了解触发器的限制吗？
□ 你知道触发器对性能的影响吗？

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔍 触发器使用场景
──────────────────────────────────────

适合使用触发器：
✓ 自动生成派生数据
✓ 保持数据一致性
✓ 审计和日志记录
✓ 数据验证
✓ 实现复杂的业务规则
✓ 同步相关表

不适合使用触发器：
✗ 复杂的业务逻辑（用存储过程）
✗ 大量数据操作（性能问题）
✗ 需要返回结果的操作
✗ 可以用约束实现的功能

常见应用：
1. 审计日志
   记录谁在什么时候修改了什么数据

2. 数据验证
   在插入/更新前检查数据合法性

3. 自动填充
   自动设置创建时间、更新时间等

4. 维护汇总
   自动更新统计数据

5. 级联操作
   删除主记录时处理关联记录

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✨ 本章小结
──────────────────────────────────────

你已经学会了：
✓ 理解触发器的概念和用途
✓ 知道触发器支持的操作类型
✓ 掌握 INSERT、DELETE、UPDATE 触发器
✓ 理解 BEFORE 和 AFTER 的区别
✓ 使用 OLD 和 NEW 访问数据
✓ 创建和删除触发器
✓ 查看触发器信息
✓ 了解触发器的限制和最佳实践

核心要点：
• 触发器响应 INSERT/UPDATE/DELETE 自动执行
• 每个表最多 6 个触发器（3种操作 × 2个时机）
• OLD 访问旧值，NEW 访问新值
• BEFORE 可以修改数据，AFTER 不能
• 触发器影响性能，谨慎使用

下一章将学习如何管理事务处理！

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💻 动手实践
──────────────────────────────────────
查看现有触发器：

-- 查看所有触发器
SHOW TRIGGERS;

-- 查看特定数据库的触发器
SHOW TRIGGERS FROM crashcourse;

-- 查看触发器定义
-- SHOW CREATE TRIGGER trigger_name;

⚠️  不要在生产数据库中随意创建触发器
    触发器会自动执行，可能产生意外后果
    建议在测试环境充分测试

触发器是强大的工具，但要谨慎使用！

选择 "1. 进入 MySQL 实践" 开始练习
