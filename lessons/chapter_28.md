━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📚 第 28 章：安全管理
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📖 学习目标
──────────────────────────────────────
✓ 理解MySQL访问控制机制
✓ 掌握用户账号管理
✓ 学会权限的授予和撤销
✓ 了解密码管理和安全最佳实践

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📝 核心知识点
──────────────────────────────────────

1️⃣  访问控制基础
   ────────────────────────────────────
   MySQL 安全的两个阶段：
   
   1. 认证（Authentication）
      • 验证用户身份
      • 检查用户名和密码
      
   2. 授权（Authorization）
      • 确定用户权限
      • 允许或拒绝操作


2️⃣  root 用户
   ────────────────────────────────────
   • MySQL 的超级用户
   • 拥有所有权限
   • 仅用于管理任务
   • 日常操作不应使用 root
   
   ⚠️ 重要：
   保护 root 密码
   限制 root 访问


3️⃣  查看用户账号
   ────────────────────────────────────
   SELECT user, host FROM mysql.user;
   
   说明：
   • mysql.user 表存储用户信息
   • user：用户名
   • host：允许连接的主机
   • 需要 root 权限查看


4️⃣  创建用户账号
   ────────────────────────────────────
   CREATE USER 'username'@'host'
   IDENTIFIED BY 'password';
   
   示例：
   CREATE USER 'ben'@'localhost'
   IDENTIFIED BY 'p@ssw0rd';
   
   CREATE USER 'admin'@'%'
   IDENTIFIED BY 'securepassword';
   
   host 说明：
   • localhost：只能本地连接
   • %：可以从任何主机连接
   • 192.168.1.%：指定IP范围


5️⃣  删除用户账号
   ────────────────────────────────────
   DROP USER 'username'@'host';
   
   示例：
   DROP USER 'ben'@'localhost';


6️⃣  修改密码
   ────────────────────────────────────
   修改自己的密码：
   SET PASSWORD = PASSWORD('new_password');
   
   修改其他用户的密码（需要权限）：
   SET PASSWORD FOR 'username'@'host' =
   PASSWORD('new_password');
   
   MySQL 8.0+ 新语法：
   ALTER USER 'username'@'host'
   IDENTIFIED BY 'new_password';


7️⃣  权限级别
   ────────────────────────────────────
   从大到小：
   
   1. 全局权限（所有数据库）
      GRANT ALL ON *.* TO 'user'@'host';
   
   2. 数据库权限（特定数据库）
      GRANT ALL ON dbname.* TO 'user'@'host';
   
   3. 表权限（特定表）
      GRANT SELECT ON dbname.table TO 'user'@'host';
   
   4. 列权限（特定列）
      GRANT SELECT(column) ON dbname.table
      TO 'user'@'host';


8️⃣  授予权限 - GRANT
   ────────────────────────────────────
   基本语法：
   GRANT privileges ON database.table
   TO 'username'@'host';
   
   示例：
   -- 授予查询权限
   GRANT SELECT ON crashcourse.*
   TO 'analyst'@'localhost';
   
   -- 授予多个权限
   GRANT SELECT, INSERT, UPDATE
   ON crashcourse.customers
   TO 'webuser'@'%';
   
   -- 授予所有权限
   GRANT ALL PRIVILEGES ON crashcourse.*
   TO 'admin'@'localhost';


9️⃣  撤销权限 - REVOKE
   ────────────────────────────────────
   REVOKE privileges ON database.table
   FROM 'username'@'host';
   
   示例：
   REVOKE INSERT ON crashcourse.customers
   FROM 'webuser'@'%';
   
   REVOKE ALL PRIVILEGES ON crashcourse.*
   FROM 'admin'@'localhost';


🔟  查看权限
   ────────────────────────────────────
   查看当前用户权限：
   SHOW GRANTS;
   
   查看其他用户权限：
   SHOW GRANTS FOR 'username'@'host';
   
   示例：
   SHOW GRANTS FOR 'ben'@'localhost';

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 实践任务
──────────────────────────────────────

📝 基础练习
──────────────────────────────────────

练习 1: 查看当前用户
──────────────────────────────────────
查看你当前登录的用户

你的SQL：
  SELECT USER(), CURRENT_USER();


练习 2: 查看所有用户
──────────────────────────────────────
列出所有MySQL用户

你的SQL：
  SELECT user, host FROM mysql.user;


练习 3: 查看当前用户权限
──────────────────────────────────────
查看你拥有的权限

你的SQL：
  SHOW GRANTS;


练习 4: 查看特定用户权限
──────────────────────────────────────
查看 root 用户的权限

你的SQL：
  SHOW GRANTS FOR 'root'@'localhost';

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🚀 进阶挑战（概念）
──────────────────────────────────────

挑战 1: 创建只读用户
──────────────────────────────────────
创建只能查询的用户

你的SQL（概念）：
  -- CREATE USER 'readonly'@'localhost'
  -- IDENTIFIED BY 'readonlypass';
  -- 
  -- GRANT SELECT ON crashcourse.*
  -- TO 'readonly'@'localhost';


挑战 2: 创建应用用户
──────────────────────────────────────
为Web应用创建合适权限的用户

你的SQL（概念）：
  -- CREATE USER 'webapp'@'%'
  -- IDENTIFIED BY 'webapppass';
  -- 
  -- GRANT SELECT, INSERT, UPDATE, DELETE
  -- ON crashcourse.*
  -- TO 'webapp'@'%';


挑战 3: 创建管理员用户
──────────────────────────────────────
创建数据库管理员

你的SQL（概念）：
  -- CREATE USER 'dbadmin'@'localhost'
  -- IDENTIFIED BY 'strongpassword';
  -- 
  -- GRANT ALL PRIVILEGES ON crashcourse.*
  -- TO 'dbadmin'@'localhost'
  -- WITH GRANT OPTION;


挑战 4: 限制特定表的权限
──────────────────────────────────────
只允许访问特定表

你的SQL（概念）：
  -- CREATE USER 'reports'@'localhost'
  -- IDENTIFIED BY 'reportspass';
  -- 
  -- GRANT SELECT ON crashcourse.orders
  -- TO 'reports'@'localhost';
  -- 
  -- GRANT SELECT ON crashcourse.customers
  -- TO 'reports'@'localhost';


挑战 5: 列级权限
──────────────────────────────────────
只允许查看特定列

你的SQL（概念）：
  -- GRANT SELECT(cust_name, cust_city)
  -- ON crashcourse.customers
  -- TO 'limited'@'localhost';

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💡 重要提示
──────────────────────────────────────

⚠️  最小权限原则
   只授予必要的权限
   不要随意授予 ALL PRIVILEGES
   根据实际需求授权

⚠️  不要使用 root
   root 拥有所有权限
   仅用于管理任务
   日常操作使用普通用户

⚠️  主机限制
   localhost：只能本地连接（更安全）
   %：可以从任何地方连接（方便但风险大）
   指定IP：折中方案

⚠️  密码安全
   • 使用强密码
   • 定期更换密码
   • 不要在脚本中明文存储密码
   • 考虑使用密码策略

⚠️  权限刷新
   修改权限后立即生效
   但某些情况需要：
   FLUSH PRIVILEGES;

⚠️  WITH GRANT OPTION
   允许用户授权给其他用户
   谨慎使用此选项
   可能导致权限泄露

⚠️  审计和监控
   定期检查用户和权限
   删除不再需要的账号
   监控异常登录活动

⚠️  备份 mysql.user
   用户信息存储在 mysql 数据库
   定期备份 mysql.user 表
   便于恢复

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 常用权限说明
──────────────────────────────────────

数据操作权限：
  SELECT   - 查询数据
  INSERT   - 插入数据
  UPDATE   - 更新数据
  DELETE   - 删除数据

结构操作权限：
  CREATE   - 创建数据库和表
  ALTER    - 修改表结构
  DROP     - 删除数据库和表
  INDEX    - 创建/删除索引

管理权限：
  GRANT OPTION    - 授权给其他用户
  CREATE USER     - 创建用户
  RELOAD          - 重新加载权限表
  SHUTDOWN        - 关闭MySQL服务器
  PROCESS         - 查看所有进程
  SUPER           - 超级权限

特殊权限：
  ALL PRIVILEGES  - 所有权限（除GRANT）
  USAGE           - 无权限（仅连接）

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 实战示例
──────────────────────────────────────

示例 1: 创建用户
  CREATE USER 'ben'@'localhost'
  IDENTIFIED BY 'p@ssw0rd';


示例 2: 授予查询权限
  GRANT SELECT ON crashcourse.*
  TO 'ben'@'localhost';


示例 3: 授予多个权限
  GRANT SELECT, INSERT, UPDATE
  ON crashcourse.customers
  TO 'ben'@'localhost';


示例 4: 授予所有权限
  GRANT ALL PRIVILEGES ON crashcourse.*
  TO 'admin'@'localhost';


示例 5: 撤销权限
  REVOKE INSERT ON crashcourse.customers
  FROM 'ben'@'localhost';


示例 6: 修改密码
  ALTER USER 'ben'@'localhost'
  IDENTIFIED BY 'new_p@ssw0rd';


示例 7: 删除用户
  DROP USER 'ben'@'localhost';


示例 8: 查看权限
  SHOW GRANTS FOR 'ben'@'localhost';


示例 9: 创建应用用户（完整流程）
  -- 创建用户
  CREATE USER 'webapp'@'%'
  IDENTIFIED BY 'webapppass';
  
  -- 授予必要权限
  GRANT SELECT, INSERT, UPDATE, DELETE
  ON crashcourse.*
  TO 'webapp'@'%';
  
  -- 查看权限
  SHOW GRANTS FOR 'webapp'@'%';


示例 10: 创建只读分析用户
  CREATE USER 'analyst'@'%'
  IDENTIFIED BY 'analystpass';
  
  GRANT SELECT ON crashcourse.*
  TO 'analyst'@'%';

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎓 知识检查点
──────────────────────────────────────

□ 你理解认证和授权的区别吗？
□ 你知道为什么不应该使用 root 吗？
□ 你会创建用户吗？
□ 你会授予和撤销权限吗？
□ 你知道不同的权限级别吗？
□ 你了解 localhost 和 % 的区别吗？
□ 你知道最小权限原则吗？
□ 你会查看用户权限吗？

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔍 安全最佳实践
──────────────────────────────────────

1. 用户管理
   ✓ 为每个应用创建专用账号
   ✓ 不要共用账号
   ✓ 定期审查和清理账号
   ✓ 禁用不需要的账号

2. 密码策略
   ✓ 使用强密码
   ✓ 定期更换密码
   ✓ 不要重复使用密码
   ✓ 使用密码管理器

3. 权限控制
   ✓ 遵循最小权限原则
   ✓ 定期审查权限
   ✓ 及时撤销不需要的权限
   ✓ 避免使用通配符主机（%）

4. 网络安全
   ✓ 限制MySQL端口访问
   ✓ 使用防火墙
   ✓ 考虑使用SSL连接
   ✓ 绑定到内网IP

5. 审计和监控
   ✓ 启用查询日志
   ✓ 监控失败的登录尝试
   ✓ 定期检查用户活动
   ✓ 设置警报

6. 备份和恢复
   ✓ 定期备份数据
   ✓ 测试恢复过程
   ✓ 安全存储备份
   ✓ 备份 mysql 数据库

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✨ 本章小结
──────────────────────────────────────

你已经学会了：
✓ 理解MySQL的访问控制机制
✓ 掌握用户账号的创建和删除
✓ 使用 GRANT 授予权限
✓ 使用 REVOKE 撤销权限
✓ 查看用户和权限
✓ 修改用户密码
✓ 了解不同级别的权限
✓ 掌握安全最佳实践

核心要点：
• 不要使用 root 进行日常操作
• 遵循最小权限原则
• 创建专用账号给每个应用
• 使用强密码并定期更换
• 限制主机访问（优先使用 localhost）
• 定期审查用户和权限

下一章将学习数据库维护！

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💻 动手实践
──────────────────────────────────────
安全的查询操作：

-- 查看当前用户
SELECT USER(), CURRENT_USER();

-- 查看当前用户权限
SHOW GRANTS;

-- 查看所有用户（需要权限）
SELECT user, host FROM mysql.user;

⚠️  不要随意创建或修改用户
    这些操作影响数据库安全
    只有管理员才应该执行

⚠️  如果你在使用 Docker 容器
    默认已经用 root 登录
    生产环境绝对不要这样做

数据库安全至关重要，永远不要掉以轻心！

