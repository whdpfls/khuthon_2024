from fastapi import APIRouter, Request
from fastapi.responses import JSONResponse

import openai
OPENAI_API_KEY = 'sk-proj-hTiLpJ0LSaVynQI6wZ1gT3BlbkFJ5j3CafuHBPDthdZNvhrG'
openai.api_key = OPENAI_API_KEY
model = 'gpt-3.5-turbo'

from models.envactivity_models import EnvActivity

# 라우터 객체
router = APIRouter(prefix="/envactivity")

# /envactivity -> 이거 나중에 논문보고 양식 변경
@router.post("")
async def envactivity_post(data: EnvActivity):
    print("입력 prompt: ", data)
    
    """
    논문제목: 
    1. ~가 되어라 - 페르소나 설정
    2. 주의사항
    3. 할 일
    """
    first_step = "지금부터 환경에 관심이 깊은 일반인이 되는거야. "
    second_step = str(data.value) + "이라는 점에 주의해서 "
    third_step = " 수 있는 환경보호활동을 구체적으로 5가지 추천 해줘"
    prompt = first_step+second_step+third_step
    
    prompt = [{"role":"user", "content": prompt}]
    print(prompt)
    response = openai.ChatCompletion.create(
        model = model,
        messages=prompt,
        temperature=0,
    )
    
    gpt_result = response.choices[0].message["content"]
    gpt_result = gpt_result.split("\n\n")
    
    result_dict = {
        "type":"string",
        "value": gpt_result
    }
    print("지피티응답: ", gpt_result)
    return JSONResponse(status_code=200, content=result_dict)
    
    


