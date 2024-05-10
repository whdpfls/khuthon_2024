from pydantic import BaseModel

class SignIn(BaseModel):
    type: str
    properties: dict

class SignUp(BaseModel):
    type: str
    properties: dict