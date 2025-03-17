# PP-OCR
PaddlePaddle OCR demo in RB3 Gen2 LU

## Paddle Lite 
PP-OCR working on the paddle lite code base as a cxx demo. 
Download the paddle lite code and complie it for the first step in RB3 Gen2 board:

```bash
git clone https://github.com/PaddlePaddle/Paddle-Lite.git
cd Paddle-Lite
./lite/tools/build.sh --arm_os=armlinux --arm_abi=arm64-v8a --arm_lang=gcc  tiny_publish
```
The log of build paddle lite successfully
![image](https://github.com/user-attachments/assets/d67c7737-4778-4308-ab74-57de7971832c)

## OCR Model
Download the model from https://github.com/PaddlePaddle/PaddleOCR/blob/release/2.6/doc/doc_en/models_list_en.md

### Det model:
![image](https://github.com/user-attachments/assets/c7fcfb72-ffd6-42b0-8e82-6268641d70c4)

### Rec model:
![image](https://github.com/user-attachments/assets/3db8e996-2b51-4560-b853-7e3c76fc0e92)

### Cls model:
![image](https://github.com/user-attachments/assets/b37e1d80-d96d-4a8c-9904-9a8ad7137132)

After we download the model and use the opt tools to convert these model from pdmodel to nb mode follow the command:
```bash
./opt_linux_x86 --model_dir=ch_ppocr_mobile_v2.0_cls_slim_infer --optimize_out_type=naive_buffer --optimize_out=ch_ppocr_mobile_v2.0_cls_slim_infer/ch_ppocr_mobile_v2.0_cls_slim_infer_opt
./opt_linux_x86 --model_dir=ch_ppocr_mobile_v2.0_det_prune_infer --optimize_out_type=naive_buffer --optimize_out=ch_ppocr_mobile_v2.0_det_prune_infer/ch_ppocr_mobile_v2.0_det_opt
./opt_linux_x86 --model_dir=ch_ppocr_mobile_v2.0_rec_slim_infer --optimize_out_type=naive_buffer --optimize_out=ch_ppocr_mobile_v2.0_rec_slim_infer/ch_ppocr_mobile_v2.0_rec_opt
```

## Build demo
Place the demo code directory into the paddle lite code path after building paddle lite:
Paddle-Lite/build.lite.armlinux.arm64-v8a.gcc/inference_lite_lib.armlinux.arm64-v8a/demo/cxx

run build.sh to build the demo app. (Note we need to install the opencv into the RB3 Gen2 for this demo)

build result:
![image](https://github.com/user-attachments/assets/31ea0676-8271-44f4-a4ac-263044ef0f27)


## Run demo
Upload the 3 nb files into the model directory, then you can use ls command to check the model
![img_v3_02kf_f5caba2d-7db1-4f2b-b0b2-687d61b7fc0g](https://github.com/user-attachments/assets/aff5853c-c7a9-48b4-ac4a-b5502d927129)


run run.sh to run the demo app, here is the result.

### OCR result:
![image](https://github.com/user-attachments/assets/41e907d1-44e5-4855-b2e5-8fd73a6eee6e)

### Original picture:
![image](https://github.com/user-attachments/assets/d98f4c8f-d5a8-4583-8ac2-6db641942da1)

### cls result
![image](https://github.com/user-attachments/assets/81bbbbfa-ff97-4ca6-b3b3-2fa0894d211c)

