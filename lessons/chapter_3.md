━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📚 第 3 章：使用 MySQL
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📖 学习目标
──────────────────────────────────────
✓ 学会连接MySQL数据库
✓ 掌握选择和使用数据库的方法
✓ 了解如何查看数据库和表的信息

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📝 核心知识点
──────────────────────────────────────

1️⃣  连接MySQL
   ────────────────────────────────────
   基本连接语法：
   mysql -h主机 -P端口 -u用户名 -p密码
   
   参数说明：
   -h  主机名（默认localhost）
   -P  端口号（默认3306）
   -u  用户名
   -p  密码
   
   本课程连接方式：
   docker exec -it mysql mysql -uroot -ppassword
   
   成功连接后，会看到：
   mysql>  提示符


2️⃣  选择数据库 (USE)
   ────────────────────────────────────
   语法：
   USE 数据库名;
   
   示例：
   USE crashcourse;
   
   说明：
   • USE命令用于选择要使用的数据库
   • 必须先选择数据库才能查询其中的表
   • 可以用数据库名.表名的方式避免使用USE


3️⃣  查看数据库列表 (SHOW DATABASES)
   ────────────────────────────────────
   语法：
   SHOW DATABASES;
   
   作用：
   列出MySQL服务器上所有数据库
   
   常见系统数据库：
   • information_schema - 元数据信息
   • mysql - 用户权限信息
   • performance_schema - 性能信息
   • sys - 系统信息


4️⃣  查看表列表 (SHOW TABLES)
   ────────────────────────────────────
   语法：
   SHOW TABLES;
   
   前提：
   必须先USE选择数据库
   
   或者不USE也可以：
   SHOW TABLES FROM crashcourse;


5️⃣  查看表结构 (DESCRIBE / SHOW COLUMNS)
   ────────────────────────────────────
   方法一：DESCRIBE
   DESCRIBE 表名;
   或简写：DESC 表名;
   
   方法二：SHOW COLUMNS
   SHOW COLUMNS FROM 表名;
   
   示例：
   DESCRIBE products;
   
   输出信息：
   • Field - 列名
   • Type - 数据类型
   • Null - 是否允许NULL
   • Key - 键信息（PRI=主键）
   • Default - 默认值
   • Extra - 额外信息（如AUTO_INCREMENT）


6️⃣  其他有用的SHOW命令
   ────────────────────────────────────
   查看表的创建语句：
   SHOW CREATE TABLE 表名;
   
   查看支持的存储引擎：
   SHOW ENGINES;
   
   查看当前数据库：
   SELECT DATABASE();
   
   查看表的索引：
   SHOW INDEX FROM 表名;

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 实践任务
──────────────────────────────────────

📝 基础练习
──────────────────────────────────────

练习 1: 连接并选择数据库
──────────────────────────────────────
连接到MySQL并选择crashcourse数据库

你的操作：
  docker exec -it mysql mysql -uroot -ppassword
  mysql> USE crashcourse;


练习 2: 查看所有数据库
──────────────────────────────────────
列出MySQL中的所有数据库

你的SQL：
  SHOW DATABASES;


练习 3: 查看crashcourse中的表
──────────────────────────────────────
查看crashcourse数据库中有哪些表

你的SQL：
  SHOW TABLES;


练习 4: 查看products表结构
──────────────────────────────────────
查看products表的列信息

你的SQL：
  DESCRIBE products;
  -- 或
  DESC products;


练习 5: 查看customers表详细信息
──────────────────────────────────────
使用SHOW COLUMNS查看customers表

你的SQL：
  SHOW COLUMNS FROM customers;


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🚀 进阶挑战
──────────────────────────────────────

挑战 1: 查看表的创建语句
──────────────────────────────────────
查看products表是如何创建的

你的SQL：
  SHOW CREATE TABLE products;


挑战 2: 不用USE直接查询
──────────────────────────────────────
不使用USE命令，直接查询crashcourse.products表

你的SQL：
  SELECT * FROM crashcourse.products LIMIT 3;


挑战 3: 查看所有表的详细信息
──────────────────────────────────────
查看crashcourse中每个表有多少列

你的SQL：
  SELECT TABLE_NAME, 
         COLUMN_NAME, 
         DATA_TYPE 
  FROM information_schema.COLUMNS 
  WHERE TABLE_SCHEMA = 'crashcourse';


挑战 4: 查找主键信息
──────────────────────────────────────
找出crashcourse数据库中所有表的主键

你的SQL：
  SELECT TABLE_NAME, COLUMN_NAME 
  FROM information_schema.KEY_COLUMN_USAGE 
  WHERE TABLE_SCHEMA = 'crashcourse' 
    AND CONSTRAINT_NAME = 'PRIMARY';


挑战 5: 查看外键关系
──────────────────────────────────────
查看products表的外键关系

你的SQL：
  SELECT 
    CONSTRAINT_NAME,
    COLUMN_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
  FROM information_schema.KEY_COLUMN_USAGE
  WHERE TABLE_SCHEMA = 'crashcourse'
    AND TABLE_NAME = 'products'
    AND REFERENCED_TABLE_NAME IS NOT NULL;


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💡 重要提示
──────────────────────────────────────

⚠️  USE命令的重要性
    
    没有USE选择数据库时：
    ✗ SHOW TABLES;  -- 错误：No database selected
    
    两种解决方法：
    ✓ USE crashcourse; SHOW TABLES;
    ✓ SHOW TABLES FROM crashcourse;


⚠️  DESCRIBE vs SHOW COLUMNS
    
    两者功能相同，DESCRIBE更简洁：
    
    DESC products;
    等同于
    SHOW COLUMNS FROM products;
    
    推荐使用DESC（输入更少）


⚠️  区分大小写
    
    • SQL关键字不区分大小写
      SELECT = select = SeLeCt
    
    • 数据库名和表名：
      - Linux: 默认区分大小写
      - Windows: 不区分大小写
      - Mac: 默认不区分大小写
    
    建议：始终使用小写命名数据库和表


⚠️  SHOW命令的强大功能
    
    SHOW命令是MySQL特有的，不是标准SQL
    但非常实用，记住常用的：
    • SHOW DATABASES;
    • SHOW TABLES;
    • SHOW COLUMNS FROM 表名;
    • SHOW CREATE TABLE 表名;
    • SHOW INDEX FROM 表名;


⚠️  information_schema数据库
    
    这是一个特殊的系统数据库
    包含了所有数据库的元数据
    可以通过查询这个库获取详细信息

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 实战示例
──────────────────────────────────────

示例 1: 完整的探索流程
  
  -- 1. 查看所有数据库
  SHOW DATABASES;
  
  -- 2. 选择crashcourse
  USE crashcourse;
  
  -- 3. 查看有哪些表
  SHOW TABLES;
  
  结果：
  +-----------------------+
  | Tables_in_crashcourse |
  +-----------------------+
  | customers             |
  | orderitems            |
  | orders                |
  | productnotes          |
  | products              |
  | vendors               |
  +-----------------------+


示例 2: 查看表结构
  
  DESC products;
  
  结果：
  +------------+--------------+------+-----+---------+
  | Field      | Type         | Null | Key | Default |
  +------------+--------------+------+-----+---------+
  | prod_id    | char(10)     | NO   | PRI | NULL    |
  | vend_id    | int          | NO   | MUL | NULL    |
  | prod_name  | varchar(255) | NO   |     | NULL    |
  | prod_price | decimal(8,2) | NO   |     | NULL    |
  | prod_desc  | text         | YES  |     | NULL    |
  +------------+--------------+------+-----+---------+
  
  解读：
  • prod_id是主键(PRI)
  • vend_id是外键(MUL表示有索引)
  • prod_price是定点数，精度8位，小数2位
  • prod_desc允许NULL


示例 3: 查看当前使用的数据库
  
  SELECT DATABASE();
  
  结果：
  +-------------+
  | DATABASE()  |
  +-------------+
  | crashcourse |
  +-------------+


示例 4: 查看表的详细创建信息
  
  SHOW CREATE TABLE customers\G
  
  (\G 表示垂直显示，更易读)
  
  会显示完整的CREATE TABLE语句
  包括所有列定义、键、引擎等


示例 5: 统计每个表的记录数
  
  SELECT 
    (SELECT COUNT(*) FROM vendors) AS vendors,
    (SELECT COUNT(*) FROM products) AS products,
    (SELECT COUNT(*) FROM customers) AS customers,
    (SELECT COUNT(*) FROM orders) AS orders;

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎓 知识检查点
──────────────────────────────────────

□ 你知道如何连接到MySQL吗？
□ 你会使用USE命令选择数据库吗？
□ 你能列出所有数据库和表吗？
□ 你会查看表的结构吗？
□ 你理解主键(PRI)和外键(MUL)的标识吗？
□ 你知道如何查看表的创建语句吗？

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📋 常用命令速查表
──────────────────────────────────────

┌─────────────────────┬──────────────────────┐
│ 命令                │ 说明                 │
├─────────────────────┼──────────────────────┤
│ SHOW DATABASES;     │ 列出所有数据库       │
│ USE 数据库名;       │ 选择数据库           │
│ SELECT DATABASE();  │ 查看当前数据库       │
│ SHOW TABLES;        │ 列出当前库的所有表   │
│ DESC 表名;          │ 查看表结构           │
│ SHOW COLUMNS FROM ; │ 查看表结构（详细）   │
│ SHOW CREATE TABLE ; │ 查看表创建语句       │
│ SHOW INDEX FROM ;   │ 查看表索引           │
└─────────────────────┴──────────────────────┘

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✨ 本章小结
──────────────────────────────────────

你已经掌握了：
✓ 如何连接MySQL数据库
✓ 使用USE选择数据库
✓ 使用SHOW命令查看数据库和表信息
✓ 使用DESC/DESCRIBE查看表结构
✓ 理解表结构输出的各个字段含义

下一章将开始学习如何检索数据！

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💻 动手练习建议
──────────────────────────────────────
1. 连接到MySQL
2. 查看所有数据库
3. 选择crashcourse数据库
4. 查看所有表
5. 逐个查看每个表的结构
6. 理解每个表的用途和关系

