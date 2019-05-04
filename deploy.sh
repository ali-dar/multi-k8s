docker build -t alidar/multi-client:latest -t alidar/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t alidar/multi-server:latest -t alidar/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t alidar/multi-worker:latest -t alidar/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push alidar/multi-client:latest
docker push alidar/multi-server:latest
docker push alidar/multi-worker:latest

docker push alidar/multi-client:$SHA
docker push alidar/multi-server:$SHA
docker push alidar/multi-worker:$SHA


 kubectl apply -f k8s
 kubectl set image deployments/server-deployment server=alidar/multi-server:$SHA
 kubectl set image deployments/client-deployment client=alidar/multi-client:$SHA
 kubectl set image deployments/worker-deployment worker=alidar/multi-worker:$SHA