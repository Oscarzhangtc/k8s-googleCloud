docker build -t oscarzzz/multi-client:latest -t oscarzzz/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t oscarzzz/multi-server:latest -t oscarzzz/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t oscarzzz/multi-worker:latest -t oscarzzz/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push oscarzzz/multi-client:latest
docker push oscarzzz/multi-server:latest
docker push oscarzzz/multi-worker:latest

docker push oscarzzz/multi-client:$SHA
docker push oscarzzz/multi-server:$SHA
docker push oscarzzz/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=oscarzzz/multi-server:$SHA
kubectl set image deployments/client-deployment client=oscarzzz/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=oscarzzz/multi-worker:$SHA
