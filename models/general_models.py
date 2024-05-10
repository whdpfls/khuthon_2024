from pydantic import BaseModel

class GeneralModel(BaseModel):
    type: str
    properties: dict
    
class GeneralModelVer2(BaseModel):
    type: str
    value: str