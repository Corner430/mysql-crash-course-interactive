━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📚 第 14 章：使用子查询
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📖 学习目标
──────────────────────────────────────
✓ 理解子查询的概念和应用场景
✓ 掌握使用子查询进行数据过滤
✓ 学会将子查询作为计算字段使用
✓ 理解子查询的执行顺序和性能考虑

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📝 核心知识点
──────────────────────────────────────

1️⃣  什么是子查询
   ────────────────────────────────────
   子查询是嵌套在其他查询中的查询
   也称为内部查询或嵌套查询
   
   用途：
   • 分步骤解决复杂查询问题
   • 基于一个查询的结果进行另一个查询
   • 动态生成过滤条件


2️⃣  子查询基本语法
   ────────────────────────────────────
   SELECT column_name
   FROM table1
   WHERE column_name IN (SELECT column_name 
                         FROM table2
                         WHERE condition);
   
   说明：内层查询先执行，结果传递给外层查询


3️⃣  利用子查询进行过滤 - 示例1
   ────────────────────────────────────
   需求：找出购买了产品 TNT2 的所有客户
   
   SELECT cust_name, cust_contact
   FROM customers
   WHERE cust_id IN (SELECT cust_id
                     FROM orders
                     WHERE order_num IN (SELECT order_num
                                        FROM orderitems
                                        WHERE prod_id = 'TNT2'));
   
   执行步骤：
   1. 最内层：找出产品TNT2的订单号
   2. 中间层：找出这些订单的客户ID  
   3. 外层：根据客户ID查找客户信息


4️⃣  逐步分解子查询
   ────────────────────────────────────
   步骤1：找出包含TNT2的订单
   SELECT order_num FROM orderitems WHERE prod_id = 'TNT2';
   -- 结果：20005, 20007
   
   步骤2：找出这些订单的客户
   SELECT cust_id FROM orders 
   WHERE order_num IN (20005, 20007);
   -- 结果：10001, 10004
   
   步骤3：查找客户信息
   SELECT cust_name FROM customers 
   WHERE cust_id IN (10001, 10004);


5️⃣  作为计算字段的子查询
   ────────────────────────────────────
   SELECT cust_name,
          cust_state,
          (SELECT COUNT(*)
           FROM orders
           WHERE orders.cust_id = customers.cust_id) AS orders_count
   FROM customers
   ORDER BY cust_name;
   
   说明：
   • 为每个客户计算订单数量
   • 子查询中使用了完全限定列名
   • 这种子查询称为相关子查询


6️⃣  相关子查询
   ────────────────────────────────────
   相关子查询：涉及外部查询的子查询
   
   特点：
   • 子查询引用外部查询的列
   • 对外部查询的每一行都执行一次子查询
   • 使用完全限定列名避免歧义
   
   WHERE orders.cust_id = customers.cust_id
         ^外部查询       ^内部查询


7️⃣  使用子查询的注意事项
   ────────────────────────────────────
   ⚠️  列名歧义：使用完全限定列名
   ⚠️  性能：子查询可能比联结慢
   ⚠️  嵌套层数：不要嵌套太深（一般不超过3层）
   ⚠️  单列：作为 WHERE 条件的子查询只能返回单列
   ⚠️  调试：逐步测试从内到外的每个查询


8️⃣  子查询 vs 联结
   ────────────────────────────────────
   同样的结果可以用联结实现：
   
   子查询方式：
   SELECT cust_name
   FROM customers
   WHERE cust_id IN (SELECT cust_id FROM orders);
   
   联结方式：
   SELECT DISTINCT cust_name
   FROM customers c
   INNER JOIN orders o ON c.cust_id = o.cust_id;
   
   选择依据：可读性、性能、个人偏好

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 实践任务
──────────────────────────────────────

📝 基础练习
──────────────────────────────────────

练习 1: 查找特定产品的客户
──────────────────────────────────────
找出购买了产品 ANV01 的所有客户名称

你的SQL：
  SELECT cust_name
  FROM customers
  WHERE cust_id IN (SELECT cust_id
                    FROM orders
                    WHERE order_num IN (SELECT order_num
                                       FROM orderitems
                                       WHERE prod_id = 'ANV01'));


练习 2: 统计每个客户的订单数
──────────────────────────────────────
显示客户名称和对应的订单数量

你的SQL：
  SELECT cust_name,
         (SELECT COUNT(*)
          FROM orders
          WHERE orders.cust_id = customers.cust_id) AS num_orders
  FROM customers
  ORDER BY cust_name;


练习 3: 查找有订单的客户
──────────────────────────────────────
找出所有下过订单的客户ID

你的SQL：
  SELECT cust_id, cust_name
  FROM customers
  WHERE cust_id IN (SELECT DISTINCT cust_id FROM orders);


练习 4: 查找特定供应商的产品订单
──────────────────────────────────────
找出购买了供应商1003产品的订单号

你的SQL：
  SELECT DISTINCT order_num
  FROM orderitems
  WHERE prod_id IN (SELECT prod_id
                    FROM products
                    WHERE vend_id = 1003);


练习 5: 计算产品被订购次数
──────────────────────────────────────
显示每个产品的ID和被订购的次数

你的SQL：
  SELECT prod_id,
         (SELECT COUNT(*)
          FROM orderitems
          WHERE orderitems.prod_id = products.prod_id) AS times_ordered
  FROM products;

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🚀 进阶挑战
──────────────────────────────────────

挑战 1: 找出高价产品的客户
──────────────────────────────────────
找出购买了价格>=10元产品的客户名称（去重）

你的SQL：
  SELECT DISTINCT cust_name
  FROM customers
  WHERE cust_id IN (
    SELECT cust_id FROM orders
    WHERE order_num IN (
      SELECT order_num FROM orderitems
      WHERE prod_id IN (
        SELECT prod_id FROM products
        WHERE prod_price >= 10
      )
    )
  );


挑战 2: 客户订单金额统计
──────────────────────────────────────
显示每个客户的总订单金额

你的SQL：
  SELECT cust_name,
         (SELECT SUM(quantity * item_price)
          FROM orderitems oi
          JOIN orders o ON oi.order_num = o.order_num
          WHERE o.cust_id = c.cust_id) AS total_amount
  FROM customers c
  ORDER BY total_amount DESC;


挑战 3: 找出没有订单的客户
──────────────────────────────────────
找出从未下过订单的客户

你的SQL：
  SELECT cust_id, cust_name
  FROM customers
  WHERE cust_id NOT IN (SELECT DISTINCT cust_id FROM orders);


挑战 4: 产品订购数量排名
──────────────────────────────────────
显示每个产品被订购的总数量，按数量降序

你的SQL：
  SELECT prod_name,
         (SELECT SUM(quantity)
          FROM orderitems
          WHERE orderitems.prod_id = products.prod_id) AS total_ordered
  FROM products
  ORDER BY total_ordered DESC;


挑战 5: 多条件组合子查询
──────────────────────────────────────
找出购买了供应商1003产品且订单金额>50的客户

你的SQL：
  SELECT DISTINCT cust_name
  FROM customers c
  WHERE cust_id IN (
    SELECT cust_id FROM orders o
    WHERE order_num IN (
      SELECT order_num FROM orderitems
      WHERE prod_id IN (SELECT prod_id FROM products WHERE vend_id = 1003)
      GROUP BY order_num
      HAVING SUM(quantity * item_price) > 50
    )
  );

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💡 重要提示
──────────────────────────────────────

⚠️  列名歧义问题
   在相关子查询中必须使用完全限定列名
   WHERE orders.cust_id = customers.cust_id
   避免 MySQL 不知道你指的是哪个表的列

⚠️  性能考虑
   子查询可能比联结慢，特别是相关子查询
   相关子查询对外部查询的每一行都执行一次
   大数据量时优先考虑使用联结

⚠️  只返回单列
   作为 WHERE IN 条件的子查询必须只返回单列
   ❌ SELECT cust_id, cust_name FROM ...
   ✅ SELECT cust_id FROM ...

⚠️  子查询嵌套深度
   理论上可以无限嵌套，但不建议超过3层
   嵌套太深难以理解和维护
   考虑使用联结或分步查询

⚠️  调试技巧
   从最内层子查询开始测试
   逐层向外验证每个查询的结果
   确保每层查询都返回正确的数据

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 实战示例
──────────────────────────────────────

示例 1: 三层嵌套子查询
  SELECT cust_name
  FROM customers
  WHERE cust_id IN (
    SELECT cust_id FROM orders
    WHERE order_num IN (
      SELECT order_num FROM orderitems
      WHERE prod_id = 'TNT2'
    )
  );


示例 2: 相关子查询计算
  SELECT prod_name,
         prod_price,
         (SELECT AVG(prod_price) FROM products) AS avg_price,
         prod_price - (SELECT AVG(prod_price) FROM products) AS diff
  FROM products;


示例 3: EXISTS 操作符
  SELECT cust_name
  FROM customers c
  WHERE EXISTS (
    SELECT 1 FROM orders o
    WHERE o.cust_id = c.cust_id
  );


示例 4: 子查询与比较操作符
  SELECT prod_name, prod_price
  FROM products
  WHERE prod_price > (
    SELECT AVG(prod_price) FROM products
  );


示例 5: 多个相关子查询
  SELECT cust_name,
         (SELECT COUNT(*) FROM orders 
          WHERE orders.cust_id = customers.cust_id) AS total_orders,
         (SELECT SUM(quantity) FROM orderitems oi
          JOIN orders o ON oi.order_num = o.order_num
          WHERE o.cust_id = customers.cust_id) AS total_items
  FROM customers;

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎓 知识检查点
──────────────────────────────────────

□ 你理解什么是子查询吗？
□ 你知道子查询的执行顺序吗？
□ 你会使用子查询进行过滤吗？
□ 你理解什么是相关子查询吗？
□ 你会将子查询作为计算字段使用吗？
□ 你知道何时使用完全限定列名吗？
□ 你了解子查询和联结的区别吗？
□ 你知道如何调试子查询吗？

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✨ 本章小结
──────────────────────────────────────

你已经学会了：
✓ 理解子查询的概念和用途
✓ 使用子查询作为 WHERE 条件进行过滤
✓ 将子查询用作计算字段
✓ 理解相关子查询的工作原理
✓ 使用完全限定列名避免歧义
✓ 了解子查询与联结的区别
✓ 掌握子查询的调试技巧

下一章将学习联结表，这是另一种组合数据的强大方法！

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💻 动手实践
──────────────────────────────────────
现在就打开 MySQL，在 crashcourse 数据库中
试试子查询的强大功能吧！

