from fastapi import APIRouter, Response
from fastapi.responses import JSONResponse

import json
from datetime import datetime, timedelta

import sys
sys.path.append('../')
import database.queries as q
from models.login_models import SignIn, SignUp

# 라우터 객체
router = APIRouter(prefix="/login")

# /login/signup
@router.post("/signup")
async def login_signup(sign_up: SignUp):
    try:
        q.insert_record("userdata", sign_up.properties)

        response_dict = {
            "type" : "string",
            "value": str(sign_up.properties) + "sign up complete"
        }
        response_json = json.dumps(response_dict)
    except:
        response_dict = {
            "type": "string",
            "value": "please send right data"
        }
        response_json = json.dumps(response_dict)
    finally:
        return response_json

# /login
@router.post("")
async def login(sign_in: SignIn, res: Response):
    try:
        user_id = str(sign_in.properties["user_id"])
        user_pw = str(sign_in.properties["user_pw"])
        
        condition = 'user_id="' + user_id + '" AND user_pw="' + user_pw +'"'
        
        login_result = q.select_records('userdata', condition)
        
        if(login_result == []):
            response_dict = {
            "type": "string",
            "value": "user not registered"
            }
            response_json = json.dumps(response_dict)
            return response_json
        
        
        
        expire_time = datetime.utcnow() + timedelta(minutes=30)
        expire_time = expire_time.strftime("%a, %d %b %Y %H:%M:%S GMT")
        
        res = JSONResponse(status_code=200, content={
            "type":"object",
            "value":{
                "id": login_result[0][0],
                "user_name": login_result[0][1],
                "user_id": login_result[0][2],
                "user_pw": login_result[0][3]
            }
        })
        
        res.set_cookie(key="id", value=str(login_result[0][0]), expires=expire_time)
        res.set_cookie(key="user_name", value=str(login_result[0][1]), expires=expire_time)
        
        return res
    except:
        response_dict = {
            "type": "string",
            "value": "please send right data"
        }
        response_json = json.dumps(response_dict)
    finally:
        return response_json

# /login/fake
@router.get("/fake")
async def login(res: Response):
    expire_time = datetime.utcnow() + timedelta(minutes=30)
    expire_time = expire_time.strftime("%a, %d %b %Y %H:%M:%S GMT")
    
    res = JSONResponse(status_code=200, content={
            "type":"string",
            "value":{
                "id": 3,
                "user_name": 'admin'
            }
        })
    
    res.set_cookie(key="id", value=3, expires=expire_time)
    res.set_cookie(key="user_name", value="admin", expires=expire_time)
        
    return res