FROM --platform=linux/amd64 python:3-buster

EXPOSE 80

RUN apt-get -yyy update && apt-get -yyy install software-properties-common && \
    wget -O- https://apt.corretto.aws/corretto.key | apt-key add - && \
    add-apt-repository 'deb https://apt.corretto.aws stable main'

RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    (dpkg -i google-chrome-stable_current_amd64.deb || apt install -y --fix-broken) && \
    rm google-chrome-stable_current_amd64.deb 

RUN apt-get -yyy update && apt-get -yyy install java-1.8.0-amazon-corretto-jdk ghostscript

RUN pip install --upgrade pip
RUN pip install anvil-app-server

COPY ./app/requirements.txt ./ 
RUN pip install -r requirements.txt

COPY ./app /app

RUN anvil-app-server || true

WORKDIR ./app

RUN mkdir anvil-data

RUN useradd anvil
RUN chown -R anvil:anvil anvil-data
USER anvil

ENTRYPOINT ["anvil-app-server", "--data-dir", "/app/anvil-data"]

CMD ["--app", "home", "--port", "80", "--origin", "https://anvil-home.azurewebsites.net", "--disable-tls"]