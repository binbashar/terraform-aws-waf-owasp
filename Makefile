.PHONY: help
SHELL         := /bin/bash
MAKEFILE_PATH := ./Makefile
MAKEFILES_DIR := ./@bin/makefiles

PROJECT_SHORT                    := bb

LOCAL_OS_USER_ID                 := $(shell id -u)
LOCAL_OS_GROUP_ID                := $(shell id -g)
LOCAL_OS_SSH_DIR                 := ~/.ssh
LOCAL_OS_GIT_CONF_DIR            := ~/.gitconfig
LOCAL_OS_AWS_CONF_DIR            := ~/.aws/${PROJECT_SHORT}

TF_PWD_DIR                       := $(shell pwd)
TF_PWD_CONT_DIR                  := "/go/src/project/"
TF_VER                           := 0.12.28
TF_DOCKER_ENTRYPOINT             := /usr/local/go/bin/terraform
TF_DOCKER_IMAGE                  := binbash/terraform-awscli

define TF_CMD_PREFIX
docker run --rm \
-v ${TF_PWD_DIR}:${TF_PWD_CONT_DIR}:rw \
-v ${LOCAL_OS_SSH_DIR}:/root/.ssh \
-v ${LOCAL_OS_GIT_CONF_DIR}:/etc/gitconfig \
-v ${LOCAL_OS_AWS_CONF_DIR}:/root/.aws/${PROJECT_SHORT} \
-e AWS_SHARED_CREDENTIALS_FILE=/root/.aws/${PROJECT_SHORT}/credentials \
-e AWS_CONFIG_FILE=/root/.aws/${PROJECT_SHORT}/config \
--entrypoint=${TF_DOCKER_ENTRYPOINT} \
-w ${TF_PWD_CONT_DIR} \
-it ${TF_DOCKER_IMAGE}:${TF_VER}
endef

help:
	@echo 'Available Commands:'
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf " - \033[36m%-18s\033[0m %s\n", $$1, $$2}'

#==============================================================#
# INITIALIZATION                                               #
#==============================================================#
init-makefiles: ## initialize makefiles
	rm -rf ${MAKEFILES_DIR}
	mkdir -p ${MAKEFILES_DIR}
	git clone https://github.com/binbashar/le-dev-makefiles.git ${MAKEFILES_DIR}
	echo "" >> ${MAKEFILE_PATH}
	sed -i '/^#include.*/s/^#//' ${MAKEFILE_PATH}

#
## IMPORTANT: Automatically managed
## Must NOT UNCOMMENT the #include lines below
#
#include ${MAKEFILES_DIR}/circleci/circleci.mk
#include ${MAKEFILES_DIR}/release-mgmt/release.mk

#==============================================================#
# TERRAFORM                                                    #
#==============================================================#
version: ## Show terraform version
	docker run --rm \
	--entrypoint=${TF_DOCKER_ENTRYPOINT} \
	-t ${TF_DOCKER_IMAGE}:${TF_VER} version

format: ## The terraform fmt is used to rewrite tf conf files to a canonical format and style.
	${TF_CMD_PREFIX} fmt -recursive

format-check: ## The terraform fmt is used to rewrite tf conf files to a canonical format and style.
	${TF_CMD_PREFIX} fmt -check
    # Consider adding -recursive after everything has been migrated to tf-0.12
	# (should exclude dev/8_k8s_kops/2-kops folder since it's not possible to migrate to
	# tf-0.12 yet
	# ${TF_CMD_PREFIX} fmt -recursive -check ${TF_PWD_CONT_DIR}

tflint: ## TFLint is a Terraform linter for detecting errors that can not be detected by terraform plan (tf0.12 > 0.10.x).
	docker run --rm \
	-v ${LOCAL_OS_AWS_CONF_DIR}:/root/.aws \
	-v ${TF_PWD_DIR}:/data \
	-t wata727/tflint:0.14.0

tflint-deep: ## TFLint is a Terraform linter for detecting errors that can not be detected by terraform plan (tf0.12 > 0.10.x).
	docker run --rm \
	-v ${LOCAL_OS_AWS_CONF_DIR}:/root/.aws \
	-v ${TF_PWD_DIR}:/data \
	-t wata727/tflint:0.14.0 --deep \
	--aws-profile=${LOCAL_OS_AWS_PROFILE} \
	--aws-creds-file=/root/.aws/credentials \
	--aws-region=${LOCAL_OS_AWS_REGION}
