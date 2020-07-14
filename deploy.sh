docker build -t varunraj/multi-client:latest -t varunraj/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t varunraj/multi-server:latest -t varunraj/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t varunraj/multi-worker:latest -t varunraj/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push varunraj/multi-client:latest
docker push varunraj/multi-server:latest
docker push varunraj/multi-worker:latest

docker push varunraj/multi-client:$SHA
docker push varunraj/multi-server:$SHA
docker push varunraj/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=varunraj/multi-server:$SHA
kubectl set image deployments/client-deployment client=varunraj/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=varunraj/multi-worker:$SHA