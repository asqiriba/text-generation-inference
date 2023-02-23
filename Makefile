install-server:
	cd server && make install

install-router:
	cd router && cargo install --path .

install-launcher:
	cd launcher && cargo install --path .

install: install-server install-router install-launcher

server-dev:
	cd server && make run-dev

router-dev:
	cd router && cargo run

integration-tests: install-router install-launcher
	cargo test

python-tests:
	cd server && pytest tests

run-bloom-560m:
	text-generation-launcher --model-id bigscience/bloom-560m --num-shard 2

run-bloom-560m-quantize:
	text-generation-launcher --model-id bigscience/bloom-560m --num-shard 2 --quantize

download-bloom:
	text-generation-server download-weights bigscience/bloom

run-bloom:
	text-generation-launcher --model-id bigscience/bloom --num-shard 8

run-bloom-quantize:
	text-generation-launcher --model-id bigscience/bloom --num-shard 8 --quantize

docker-build:
	docker build . -t new-nebula
	
docker-run:
	docker run -it --rm --gpus all --shm-size 1g -p 7070:80 -v $volume:/data -t new-nebula --model-id EleutherAI/gpt-j-6B
