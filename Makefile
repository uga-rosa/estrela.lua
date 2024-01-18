.PHONY: test

test:
	busted . --lpath='./lua/?.lua;./lua/?/init.lua'
