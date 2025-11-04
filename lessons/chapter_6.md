━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📚 第 6 章：过滤数据
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📖 学习目标
──────────────────────────────────────
✓ 使用 WHERE 子句过滤数据
✓ 掌握各种比较操作符
✓ 使用 BETWEEN 进行范围检查
✓ 检查 NULL 值

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📝 核心知识点
──────────────────────────────────────

1️⃣  WHERE 子句基础
   
   作用：指定搜索条件，过滤数据
   
   基本语法：
   SELECT 列名 FROM 表名 WHERE 条件;
   
   位置：WHERE 在 FROM 之后，ORDER BY 之前


2️⃣  WHERE 子句操作符
   ────────────────────────────────────
   =       等于
   <>      不等于
   !=      不等于
   <       小于
   <=      小于等于
   >       大于
   >=      大于等于
   BETWEEN 在两个值之间
   IS NULL 为空值


3️⃣  相等检查
   ────────────────────────────────────
   SELECT prod_name, prod_price 
   FROM products
   WHERE prod_name = 'Fuses';
   
   说明：查找产品名为 'Fuses' 的产品
   注意：字符串需要用引号括起来（推荐单引号）


4️⃣  不匹配检查
   ────────────────────────────────────
   SELECT vend_id, prod_name 
   FROM products
   WHERE vend_id <> 1003;
   
   或者：
   SELECT vend_id, prod_name 
   FROM products
   WHERE vend_id != 1003;
   
   说明：查找供应商不是 1003 的产品


5️⃣  范围值检查
   ────────────────────────────────────
   方法一：使用比较符
   SELECT prod_name, prod_price 
   FROM products
   WHERE prod_price < 10;
   
   方法二：使用 BETWEEN
   SELECT prod_name, prod_price 
   FROM products
   WHERE prod_price BETWEEN 5 AND 10;
   
   说明：BETWEEN 包含边界值（5和10都包含）


6️⃣  空值检查
   ────────────────────────────────────
   SELECT cust_id, cust_name, cust_email 
   FROM customers
   WHERE cust_email IS NULL;
   
   说明：查找没有电子邮箱的客户
   注意：不能用 = NULL，必须用 IS NULL

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 实践任务
──────────────────────────────────────

📝 基础练习
──────────────────────────────────────

练习 1: 查找特定客户
──────────────────────────────────────
查找客户名为 'E Fudd' 的客户信息

你的SQL：
  SELECT * FROM customers 
  WHERE cust_name = 'E Fudd';


练习 2: 价格过滤
──────────────────────────────────────
查找价格小于 10 元的所有产品

你的SQL：
  SELECT prod_name, prod_price 
  FROM products
  WHERE prod_price < 10;


练习 3: 价格区间查询
──────────────────────────────────────
查找价格在 5 到 10 元之间的产品（包含5和10）

你的SQL：
  SELECT prod_name, prod_price 
  FROM products
  WHERE prod_price BETWEEN 5 AND 10;


练习 4: 查找空值
──────────────────────────────────────
查找没有电子邮箱的客户

你的SQL：
  SELECT cust_name, cust_email 
  FROM customers
  WHERE cust_email IS NULL;


练习 5: 不等于查询
──────────────────────────────────────
查找供应商ID不是 1002 的所有产品

你的SQL：
  SELECT vend_id, prod_name 
  FROM products
  WHERE vend_id <> 1002;


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🚀 进阶挑战
──────────────────────────────────────

挑战 1: 查找高价产品
──────────────────────────────────────
查找价格大于等于 10 元的产品，按价格降序排列

你的SQL：
  SELECT prod_name, prod_price 
  FROM products
  WHERE prod_price >= 10
  ORDER BY prod_price DESC;


挑战 2: 查找特定订单
──────────────────────────────────────
查找订单号为 20005 的所有订单项

你的SQL：
  SELECT * FROM orderitems 
  WHERE order_num = 20005;


挑战 3: 日期过滤
──────────────────────────────────────
查找 2005年10月的所有订单

你的SQL：
  SELECT order_num, order_date, cust_id 
  FROM orders
  WHERE order_date BETWEEN '2005-10-01' AND '2005-10-31';


挑战 4: 组合过滤和排序
──────────────────────────────────────
查找价格低于 5 元的产品，按价格升序排列，
只显示前3个

你的SQL：
  SELECT prod_name, prod_price 
  FROM products
  WHERE prod_price < 5
  ORDER BY prod_price
  LIMIT 3;


挑战 5: 数量过滤
──────────────────────────────────────
从 orderitems 表中查找数量大于等于 10 的订单项

你的SQL：
  SELECT order_num, prod_id, quantity 
  FROM orderitems
  WHERE quantity >= 10;


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💡 重要提示
──────────────────────────────────────

⚠️  单引号还是双引号？
    
    字符串值必须用引号括起来：
    ✓ WHERE prod_name = 'Fuses'   (推荐：单引号)
    ✓ WHERE prod_name = "Fuses"   (也可以：双引号)
    ✗ WHERE prod_name = Fuses     (错误：没有引号)
    
    💡 最佳实践：使用单引号
    - 单引号是SQL标准，兼容性更好
    - 某些SQL模式下双引号用于标识符（表名/列名）
    
    数值不需要引号：
    ✓ WHERE prod_price = 2.50
    ✗ WHERE prod_price = '2.50'  (虽然MySQL会自动转换，但不规范)


⚠️  WHERE 子句的位置
    
    正确顺序：
    SELECT ... FROM ... WHERE ... ORDER BY ...
    
    ✓ 正确：
    SELECT prod_name FROM products 
    WHERE prod_price < 10 
    ORDER BY prod_name;
    
    ✗ 错误：
    SELECT prod_name FROM products 
    ORDER BY prod_name
    WHERE prod_price < 10;


⚠️  NULL 的特殊性
    
    ✗ WHERE cust_email = NULL      (错误)
    ✓ WHERE cust_email IS NULL     (正确)
    ✓ WHERE cust_email IS NOT NULL (正确)
    
    说明：NULL 表示"没有值"，不能用 = 比较


⚠️  字符串匹配区分大小写吗？
    
    默认情况下，MySQL 不区分大小写
    'Fuses' = 'fuses' = 'FUSES'
    
    可以通过设置改变此行为


⚠️  BETWEEN 包含边界
    
    BETWEEN 5 AND 10
    包括 5 和 10
    
    等价于：>= 5 AND <= 10

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎓 知识检查点
──────────────────────────────────────

□ 你知道 WHERE 子句的作用吗？
□ 你能列举常用的比较操作符吗？
□ 你了解 BETWEEN 的用法吗？
□ 你知道如何检查 NULL 值吗？
□ 你理解 WHERE 的正确位置吗？

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 实战示例
──────────────────────────────────────

示例 1: 查找特定产品
  SELECT prod_name, prod_price 
  FROM products
  WHERE prod_name = 'Fuses';
  
  结果：
  Fuses | 3.42


示例 2: 价格过滤
  SELECT prod_name, prod_price 
  FROM products
  WHERE prod_price < 10;
  
  结果：14个产品中有10个价格低于10元


示例 3: 范围查询
  SELECT prod_name, prod_price 
  FROM products
  WHERE prod_price BETWEEN 5 AND 10;
  
  结果：
  .5 ton anvil   | 5.99
  1 ton anvil    | 9.99
  Oil can        | 8.99
  ...


示例 4: 查找空值
  SELECT cust_name, cust_email 
  FROM customers
  WHERE cust_email IS NULL;
  
  结果：
  Mouse House  | NULL
  E Fudd       | NULL


示例 5: 不等于
  SELECT vend_id, prod_name 
  FROM products
  WHERE vend_id != 1003
  ORDER BY vend_id;

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✨ 本章小结
──────────────────────────────────────

你已经学会了：
✓ 使用 WHERE 子句过滤数据
✓ 使用比较操作符（=、<>、<、>等）
✓ 使用 BETWEEN 进行范围检查
✓ 使用 IS NULL 检查空值
✓ 组合 WHERE、ORDER BY 和 LIMIT

下一章将学习如何组合多个 WHERE 条件！

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💻 实践建议
──────────────────────────────────────
尝试以下练习加深理解：
• 在不同表上使用各种操作符
• 组合过滤、排序和限制
• 理解 NULL 的特殊性
• 体会 BETWEEN 的便利性

