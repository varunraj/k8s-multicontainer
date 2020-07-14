docker build -t varunrajdocker/multi-client:latest -t varunrajdocker/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t varunrajdocker/multi-server:latest -t varunrajdocker/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t varunrajdocker/multi-worker:latest -t varunrajdocker/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push varunrajdocker/multi-client:latest
docker push varunrajdocker/multi-server:latest
docker push varunrajdocker/multi-worker:latest

docker push varunrajdocker/multi-client:$SHA
docker push varunrajdocker/multi-server:$SHA
docker push varunrajdocker/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=varunrajdocker/multi-server:$SHA
kubectl set image deployments/client-deployment client=varunrajdocker/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=varunrajdocker/multi-worker:$SHA