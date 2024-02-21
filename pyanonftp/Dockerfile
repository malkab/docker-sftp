#Docker file for Python FTP Anonymous Server --Author Waqar Mansoor

FROM python:3.12.2-alpine
LABEL author="Juan Pedro Perez"
LABEL email="jp.perez.alcantara@gmail.com"

RUN pip install pyftpdlib

# Copy assets
COPY ./main.py ./
COPY ./setup.py ./

# Run setup
RUN chmod 755 setup.py ; \
    /setup.py ; \
    rm setup.py

# Expose ports
EXPOSE 21
EXPOSE 40000-40009

# Command to run the application
CMD [ "python", "./main.py" ]
