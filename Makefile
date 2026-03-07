.DEFAULT_GOAL := test

EXERCISE ?= ""
EXERCISES = $(shell find ./exercises/practice -maxdepth 1 -mindepth 1 -type d | cut -s -d '/' -f4 | sort)
OUTDIR ?= "tmp"

# check all package.json and package-lock.json are matching
check-package-files:
	@echo "Validation package.json files..."
	@for pkg in $(PKG_FILES); do \
		! ./bin/md5-hash $$pkg | grep -qv $(SOURCE_PKG_MD5) || { echo "$$pkg does not match main package.json.  Please run 'make sync-package-files' locally and commit the results."; exit 1; }; \
	done
	@echo "Validation package-lock.json files..."
	@for pkg in $(PKG_LOCK_FILES); do \
		! ./bin/md5-hash $$pkg | grep -qv $(SOURCE_PKG_LOCK_MD5) || { echo "$$pkg does not match main package.json.  Please run 'make sync-package-files' locally and commit the results."; exit 1; }; \
	done
	@echo "package-file check complete..."

# copy package.json and package-lock.json for single exercise
copy-package-file:
	@cp package.json exercises/practice/$(EXERCISE)/package.json
	@cp package-lock.json exercises/practice/$(EXERCISE)/package-lock.json
	@cp rescript.json exercises/practice/$(EXERCISE)/rescript.json
	
# copy package files to all exercise directories
sync-package-files:
	@echo "Syncing package.json and package-lock.json..."
	@for exercise in $(EXERCISES); do EXERCISE=$$exercise $(MAKE) -s copy-package-file || exit 1; done

copy-exercise:
	if [ -f exercises/practice/$(EXERCISE)/src/*.res ]; then \
		echo "Copying $(EXERCISE)"; \
        	cp exercises/practice/$(EXERCISE)/.meta/*.res $(OUTDIR)/src/; \
        	cp exercises/practice/$(EXERCISE)/tests/*.res $(OUTDIR)/tests/; \
	fi

copy-all-exercises:
	@echo "Copying exercises for testing..."
	@mkdir -p $(OUTDIR)/src
	@mkdir -p $(OUTDIR)/tests
	@for exercise in $(EXERCISES); do EXERCISE=$$exercise $(MAKE) -s copy-exercise || exit 1; done

# Remove the OUTDIR
clean:
	@echo "Cleaning tmp directory..."
	@rm -rf $(OUTDIR)

# Format all ReScript files in the project
format:
	@echo "Formatting ReScript files..."
	@find . -name "node_modules" -prune -o -name "*.res" -print -o -name "*.resi" -print | xargs npx rescript format

test:
	$(MAKE) -s clean
	$(MAKE) -s check-package-files
	$(MAKE) -s copy-all-exercises
	npm run ci