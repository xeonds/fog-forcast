NAME=fog-forcast
BINDIR=build
VERSION=1.0.0
BUILDTIME=$(shell date -u)
GOBUILD=cd server && go mod tidy && go build -ldflags '-s -w -X "main.version=$(VERSION)" -X "main.buildTime=$(BUILDTIME)"'

.PHONY: app init

all: linux-amd64 windows-amd64 app

linux-amd64: 
	GOOS=linux GOARCH=amd64 $(GOBUILD) -o ../$(BINDIR)/$(NAME)-$@

windows-amd64: 
	GOOS=windows GOARCH=amd64 $(GOBUILD) -o ../$(BINDIR)/$(NAME)-$@.exe

app:
	(cd app && fvm flutter build apk --release --split-per-abi ) && \
	(mv ./app/build/app/outputs/apk/release/* ./build)

run:
	cd $(BINDIR) && ./$(NAME)-linux-amd64

deploy: linux-amd64
	docker-compose up -d

init:
	(mkdir -p $(BINDIR)) & \
	(cd server && go mod tidy) & \
	(cd app && fvm flutter pub get)

clean:
	rm -rf $(BINDIR)/$(NAME)-* $(BINDIR)/app-*
