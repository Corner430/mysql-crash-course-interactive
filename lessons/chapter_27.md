━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📚 第 27 章：全球化和本地化
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📖 学习目标
──────────────────────────────────────
✓ 理解字符集和校对顺序
✓ 掌握查看和设置字符集
✓ 了解不同校对的区别
✓ 学会为表和列指定字符集

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📝 核心知识点
──────────────────────────────────────

1️⃣  字符集和校对
   ────────────────────────────────────
   字符集（Character Set）：
   • 字母和符号的集合
   • 例如：ASCII、Latin1、UTF-8
   
   校对（Collation）：
   • 规定字符如何比较
   • 影响排序和搜索
   • 例如：区分大小写、不区分大小写


2️⃣  为什么重要
   ────────────────────────────────────
   全球化应用需要：
   ✓ 支持多种语言
   ✓ 正确的排序规则
   ✓ 准确的字符比较
   ✓ 适当的搜索行为
   
   例如：
   • 英文数据：Latin1 就够了
   • 中文数据：必须用 UTF-8
   • 混合语言：UTF-8 是最佳选择


3️⃣  查看可用字符集
   ────────────────────────────────────
   SHOW CHARACTER SET;
   
   常用字符集：
   • latin1：西欧字符（默认）
   • utf8：Unicode（推荐）
   • utf8mb4：完整 Unicode（支持 emoji）
   • gbk：简体中文
   • gb2312：简体中文（旧）


4️⃣  查看可用校对
   ────────────────────────────────────
   SHOW COLLATION;
   
   查看特定字符集的校对：
   SHOW COLLATION LIKE 'utf8%';
   
   常见后缀：
   • _ci：不区分大小写（case insensitive）
   • _cs：区分大小写（case sensitive）
   • _bin：二进制比较


5️⃣  查看默认设置
   ────────────────────────────────────
   查看系统默认字符集：
   SHOW VARIABLES LIKE 'character%';
   
   查看系统默认校对：
   SHOW VARIABLES LIKE 'collation%';


6️⃣  为表指定字符集和校对
   ────────────────────────────────────
   创建表时指定：
   CREATE TABLE mytable
   (
       column1 INT,
       column2 VARCHAR(10)
   ) DEFAULT CHARACTER SET utf8mb4
     COLLATE utf8mb4_general_ci;


7️⃣  为列指定字符集和校对
   ────────────────────────────────────
   CREATE TABLE mytable
   (
       column1 INT,
       column2 VARCHAR(10) 
               CHARACTER SET latin1
               COLLATE latin1_general_ci,
       column3 VARCHAR(10)
               CHARACTER SET utf8mb4
               COLLATE utf8mb4_bin
   );


8️⃣  修改表的字符集
   ────────────────────────────────────
   ALTER TABLE mytable
   DEFAULT CHARACTER SET utf8mb4
   COLLATE utf8mb4_unicode_ci;
   
   注意：只影响新列，不改变现有列


9️⃣  修改列的字符集
   ────────────────────────────────────
   ALTER TABLE mytable
   MODIFY column_name VARCHAR(100)
   CHARACTER SET utf8mb4
   COLLATE utf8mb4_unicode_ci;


🔟  在查询中使用校对
   ────────────────────────────────────
   SELECT * FROM customers
   ORDER BY cust_name;
   
   使用特定校对排序：
   SELECT * FROM customers
   ORDER BY cust_name COLLATE latin1_general_cs;
   
   临时改变比较方式：
   SELECT * FROM customers
   WHERE cust_name = 'Fun4All'
   COLLATE latin1_general_cs;

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 实践任务
──────────────────────────────────────

📝 基础练习
──────────────────────────────────────

练习 1: 查看可用字符集
──────────────────────────────────────
列出所有支持的字符集

你的SQL：
  SHOW CHARACTER SET;


练习 2: 查看 UTF-8 相关校对
──────────────────────────────────────
查看 UTF-8 的所有校对规则

你的SQL：
  SHOW COLLATION LIKE 'utf8%';


练习 3: 查看系统设置
──────────────────────────────────────
查看当前字符集配置

你的SQL：
  SHOW VARIABLES LIKE 'character%';
  SHOW VARIABLES LIKE 'collation%';


练习 4: 查看表的字符集
──────────────────────────────────────
查看 customers 表的字符集设置

你的SQL：
  SHOW CREATE TABLE customers;
  -- 或
  SHOW TABLE STATUS LIKE 'customers';


练习 5: 查看列的字符集
──────────────────────────────────────
查看列的详细信息

你的SQL：
  SHOW FULL COLUMNS FROM customers;

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🚀 进阶挑战
──────────────────────────────────────

挑战 1: 创建多语言表（概念）
──────────────────────────────────────
创建支持多语言的表

你的SQL（概念）：
  -- CREATE TABLE products_i18n
  -- (
  --     prod_id     INT PRIMARY KEY,
  --     name_en     VARCHAR(100) CHARACTER SET latin1,
  --     name_zh     VARCHAR(100) CHARACTER SET utf8mb4,
  --     name_ja     VARCHAR(100) CHARACTER SET utf8mb4,
  --     description TEXT CHARACTER SET utf8mb4
  -- ) DEFAULT CHARACTER SET utf8mb4
  --   COLLATE utf8mb4_unicode_ci;


挑战 2: 区分大小写查询（概念）
──────────────────────────────────────
临时改变比较规则

你的SQL（概念）：
  -- 不区分大小写（默认）
  -- SELECT * FROM customers
  -- WHERE cust_name = 'fun4all';
  -- 
  -- 区分大小写
  -- SELECT * FROM customers
  -- WHERE cust_name = 'Fun4All'
  -- COLLATE utf8mb4_bin;


挑战 3: 不同校对的排序（概念）
──────────────────────────────────────
比较不同校对的排序结果

你的SQL（概念）：
  -- 默认排序
  -- SELECT cust_name FROM customers
  -- ORDER BY cust_name;
  -- 
  -- 二进制排序
  -- SELECT cust_name FROM customers
  -- ORDER BY cust_name COLLATE utf8mb4_bin;

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💡 重要提示
──────────────────────────────────────

⚠️  推荐使用 UTF8MB4
   • 支持所有 Unicode 字符
   • 包括 emoji 表情符号
   • 向后兼容 utf8
   • 现代应用的最佳选择

⚠️  字符集层级
   从高到低：
   1. 服务器默认字符集
   2. 数据库默认字符集
   3. 表默认字符集
   4. 列字符集
   
   下层覆盖上层

⚠️  UTF8 vs UTF8MB4
   utf8：MySQL 的 utf8 最多3字节
   • 不支持某些 Unicode 字符
   • 不支持 emoji
   
   utf8mb4：真正的 UTF-8（4字节）
   • 支持所有 Unicode 字符
   • 推荐使用

⚠️  校对命名规则
   字符集_语言_后缀
   
   例如：utf8mb4_general_ci
   • utf8mb4：字符集
   • general：通用规则
   • ci：不区分大小写
   
   例如：utf8mb4_unicode_ci
   • unicode：Unicode 规则
   • 更准确但稍慢

⚠️  性能考虑
   • utf8mb4 比 latin1 占用更多空间
   • 但现代硬件性能足够
   • 正确性 > 性能
   • 选择 utf8mb4 是明智的

⚠️  迁移现有数据
   改变字符集要小心：
   • 可能导致数据损坏
   • 先备份数据
   • 在测试环境验证
   • 使用正确的转换方法

⚠️  排序规则差异
   不同校对排序结果不同：
   • latin1_swedish_ci（默认）
   • utf8mb4_general_ci（快）
   • utf8mb4_unicode_ci（准确）
   
   选择适合你的应用

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 实战示例
──────────────────────────────────────

示例 1: 查看字符集
  SHOW CHARACTER SET;


示例 2: 查看校对
  SHOW COLLATION;
  SHOW COLLATION LIKE 'utf8mb4%';


示例 3: 查看当前设置
  SHOW VARIABLES LIKE 'character%';
  SHOW VARIABLES LIKE 'collation%';


示例 4: 创建使用 UTF8MB4 的表
  CREATE TABLE articles
  (
      id      INT PRIMARY KEY AUTO_INCREMENT,
      title   VARCHAR(200),
      content TEXT,
      author  VARCHAR(50)
  ) ENGINE=InnoDB
    DEFAULT CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;


示例 5: 不同列使用不同字符集
  CREATE TABLE mixed_charset
  (
      id       INT PRIMARY KEY,
      ascii_col VARCHAR(50) CHARACTER SET ascii,
      latin_col VARCHAR(50) CHARACTER SET latin1,
      utf8_col  VARCHAR(50) CHARACTER SET utf8mb4
  );


示例 6: 修改表的默认字符集
  ALTER TABLE customers
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;


示例 7: 修改列的字符集
  ALTER TABLE customers
  MODIFY cust_name VARCHAR(50)
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;


示例 8: 查询时指定校对
  SELECT * FROM customers
  ORDER BY cust_name COLLATE utf8mb4_bin;


示例 9: 比较时指定校对
  SELECT * FROM customers
  WHERE cust_name = 'Fun4All'
  COLLATE utf8mb4_bin;


示例 10: 查看表的字符集
  SHOW CREATE TABLE customers;
  SHOW TABLE STATUS LIKE 'customers';

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎓 知识检查点
──────────────────────────────────────

□ 你理解字符集和校对的区别吗？
□ 你知道 UTF8MB4 比 UTF8 更好吗？
□ 你会查看可用的字符集吗？
□ 你会为表设置字符集吗？
□ 你会为列设置字符集吗？
□ 你知道 _ci 和 _bin 的区别吗？
□ 你了解字符集的层级关系吗？
□ 你会在查询中使用 COLLATE 吗？

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔍 常用字符集选择指南
──────────────────────────────────────

场景 1: 纯英文应用
推荐：latin1 或 utf8mb4
• latin1：更快，占用更少
• utf8mb4：未来扩展性好

场景 2: 中文应用
推荐：utf8mb4
• 完整支持中文
• 支持繁简混合
• 支持 emoji

场景 3: 国际化应用
推荐：utf8mb4
• 支持所有语言
• 一个字符集解决所有问题
• 现代应用标准

场景 4: 需要 emoji
必须：utf8mb4
• utf8 不支持 emoji
• utf8mb4 完整支持

常用校对选择：
• utf8mb4_general_ci：快速，通用
• utf8mb4_unicode_ci：准确，推荐
• utf8mb4_bin：区分大小写

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✨ 本章小结
──────────────────────────────────────

你已经学会了：
✓ 理解字符集和校对的概念
✓ 知道常用字符集的特点
✓ 查看可用的字符集和校对
✓ 查看系统和表的字符集设置
✓ 为表和列指定字符集
✓ 修改表和列的字符集
✓ 在查询中使用 COLLATE
✓ 了解 UTF8MB4 的重要性

核心要点：
• 字符集定义字符，校对定义比较规则
• UTF8MB4 是现代应用的最佳选择
• _ci 不区分大小写，_bin 区分大小写
• 字符集有层级：服务器→数据库→表→列
• 可以在查询时临时改变校对

下一章将学习安全管理！

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💻 动手实践
──────────────────────────────────────
安全的查询操作：

-- 查看所有字符集
SHOW CHARACTER SET;

-- 查看 UTF8MB4 的校对
SHOW COLLATION LIKE 'utf8mb4%';

-- 查看系统设置
SHOW VARIABLES LIKE 'character%';
SHOW VARIABLES LIKE 'collation%';

-- 查看表的字符集
SHOW CREATE TABLE customers;
SHOW TABLE STATUS LIKE 'customers';

-- 查看列的字符集
SHOW FULL COLUMNS FROM customers;

字符集和校对对国际化应用至关重要！

