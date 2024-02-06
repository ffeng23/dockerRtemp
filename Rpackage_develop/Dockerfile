#From r-base:4.3.2
From rocker/r-ver:4.3.1

ENV PATH="$PATH:/root/bin"

RUN apt-get update && apt-get install -y libxt6 pandoc perl wget pandoc-citeproc \
    ghostscript qpdf
    
RUN R -e "install.packages(c('devtools','R2HTML','minpack.lm','tinytex','rmarkdown'))"


RUN R -e "tinytex::install_tinytex()"

#RUN apt-get update && apt-get install pandoc-citeproc

#RUN R -e "devtools::document(); 
#devtools::install('.',build=T, build_vignettes=T)"


# rmarkdown tex dependencies
RUN tlmgr update --self
RUN tlmgr install inter titling lastpage fancyhdr setspace \
    colortbl multirow wrapfig dejavu
    
#copy  contents of packages

WORKDIR /App/package


COPY . ./
#ADD R ./R
#ADD inst/extdata ./inst/extdata
#ADD vignettes ./vignettes

#COPY DESCRIPTION ./
#ADD LICENSE ./
#ADD NAMESPACE ./
#ADD README.md ./

#run the docker 
# docker run -it elisatools 
