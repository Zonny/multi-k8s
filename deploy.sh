docker build -t ajvieyra/multi-client:latest -t ajvieyra/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ajvieyra/multi-server:latest -t ajvieyra/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ajvieyra/multi-worker:latest -t ajvieyra/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ajvieyra/multi-client:latest
docker push ajvieyra/multi-client:$SHA
docker push ajvieyra/multi-server:latest
docker push ajvieyra/multi-server:$SHA
docker push ajvieyra/multi-worker:latest
docker push ajvieyra/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ajvieyra/multi-server:$SHA
kubectl set image deployments/client-deployment client=ajvieyra/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ajvieyra/multi-worker:$SHA
