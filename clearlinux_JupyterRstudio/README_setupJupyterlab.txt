By default, Jupyter Lab doesn’t require a password to access the web interface. To secure Jupyter Lab, generate the Jupyter Lab configuration using the following command.

jupyter-lab --generate-config

Output.

Writing default config to: /root/.jupyter/jupyter_lab_config.py

Next, set the Jupyter Lab password.

jupyter-lab password

Set your password as shown below:

Enter password: 
Verify password: 
[JupyterPasswordApp] Wrote hashed password to /root/.jupyter/jupyter_server_config.json

You can verify your hashed password using the following command.

cat /root/.jupyter/jupyter_server_config.json

Output.

{
  "IdentityProvider": {
    "hashed_password": "argon2:$argon2id$v=19$m=10240,t=10,p=8$zf0ZE2UkNLJK39l8dfdgHA$0qIAAnKiX1EgzFBbo4yp8TgX/G5GrEsV29yjHVUDHiQ"
  }
}

Make a note of this information, as you will need to add it to your config.

Next, edit the Jupyter Lab configuration file.

nano /root/.jupyter/jupyter_lab_config.py

Define your server IP, hashed password, and other configurations as shown below:

c.ServerApp.ip = 'your-server-ip'

c.ServerApp.open_browser = False

c.ServerApp.password = 'argon2:$argon2id$v=19$m=10240,t=10,p=8$zf0ZE2UkNLJK39l8dfdgHA$0qIAAnKiX1EgzFBbo4yp8TgX/G5GrEsV29yjHVUDHiQ'

c.ServerApp.port = 8888

Make sure you format the file exactly as above. For example, the port number is not in brackets, and the False boolean must have a capital F.

Save and close the file when you are done.
Step 4 – Create a Systemctl Service File

Next, create a systemd service file to manage the Jupyter Lab.

nano /etc/systemd/system/jupyter-lab.service

Add the following configuration:

[Service]
Type=simple
PIDFile=/run/jupyter.pid
WorkingDirectory=/root/
ExecStart=/usr/local/bin/jupyter lab --config=/root/.jupyter/jupyter_lab_config.py --allow-root
User=root   
Group=root   
Restart=always
RestartSec=10
[Install]
WantedBy=multi-user.target

Save and close the file, then reload the systemd daemon.

systemctl daemon-reload

Next, start the Jupyter Lab service using the following command.

systemctl start jupyter-lab

You can now check the status of Jupyter Lab service using the following command.

systemctl status jupyter-lab

Output.

● jupyter-lab.service
     Loaded: loaded (/etc/systemd/system/jupyter-lab.service; disabled; vendor preset: enabled)
     Active: active (running) since Tue 2023-12-05 15:22:45 UTC; 6s ago
   Main PID: 156299 (jupyter-lab)
      Tasks: 1 (limit: 2242)
     Memory: 59.4M
        CPU: 1.448s
     CGroup: /system.slice/jupyter-lab.service
             └─156299 /usr/bin/python3 /usr/local/bin/jupyter-lab --config=/root/.jupyter/jupyter_lab_config.py --allow-root

Dec 05 15:22:47 ubuntu jupyter[156299]: [I 2023-12-05 15:22:47.322 LabApp] JupyterLab extension loaded from /usr/local/lib/python3.10/dist-packages/jupyterlab
Dec 05 15:22:47 ubuntu jupyter[156299]: [I 2023-12-05 15:22:47.322 LabApp] JupyterLab application directory is /usr/local/share/jupyter/lab
Dec 05 15:22:47 ubuntu jupyter[156299]: [I 2023-12-05 15:22:47.323 LabApp] Extension Manager is 'pypi'.
Dec 05 15:22:47 ubuntu jupyter[156299]: [I 2023-12-05 15:22:47.328 ServerApp] jupyterlab | extension was successfully loaded.
Dec 05 15:22:47 ubuntu jupyter[156299]: [I 2023-12-05 15:22:47.329 ServerApp] Serving notebooks from local directory: /root
Dec 05 15:22:47 ubuntu jupyter[156299]: [I 2023-12-05 15:22:47.329 ServerApp] Jupyter Server 2.11.2 is running at:
Dec 05 15:22:47 ubuntu jupyter[156299]: [I 2023-12-05 15:22:47.329 ServerApp] http://104.219.55.40:8888/lab
Dec 05 15:22:47 ubuntu jupyter[156299]: [I 2023-12-05 15:22:47.329 ServerApp]     http://127.0.0.1:8888/lab
Dec 05 15:22:47 ubuntu jupyter[156299]: [I 2023-12-05 15:22:47.330 ServerApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
Dec 05 15:22:47 ubuntu jupyter[156299]: [I 2023-12-05 15:22:47.354 ServerApp] Skipped non-installed server(s): bash-language-server, dockerfile-language-server-nodejs,>

Jupyter Lab is now started and listening on port 8888. You can verify it with the following command.

ss -antpl | grep jupyter

Output.

LISTEN 0      128    104.219.55.40:8888      0.0.0.0:*    users:(("jupyter-lab",pid=156299,fd=6))                    

Step 5 – Access Jupyter Lab

Now, open your web browser and access the Jupyter Lab web interface using the URL http://your-server-ip:8888. You will see the Jupyter Lab on the following screen.



