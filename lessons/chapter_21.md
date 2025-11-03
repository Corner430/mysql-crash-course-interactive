━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📚 第 21 章：创建和操纵表
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📖 学习目标
──────────────────────────────────────
✓ 掌握 CREATE TABLE 创建表
✓ 理解 NULL 值和 NOT NULL
✓ 学会使用主键和 AUTO_INCREMENT
✓ 掌握 ALTER TABLE 修改表结构
✓ 了解 DROP TABLE 和 RENAME TABLE

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📝 核心知识点
──────────────────────────────────────

1️⃣  CREATE TABLE 基本语法
   ────────────────────────────────────
   CREATE TABLE table_name
   (
       column1 datatype constraints,
       column2 datatype constraints,
       ...
       PRIMARY KEY (column_name)
   ) ENGINE=InnoDB;
   
   组成部分：
   • 表名
   • 列定义（名称、数据类型、约束）
   • 主键定义
   • 存储引擎


2️⃣  简单的表创建示例
   ────────────────────────────────────
   CREATE TABLE customers
   (
       cust_id      int         NOT NULL AUTO_INCREMENT,
       cust_name    char(50)    NOT NULL,
       cust_address char(50)    NULL,
       cust_city    char(50)    NULL,
       cust_state   char(5)     NULL,
       cust_zip     char(10)    NULL,
       cust_country char(50)    NULL,
       cust_contact char(50)    NULL,
       cust_email   char(255)   NULL,
       PRIMARY KEY (cust_id)
   ) ENGINE=InnoDB;


3️⃣  使用 NULL 值
   ────────────────────────────────────
   NULL 值说明：
   • NULL：允许 NULL 值（默认）
   • NOT NULL：不允许 NULL 值
   
   示例：
   cust_name char(50) NOT NULL  -- 必须有值
   cust_email char(255) NULL     -- 可以为空
   
   建议：
   • 主键列必须 NOT NULL
   • 重要字段应该 NOT NULL
   • 可选字段可以 NULL


4️⃣  主键简介
   ────────────────────────────────────
   单列主键：
   PRIMARY KEY (cust_id)
   
   多列主键（复合主键）：
   PRIMARY KEY (order_num, order_item)
   
   主键特点：
   • 唯一标识每一行
   • 不能为 NULL
   • 值不能重复
   • 可以由多列组成


5️⃣  AUTO_INCREMENT
   ────────────────────────────────────
   cust_id int NOT NULL AUTO_INCREMENT
   
   说明：
   • 自动生成唯一递增的数值
   • 每个表只能有一个 AUTO_INCREMENT 列
   • 必须被索引（如作为主键）
   • 插入时可省略，MySQL 自动分配
   
   获取最后的 AUTO_INCREMENT 值：
   SELECT LAST_INSERT_ID();


6️⃣  指定默认值 - DEFAULT
   ────────────────────────────────────
   CREATE TABLE orderitems
   (
       order_num    int          NOT NULL,
       order_item   int          NOT NULL,
       quantity     int          NOT NULL DEFAULT 1,
       item_price   decimal(8,2) NOT NULL
   );
   
   说明：
   • DEFAULT 指定默认值
   • 插入时如果不提供值，使用默认值
   • 支持函数：DEFAULT CURRENT_TIMESTAMP


7️⃣  引擎类型 - ENGINE
   ────────────────────────────────────
   常用引擎：
   
   InnoDB（推荐）：
   • 支持事务处理
   • 支持外键
   • 崩溃恢复
   • 行级锁定
   
   MyISAM：
   • 支持全文搜索
   • 性能较高
   • 不支持事务
   
   MEMORY：
   • 数据存储在内存
   • 速度极快
   • 重启数据丢失


8️⃣  更新表 - ALTER TABLE
   ────────────────────────────────────
   添加列：
   ALTER TABLE vendors
   ADD vend_phone CHAR(20);
   
   删除列：
   ALTER TABLE vendors
   DROP COLUMN vend_phone;
   
   修改列：
   ALTER TABLE vendors
   MODIFY vend_phone CHAR(30);
   
   添加外键：
   ALTER TABLE orderitems
   ADD CONSTRAINT fk_orderitems_orders
   FOREIGN KEY (order_num) REFERENCES orders (order_num);


9️⃣  删除表 - DROP TABLE
   ────────────────────────────────────
   DROP TABLE customers;
   
   ⚠️  警告：
   • 删除表及其所有数据
   • 不可恢复
   • 没有确认步骤
   • 慎用！


🔟  重命名表 - RENAME TABLE
   ────────────────────────────────────
   单个表：
   RENAME TABLE customers TO customers_old;
   
   多个表：
   RENAME TABLE customers TO customers_old,
                orders TO orders_old,
                products TO products_old;

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 实践任务
──────────────────────────────────────

📝 基础练习
──────────────────────────────────────

练习 1: 查看现有表结构
──────────────────────────────────────
查看 customers 表的结构

你的SQL：
  DESCRIBE customers;
  -- 或者
  SHOW COLUMNS FROM customers;


练习 2: 查看创建表的语句
──────────────────────────────────────
查看 MySQL 用于创建表的实际语句

你的SQL：
  SHOW CREATE TABLE customers;


练习 3: 创建简单的表（概念）
──────────────────────────────────────
创建一个简单的测试表

你的SQL（概念）：
  -- CREATE TABLE test_table
  -- (
  --     id   int         NOT NULL AUTO_INCREMENT,
  --     name char(50)    NOT NULL,
  --     PRIMARY KEY (id)
  -- ) ENGINE=InnoDB;


练习 4: 创建带默认值的表（概念）
──────────────────────────────────────
创建包含默认值的表

你的SQL（概念）：
  -- CREATE TABLE products_test
  -- (
  --     prod_id    char(10)     NOT NULL,
  --     prod_name  char(255)    NOT NULL,
  --     prod_price decimal(8,2) NOT NULL DEFAULT 0.00,
  --     in_stock   char(1)      NOT NULL DEFAULT 'Y',
  --     PRIMARY KEY (prod_id)
  -- ) ENGINE=InnoDB;


练习 5: 使用 IF NOT EXISTS
──────────────────────────────────────
安全地创建表（如果不存在）

你的SQL（概念）：
  -- CREATE TABLE IF NOT EXISTS test_table
  -- (
  --     id int NOT NULL AUTO_INCREMENT,
  --     PRIMARY KEY (id)
  -- );


练习 6: 查看数据库中的所有表
──────────────────────────────────────
列出当前数据库的所有表

你的SQL：
  SHOW TABLES;


练习 7: 查看表的索引
──────────────────────────────────────
查看表的索引信息

你的SQL：
  SHOW INDEX FROM customers;

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🚀 进阶挑战
──────────────────────────────────────

挑战 1: 创建完整的表（概念）
──────────────────────────────────────
创建包含多种约束的表

你的SQL（概念）：
  -- CREATE TABLE employees
  -- (
  --     emp_id       int          NOT NULL AUTO_INCREMENT,
  --     emp_name     varchar(100) NOT NULL,
  --     emp_email    varchar(255) NULL,
  --     dept_id      int          NOT NULL,
  --     salary       decimal(10,2) NOT NULL DEFAULT 0.00,
  --     hire_date    date         NOT NULL DEFAULT (CURRENT_DATE),
  --     is_active    char(1)      NOT NULL DEFAULT 'Y',
  --     PRIMARY KEY (emp_id)
  -- ) ENGINE=InnoDB;


挑战 2: ALTER TABLE 添加列（概念）
──────────────────────────────────────
为现有表添加新列

你的SQL（概念）：
  -- ALTER TABLE customers
  -- ADD cust_phone CHAR(20) NULL;


挑战 3: 创建带外键的表（概念）
──────────────────────────────────────
创建具有外键约束的表

你的SQL（概念）：
  -- CREATE TABLE order_details
  -- (
  --     order_id   int         NOT NULL,
  --     product_id int         NOT NULL,
  --     quantity   int         NOT NULL DEFAULT 1,
  --     PRIMARY KEY (order_id, product_id),
  --     FOREIGN KEY (order_id) REFERENCES orders(order_num)
  -- ) ENGINE=InnoDB;


挑战 4: 修改列定义（概念）
──────────────────────────────────────
修改已存在的列

你的SQL（概念）：
  -- ALTER TABLE customers
  -- MODIFY cust_email VARCHAR(255) NOT NULL;


挑战 5: 创建带时间戳的表（概念）
──────────────────────────────────────
自动记录创建和更新时间

你的SQL（概念）：
  -- CREATE TABLE articles
  -- (
  --     article_id  int          NOT NULL AUTO_INCREMENT,
  --     title       varchar(255) NOT NULL,
  --     content     text         NULL,
  --     created_at  timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  --     updated_at  timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP 
  --                              ON UPDATE CURRENT_TIMESTAMP,
  --     PRIMARY KEY (article_id)
  -- ) ENGINE=InnoDB;

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💡 重要提示
──────────────────────────────────────

⚠️  表名必须唯一
   在同一数据库中表名不能重复
   使用 IF NOT EXISTS 避免错误
   或先 DROP TABLE 再创建

⚠️  主键的重要性
   每个表都应该有主键
   主键必须唯一且 NOT NULL
   主键可以是单列或多列（复合主键）

⚠️  NULL vs NOT NULL
   NULL 允许列没有值
   NOT NULL 要求列必须有值
   主键列必须 NOT NULL
   重要数据建议 NOT NULL

⚠️  AUTO_INCREMENT 限制
   每个表只能有一个 AUTO_INCREMENT 列
   必须被索引（通常作为主键）
   只能用于整数类型

⚠️  默认值
   DEFAULT 为列指定默认值
   插入时不提供值则使用默认值
   可以使用函数如 CURRENT_TIMESTAMP

⚠️  引擎选择
   InnoDB：事务、外键、崩溃恢复（推荐）
   MyISAM：全文搜索、高性能（无事务）
   MEMORY：内存存储、极快（临时数据）

⚠️  ALTER TABLE 注意事项
   ALTER TABLE 可能耗时很长
   会锁定表（影响其他操作）
   在生产环境要谨慎
   大表修改前应该备份

⚠️  DROP TABLE 危险
   DROP TABLE 永久删除表和数据
   没有确认提示
   无法恢复
   生产环境绝对小心

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 实战示例
──────────────────────────────────────

示例 1: 创建基本表
  CREATE TABLE categories
  (
      cat_id   int         NOT NULL AUTO_INCREMENT,
      cat_name varchar(50) NOT NULL,
      PRIMARY KEY (cat_id)
  ) ENGINE=InnoDB;


示例 2: 创建带默认值的表
  CREATE TABLE settings
  (
      setting_id    int          NOT NULL AUTO_INCREMENT,
      setting_name  varchar(50)  NOT NULL,
      setting_value varchar(255) NULL,
      is_active     char(1)      NOT NULL DEFAULT 'Y',
      updated_at    timestamp    NOT NULL DEFAULT CURRENT_TIMESTAMP,
      PRIMARY KEY (setting_id)
  ) ENGINE=InnoDB;


示例 3: 创建复合主键表
  CREATE TABLE order_items
  (
      order_num  int          NOT NULL,
      order_item int          NOT NULL,
      prod_id    char(10)     NOT NULL,
      quantity   int          NOT NULL,
      item_price decimal(8,2) NOT NULL,
      PRIMARY KEY (order_num, order_item)
  ) ENGINE=InnoDB;


示例 4: 添加列
  ALTER TABLE vendors
  ADD vend_phone CHAR(20) NULL;


示例 5: 删除列
  ALTER TABLE vendors
  DROP COLUMN vend_phone;


示例 6: 修改列
  ALTER TABLE vendors
  MODIFY vend_name CHAR(100) NOT NULL;


示例 7: 添加外键约束
  ALTER TABLE orderitems
  ADD CONSTRAINT fk_orderitems_products
  FOREIGN KEY (prod_id) REFERENCES products (prod_id);


示例 8: 重命名表
  RENAME TABLE old_customers TO backup_customers;


示例 9: 复制表结构
  CREATE TABLE customers_backup LIKE customers;


示例 10: 复制表结构和数据
  CREATE TABLE customers_backup AS
  SELECT * FROM customers;

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎓 知识检查点
──────────────────────────────────────

□ 你会使用 CREATE TABLE 创建表吗？
□ 你理解 NULL 和 NOT NULL 的区别吗？
□ 你知道如何定义主键吗？
□ 你了解 AUTO_INCREMENT 的作用吗？
□ 你会使用 DEFAULT 设置默认值吗？
□ 你知道不同存储引擎的区别吗？
□ 你会使用 ALTER TABLE 修改表吗？
□ 你了解 DROP TABLE 的危险性吗？

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔍 常见数据类型
──────────────────────────────────────

数值类型：
  TINYINT    - 非常小的整数（-128 到 127）
  INT        - 标准整数（约 -21 亿到 21 亿）
  BIGINT     - 大整数
  DECIMAL    - 精确小数，如 DECIMAL(8,2)
  FLOAT      - 单精度浮点数
  DOUBLE     - 双精度浮点数

字符串类型：
  CHAR(n)    - 定长字符串，最多 255 字符
  VARCHAR(n) - 变长字符串，最多 65535 字符
  TEXT       - 长文本，最多 65535 字符
  MEDIUMTEXT - 更长文本，最多 16MB
  LONGTEXT   - 极长文本，最多 4GB

日期时间类型：
  DATE       - 日期（YYYY-MM-DD）
  TIME       - 时间（HH:MM:SS）
  DATETIME   - 日期时间
  TIMESTAMP  - 时间戳（自动更新）
  YEAR       - 年份

二进制类型：
  BLOB       - 二进制大对象
  MEDIUMBLOB - 中等二进制对象
  LONGBLOB   - 长二进制对象

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✨ 本章小结
──────────────────────────────────────

你已经学会了：
✓ 使用 CREATE TABLE 创建新表
✓ 指定列的数据类型和约束
✓ 使用 NULL 和 NOT NULL 控制空值
✓ 定义主键（单列和复合主键）
✓ 使用 AUTO_INCREMENT 自动生成 ID
✓ 使用 DEFAULT 设置默认值
✓ 选择合适的存储引擎
✓ 使用 ALTER TABLE 修改表结构
✓ 使用 DROP TABLE 删除表
✓ 使用 RENAME TABLE 重命名表
✓ 了解常用的数据类型

核心要点：
• 每个表都应该有主键
• 重要字段使用 NOT NULL
• 合理使用 DEFAULT 提供默认值
• InnoDB 是推荐的存储引擎
• ALTER TABLE 和 DROP TABLE 要谨慎使用

下一章将学习如何使用视图！

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💻 动手实践
──────────────────────────────────────
你可以查看现有表的结构来学习：

-- 查看表结构
DESCRIBE customers;

-- 查看创建表的语句
SHOW CREATE TABLE customers;

-- 查看所有表
SHOW TABLES;

-- 查看表的索引
SHOW INDEX FROM customers;

⚠️  不要在 crashcourse 数据库中执行 CREATE/ALTER/DROP
    这些操作会修改数据库结构！

选择 "1. 进入 MySQL 实践" 开始练习
