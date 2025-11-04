#!/bin/bash

# ========================================
# MySQL 必知必会 - 交互式学习系统
# ========================================

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 配置
PROGRESS_FILE=".mysql_progress.json"
LESSONS_DIR="lessons"

# Docker MySQL connection settings
MYSQL_CONTAINER="mysql"
MYSQL_USER="root"
MYSQL_PASS="password"
MYSQL_DB="crashcourse"

# 初始化进度文件
init_progress() {
    if [ ! -f "$PROGRESS_FILE" ]; then
        echo '{"completed_chapters": [], "current_chapter": 1, "total_score": 0}' > "$PROGRESS_FILE"
    fi
}

# 获取当前进度
get_current_chapter() {
    if [ -f "$PROGRESS_FILE" ]; then
        grep -o '"current_chapter": [0-9]*' "$PROGRESS_FILE" | grep -o '[0-9]*'
    else
        echo "1"
    fi
}

# 标记章节完成
mark_chapter_complete() {
    local chapter=$1
    
    # 检查章节是否已完成
    local completed=$(jq ".completed_chapters | contains([$chapter])" "$PROGRESS_FILE")
    
    if [ "$completed" = "true" ]; then
        echo -e "${YELLOW}章节 $chapter 已经标记为完成${NC}"
        sleep 2
        return
    fi
    
    # 更新 JSON: 添加到已完成列表，推进当前章节
    jq ".completed_chapters += [$chapter] | .current_chapter = (if $chapter >= .current_chapter then $chapter + 1 else .current_chapter end)" \
       "$PROGRESS_FILE" > "${PROGRESS_FILE}.tmp" && \
       mv "${PROGRESS_FILE}.tmp" "$PROGRESS_FILE"
    
    # 记录日志
    echo "章节 $chapter 已完成！- $(date '+%Y-%m-%d %H:%M:%S')" >> .learning_log.txt
}

# 显示标题
show_header() {
    clear
    echo -e "${CYAN}================================================${NC}"
    echo -e "${CYAN}     MySQL 必知必会 - 交互式学习系统${NC}"
    echo -e "${CYAN}================================================${NC}"
    echo ""
}

# 显示主菜单
show_main_menu() {
    show_header
    echo -e "${GREEN}请选择学习内容：${NC}"
    echo ""
    echo -e "${YELLOW}=== 基础篇 ===${NC}"
    echo "  1. 第1章 - 了解 SQL"
    echo "  2. 第2章 - MySQL 简介"
    echo "  3. 第3章 - 使用 MySQL"
    echo "  4. 第4章 - 检索数据"
    echo ""
    echo -e "${YELLOW}=== 查询篇 ===${NC}"
    echo "  5. 第5章 - 排序检索数据"
    echo "  6. 第6章 - 过滤数据"
    echo "  7. 第7章 - 数据过滤"
    echo "  8. 第8章 - 用通配符进行过滤"
    echo "  9. 第9章 - 用正则表达式进行搜索"
    echo ""
    echo -e "${YELLOW}=== 数据处理篇 ===${NC}"
    echo " 10. 第10章 - 创建计算字段"
    echo " 11. 第11章 - 使用数据处理函数"
    echo " 12. 第12章 - 汇总数据"
    echo " 13. 第13章 - 分组数据"
    echo ""
    echo -e "${YELLOW}=== 高级查询篇 ===${NC}"
    echo " 14. 第14章 - 使用子查询"
    echo " 15. 第15章 - 联结表"
    echo " 16. 第16章 - 创建高级联结"
    echo " 17. 第17章 - 组合查询"
    echo " 18. 第18章 - 全文本搜索"
    echo ""
    echo -e "${YELLOW}=== 数据操作篇 ===${NC}"
    echo " 19. 第19章 - 插入数据"
    echo " 20. 第20章 - 更新和删除数据"
    echo " 21. 第21章 - 创建和操纵表"
    echo ""
    echo -e "${YELLOW}=== 高级特性篇 ===${NC}"
    echo " 22. 第22章 - 使用视图"
    echo " 23. 第23章 - 使用存储过程"
    echo " 24. 第24章 - 使用游标"
    echo " 25. 第25章 - 使用触发器"
    echo " 26. 第26章 - 管理事务处理"
    echo ""
    echo -e "${YELLOW}=== 管理篇 ===${NC}"
    echo " 27. 第27章 - 全球化和本地化"
    echo " 28. 第28章 - 安全管理"
    echo " 29. 第29章 - 数据库维护"
    echo " 30. 第30章 - 改善性能"
    echo ""
    echo -e "${BLUE}特殊选项：${NC}"
    echo "  0. 初始化数据库"
    echo "  p. 查看学习进度"
    echo "  q. 退出"
    echo ""
    echo -n -e "${GREEN}请输入选项: ${NC}"
}

# 执行 SQL 命令
run_sql() {
    local sql="$1"
    docker exec -i "$MYSQL_CONTAINER" mysql -u"$MYSQL_USER" -p"$MYSQL_PASS" "$MYSQL_DB" -e "$sql" 2>&1
}

# 执行 SQL 文件
run_sql_file() {
    local file="$1"
    docker exec -i "$MYSQL_CONTAINER" mysql -u"$MYSQL_USER" -p"$MYSQL_PASS" < "$file" 2>&1
}

# 初始化数据库
init_database() {
    show_header
    echo -e "${YELLOW}正在初始化数据库...${NC}"
    echo ""
    
    if [ ! -f "setup_db.sql" ]; then
        echo -e "${RED}错误: 找不到 setup_db.sql 文件${NC}"
        return 1
    fi
    
    run_sql_file "setup_db.sql"
    
    if [ $? -eq 0 ]; then
        echo ""
        echo -e "${GREEN}✓ 数据库初始化成功！${NC}"
        echo -e "${GREEN}已创建数据库: crashcourse${NC}"
        echo -e "${GREEN}已创建表: vendors, products, customers, orders, orderitems, productnotes${NC}"
    else
        echo -e "${RED}✗ 数据库初始化失败${NC}"
    fi
    
    echo ""
    echo -n "按回车键继续..."
    read
}

# 显示学习进度
show_progress() {
    show_header
    echo -e "${YELLOW}学习进度${NC}"
    echo ""
    
    if [ -f "$PROGRESS_FILE" ]; then
        local current=$(jq -r '.current_chapter' "$PROGRESS_FILE")
        local completed_count=$(jq '.completed_chapters | length' "$PROGRESS_FILE")
        local percent=$((completed_count * 100 / 30))
        
        echo -e "当前章节: ${GREEN}第 $current 章${NC}"
        echo -e "已完成章节: ${GREEN}$completed_count${NC} / 30"
        echo -e "总体进度: ${GREEN}$percent%${NC}"
        echo ""
        
        # 显示进度条
        local filled=$((percent / 5))
        local empty=$((20 - filled))
        echo -n "["
        for ((i=0; i<filled; i++)); do echo -n "█"; done
        for ((i=0; i<empty; i++)); do echo -n "░"; done
        echo "]"
        echo ""
        
        # 显示已完成章节列表
        local completed_list=$(jq -r '.completed_chapters | join(", ")' "$PROGRESS_FILE")
        if [ -n "$completed_list" ] && [ "$completed_list" != "" ]; then
            echo -e "${CYAN}已完成章节：${NC}$completed_list"
        fi
    else
        echo -e "${YELLOW}还没有学习记录${NC}"
    fi
    
    echo ""
    echo -n "按回车键继续..."
    read
}

# 学习章节
learn_chapter() {
    local chapter=$1
    local lesson_file="${LESSONS_DIR}/chapter_${chapter}.md"
    
    if [ ! -f "$lesson_file" ]; then
        show_header
        echo -e "${RED}该章节内容正在准备中...${NC}"
        echo ""
        echo -e "${YELLOW}提示: 请先运行第 $chapter 章的学习内容生成${NC}"
        echo ""
        echo -n "按回车键继续..."
        read
        return
    fi
    
    show_header
    
    # 显示章节内容（使用 less 分页器，从头开始显示）
    less -R "$lesson_file"
    
    # 阅读完成后显示分隔线
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo -e "${GREEN}选项：${NC}"
    echo "  1. 进入 MySQL 实践"
    echo "  2. 标记为已完成"
    echo "  0. 返回主菜单"
    echo ""
    echo -n -e "${GREEN}请选择: ${NC}"
    
    read choice
    case $choice in
        1)
            practice_sql
            ;;
        2)
            mark_chapter_complete "$chapter"
            echo -e "${GREEN}✓ 已标记第 $chapter 章为已完成${NC}"
            sleep 2
            ;;
        *)
            ;;
    esac
}

# 进入 SQL 实践模式
practice_sql() {
    show_header
    echo -e "${CYAN}=== MySQL 实践模式 ===${NC}"
    echo -e "${YELLOW}你现在可以直接在 MySQL 中练习${NC}"
    echo -e "${YELLOW}输入 'exit' 返回菜单${NC}"
    echo ""
    
    docker exec -it "$MYSQL_CONTAINER" mysql -u"$MYSQL_USER" -p"$MYSQL_PASS" "$MYSQL_DB"
}

# 主循环
main() {
    init_progress
    
    while true; do
        show_main_menu
        read choice
        
        case $choice in
            0)
                init_database
                ;;
            [1-9]|[12][0-9]|30)
                learn_chapter "$choice"
                ;;
            p|P)
                show_progress
                ;;
            q|Q)
                echo -e "${GREEN}感谢使用！祝学习愉快！${NC}"
                exit 0
                ;;
            *)
                echo -e "${RED}无效选项${NC}"
                sleep 1
                ;;
        esac
    done
}

# 运行主程序
main
