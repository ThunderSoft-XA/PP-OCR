#!/bin/bash

local_path=`pwd`
export LD_LIBRARY_PATH=$local_path/3rd/libs/opencv/lib:$local_path/../../../cxx/lib

./build/ppocr_demo \
./models/ch_ppocr_mobile_v2.0_det_opt.nb \
./models/ch_ppocr_mobile_v2.0_rec_opt.nb \
./models/ch_ppocr_mobile_v2.0_cls_slim_infer_opt.nb \
./images/test.jpg \
./images/test_img_result.jpg \
./labels/ppocr_keys_v1.txt \
./config.txt