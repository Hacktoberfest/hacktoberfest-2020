GIT_COMMIT = $(shell git rev-parse HEAD 2>/dev/null)
GIT_BRANCH = $(shell git rev-parse --abbrev-ref HEAD 2>/dev/null)

### Stage2 targets
# A convenience target to allow use of either `deploy-staging` or
# `deploy-stage2` as a staging deploy
.PHONY: deploy-staging
deploy-staging: deploy-stage2

.PHONY: deploy-stage2
deploy-stage2:
	git push origin $(GIT_BRANCH):staging -f

### Production targets
.PHONY: deploy-production
deploy-production:
	git push origin $(GIT_BRANCH):production -f