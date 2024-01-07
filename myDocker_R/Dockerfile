#My first R docker file with R
FROM r-base:3.4.3
#create a folder in container and entering it.
#something it is not working well at the root directory.
WORKDIR /app/r_stuff 
RUN touch little_script.R
#add current directory to show in the print.
RUN echo "print('hi, every-body!$(pwd)')" >> little_script.R
RUN echo "created an R file. now running.....!!\n"
CMD ["Rscript", "little_script.R"]