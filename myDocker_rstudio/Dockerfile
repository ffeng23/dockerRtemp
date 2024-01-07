####this is the one to do read and write 
#    used in combination with compose.yml file.
#      (we don't have to do in combination, but we could)
#	https://www.robertmylesmcdonnell.com/content/posts/docker/
# but we do convert not to use yaml (docker compose)
#	but only use docker to add named volumes
FROM rocker/rstudio
#create a folder in container and entering it.
#something it is not working well at the root directory.
WORKDIR /main/app
#note about directory, we use the bind volume to the container volum main
#we do this binding with the docker run command switches -w /main -v "$(pwd):/main" 
# At running time (not compiling/building time)
#  docker run \
#     -w /main -v "$(pwd):/main" \
#     -it "readwrite"
# #building:
# docker build -t readwrite .
#RUN touch little_script.R
RUN apt-get update && apt-get install -y --no-install-recommends libxt6
  
#add current directory to show in the print.
#RUN echo "print('hi, every-body!$(pwd)')" >> little_script.R
#RUN echo "created an R file. now running.....!!\n"
#CMD ["Rscript", "readwrite.R"]
