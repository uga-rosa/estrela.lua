.PHONY: integ test lint

integ: lint test

lint:
	luacheck ./lua

test:
	busted . --lpath='./lua/?.lua;./lua/?/init.lua'
