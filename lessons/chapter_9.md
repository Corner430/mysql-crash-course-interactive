━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📚 第 9 章：用正则表达式进行搜索
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📖 学习目标
──────────────────────────────────────
✓ 理解正则表达式的概念和作用
✓ 掌握REGEXP操作符的使用
✓ 学会使用各种正则表达式元字符
✓ 能够构建复杂的搜索模式

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📝 核心知识点
──────────────────────────────────────

正则表达式（Regular Expression）
   用来匹配文本的特殊字符串模式


1️⃣  REGEXP 操作符
   ────────────────────────────────────
   语法：
   WHERE 列名 REGEXP '正则表达式'
   
   示例：
   SELECT prod_name FROM products
   WHERE prod_name REGEXP '1000';
   
   REGEXP vs LIKE：
   • LIKE匹配整个列值
   • REGEXP在列值内进行匹配


2️⃣  基本字符匹配
   ────────────────────────────────────
   . - 匹配任意单个字符
   
   示例：
   WHERE prod_name REGEXP '.000'
   
   匹配：1000、2000、.000等


3️⃣  OR匹配（|）
   ────────────────────────────────────
   | - 或操作符
   
   示例：
   WHERE prod_name REGEXP '1000|2000'
   
   匹配：包含1000或2000的产品


4️⃣  匹配几个字符之一（[]）
   ────────────────────────────────────
   [abc] - 匹配a、b或c
   [^abc] - 匹配除a、b、c之外的
   
   示例：
   WHERE prod_name REGEXP '[123] ton'
   
   匹配：1 ton、2 ton、3 ton


5️⃣  匹配范围（[-]）
   ────────────────────────────────────
   [0-9] - 匹配数字0到9
   [a-z] - 匹配字母a到z
   
   示例：
   WHERE prod_name REGEXP '[1-5] ton'


6️⃣  匹配特殊字符
   ────────────────────────────────────
   需要转义的特殊字符：. [] | - 等
   
   使用\\进行转义：
   WHERE prod_name REGEXP '\\.'
   
   匹配：包含点号的产品


7️⃣  匹配字符类（POSIX字符类）
   ────────────────────────────────────
   [:alnum:]  - 字母和数字
   [:alpha:]  - 字母
   [:digit:]  - 数字
   [:lower:]  - 小写字母
   [:upper:]  - 大写字母
   [:space:]  - 空白字符
   
   💡 双重方括号说明：
   标准写法：WHERE prod_name REGEXP '[[:digit:]]'
   - 外层[]：字符集语法
   - 内层[:digit:]：POSIX字符类名称
   
   MySQL 8.0简化写法：WHERE prod_name REGEXP '[:digit:]'
   - 也能正常工作，但标准写法兼容性更好
   
   等价写法：WHERE prod_name REGEXP '[0-9]'


8️⃣  匹配多个实例
   ────────────────────────────────────
   *  - 0个或多个
   +  - 1个或多个
   ?  - 0个或1个
   {n} - 恰好n个
   {n,} - 至少n个
   {n,m} - n到m个
   
   示例：
   WHERE prod_name REGEXP '[0-9]{4}'  -- 4位数字


9️⃣  定位符
   ────────────────────────────────────
   ^  - 文本开始
   $  - 文本结束
   [[:<:]] - 词的开始
   [[:>:]] - 词的结束
   
   示例：
   WHERE prod_name REGEXP '^Jet'  -- 以Jet开头

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 实践任务
──────────────────────────────────────

📝 基础练习
──────────────────────────────────────

练习 1: 基本匹配
──────────────────────────────────────
查找包含'000'的产品

你的SQL：
  SELECT prod_name 
  FROM products
  WHERE prod_name REGEXP '000';


练习 2: OR匹配
──────────────────────────────────────
查找包含1000或2000的产品

你的SQL：
  SELECT prod_name 
  FROM products
  WHERE prod_name REGEXP '1000|2000';


练习 3: 字符集匹配
──────────────────────────────────────
查找"X ton"格式的产品（X是1、2或5）

你的SQL：
  SELECT prod_name 
  FROM products
  WHERE prod_name REGEXP '[125] ton';


练习 4: 范围匹配
──────────────────────────────────────
查找包含数字的产品名

你的SQL：
  SELECT prod_name 
  FROM products
  WHERE prod_name REGEXP '[0-9]';


练习 5: 定位匹配
──────────────────────────────────────
查找以字母J开头的产品

你的SQL：
  SELECT prod_name 
  FROM products
  WHERE prod_name REGEXP '^J';


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🚀 进阶挑战
──────────────────────────────────────

挑战 1: 复杂模式
──────────────────────────────────────
查找恰好包含4位数字的产品

你的SQL：
  SELECT prod_name 
  FROM products
  WHERE prod_name REGEXP '[0-9]{4}';


挑战 2: 组合定位符
──────────────────────────────────────
查找以数字开头的产品名

你的SQL：
  SELECT prod_name 
  FROM products
  WHERE prod_name REGEXP '^[0-9]';


挑战 3: 否定匹配
──────────────────────────────────────
查找不包含数字的产品名

你的SQL：
  SELECT prod_name 
  FROM products
  WHERE prod_name NOT REGEXP '[0-9]';


挑战 4: 多个实例匹配
──────────────────────────────────────
查找包含连续两个或以上数字的产品

你的SQL：
  SELECT prod_name 
  FROM products
  WHERE prod_name REGEXP '[0-9]{2,}';


挑战 5: 复杂字符类
──────────────────────────────────────
查找产品名中包含括号的产品

你的SQL：
  SELECT prod_name 
  FROM products
  WHERE prod_name REGEXP '\\(';


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💡 重要提示
──────────────────────────────────────

⚠️  REGEXP vs LIKE
    
    LIKE匹配整个值：
    WHERE name LIKE 'jet%'  -- jet必须在开头
    
    REGEXP在值内匹配：
    WHERE name REGEXP 'jet'  -- jet在任意位置
    
    等价关系：
    LIKE '%jet%' = REGEXP 'jet'


⚠️  区分大小写
    
    默认不区分大小写：
    REGEXP 'jet' 匹配 'JetPack'
    
    要区分大小写，使用BINARY：
    WHERE BINARY prod_name REGEXP 'jet'


⚠️  特殊字符转义
    
    需要转义的字符：
    . [ ] | - ^ $ ( ) { } * + ? \
    
    使用\\转义：
    '\\.'  匹配点号
    '\\['  匹配左括号


⚠️  MySQL正则表达式限制
    
    MySQL实现的是正则表达式的子集
    某些高级功能可能不支持
    
    建议查阅MySQL文档了解支持的功能


⚠️  性能考虑
    
    正则表达式比简单匹配慢
    能用LIKE就不用REGEXP
    在大表上谨慎使用

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 实战示例
──────────────────────────────────────

示例 1: 基本正则匹配
  
  SELECT prod_name 
  FROM products
  WHERE prod_name REGEXP '1000';
  
  结果：JetPack 1000


示例 2: OR匹配
  
  SELECT prod_name 
  FROM products
  WHERE prod_name REGEXP 'stick|sticks';
  
  结果：
  TNT (1 stick)
  TNT (5 sticks)


示例 3: 字符集匹配
  
  SELECT prod_name 
  FROM products
  WHERE prod_name REGEXP '[123] ton';
  
  结果：
  .5 ton anvil  -- 不匹配（.5不是单个字符）
  1 ton anvil   -- 匹配
  2 ton anvil   -- 匹配


示例 4: 范围和数量
  
  SELECT prod_name 
  FROM products
  WHERE prod_name REGEXP '[0-9]{4}';
  
  结果：
  JetPack 1000
  JetPack 2000


示例 5: 定位符应用
  
  -- 以Jet开头
  SELECT prod_name 
  FROM products
  WHERE prod_name REGEXP '^Jet';
  
  -- 以00结尾
  SELECT prod_name 
  FROM products
  WHERE prod_name REGEXP '00$';

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎓 正则表达式速查表
──────────────────────────────────────

基本元字符：
.       任意单个字符
|       或
[]      字符集
[^]     否定字符集
-       范围

重复元字符：
*       0次或多次
+       1次或多次
?       0次或1次
{n}     恰好n次
{n,}    至少n次
{n,m}   n到m次

定位元字符：
^       开始
$       结束
[[:<:]] 词首
[[:>:]] 词尾

字符类：
[:alnum:]  字母数字
[:alpha:]  字母
[:digit:]  数字
[:lower:]  小写
[:upper:]  大写
[:space:]  空白

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✨ 本章小结
──────────────────────────────────────

你已经掌握了：
✓ 正则表达式的基本概念
✓ 使用REGEXP操作符进行模式匹配
✓ 各种正则表达式元字符的使用
✓ 构建复杂的搜索模式
✓ 正则表达式的性能考虑

下一章将学习如何创建计算字段！

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💻 学习建议
──────────────────────────────────────
• 正则表达式需要大量练习
• 从简单模式开始逐步复杂
• 测试每个模式确保正确
• 参考MySQL文档了解更多

