━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📚 第 5 章：排序检索数据
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📖 学习目标
──────────────────────────────────────
✓ 使用 ORDER BY 子句排序数据
✓ 按多个列排序
✓ 指定排序方向（升序/降序）

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📝 核心知识点
──────────────────────────────────────

1️⃣  ORDER BY 子句基础
   
   作用：对查询结果进行排序
   
   基本语法：
   SELECT 列名 FROM 表名 ORDER BY 列名;


2️⃣  单列排序
   ────────────────────────────────────
   SELECT prod_name FROM products 
   ORDER BY prod_name;
   
   说明：按产品名称字母顺序排序（A-Z）


3️⃣  按多个列排序
   ────────────────────────────────────
   SELECT prod_id, prod_price, prod_name 
   FROM products
   ORDER BY prod_price, prod_name;
   
   说明：
   • 先按价格排序
   • 价格相同时，再按名称排序


4️⃣  指定排序方向
   ────────────────────────────────────
   ASC  - 升序（默认，可省略）
   DESC - 降序
   
   示例：
   SELECT prod_id, prod_price, prod_name 
   FROM products
   ORDER BY prod_price DESC;
   
   说明：按价格从高到低排序


5️⃣  多列多方向排序
   ────────────────────────────────────
   SELECT prod_id, prod_price, prod_name 
   FROM products
   ORDER BY prod_price DESC, prod_name ASC;
   
   说明：
   • 价格降序（贵→便宜）
   • 价格相同时名称升序（A→Z）


6️⃣  按列位置排序
   ────────────────────────────────────
   SELECT prod_id, prod_price, prod_name 
   FROM products
   ORDER BY 2, 3;
   
   说明：
   • 2 表示第2列（prod_price）
   • 3 表示第3列（prod_name）
   • 不推荐使用（代码可读性差）

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 实践任务
──────────────────────────────────────

📝 基础练习
──────────────────────────────────────

练习 1: 按名称排序客户
──────────────────────────────────────
检索所有客户名称，按字母顺序排序

你的SQL：
  SELECT cust_name FROM customers 
  ORDER BY cust_name;


练习 2: 按价格排序产品
──────────────────────────────────────
检索产品ID、名称和价格，按价格从低到高排序

你的SQL：
  SELECT prod_id, prod_name, prod_price 
  FROM products
  ORDER BY prod_price;


练习 3: 降序排序
──────────────────────────────────────
检索产品名称和价格，按价格从高到低排序

你的SQL：
  SELECT prod_name, prod_price 
  FROM products
  ORDER BY prod_price DESC;


练习 4: 多列排序
──────────────────────────────────────
显示所有产品，先按供应商ID排序，再按产品名称排序

你的SQL：
  SELECT vend_id, prod_name, prod_price 
  FROM products
  ORDER BY vend_id, prod_name;


练习 5: 混合方向排序
──────────────────────────────────────
按供应商ID降序，产品价格升序排列

你的SQL：
  SELECT vend_id, prod_price, prod_name 
  FROM products
  ORDER BY vend_id DESC, prod_price ASC;


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🚀 进阶挑战
──────────────────────────────────────

挑战 1: 找出价格最高的产品
──────────────────────────────────────
显示价格最高的3个产品的名称和价格

你的SQL：
  SELECT prod_name, prod_price 
  FROM products
  ORDER BY prod_price DESC
  LIMIT 3;

💡 注意：本例中前3贵的产品价格各不相同，结果准确
   但如果第3名有多个产品同价，LIMIT 3 只会显示其中部分


挑战 2: 找出价格最低的产品
──────────────────────────────────────
显示价格最低的产品名称和价格（只显示1个）

你的SQL：
  SELECT prod_name, prod_price 
  FROM products
  ORDER BY prod_price ASC
  LIMIT 1;

💡 思考：如果有多个产品价格相同都是最低价怎么办？
   使用 LIMIT 1 只能显示其中一个
   要显示所有最低价产品，需要用到 WHERE 子句（第6章学习）


挑战 3: 复杂排序
──────────────────────────────────────
显示所有产品，按以下规则排序：
1. 价格降序
2. 价格相同时，按供应商ID升序
3. 再按产品名称升序

你的SQL：
  SELECT prod_name, prod_price, vend_id 
  FROM products
  ORDER BY prod_price DESC, vend_id ASC, prod_name ASC;


挑战 4: ORDER BY + LIMIT 组合
──────────────────────────────────────
找出第2贵到第4贵的产品

你的SQL：
  SELECT prod_name, prod_price 
  FROM products
  ORDER BY prod_price DESC
  LIMIT 3 OFFSET 1;


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💡 重要提示
──────────────────────────────────────

⚠️  ORDER BY 子句的位置
    必须是 SELECT 语句中的最后一条子句
    
    ✓ 正确：
    SELECT prod_name FROM products 
    WHERE prod_price > 5 
    ORDER BY prod_name;
    
    ✗ 错误：
    SELECT prod_name FROM products 
    ORDER BY prod_name
    WHERE prod_price > 5;


⚠️  DESC 关键词只应用于直接位于其前面的列
    
    SELECT prod_price, prod_name 
    FROM products
    ORDER BY prod_price DESC, prod_name;
    
    说明：
    • prod_price 降序
    • prod_name 升序（没有DESC）


⚠️  大小写和排序
    MySQL 中，A 和 a 被视为相同
    排序时不区分大小写（取决于数据库设置）


⚠️  按非选择列排序
    可以按不在 SELECT 列表中的列排序
    
    SELECT prod_name FROM products 
    ORDER BY prod_price;
    
    说明：显示名称，但按价格排序

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎓 知识检查点
──────────────────────────────────────

□ 你知道 ORDER BY 的作用吗？
□ 你能按多个列排序吗？
□ 你理解 ASC 和 DESC 的区别吗？
□ 你知道 ORDER BY 必须放在最后吗？
□ 你会结合 LIMIT 使用 ORDER BY 吗？

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 实战示例
──────────────────────────────────────

示例 1: 按字母顺序列出所有产品
  SELECT prod_name FROM products 
  ORDER BY prod_name;

示例 2: 找出价格前3的产品
  SELECT prod_name, prod_price 
  FROM products
  ORDER BY prod_price DESC
  LIMIT 3;
  
  结果应该是：
  JetPack 2000  |  55.00
  Safe          |  50.00
  JetPack 1000  |  35.00

示例 3: 按供应商分组，价格排序
  SELECT vend_id, prod_name, prod_price 
  FROM products
  ORDER BY vend_id, prod_price DESC;

示例 4: 复杂查询 - 找出最贵的ACME产品
  SELECT prod_name, prod_price 
  FROM products
  WHERE vend_id = 1003
  ORDER BY prod_price DESC
  LIMIT 1;

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✨ 本章小结
──────────────────────────────────────

你已经掌握了：
✓ 使用 ORDER BY 排序查询结果
✓ 按一个或多个列排序
✓ 使用 DESC 降序排序
✓ 结合 LIMIT 查找最值
✓ ORDER BY 的正确位置

下一章将学习如何使用 WHERE 子句过滤数据！

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💻 动手实践时间
──────────────────────────────────────
试试自己写几个不同的排序查询：
• 从不同角度排序同一个表
• 结合 LIMIT 找最大最小值
• 尝试多列多方向排序

选择 "1. 进入 MySQL 实践" 开始练习
