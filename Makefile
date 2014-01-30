#########################################################
##  ADA RELATED CONFIGURATION
GPR_PROJECT=dispatch.gpr
GPR_FLAGS=-j2

GPRBUILD=gprbuild
GPRCLEAN=gprclean
##
#########################################################
##  C RELATED CONFIGURATION
CFLAGS+=-I/usr/local/include -fblocks
LDFLAGS+=-L/usr/local/lib -ldispatch
##
#########################################################

.PHONY: clean test setup

test: dispatch-test dispatch-ada-test
	./dispatch-test

setup:
	mkdir -p obj

clean:
	$(GPRCLEAN) -P $(GPR_PROJECT)
	rm -f tags

dispatch-ada-test: setup
	$(GPRBUILD) $(GPR_FLAGS) -P $(GPR_PROJECT)

tags: setup
	ctags --links=no --languages=Ada --recurse .

