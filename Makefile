SOURCE_DIR=public/
DISTRIBUTION_ID=EZLUSUK2I41W0
BUCKET=www.baty.net

build:
	@echo "\033[0;32mBuilding site...\033[0m"
	@hugo

upload:
	@echo "\033[0;32mDeploying updates to S3 bucket...\033[0m"
	@s3deploy -bucket=$(BUCKET) -region=us-east-1 -source=$(SOURCE_DIR)

server:
	@hugo server

invalidate:
	@echo "\033[0;32mInvalidating caches...\033[0m"
	@aws cloudfront create-invalidation --distribution-id=$(DISTRIBUTION_ID) --paths /index.html /index.xml "/page/*" "/post/"

deploy: build commit push

commit:
	@echo "\033[0;32mCommiting changes to git...\033[0m"
	@git add -A
	-@git commit -m "Build site `date`"

push:
	@echo "\033[0;32mPushing to Github...\033[0m"
	@git push origin master

save: commit push

clean:
	rm -rf $(PUBLIC_DIR)

.FORCE:
