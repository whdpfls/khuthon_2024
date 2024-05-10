from pydantic import BaseModel

class FloggingStart(BaseModel):
    type: str
    value: bytes