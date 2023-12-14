PROJECT_DIR = $(realpath $(dir $(lastword $(MAKEFILE_LIST))))

DOCKER_IMAGE = cuda-pytorch-image

.PHONY: all
all: help
	# Do nothing

.PHONY: help
help: ## This is help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-$(HELP_WIDTH)s\033[0m %s\n", $$1, $$2}'

.PHONY: clean
clean: ## Clean untracked files.
	git clean -dfx

.PHONY: build
build: ## Docker build
	docker build -t $(DOCKER_IMAGE) -f Dockerfile-cuda .

.PHONY: run
run: ## Docker run
	docker run -it \
		-v $(PWD)/run.py:/workspace/run.py \
		--name docker-example \
		--rm \
		--shm-size=20g \
		-w /workspace \
		--gpus all \
		$(DOCKER_IMAGE) bash
