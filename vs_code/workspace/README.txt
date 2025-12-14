# ReadMe

## extensions

We need to install the following extensions in VS code server:

+ REditor Support, R extension for vs code

+ Quarto, if we want to do Quarto

+ Python for VSCode (tht13)  <- this might not be good. try "ms-Python" instead

+ Jupyter, Jupyther notebook support, interactive programming and computing...
(ms-toolsai)
It comes in with other 4 extensions,
  
  - Jupyter Cell Tags

  - Jupyter Keymap

  - Jupyter Notebook Renderer

  - Jupyter slide Show

+ pdf-viewer if we want to diplay pdf files (vscode-pdf tomoki1207)

Again, these extensions need to be installed in the VS code server interface (, instead 
if we run vs code, we could do commandline at the docker building time with command like
    code install <extension-name>
)

vscode-pdf by tomoki1207 doesn't work on vs code web version. install pdf-viewer by mathematica(?)



+ "live preview" by ms-code

For a html, we need to install extension "live preview" (by ms-vscode), then
to preview, right click the html file in the explorer and select "show preview".

Note: "open in browser" extension doesn't work in web vs-code(???). Always give 
out the "open browser fail..." error (something like that).


## Quarto 

+ need to install Quarto at the system wide, VS code needs also Quarto extension (see above)

+ need to install tinytex in order to render pdf output.

+ if want to mix both python and R code, we need to do either

  - with "engine:knitr" and then install R reticulate to render python code 

  - with "jupyter: python3" and then do rpy2 to render r code in pyhton.

**meaning quarto can not automatically figure out code chunk with 2 engines.**


### commands

+ ctrl+shift p -> quarto: Preview

+ ctrl_shift p -> quarto: Render Document, and then follow the prompt


## R 

add the tag "engine: knitr"

need to install r-base system-wise

also renv works in this project. 

need to install and arrange renv at the project/folder level.
and add R extension (REditorSupport, see above)

### commands

+ ctrl+shift p -> R: Create terminal


## Python

add the tag "jupyter: python3" in quarto file

we need to jupyter with engine python3. 
so we need to install at the systme jupyter-notebook 
(apt install python3-pip jupyter-notebook python3-yaml)

need the jupyter extension (see above)

### commands

(need to figure out using "uv" to manage the dependencies later ) <----


## File permissions

file permissions here is weird in this case. 

Even thought in this case, we try to match the file id at the build time, it is the vs code "messing" up
the ids/permissions, since it is out of different file system (ms pc fat???)

So the end result is that the file permission will never match the host permission. We can not directly modify 
the files on the host (might through root privilege). So we have to go throught vs code and do version control through
vs on the container. (git see below)

-----------------
## version control

due to file permissio issues (see above), we have to do through vs-code interface. Good or bad. don't know.

will figure this out later.

(need to be careful about this with dockerfile and docker compose at the root of the folder!!!!)


-----------------
## structure of the folder and vs code project.

so far, it is still one vs code server for each different project. don't mix the projects.

Design:
+ The root of folder contains
  - dockerfiles
  - all necessary components of vs code

  - workspace: the actual project folder for R (renv) and python (uv virtual env folder)

  - need to take care of 3 sub-folder in workspace:
    
    i) uv installed folder, the point is to use uv to manager python libraries.

    ii) uv .venv virtual environments for pythons.

    iii) R, renv folder, r libraries.
  
  need to map these 3 folders to the names volumes, so that they contain the container side libreies/environments
  not host side libraries.


## uv, the new python managing utility

very fast, very good to use.

no need to prepare the 


## python and quarto running python. select Interpretor

commands:

+ ctrl+shit + p for command pallete 

+ Jupyter: select interpretor -> select ".venv"

+ Python: select interpretor -> select ".venv"

+ select code lines and then -> shift+Enter to run

+ right up corner "1>" the triangle sign to run the python file.


## Design issues about Renv and venv and project

It is a bit complicated!!! 

###  uv and venv

First thing about the complication is that Renv and venv are different in design.

renv is slow, but uv venv seems quick. So that we can prepare renv at the docker time, but venv at the run time (after launching the vs code. and 
through vs code environment. 

second thing.It seems that when I tried to use venv, if prepare venv environment on the container, and then mapped as named volume for .venv folder, I will
be complained for adding (by uv add matplot, eg) packages as "hardlink to file, reduced performance" warning.it is likely because of "different file system"??. 

Anyway, a workable strategy is to **install uv (for the first time), and then create virtual environment by uv within vs code environment.** 
Later on, we only need to keep track the pyproject.toml and uv.lock by git and only update (sync) the environment, but don't update the docker for venv point of view.

To re-iterate, we only need to prepare uv but not uv venv on container. But use git to keep track of project yaml and lock.uv together with other project files(?need to try and confirm later).
As a result, there will be only one set of Dockerfile and docker-compose yaml files. It depends
on whether we start with a new project or continue with a project.

+ In the former case, we need to run uv init >> uv venv >> . .venv/bin/activate >> uv
  add and then add the new
  project yaml and uv.lock to the project by git

+ In the latter case, we only need to pull the changes with project yaml and uv and
  then uv sync for restore the virtual environment.

Note again, in either case, we only need to run the same set of docker file and docker compose
yaml files.
!!! Dockefile_python and docker-compose_python.yml


### renv 

Again, for renv, we would do the same thing as we do for uv. But for now we are doing this differently, we prepare the renv libraries on docker container,
and then map the named volume of renv of container. After that, we will prepare the incremental docker containers later as necessary. we also keep track of
renv.lock among others for project environment. Of course, we need to do the first time to set up things. 

### Project

for project files, we will run git to keep track inside vs code, this way, we wouldn't have permission issues. 

since the project and vs-code IDE are separated, we don't have to match the user id in the docker to linux host system
user ids (?). we only need to make sure the two ids in Dockerfile and docker-compose file match.

!!!(need to confirm).

update on this permission issue: it seems if we do everything correctly, we will be able to
make the file permission working correctly on both container and host.
Below is the things need to be correct:

+ match the user name to be "abc", which is the default by the dockerfile to
  start with (?).
+ only change the id to match between the container and host.

(need to come back testing on this issue!!
one thing to test is whether we can change the username at docker build time or running time
or at the time of running project after docker container launching.


---------------------
## To-do later

1) need to split the docker into R and Python modules.

2)
