FROM python:3.9-slim
ADD base-image/requirements.txt /
RUN pip install -r requirements.txt
ADD src /src
CMD kopf run -A /src/handlers.py