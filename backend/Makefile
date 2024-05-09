-include .env.develop

START_LOG = @echo "================================================= START OF LOG ==================================================="
END_LOG = @echo "================================================== END OF LOG ===================================================="

.PHONY: env
env: ./.env.develop.tmpl
	$(START_LOG)
	@cp ./.env.develop.tmpl ./.env.develop
	@echo "Environment file created at ./.env.develop"
	$(END_LOG)

.PHONY: infra
infra:
	$(START_LOG)
	@docker compose \
<<<<<<< HEAD
		-f ./deployments/compose.infra.yaml up \
		--build -d
=======
         -f ./deployments/compose.packages.yaml \
         --env-file ./.env.develop \
         up --build

>>>>>>> aac7334f593b3b23917d753411f389f9cfc54872
	@echo "Creating kafka topics..."
	@sleep 30
	@docker compose \
		-f ./deployments/compose.infra.yaml exec \
		kafka kafka-topics --bootstrap-server kafka:9094 \
		--create --topic orders \
		--partitions 10
	$(END_LOG)

<<<<<<< HEAD
.PHONY: dev
dev:
=======
.PHONY: run
run:
>>>>>>> aac7334f593b3b23917d753411f389f9cfc54872
	$(START_LOG)
	@docker compose \
		-f ./deployments/compose.packages.yaml up \
		--build -d
<<<<<<< HEAD
	$(END_LOG)

.PHONY: swagger
swagger:
	$(START_LOG)
	@cd ./cmd/server && swag init --output ./api
=======
>>>>>>> aac7334f593b3b23917d753411f389f9cfc54872
	$(END_LOG)