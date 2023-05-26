mkdirs:
	@mkdir -p bin/debug/quiz bin/debug/instructions obj/debug/quiz obj/debug/instructions

run: mkdirs
	./src/scripts/Compile.sh $(t) && gdb bin/debug/$(t)
