docker build -t johancblom/multi-client:latest -t johancblom/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t johancblom/multi-server:latest -t johancblom/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t johancblom/multi-worker:latest -t johancblom/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push johancblom/multi-client:latest
docker push johancblom/multi-server:latest
docker push johancblom/multi-worker:latest

docker push johancblom/multi-client:$SHA
docker push johancblom/multi-server:$SHA
docker push johancblom/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=johancblom/multi-server:$SHA
kubectl set image deployments/client-deployment client=johancblom/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=johancblom/multi-worker:$SHA