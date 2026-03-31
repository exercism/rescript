.DEFAULT_GOAL := test

EXERCISE ?= ""
EXERCISES = $(shell find ./exercises/practice -maxdepth 1 -mindepth 1 -type d | cut -s -d '/' -f4 | sort)
OUTDIR ?= "tmp"

# Define the files you want to ensure are synced across all exercises
FILES_TO_CHECK = package.json package-lock.json rescript.json .gitignore LICENSE

# Camel to Pascal case utility
TO_PASCAL = $(shell echo "$(1)" | sed -E 's/[-_]/ /g' | awk '{for(i=1;i<=NF;i++)sub(/./,toupper(substr($$i,1,1)),$$i)}1' | sed 's/ //g')

# check all exercise files that need to be in sync
check-exercise-files:
	@for exercise in $(EXERCISES); do \
		echo "Checking exercise: $$exercise"; \
		for file in $(FILES_TO_CHECK); do \
			target="exercises/practice/$$exercise/$$file"; \
			\
			# Map the source template path \
			if [ -f "./templates/$$file" ]; then \
				source="./templates/$$file"; \
			else \
				source="./$$file"; \
			fi; \
			\
			# 1. Check if the file exists \
			if [ ! -f "$$target" ]; then \
				echo "ERROR: Missing file $$file in $$exercise. Run make sync-exercise-files and commit the changes."; \
				exit 1; \
			fi; \
			\
			# 2. Check if the content matches (ignoring name/version) \
			if [ "$$file" != ".meta/testTemplate.js" ]; then \
				diff -q -I '"name":' -I '"version":' "$$source" "$$target" > /dev/null || { \
					echo "ERROR: $$target does not match template $$source."; \
					diff -u -I '"name":' -I '"version":' "$$source" "$$target" | head -n 20; \
					exit 1; \
				}; \
			fi; \
		done; \
	done
	@echo "All exercises contain all required files and are in sync."

add-test-template:
	@$(eval PASCAL_EXERCISE=$(shell echo $(EXERCISE) | sed -r 's/(^|-)([a-z])/\U\2/g'))
	@cp templates/Test_template.res test_templates/$(PASCAL_EXERCISE)_template.res
	@echo "Copied $(PASCAL_EXERCISE)Template.res to $(EXERCISE)"

# copy all relevant files for a single exercise - test template, config etc.
copy-exercise-files:
	@cp package.json exercises/practice/$(EXERCISE)/package.json
	@cp package-lock.json exercises/practice/$(EXERCISE)/package-lock.json
	@cp templates/rescript.json exercises/practice/$(EXERCISE)/rescript.json
	@cp templates/.gitignore exercises/practice/$(EXERCISE)/.gitignore
	@cp LICENSE exercises/practice/$(EXERCISE)/LICENSE

# sync all files for each exercise directory
sync-exercise-files:
	@echo "Syncing exercise files..."
	@for exercise in $(EXERCISES); do EXERCISE=$$exercise $(MAKE) -s copy-exercise-files || exit 1; done

# copy single exercise build artifacts for testing
copy-exercise:
	if [ -f exercises/practice/$(EXERCISE)/src/*.res ]; then \
		echo "Copying $(EXERCISE)"; \
        	cp exercises/practice/$(EXERCISE)/.meta/*.res $(OUTDIR)/src/; \
			cp exercises/practice/$(EXERCISE)/.meta/*.resi $(OUTDIR)/src/; \
        	cp exercises/practice/$(EXERCISE)/tests/*.res $(OUTDIR)/tests/; \
	fi

# copy build artifacts for testing
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

# Generate tests for all exercises
generate-tests:
	@echo "Generating tests from test_templates directory..."
	@for template in $(wildcard test_templates/*_template.res.js); do \
		echo "-> Running template: $$template"; \
		node $$template || exit 1; \
	done
	@echo "Formatting files"
	npm run res:format-fix
	@echo "All tests generated and formatted successfully."

# Generate test for exercise
generate-test:
ifeq ($(EXERCISE),)
	$(error EXERCISE variable is required. usage: make generate-test EXERCISE=hello-world)
endif
	@# 1. Replace hyphens/underscores with spaces 
	@# 2. Capitalize first letter of every word
	@# 3. Remove spaces
	$(eval PASCAL_EXERCISE=$(shell echo "$(EXERCISE)" | sed -E 's/[-_]/ /g' | awk '{for(i=1;i<=NF;i++)sub(/./,toupper(substr($$i,1,1)),$$i)}1' | sed 's/ //g'))
	
	@if [ ! -f "test_templates/$(PASCAL_EXERCISE)_template.res.js" ]; then \
		echo "Error: Template 'test_templates/$(PASCAL_EXERCISE)_template.res.js' not found (converted from '$(EXERCISE)')"; \
		exit 1; \
	fi
	
	@echo "-> Running template: test_templates/$(PASCAL_EXERCISE)_template.res.js"
	@node test_templates/$(PASCAL_EXERCISE)_template.res.js || exit 1
	npm run res:format-fix

# Test a single exercise - e.g. make test-one EXERCISE=eliuds-eggs
test-one:
	$(MAKE) -s check-exercise-files
	$(MAKE) -s copy-all-exercises
	npm run test:only -- tmp/tests/$(call TO_PASCAL,$(EXERCISE))_test.res.js

test:
	$(MAKE) -s clean
	$(MAKE) -s check-exercise-files
	$(MAKE) -s copy-all-exercises
	npm run ci