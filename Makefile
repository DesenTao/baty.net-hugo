PUBLIC_DIR=public/
SERVER_HOST=do.baty.net
SERVER_DIR=/srv/users/serverpilot/apps/batydotnet/public/
#TARGET=netlify
#TARGET=digitalocean
TARGET=s3



build:
		hugo

server:
		hugo server

deploy: build commit push
		@echo "\033[0;32mDeploying updates to $(TARGET)...\033[0m"
ifeq "$(TARGET)" "s3"
    s3deploy -bucket=www.baty.net -region=us-east-1 -source=public/
else
    rsync -v -rz -e "ssh -l serverpilot" --checksum --delete --no-perms $(PUBLIC_DIR) $(SERVER_HOST):$(SERVER_DIR)
endif

commit:
		git add -A
		git commit -m "Build site `date`"

push:
		git push origin master

clean:
		rm -rf $(PUBLIC_DIR)

.FORCE:
