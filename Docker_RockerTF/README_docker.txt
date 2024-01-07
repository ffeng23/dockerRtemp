###################################################################
# for docker with rocker/cuda, Dockerfile.workingRcmd_TF          #
###################################################################

## to build
docker build . -t test_tf2 -f Dockerfile.workingRcmd_TF 

    
## to run
docker run --rm -ti -p 8787:8787 --gpus all test_tf2

### docker compose with yaml
        docker-compose_Rcmd.yml

(it is better to use compose, since it will change permission and have volume/bind)
see below.


################################################################
# for docker with rocker/ml, Dockerfile.workRenvGPU            #
################################################################

## to build
docker build . -t test_tf4 -f Dockerfile.workRenvGPU 


## to run
docker run --rm -ti -p 8787:8787 --gpus all test_tf4

## to run with persistent data
#  first with named volume, for deployed testing. 
docker run --rm -ti -p 8787:8787 --gpus all -v tf2:/home/rstudio/keras_r -e USERID=1000 test_tf4
    
    #the yaml version
    docker-compose_volume.yaml

# with local mount for local development
docker run --rm -ti -p 8787:8787 --gpus all -v ./:/home/rstudio/keras_r -e USERID=1000 test_tf4
    
    #the yaml version
    docker-compose.yaml
    
#### Note: yaml version is better, because it changed id of the rstudio, so that it
#works out the file permission for read/write and allow the newly created 
# files on local have no issues either for local host user.
    
## need to really be careful here. It seems that 

### after running and making changes, docker commit only works to update/save some
#changes, but not for data or volume (? need to confirm).
#

docker commit #<-no good idea
