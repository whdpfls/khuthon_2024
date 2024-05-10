from fastapi import APIRouter, Response

import sys
sys.path.append('../')
import database.queries as q

# 라우터 객체
router = APIRouter(prefix="/animalcatalog")





