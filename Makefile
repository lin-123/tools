TIMEOUT = 5000
SLOW = 500
MOCHA_OPTS = --compilers coffee:coffee-script/register --timeout $(TIMEOUT) --slow $(SLOW)

test:
	@./node_modules/mocha/bin/mocha \
		--reporter spec \
		$(MOCHA_OPTS) \
		test/*.test.coffee | tee test.result.log

.PHONY: test


# TIMEOUT = 5000
# SLOW = 500
# MOCHA_OPTS = --compilers coffee:coffee-script/register --timeout $(TIMEOUT) --slow $(SLOW)
# SLOW 指定“慢”测试阈值，默认为75ms。摩卡使用这个突出的测试用例，花费太长的时间。

# test:
# 	@./node_modules/mocha/bin/mocha \
#		# 显示类型  display available reporters
#		# spec - hierarchical spec list
#		# 当这段出现注释时， 不能加载coffee文件
# 		--reporter spec \

# 		$(MOCHA_OPTS) \
# 		test/*.test.coffee | tee test.result.log

