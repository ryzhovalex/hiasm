mkdirs:
	@mkdir -p bin/debug/quiz bin/debug/instructions bin/debug/stack obj/debug/quiz obj/debug/instructions obj/debug/stack

compile: mkdirs
	./src/scripts/compile.sh $(t)

debug: compile
	gdb bin/debug/$(t)
