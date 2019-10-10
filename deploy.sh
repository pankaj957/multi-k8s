docker build -t pankaj957/multi-client:latest -t pankaj957/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t pankaj957/multi-server:latest -t pankaj957/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t pankaj957/multi-worker:latest -t pankaj957/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push pankaj957/multi-client:latest
docker push pankaj957/multi-server:latest
docker push pankaj957/multi-worker:latest

docker push pankaj957/multi-client:$SHA
docker push pankaj957/multi-server:$SHA
docker push pankaj957/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=pankaj957/multi-server:$SHA
kubectl set image deployments/client-deployment client=pankaj957/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=pankaj957/multi-worker:$SHA