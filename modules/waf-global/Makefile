.PHONY: help
SHELL := /bin/bash
LOCAL_OS_USER := $(shell whoami)
LOCAL_OS_SSH_DIR := ~/.ssh
LOCAL_OS_GIT_CONF_DIR := ~/.gitconfig
LOCAL_OS_AWS_CONF_DIR := ~/.aws

TF_PWD_DIR := $(shell pwd)
TF_VER := 0.11.14
TF_PWD_CONT_DIR := "/go/src/project/"
TF_DOCKER_ENTRYPOINT := /usr/local/go/bin/terraform
TF_DOCKER_IMAGE := binbash/terraform-resources

TERRATEST_DOCKER_ENTRYPOINT := dep
TERRATEST_DOCKER_WORKDIR := /go/src/project/tests

#
# TERRAFORM
#
define TF_CMD_PREFIX
docker run --rm \
-v ${TF_PWD_DIR}:${TF_PWD_CONT_DIR}:rw \
--entrypoint=${TF_DOCKER_ENTRYPOINT} \
-it ${TF_DOCKER_IMAGE}:${TF_VER}
endef

#
# TERRATEST
#
define TERRATEST_GO_CMD_PREFIX
docker run --rm \
-v ${TF_PWD_DIR}:${TF_PWD_CONT_DIR}:rw \
-v ${LOCAL_OS_SSH_DIR}:/root/.ssh \
-v ${LOCAL_OS_GIT_CONF_DIR}:/etc/gitconfig \
-v ${LOCAL_OS_AWS_CONF_DIR}:/root/.aws \
-w ${TERRATEST_DOCKER_WORKDIR} \
-it ${TF_DOCKER_IMAGE}:${TF_VER}
endef

define TERRATEST_DEP_CMD_PREFIX
docker run --rm \
-v ${TF_PWD_DIR}:${TF_PWD_CONT_DIR}:rw \
-v ${LOCAL_OS_SSH_DIR}:/root/.ssh \
-v ${LOCAL_OS_GIT_CONF_DIR}:/etc/gitconfig \
--entrypoint=${TERRATEST_DOCKER_ENTRYPOINT} \
-it ${TF_DOCKER_IMAGE}:${TF_VER}
endef

#
# GIT-RELEASE
#
# pre-req -> https://github.com/pnikosis/semtag
define GIT_SEMTAG_CMD_PREFIX
docker run --rm \
-v ${TF_PWD_DIR}:/data:rw \
-v ${LOCAL_OS_SSH_DIR}:/root/.ssh \
-v ${LOCAL_OS_GIT_CONF_DIR}:/etc/gitconfig \
--entrypoint=/opt/semtag/semtag/semtag \
-it binbash/git-release
endef

GIT_SEMTAG_VER_PATCH := $(shell ${GIT_SEMTAG_CMD_PREFIX} final -s patch -o)
GIT_SEMTAG_VER_MINOR := $(shell ${GIT_SEMTAG_CMD_PREFIX} final -s minor -o)
GIT_SEMTAG_VER_MINOR := $(shell ${GIT_SEMTAG_CMD_PREFIX} final -s major -o)

help:
	@echo 'Available Commands:'
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf " - \033[36m%-18s\033[0m %s\n", $$1, $$2}'


#==============================================================#
# TERRAFORM 												   #
#==============================================================#
version: ## Show terraform version
	docker run --rm \
	--entrypoint=${TF_DOCKER_ENTRYPOINT} \
	-t ${TF_DOCKER_IMAGE}:${TF_VER} version

format: ## The terraform fmt is used to rewrite tf conf files to a canonical format and style.
	${TF_CMD_PREFIX} fmt ${TF_PWD_CONT_DIR}

doc: ## A utility to generate documentation from Terraform modules in various output formats.
	docker run --rm -v ${TF_PWD_DIR}:/data -t binbash/terraform-docs markdown table /data

lint: ## TFLint is a Terraform linter for detecting errors that can not be detected by terraform plan.
	docker run --rm -v ${TF_PWD_DIR}:/data -t wata727/tflint --deep


#==============================================================#
# TERRATEST 												   #
#==============================================================#
terratest-dep-init: ## dep is a dependency management tool for Go. (https://github.com/golang/dep)
	${TERRATEST_DEP_CMD_PREFIX} init
	${TERRATEST_DEP_CMD_PREFIX} ensure
	sudo chown -R ${LOCAL_OS_USER}:${LOCAL_OS_USER} .
	cp -r ./vendor ./tests/ && rm -rf ./vendor
	cp -r ./Gopkg* ./tests/ && rm -rf ./Gopkg*

terratest-go-test: ## lint: TFLint is a Terraform linter for detecting errors that can not be detected by terraform plan.
	${TERRATEST_GO_CMD_PREFIX} test
	sudo chown -R ${LOCAL_OS_USER}:${LOCAL_OS_USER} .

#==============================================================#
# GIT RELEASE 												   #
#==============================================================#
release-patch: ## releasing patch (eg: 0.0.1 -> 0.0.2) based on semantic tagging script for Git
	# pre-req -> https://github.com/pnikosis/semtag
	${GIT_SEMTAG_CMD_PREFIX} get
	sudo chown -R ${LOCAL_OS_USER}:${LOCAL_OS_USER} ./.git
	${GIT_SEMTAG_CMD_PREFIX} final -s patch

release-minor: ## releasing minor (eg: 0.0.2 -> 0.1.0) based on semantic tagging script for Git
	# pre-req -> https://github.com/pnikosis/semtag
	${GIT_SEMTAG_CMD_PREFIX} get
	sudo chown -R ${LOCAL_OS_USER}:${LOCAL_OS_USER} ./.git
	${GIT_SEMTAG_CMD_PREFIX} final -s minor

release-major: ## releasing major (eg: 0.1.0 -> 1.0.0) based on semantic tagging script for Git
	# pre-req -> https://github.com/pnikosis/semtag
	${GIT_SEMTAG_CMD_PREFIX} get
	sudo chown -R ${LOCAL_OS_USER}:${LOCAL_OS_USER} ./.git
	${GIT_SEMTAG_CMD_PREFIX} final -s major

changelog-init: ## git-chglog (https://github.com/git-chglog/git-chglog) config initialization -> ./.chglog
	@if [ ! -d ./.chglog ]; then\
		docker run --rm -v ${TF_PWD_DIR}:/data -it binbash/git-release --init;\
		sudo chown -R ${LOCAL_OS_USER}:${LOCAL_OS_USER} ./.chglog;\
	else\
		  echo "==============================";\
    	echo "git-chglog already initialized";\
    	echo "==============================";\
    	echo "$$(ls ./.chglog)";\
    	echo "==============================";\
	fi

changelog-patch: ## git-chglog generation for path release
	docker run --rm -v ${TF_PWD_DIR}:/data -it binbash/git-release -o CHANGELOG.md --next-tag ${GIT_SEMTAG_VER_PATCH}
	sudo chown -R ${LOCAL_OS_USER}:${LOCAL_OS_USER} ./.chglog
	sudo chown -R ${LOCAL_OS_USER}:${LOCAL_OS_USER} ./.git
	sudo chown -R ${LOCAL_OS_USER}:${LOCAL_OS_USER} ./CHANGELOG.md

changelog-minor: ## git-chglog generation for minor release
	docker run --rm -v ${TF_PWD_DIR}:/data -it binbash/git-release -o CHANGELOG.md --next-tag ${GIT_SEMTAG_VER_MINOR}
	sudo chown -R ${LOCAL_OS_USER}:${LOCAL_OS_USER} ./.chglog
	sudo chown -R ${LOCAL_OS_USER}:${LOCAL_OS_USER} ./.git
	sudo chown -R ${LOCAL_OS_USER}:${LOCAL_OS_USER} ./CHANGELOG.md

changelog-major: ## git-chglog generation for major release
	docker run --rm -v ${TF_PWD_DIR}:/data -it binbash/git-release -o CHANGELOG.md --next-tag ${GIT_SEMTAG_VER_MAJOR}
	sudo chown -R ${LOCAL_OS_USER}:${LOCAL_OS_USER} ./.chglog
	sudo chown -R ${LOCAL_OS_USER}:${LOCAL_OS_USER} ./.git
	sudo chown -R ${LOCAL_OS_USER}:${LOCAL_OS_USER} ./CHANGELOG.md