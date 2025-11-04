━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📚 第 7 章：数据过滤
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📖 学习目标
──────────────────────────────────────
✓ 使用 AND 和 OR 组合多个条件
✓ 理解操作符优先级
✓ 使用 IN 操作符简化条件
✓ 使用 NOT 操作符否定条件

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📝 核心知识点
──────────────────────────────────────

1️⃣  AND 操作符
   
   作用：同时满足多个条件
   
   语法：
   WHERE 条件1 AND 条件2 AND 条件3
   
   示例：
   SELECT prod_id, prod_price, prod_name 
   FROM products
   WHERE vend_id = 1003 AND prod_price <= 10;
   
   说明：供应商是1003 且 价格≤10


2️⃣  OR 操作符
   ────────────────────────────────────
   作用：满足任一条件即可
   
   语法：
   WHERE 条件1 OR 条件2
   
   示例：
   SELECT prod_name, prod_price 
   FROM products
   WHERE vend_id = 1002 OR vend_id = 1003;
   
   说明：供应商是1002 或 1003


3️⃣  计算次序（优先级）
   ────────────────────────────────────
   ⚠️ AND 优先级高于 OR
   
   示例（错误）：
   SELECT prod_name, prod_price 
   FROM products
   WHERE vend_id = 1002 OR vend_id = 1003 
     AND prod_price >= 10;
   
   理解：(vend_id=1002) OR (vend_id=1003 AND price>=10)
   
   示例（正确）：
   SELECT prod_name, prod_price 
   FROM products
   WHERE (vend_id = 1002 OR vend_id = 1003) 
     AND prod_price >= 10;
   
   说明：使用圆括号明确指定优先级


4️⃣  IN 操作符
   ────────────────────────────────────
   作用：指定条件范围（列表）
   
   语法：
   WHERE 列名 IN (值1, 值2, 值3)
   
   示例：
   SELECT prod_name, prod_price 
   FROM products
   WHERE vend_id IN (1002, 1003);
   
   等价于：
   WHERE vend_id = 1002 OR vend_id = 1003;
   
   优点：
   • 语法更清晰直观
   • 性能与多个 OR 相同（优化器会生成相同的执行计划）
   • 可以包含子查询（第14章学习）
   • 更容易维护（添加/删除条件更方便）


5️⃣  NOT 操作符
   ────────────────────────────────────
   作用：否定条件
   
   示例：
   SELECT prod_name, prod_price 
   FROM products
   WHERE vend_id NOT IN (1002, 1003);
   
   说明：供应商不是 1002 也不是 1003
   
   等价于：
   WHERE vend_id <> 1002 AND vend_id <> 1003;

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 实践任务
──────────────────────────────────────

📝 基础练习
──────────────────────────────────────

练习 1: AND 操作符
──────────────────────────────────────
查找供应商1003且价格小于10元的产品

你的SQL：
  SELECT prod_name, prod_price, vend_id 
  FROM products
  WHERE vend_id = 1003 AND prod_price < 10;


练习 2: OR 操作符
──────────────────────────────────────
查找供应商为1001或1002的所有产品

你的SQL：
  SELECT prod_name, vend_id 
  FROM products
  WHERE vend_id = 1001 OR vend_id = 1002;


练习 3: IN 操作符
──────────────────────────────────────
使用 IN 操作符重写练习2

你的SQL：
  SELECT prod_name, vend_id 
  FROM products
  WHERE vend_id IN (1001, 1002);


练习 4: NOT 操作符
──────────────────────────────────────
查找供应商不是1001、1002、1003的产品

你的SQL：
  SELECT prod_name, vend_id 
  FROM products
  WHERE vend_id NOT IN (1001, 1002, 1003);


练习 5: 组合条件
──────────────────────────────────────
查找价格在5-10元之间，且供应商是1003的产品

你的SQL：
  SELECT prod_name, prod_price 
  FROM products
  WHERE vend_id = 1003 
    AND prod_price BETWEEN 5 AND 10;


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🚀 进阶挑战
──────────────────────────────────────

挑战 1: 复杂 AND/OR 组合
──────────────────────────────────────
查找：
• 供应商1003的价格<10的产品
• 或供应商1001的所有产品

你的SQL：
  SELECT prod_name, prod_price, vend_id 
  FROM products
  WHERE (vend_id = 1003 AND prod_price < 10) 
     OR vend_id = 1001;


挑战 2: 使用圆括号控制优先级
──────────────────────────────────────
查找价格≥10元的产品，且供应商是1002或1003

你的SQL：
  SELECT prod_name, prod_price, vend_id 
  FROM products
  WHERE prod_price >= 10 
    AND (vend_id = 1002 OR vend_id = 1003);


挑战 3: IN + AND 组合
──────────────────────────────────────
查找供应商在(1001,1002,1003)中，且价格<10的产品

你的SQL：
  SELECT prod_name, prod_price, vend_id 
  FROM products
  WHERE vend_id IN (1001, 1002, 1003) 
    AND prod_price < 10;


挑战 4: NOT + BETWEEN
──────────────────────────────────────
查找价格不在5-10元之间的产品

你的SQL：
  SELECT prod_name, prod_price 
  FROM products
  WHERE prod_price NOT BETWEEN 5 AND 10;


挑战 5: 多条件排序
──────────────────────────────────────
查找供应商1002或1003的产品，
按供应商ID和价格降序排列

你的SQL：
  SELECT vend_id, prod_name, prod_price 
  FROM products
  WHERE vend_id IN (1002, 1003)
  ORDER BY vend_id, prod_price DESC;


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💡 重要提示
──────────────────────────────────────

⚠️  操作符优先级
    
    优先级（高→低）：
    1. 圆括号 ()
    2. NOT
    3. AND
    4. OR
    
    建议：始终使用圆括号明确优先级！


⚠️  AND vs OR 理解
    
    AND：所有条件都必须满足
    WHERE A AND B AND C
    → A为真 且 B为真 且 C为真
    
    OR：任一条件满足即可
    WHERE A OR B OR C
    → A为真 或 B为真 或 C为真


⚠️  IN 操作符的优势
    
    1. 语法更清晰
       IN (1,2,3) 比 =1 OR =2 OR =3 清晰
    
    2. 执行速度更快
    
    3. 可以包含子查询
       WHERE vend_id IN (SELECT vend_id FROM ...)


⚠️  NOT 的使用位置
    
    ✓ WHERE vend_id NOT IN (1002, 1003)
    ✓ WHERE prod_price NOT BETWEEN 5 AND 10
    ✓ WHERE cust_email IS NOT NULL
    
    NOT 支持对 IN、BETWEEN、EXISTS 取反


⚠️  常见错误
    
    错误示例：
    WHERE vend_id = 1002 OR 1003
    
    正确写法：
    WHERE vend_id = 1002 OR vend_id = 1003
    或
    WHERE vend_id IN (1002, 1003)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎓 知识检查点
──────────────────────────────────────

□ 你理解 AND 和 OR 的区别吗？
□ 你知道为什么要使用圆括号吗？
□ 你会使用 IN 操作符吗？
□ 你了解 NOT 的用法吗？
□ 你能正确组合多个条件吗？

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 实战示例
──────────────────────────────────────

示例 1: AND 示例
  SELECT prod_name, prod_price, vend_id 
  FROM products
  WHERE vend_id = 1003 AND prod_price <= 10;
  
  结果：供应商1003的产品中，价格≤10的
  TNT (1 stick)  | 2.50  | 1003
  Carrots        | 2.50  | 1003
  Sling          | 4.49  | 1003
  ...


示例 2: OR 示例
  SELECT prod_name, vend_id 
  FROM products
  WHERE vend_id = 1002 OR vend_id = 1003;
  
  结果：所有来自1002或1003的产品


示例 3: 优先级陷阱
  -- 错误理解
  WHERE vend_id = 1002 OR vend_id = 1003 
    AND prod_price >= 10
  
  执行顺序：
  vend_id = 1002 
  OR 
  (vend_id = 1003 AND prod_price >= 10)
  
  -- 正确写法
  WHERE (vend_id = 1002 OR vend_id = 1003) 
    AND prod_price >= 10


示例 4: IN 操作符
  SELECT prod_name, vend_id 
  FROM products
  WHERE vend_id IN (1001, 1002, 1003)
  ORDER BY prod_name;


示例 5: NOT 操作符
  SELECT prod_name, vend_id 
  FROM products
  WHERE vend_id NOT IN (1002, 1003);
  
  结果：来自1001、1005等其他供应商的产品

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✨ 本章小结
──────────────────────────────────────

你已经掌握了：
✓ 使用 AND 组合多个条件
✓ 使用 OR 实现备选条件
✓ 理解并正确使用圆括号
✓ 使用 IN 简化多个 OR
✓ 使用 NOT 否定条件

下一章将学习通配符和模式匹配！

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💻 练习建议
──────────────────────────────────────
• 写出复杂的AND/OR组合，观察结果
• 对比有无圆括号的区别
• 用IN改写多个OR
• 尝试NOT的各种用法

选择 "1. 进入 MySQL 实践" 开始练习
