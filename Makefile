mkdirs:
	@mkdir -p bin/debug/quiz bin/debug/instructions bin/debug/stack obj/debug/quiz obj/debug/instructions obj/debug/stack

debug: mkdirs
	./src/scripts/Compile.sh $(t) && gdb bin/debug/$(t)
