LISP ?= sbcl
## We use --non-interactive with SBCL so that errors don't interrupt the CI.
# LISP_FLAGS ?= --no-userinit --non-interactive
LISP_FLAGS ?= --non-interactive

application:
	$(LISP) $(LISP_FLAGS) \
		--eval '(require "asdf")' \
		--load malina-backup.asd \
		--eval '(asdf:make :malina-backup/executable)' \
		--eval '(uiop:quit)' || (printf "\n%s\n%s\n" "Compilation failed, see the above stacktrace." && exit 1)

clean:
	rm -f src/*.fasl
	rm -f *.fasl
	rm -f malina-backup
