START_LOG = @echo "================================================= START OF LOG ==================================================="
END_LOG = @echo "================================================== END OF LOG ===================================================="

.PHONY: env
env: ./.env.develop.tmpl
	$(START_LOG)
	@cp ./.env.develop.tmpl ./.env
	@echo "Environment file created at ./.env.develop"
	$(END_LOG)

.PHONY: infra
infra:
	$(START_LOG)
	@docker compose \
		-f ../docker-compose.yml up \
		--build -d
	@echo "Creating kafka topics..."
	@sleep 30
	@docker compose \
		-f ../docker-compose.yml exec \
		kafka kafka-topics --bootstrap-server kafka:9094 \
		--create --topic orders \
		--partitions 10
	$(END_LOG)

.PHONY: run
run:
	$(START_LOG)
	@docker compose \
		-f ./deployments/compose.packages.yaml up \
		--build -d
	$(END_LOG)

.PHONY: swagger
swagger:
	$(START_LOG)
	@cd ./cmd/server && swag init --output ./api
	$(END_LOG)