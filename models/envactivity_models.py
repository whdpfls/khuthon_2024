from pydantic import BaseModel

class EnvActivity(BaseModel):
    type: str
    value: str