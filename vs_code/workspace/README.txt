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

## version control

due to file permissio issues (see above), we have to do through vs-code interface. Good or bad. don't know.

will figure this out later.

(need to be careful about this with dockerfile and docker compose at the root of the folder!!!!)

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

a 


## python and quarto running python.

commands:

+ ctrl+shit + p for command pallete 

+ Jupyter: select interpretor -> select ".venv"

+ Python: select interpretor -> select ".venv"

+ select code lines and then -> shift+Enter to run

+ right up corner "1>" the triangle sign to run the python file.
