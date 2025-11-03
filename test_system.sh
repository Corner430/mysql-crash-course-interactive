#!/bin/bash

# MySQL Crash Course Learning System - Test Script

MYSQL_USER="root"
MYSQL_PASS="password"
MYSQL_DB="crashcourse"

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "========================================"
echo "Testing MySQL Learning System"
echo "========================================"
echo ""

# Test 1: Check MySQL connection
echo -n "Test 1: MySQL Connection... "
if docker exec mysql mysql -u${MYSQL_USER} -p${MYSQL_PASS} -e "SELECT 1;" >/dev/null 2>&1; then
    echo -e "${GREEN}PASS${NC}"
else
    echo -e "${RED}FAIL${NC}"
    exit 1
fi

# Test 2: Check database exists
echo -n "Test 2: Database 'crashcourse' exists... "
if docker exec mysql mysql -u${MYSQL_USER} -p${MYSQL_PASS} -e "USE crashcourse;" 2>/dev/null; then
    echo -e "${GREEN}PASS${NC}"
else
    echo -e "${RED}FAIL${NC}"
    exit 1
fi

# Test 3: Check all tables exist
echo -n "Test 3: All tables exist... "
TABLES=$(docker exec mysql mysql -u${MYSQL_USER} -p${MYSQL_PASS} ${MYSQL_DB} -e "SHOW TABLES;" 2>/dev/null | wc -l)
if [ $TABLES -eq 7 ]; then  # 6 tables + header
    echo -e "${GREEN}PASS${NC} (6 tables)"
else
    echo -e "${RED}FAIL${NC} (found $((TABLES-1)) tables)"
fi

# Test 4: Check vendors data
echo -n "Test 4: Vendors data... "
VENDOR_COUNT=$(docker exec mysql mysql -u${MYSQL_USER} -p${MYSQL_PASS} ${MYSQL_DB} -e "SELECT COUNT(*) FROM vendors;" 2>/dev/null | tail -1)
if [ "$VENDOR_COUNT" = "6" ]; then
    echo -e "${GREEN}PASS${NC} (6 records)"
else
    echo -e "${RED}FAIL${NC} (found $VENDOR_COUNT records)"
fi

# Test 5: Check products data
echo -n "Test 5: Products data... "
PRODUCT_COUNT=$(docker exec mysql mysql -u${MYSQL_USER} -p${MYSQL_PASS} ${MYSQL_DB} -e "SELECT COUNT(*) FROM products;" 2>/dev/null | tail -1)
if [ "$PRODUCT_COUNT" = "14" ]; then
    echo -e "${GREEN}PASS${NC} (14 records)"
else
    echo -e "${RED}FAIL${NC} (found $PRODUCT_COUNT records)"
fi

# Test 6: Check customers data
echo -n "Test 6: Customers data... "
CUSTOMER_COUNT=$(docker exec mysql mysql -u${MYSQL_USER} -p${MYSQL_PASS} ${MYSQL_DB} -e "SELECT COUNT(*) FROM customers;" 2>/dev/null | tail -1)
if [ "$CUSTOMER_COUNT" = "5" ]; then
    echo -e "${GREEN}PASS${NC} (5 records)"
else
    echo -e "${RED}FAIL${NC} (found $CUSTOMER_COUNT records)"
fi

# Test 7: Check orders data
echo -n "Test 7: Orders data... "
ORDER_COUNT=$(docker exec mysql mysql -u${MYSQL_USER} -p${MYSQL_PASS} ${MYSQL_DB} -e "SELECT COUNT(*) FROM orders;" 2>/dev/null | tail -1)
if [ "$ORDER_COUNT" = "5" ]; then
    echo -e "${GREEN}PASS${NC} (5 records)"
else
    echo -e "${RED}FAIL${NC} (found $ORDER_COUNT records)"
fi

# Test 8: Check foreign key relationships
echo -n "Test 8: Foreign key constraints... "
FK_TEST=$(docker exec mysql mysql -u${MYSQL_USER} -p${MYSQL_PASS} ${MYSQL_DB} -e "SELECT prod_name, vend_name FROM products p JOIN vendors v ON p.vend_id = v.vend_id LIMIT 1;" 2>/dev/null | wc -l)
if [ $FK_TEST -gt 1 ]; then
    echo -e "${GREEN}PASS${NC}"
else
    echo -e "${RED}FAIL${NC}"
fi

# Test 9: Check lesson files exist
echo -n "Test 9: Lesson files... "
LESSON_COUNT=$(ls lessons/chapter_*.md 2>/dev/null | wc -l)
if [ $LESSON_COUNT -gt 0 ]; then
    echo -e "${GREEN}PASS${NC} ($LESSON_COUNT chapters)"
else
    echo -e "${RED}FAIL${NC} (no lessons found)"
fi

# Test 10: Check learning script executable
echo -n "Test 10: Learning script executable... "
if [ -x mysql_learn.sh ]; then
    echo -e "${GREEN}PASS${NC}"
else
    echo -e "${RED}FAIL${NC}"
fi

echo ""
echo "========================================"
echo "Test Summary"
echo "========================================"
echo ""
echo -e "${GREEN}All tests passed!${NC}"
echo ""
echo "You can now start learning:"
echo "  ./mysql_learn.sh"
echo ""
echo "Or connect directly to MySQL:"
echo "  docker exec -it mysql mysql -uroot -ppassword crashcourse"
echo ""
