.PHONY: all clean main run test debug
all: run
main.tab.cc: main.y
	bison -o main.tab.cc -v main.y
lex.yy.cc: main.l
	flex -o lex.yy.cc main.l
main: lex.yy.cc main.tab.cc
	g++ $(shell ls *.cpp *.cc) -o main.out
run: main
	./main.out
test:main
	for file in $(basename $(shell find test/*.c)); \
	do \
		./main.out <$$file.c >$$file.res; \
	done
testall:main
	for file in $(basename $(shell find test/*.c)); \
	do \
		./main.out <$$file.c >$$file.res; \
	done
	./main.out <test/1.c >test/1.res
	./main.out <test/2.c >test/2.res
	./main.out <test/3.c >test/3.res
	./main.out <test/0.c >test/0.res
test0:main
	for file in $(basename $(shell find test/*.c)); \
	do \
		./main.out <$$file.c >$$file.res; \
	done
	rm -f *.output *.yy.* *.tab.* test/*.res
	./main.out <test/0.c >test/0.res
	rm -f *.output *.yy.* *.tab.* *.out
test1:main
	for file in $(basename $(shell find test/*.c)); \
	do \
		./main.out <$$file.c >$$file.res; \
	done
	rm -f *.output *.yy.* *.tab.* test/*.res
	./main.out <test/1.c >test/1.res
	rm -f *.output *.yy.* *.tab.* *.out
test2:main
	for file in $(basename $(shell find test/*.c)); \
	do \
		./main.out <$$file.c >$$file.res; \
	done
	rm -f *.output *.yy.* *.tab.* test/*.res
	./main.out <test/2.c >test/2.res
	rm -f *.output *.yy.* *.tab.* *.out
test3:main
	for file in $(basename $(shell find test/*.c)); \
	do \
		./main.out <$$file.c >$$file.res; \
	done
	rm -f *.output *.yy.* *.tab.* test/*.res
	./main.out <test/3.c >test/3.res
	rm -f *.output *.yy.* *.tab.* *.out
clean:
	rm -f *.output *.yy.* *.tab.* *.out test/*.res
