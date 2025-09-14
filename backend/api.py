from fastapi import FastAPI, Query
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import Optional, List

app = FastAPI()
app.add_middleware(CORSMiddleware, allow_origins=["*"], allow_methods=["*"], allow_headers=["*"])

class MenuItem(BaseModel):
    id: str
    title: str
    price: Optional[float] = None
    currency: Optional[str] = None
    imageURL: Optional[str] = None
    options: Optional[list[str]] = None

class Restaurant(BaseModel):
    id: str
    name: str
    imageURL: Optional[str] = None
    cuisine: list[str] = []
    deliveryETA: Optional[str] = None
    platform: str
    rating: Optional[float] = None
    city: Optional[str] = None
    menu: Optional[List[MenuItem]] = None

SAMPLE = [
    {"id":"r1","name":"Sample Burger Kuwait","imageURL":"https://picsum.photos/400/300","cuisine":["Burgers","American"],"deliveryETA":"30-40m","platform":"talabat","rating":4.4,"city":"Kuwait City","menu":[{"id":"m1","title":"Classic Burger","price":2.750,"currency":"KWD","imageURL":"https://picsum.photos/240/160","options":["No Pickles","Extra Cheese"]}]}
]

@app.get("/restaurants", response_model=list[Restaurant])
def restaurants(query: str = Query(""), lang: str = "en", city: str = "kuwait"):
    q = query.lower().strip()
    if not q: return SAMPLE
    return [r for r in SAMPLE if q in r["name"].lower()]
