import json
import os

import boto3
from fastapi import FastAPI

app = FastAPI()


def load_db_credentials() -> dict:
  secret_arn = os.getenv("DB_SECRET_ARN")
  if not secret_arn:
    return {}

  client = boto3.client("secretsmanager")
  payload = client.get_secret_value(SecretId=secret_arn)
  return json.loads(payload.get("SecretString", "{}"))


@app.get("/health")
def health():
  creds = load_db_credentials()
  return {
    "status": "ok",
    "db_host": os.getenv("DB_HOST", "unset"),
    "db_port": os.getenv("DB_PORT", "unset"),
    "db_user_present": bool(creds.get("username"))
  }


@app.get("/api/version")
def version():
  return {"version": "1.0.0"}
