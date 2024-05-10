import requests
import socket
import json
import base64

def get_local_ip_address():
    hostname = socket.gethostname()
    ip_addresses = socket.getaddrinfo(hostname, None)
    ipv4_addresses = [ip[4][0] for ip in ip_addresses if ip[0] == socket.AF_INET]
    return ipv4_addresses

myIP = get_local_ip_address()[0]
myPort = 8000

# 엔드포인트 URL
#url = "http://"+str(myIP)+":"+str(myPort)+"/mileleage/flogging"
url = "http://172.21.119.167:8000"+"/mileleage/flogging1"
print(url)
# 이미지 파일 경로
image_path = "./full.jpg"

# 쿠키 정보
cookies = {
    "id": "1",
    "user_name" : "test"
}

try:
    # 이미지 파일 열기
    a = open(image_path, 'rb').read()
    encoded_image = base64.b64encode(a).decode('utf-8')

    json_val = {"type":"string","value": encoded_image}
    json_val = json.dumps(json_val, ensure_ascii=False)
    print(json_val)
    response = requests.post(url, data=json_val)
    #response = requests.post(url, cookies=cookies, files={"image": image_path})
    # 응답 확인
    if response.status_code == 200:
        print("요청이 성공적으로 처리되었습니다.")
        print(response.json())  # 서버에서 반환한 JSON 응답 확인
    else:
        print(f"요청 실패 - 상태 코드: {response.status_code}")
except Exception as e:
    print(f"요청 실패 - 에러: {e}")