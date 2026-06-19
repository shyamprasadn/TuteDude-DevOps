FROM python:alpine3.24

ADD requirements.txt /app/requirements.txt
RUN python -m pip install --upgrade pip
RUN pip install --no-cache-dir -r /app/requirements.txt

ADD . /app

WORKDIR /app 

CMD [ "python", "/app/app.py" ]