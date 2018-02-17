PUBLIC_DIR=public/
SERVER_HOST=do.baty.net
SERVER_DIR=/srv/users/serverpilot/apps/batydotnet/public/
#TARGET=netlify
TARGET=digitalocean



build:
		hugo

server:
		hugo server

deploy: build commit push
		@echo "\033[0;32mDeploying updates to $(TARGET)...\033[0m"
ifeq "$(TARGET)" "netlify"
	curl -X POST -d '{}' https://api.netlify.com/build_hooks/59d91b4d0b79b73216fa708c
	@echo "You're all set, just hang tight"

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
