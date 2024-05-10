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
@router.post("/flogging")
async def mileleage_flogging(image: FloggingStart, request: Request):
    cookies = request.cookies
    try:
        cookie_id = cookies["id"]
        cookie_user_name = cookies["user_name"]
        condition = 'id = "' + str(cookie_id)+'" and user_name = "'+str(cookie_user_name)+'"'
        data = q.select_records('flogging', condition)
    except:
        return {
            "type":"string",
            "value": "unauthenticated user"
        }
    if(cookies == {}):
         return {
            "type":"string",
            "value": "unauthenticated user"
        }
    
    if(not data):
        # 만약 유저 이미지 데이터가 없다면 빈 봉투를 처음 등록하는 경우임.
        try:
            image_data = image.value
            
            values = {
                "id": cookie_id,
                "user_name": cookie_user_name,
                "start_image": image_data
            }
            
            q.insert_record('floggingimage', values)
                
            return JSONResponse(status_code=200, content={
                "type":"string",
                "value": "file uploaded successfully"
            })
        except Exception as e:
            return JSONResponse(status_code=500, content={
                "type":"string",
                "value" : str(e) + "occured"
            })
    else:
        try:

            # 유저 정보 확인 후 기존에 등록된 이미지 데이터 로드
            condition = 'id="'+str(cookie_id)+'" and user_name="'+str(cookie_user_name)+'"'
            start_data = q.select_records('`flogg`ing', condition)
            start_image = str(start_data[0][2])
            start_time = str(start_data[0][3])
            
            end_image = image.value
            end_time = str(datetime.now().strftime("%Y-%m-%d %H:%M:%S"))


            # 마일리지 생성 및 갱신 여부 확인
            mileleage = product(start_image, end_image)
            
            dt1 = datetime.strptime(start_time, "%Y-%m-%d %H:%M:%S")
            dt2 = datetime.strptime(end_time, "%Y-%m-%d %H:%M:%S")
            time_difference = dt2 - dt1
            minutes_difference = time_difference.total_seconds() / 60

            # 시간 차이 설정
            dt3 = minutes_difference # float


            # 시간 간격이 30분 이상일 경우 마일리지를 갱신하고 이미지 정보를 제거
            # 만약 시간 간격이 30분 미만일 경우 마일리지 갱신을 수행하지 않고 result에 1을 담아 클라이언트에게 전송
            result = 1
            if dt3 >= min_gap:
                update_mileleage(mileleage, cookies["id"], cookies["user_name"])
                q.delete_record('floggingimage', condition)
                result = 0
                
                
            # 통신 상태가 정상적이라면 결과 코드로 result를 전송
            return JSONResponse(status_code=200, content={
                                "type":"int",
                                "result" : result}
                                )
            
        except Exception as e:  
            return JSONResponse(status_code=500, content={
                "type":"string",
                "value" : str(e) + "occured"
            })
        
    
    
        

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
        
    
    
    
        




