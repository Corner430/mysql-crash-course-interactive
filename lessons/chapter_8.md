━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📚 第 8 章：用通配符进行过滤
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📖 学习目标
──────────────────────────────────────
✓ 理解通配符和搜索模式的概念
✓ 掌握LIKE操作符的使用
✓ 学会使用%和_通配符
✓ 了解通配符的性能影响

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📝 核心概念
──────────────────────────────────────

通配符（wildcard）
   用来匹配值的一部分的特殊字符

搜索模式（search pattern）
   由字面值、通配符或两者组合构成的搜索条件


1️⃣  LIKE 操作符
   ────────────────────────────────────
   作用：指示MySQL使用通配符匹配
   
   语法：
   WHERE 列名 LIKE '模式'
   
   示例：
   SELECT prod_name FROM products
   WHERE prod_name LIKE 'jet%';


2️⃣  百分号（%）通配符
   ────────────────────────────────────
   含义：匹配任意字符出现任意次数（0次、1次或多次）
   
   示例1：以jet开头
   WHERE prod_name LIKE 'jet%'
   
   匹配：JetPack 1000、JetPack 2000
   
   示例2：包含anvil
   WHERE prod_name LIKE '%anvil%'
   
   匹配：.5 ton anvil、1 ton anvil、2 ton anvil
   
   示例3：以s开头、e结尾
   WHERE prod_name LIKE 's%e'
   
   匹配：Safe、Sling（如果以e结尾）
   
   重要：%可以匹配0个字符
   'jet%' 能匹配 'jet'


3️⃣  下划线（_）通配符
   ────────────────────────────────────
   含义：匹配单个字符（必须是1个字符）
   
   示例：
   WHERE prod_name LIKE '_ ton anvil'
   
   匹配：1 ton anvil、2 ton anvil
   不匹配：.5 ton anvil（.5是两个字符）
   
   区别：
   % - 0个或多个字符
   _ - 恰好1个字符

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 实践任务
──────────────────────────────────────

📝 基础练习
──────────────────────────────────────

练习 1: 查找以Jet开头的产品
──────────────────────────────────────
查找所有以"Jet"开头的产品

你的SQL：
  SELECT prod_id, prod_name 
  FROM products
  WHERE prod_name LIKE 'Jet%';


练习 2: 查找包含anvil的产品
──────────────────────────────────────
查找产品名中包含"anvil"的所有产品

你的SQL：
  SELECT prod_name 
  FROM products
  WHERE prod_name LIKE '%anvil%';


练习 3: 查找以s开头的产品
──────────────────────────────────────
查找以字母s开头的产品（不区分大小写）

你的SQL：
  SELECT prod_name 
  FROM products
  WHERE prod_name LIKE 's%';


练习 4: 查找第二个字符是o的产品
──────────────────────────────────────
使用_通配符查找第二个字符是'o'的产品

你的SQL：
  SELECT prod_name 
  FROM products
  WHERE prod_name LIKE '_o%';


练习 5: 查找恰好X个字符的产品ID
──────────────────────────────────────
查找产品ID恰好5个字符的产品

你的SQL：
  SELECT prod_id, prod_name 
  FROM products
  WHERE prod_id LIKE '_____';


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🚀 进阶挑战
──────────────────────────────────────

挑战 1: 复杂的%模式
──────────────────────────────────────
查找包含数字的产品名

你的SQL：
  SELECT prod_name 
  FROM products
  WHERE prod_name LIKE '%1%'
     OR prod_name LIKE '%2%'
     OR prod_name LIKE '%3%'
     OR prod_name LIKE '%4%'
     OR prod_name LIKE '%5%';


挑战 2: 组合通配符
──────────────────────────────────────
查找形如"X ton anvil"的产品（X是单个字符）

你的SQL：
  SELECT prod_name 
  FROM products
  WHERE prod_name LIKE '_ ton anvil';


挑战 3: 排除特定模式
──────────────────────────────────────
查找不以Jet开头的所有产品

你的SQL：
  SELECT prod_name 
  FROM products
  WHERE prod_name NOT LIKE 'Jet%';


挑战 4: 查找有邮箱的客户
──────────────────────────────────────
查找邮箱地址包含".com"的客户

你的SQL：
  SELECT cust_name, cust_email 
  FROM customers
  WHERE cust_email LIKE '%.com';


挑战 5: 多通配符组合
──────────────────────────────────────
查找产品名以字母开头，包含数字，且长度至少5个字符

你的SQL：
  SELECT prod_name 
  FROM products
  WHERE prod_name LIKE '%[0-9]%'
    AND LENGTH(prod_name) >= 5;


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💡 重要提示
──────────────────────────────────────

⚠️  通配符位置很重要
    
    '%jet' - jet在末尾
    'jet%' - jet在开头  
    '%jet%' - jet在任意位置
    
    '%jet%'搜索最慢（需要扫描所有数据）


⚠️  注意尾空格
    
    如果数据末尾有空格：
    'anvil ' 不会匹配 'anvil'
    
    解决方法：
    WHERE prod_name LIKE '%anvil%'
    或使用函数：
    WHERE TRIM(prod_name) = 'anvil'


⚠️  NULL值问题
    
    通配符不能匹配NULL：
    WHERE prod_name LIKE '%'  
    不会匹配 prod_name IS NULL的行


⚠️  区分大小写
    
    根据MySQL配置：
    • 默认不区分大小写
    • 'jet%' 可以匹配 'JetPack'
    
    如需区分，使用BINARY：
    WHERE BINARY prod_name LIKE 'jet%'


⚠️  性能考虑
    
    慢：'%jet%' （两端都有%）
    快：'jet%'  （只在末尾有%）
    
    建议：
    • 避免在开头使用%
    • 能用其他操作符就不用通配符
    • 考虑使用全文搜索（第18章）

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 实战示例
──────────────────────────────────────

示例 1: 查找所有anvil产品
  
  SELECT prod_id, prod_name, prod_price
  FROM products
  WHERE prod_name LIKE '%anvil%';
  
  结果：
  ANV01 | .5 ton anvil  | 5.99
  ANV02 | 1 ton anvil   | 9.99
  ANV03 | 2 ton anvil   | 14.99


示例 2: 查找TNT产品
  
  SELECT prod_name 
  FROM products
  WHERE prod_name LIKE 'TNT%';
  
  结果：
  TNT (1 stick)
  TNT (5 sticks)


示例 3: 组合条件
  
  SELECT prod_name, prod_price
  FROM products
  WHERE prod_name LIKE '%pack%'
    AND prod_price > 30;
  
  结果：
  JetPack 1000 | 35.00
  JetPack 2000 | 55.00


示例 4: 使用_通配符
  
  SELECT prod_id 
  FROM products
  WHERE prod_id LIKE 'ANV0_';
  
  结果：
  ANV01
  ANV02
  ANV03


示例 5: 查找特定格式的数据
  
  -- 查找州代码恰好2个字符的客户
  SELECT cust_name, cust_state
  FROM customers
  WHERE cust_state LIKE '__';
  
  结果：所有州代码为2字母的记录

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎓 知识检查点
──────────────────────────────────────

□ 你理解通配符的概念吗？
□ 你知道%和_的区别吗？
□ 你会使用LIKE操作符吗？
□ 你了解通配符的性能影响吗？
□ 你知道通配符不能匹配NULL吗？

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📋 通配符速查表
──────────────────────────────────────

┌──────────┬─────────────────┬──────────────┐
│ 通配符   │ 描述            │ 示例         │
├──────────┼─────────────────┼──────────────┤
│ %        │ 任意字符任意次  │ 'jet%'       │
│ _        │ 单个字符        │ '_ ton'      │
│ LIKE     │ 通配符操作符    │ LIKE 'jet%'  │
│ NOT LIKE │ 否定通配符      │ NOT LIKE '%' │
└──────────┴─────────────────┴──────────────┘

常用模式：
'a%'    - 以a开头
'%a'    - 以a结尾
'%a%'   - 包含a
'_a%'   - 第二个字符是a
'a%b'   - 以a开头b结尾
'___'   - 恰好3个字符

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔍 使用技巧
──────────────────────────────────────

1. 不要过度使用通配符
   如果能用=、<、>等，就不要用通配符

2. 通配符放在末尾
   'jet%' 比 '%jet' 快得多

3. 仔细选择通配符位置
   根据实际需求放置通配符

4. 注意性能
   '%keyword%' 在大表上很慢
   考虑使用全文搜索

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✨ 本章小结
──────────────────────────────────────

你已经学会了：
✓ 通配符是匹配部分值的特殊字符
✓ 使用LIKE操作符进行通配符搜索
✓ %匹配任意字符任意次数
✓ _匹配单个字符
✓ 通配符功能强大但影响性能
✓ 通配符不能匹配NULL值

下一章将学习更强大的正则表达式！

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💻 实践建议
──────────────────────────────────────
在products和customers表上：
• 尝试不同的通配符模式
• 对比%和_的区别
• 体验通配符位置的影响
• 练习组合使用通配符

