from fastapi import APIRouter, File, UploadFile, Request
from fastapi.responses import JSONResponse

from datetime import datetime

import sys
sys.path.append('../')
import database.queries as q
from models.mileleage_models import FloggingStart
from models.general_models import GeneralModel, GeneralModelVer2

# 라우터 객체
router = APIRouter(prefix="/mileleage")

# /mileleage
@router.get("")
async def mileleage_get(req: Request):
    cookies = req.cookies
    try:
        cookie_id = cookies["id"]
        cookie_user_name = cookies["user_name"]
        condition = 'id = "' + str(cookie_id)+'" and user_name = "'+str(cookie_user_name)+'"'
        data = q.select_attrs('userdata', 'mileleage', condition)[0]
        
        return JSONResponse(status_code=200, content={
            "type":"string",
            "value":data[0]
        })
        
    except:
        return JSONResponse(status_code=200, content={
            "type":"string",
            "value":"unathentipicated user"
        })


# /mileleage/flogging

    
        

    # start_image와 end_image 업로드 시간 차이 30분 이상
    # 현재 타입 str이니까 적당히 변경
    # AI 모델 삽입해서
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

@router.post("/calculate")
async def mileage_calculate(req:Request, data:GeneralModelVer2):
    """
    전기사용량, 수도사용량, 가스사용량
    10,652kWh, 8.184,     
    """
    cookies = req.cookies
    if(cookies == []):
        return JSONResponse(status_code=200, content={
                "type":"string",
                "value": "unauthenticated user"
            })
    
    try:
        data_ = data.value
        
        cookie_id = cookies["id"]
        cookie_user_name = cookies["user_name"]
        dict_ = {
            "id": cookie_id,
            "user_name": cookie_user_name,
            "consume": data_
        }
        
        condition = 'id = "' + str(cookie_id)+'" and user_name = "'+str(cookie_user_name)+'"'
        find_data = q.select_records('consumption', condition)[0]
        if(not find_data):
            data = q.insert_record('consumption', dict_)
            print(data)
            return JSONResponse(status_code=200, content={
                "type":"string",
                "value": "first consumption register"
            })
            
        else:
            e, w, g = 0, 0, 0
            len_table = q.get_table_length('consumption')
            
            for i in range(1, len_table+1):
                condition = "iid=" + str(i)
                tu = q.select_records('consumption', condition)[0][2].split(" ")
                e += int(tu[0])
                w += int(tu[1])
                g += int(tu[2])
                print(tu)
                print("a", e,w,g)
                
            e, w, g = e/len_table, w/len_table, g/len_table
            data_ = list(map(int, data_.split(" ")))
            delta_e, delta_w, delta_g = e - data_[0], w-data_[1], g-data_[2]
            
            print(delta_e, delta_w, delta_g)
            
                    
            
        
        
    except:
        return JSONResponse(status_code=200, content={
                "type":"string",
                "value": "please send right data"
            })
        
    
    
    
        




