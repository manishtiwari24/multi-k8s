docker build -t mtiwari24/multi-client:latest -t mtiwari24/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mtiwari24/multi-server:latest -t mtiwari24/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mtiwari24/multi-worker:latest -t mtiwari24/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mtiwari24/multi-client:latest
docker push mtiwari24/multi-server:latest
docker push mtiwari24/multi-worker:latest

docker push mtiwari24/multi-client:$SHA
docker push mtiwari24/multi-server:$SHA
docker push mtiwari24/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=mtiwari24/multi-client:$SHA
kubectl set image deployments/server-deployment server=mtiwari24/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=mtiwari24/multi-worker:$SHA
