TIMEOUT = 10000
SLOW = 500
MOCHA_OPTS = --compilers coffee:coffee-script/register --timeout $(TIMEOUT) --slow $(SLOW)

test:
	@./node_modules/mocha/bin/mocha \
		--reporter spec \
		$(MOCHA_OPTS) \
		test/*.test.coffee | tee test.result.log

redis2SqlTest:
	@./node_modules/mocha/bin/mocha \
		--reporter spec \
		$(MOCHA_OPTS) \
		msgRedisToMysql/test/*.test.coffee | tee test.result.log

test-cov:
	@$(MAKE) test MOCHA_OPTS='--require blanket' REPORTER=html-cov > coverage.html

.PHONY: test redis2SqlTest