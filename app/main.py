from fastapi import FastAPI
from sqlalchemy import create_engine
from db import engine

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "Hello, Kubernetes!"}

@app.get("/")
def read_root():
    with engine.connect() as con:
        result = con.execute("SELECT 1")
        return {"message": f"DB connection works: {result.fetcone()}"}
@app.get("/items/{item_id}")
def read_item(item_id: int, q: str = None):
    return {"item_id": item_id, "q": q}
