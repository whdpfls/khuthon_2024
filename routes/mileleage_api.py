from fastapi import APIRouter, File, UploadFile, Request, BackgroundTasks
from fastapi.responses import JSONResponse

from datetime import datetime
import logging
import tensorflow as tf
import cv2
import numpy as np

import sys
sys.path.append('../')
import database.queries as q
from models.mileleage_models import FloggingStart
from models.general_models import GeneralModelVer3, GeneralModelVer2
from ML.mileleage import product, predict_content_amount, predict_content_amount_np

# 라우터 객체
router = APIRouter(prefix="/mileleage")

# /mileleage
@router.get("")
async def mileleage_get(req: Request):
    try:
        condition = 'id = 3'
        data = q.select_attrs('userdata', 'mileleage', condition)[0]
        print(data)
        
        return JSONResponse(status_code=200, content={
            "type":"string",
            "value":data[0]
        })
        
    except:
        return JSONResponse(status_code=200, content={
            "type":"string",
            "value":"unathentipicated user"
        })

min_gap = 0

def update_mileleage(mlg, user_id, user_name):
    condition = f"id = {user_id} and user_name = '{user_name}'"

    # 현재 마일리지 조회
    mileleage_value = q.select_attrs('userdata', 'mileleage', condition)
    if mileleage_value:
        current_mileage = int(mileleage_value[0][0]) + mlg

        # 업데이트할 값 딕셔너리 생성
        update_values = {'mileleage': current_mileage}

        try:
            # 레코드 업데이트
            q.update_record('userdata', update_values, condition)
        except Exception as e:
            print(f"레코드 업데이트 오류 발생: {e}")
    else:
        print("조건에 해당하는 데이터가 없습니다.")

    
logging.basicConfig(
    filename='server.log',  # 로그 파일 경로
    level=logging.INFO,     # 로그 레벨 (INFO 수준 이상의 로그만 기록)
    format='%(asctime)s %(levelname)s: %(message)s'  # 로그 포맷
)

# /mileleage/flogging
@router.post("/flogging")
async def mileleage_flogging(request: Request, background_tasks: BackgroundTasks):
    cookies = {"id":3, "user_name":"admin"}
    print("쿠키: ",cookies)
    try:
        cid = cookies["id"]
        cname = cookies["user_name"]
        condition = 'id = ' + str(cid)+' and user_name = "'+str(cname)+'"'
        print("조건: ", condition)
        data = q.select_records('userdata', condition)
    except:
        return {
            "error":"none",
            "type":"string",
            "value": "unauthenticated user"
        }

    condition = 'user_name = "'+str(cname)+'"'
    data = q.select_records('flogging', condition)

    form_data = await request.body()
    image_data = form_data
    # print("ㅇㅇ", request)
    # print(form_data)
    # image_bytes_io = form_data['image'].file
    # image_data = image_bytes_io.read()
    # #file_path = image_data.decode('utf-8')

    nparr = np.frombuffer(image_data, np.uint8)
    cv_image = cv2.imdecode(nparr, cv2.IMREAD_COLOR)  # BGR 형식으로 이미지를 읽음

            # OpenCV 이미지를 RGB 형식으로 변환 (선택적)
    cv_image_rgb = cv2.cvtColor(cv_image, cv2.COLOR_BGR2RGB)
    if(not data):
        print("no data")
        # 만약 유저 이미지 데이터가 없다면 빈 봉투를 처음 등록하는 경우임.
        try:
            
        # JSON 데이터를 파일에 쓰기
            

            model = tf.keras.models.load_model('./routes/prediction_model.h5')
            value = predict_content_amount_np(model, cv_image_rgb, 128, 128)
            #value = predict_content_amount(model, file_path, 128, 128)

            values = {
                "id": cid,
                "user_name": str(cname),
                "start_score": int(value)
            }
            q.insert_record('flogging', values)
            return JSONResponse(status_code=200, content={
                "type":"int",
                "result" : 0
            })
        except Exception as e:
            return JSONResponse(status_code=500, content={
                "type":"string",
                "value" : str(e) + "occured"
            })
    else:
        try:

            # 유저 정보 확인 후 기존에 등록된 이미지 데이터 로드
            condition = 'user_name="'+str(cname)+'"'
            start_data = q.select_records('flogging', condition)
            
            # 빈 봉투 이미지와 내용물이 든 봉투 이미지를 불러오고 시간 정보 체크
            start_value = start_data[0][2]
            start_time = str(start_data[0][3])
            model = tf.keras.models.load_model('./routes/prediction_model.h5')
            end_value = predict_content_amount_np(model, cv_image_rgb, 128, 128)
            #end_value = predict_content_amount(model, file_path, 128, 128)
            #image_data
            end_time = str(datetime.now().strftime("%Y-%m-%d %H:%M:%S"))


            # 마일리지 생성 및 갱신 여부 확인
            mileleage = abs(start_value - end_value)

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
                update_mileleage(mileleage*50, cookies["id"], cookies["user_name"])
                q.delete_record('flogging', condition)
                result = 0
                
                
            # 통신 상태가 정상적이라면 결과 코드로 result를 전송
            return JSONResponse(status_code=200, content={
                                "type":"int",
                                "value" : str(mileleage*50)}
                                )
            
        except Exception as e:  
            return JSONResponse(status_code=500, content={
                "type":"string",
                "value" : str(e) + "occured"
            })

def calc_(e, w, g):
    if e >= 15:
        p1 = 15000
    elif e>= 10:
        p1 = 10000
    elif e>=5:
        p1 = 5000
    else:
        p1 = 0
        
    if e >= 15:
        p2 = 2000
    elif e>= 10:
        p2 = 1500
    elif e>=5:
        p2 = 750
    else:
        p2 = 0
        
    if e >= 15:
        p3 = 8000
    elif e>= 10:
        p3 = 6000
    elif e>=5:
        p3 = 3000
    else:
        p3 = 0   
        
    return p1, p2, p3

@router.post("/calc")
async def mileage_calculate(req:Request, data:GeneralModelVer2):
    try:
        data = (data.value).split(" ")
        data_dict = {
            "mon": data[0],
            "elec": data[1],
            "water": data[2],
            "gas": data[3]
        }
        
        #일단 갱신
        cond = 'mon = ' + str(data[0])
        try:
            q.update_record('calc', data_dict, cond)
        except:
            print("db와 일치")
        
        print("달: ", data[0])
                
        # 반복해서 평균찾기
        e, w, g = 0, 0, 0
        for i in range(1, int(data[0])+1):
            cond2 = 'mon = '+str(i)
            result = q.select_records('calc', cond2)[0]
            if i == data[0]:
                continue
            
            print("조회결과: ", result)
            e += int(result[1])
            w += int(result[2])
            g += int(result[3])
            
        e, w, g = e/int(data[0]), w/int(data[0]), g/int(data[0])
        print("사용량:", e,w,g)
        d_e, d_w, d_g = e - int(data[1]), w-int(data[2]), g-int(data[3])
        print("d사용량:", d_e,d_w,d_g)
        r_e, r_w, r_g = abs((d_e/e)*100), abs((d_w/w)*100), abs((d_g/g)*100)
        print("r사용량:", r_e,r_w,r_g)
        p1, p2, p3 = calc_(abs(r_e), abs(r_w), abs(r_g))
        print("점수: ", p1, p2, p3)
        
        point = p1+p2+p3
        
        print(point)
        
        return JSONResponse(status_code=200, content={
            "type":"string",
            "value": str(point)            
        })

    except:
        return JSONResponse(status_code=200, content={
                "type":"string",
                "value": "please send right data"
            })
        
    
    
