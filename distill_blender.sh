#!/bin/bash
mkdir -p blender_distilled
python -c "from parlai.zoo.blender.blender_3B import download; download('data')"
# To manually download the BlenderBot3B model, required for specifying `--init-opt`
parlai train_model \
--allow-missing-init-opts True \
--init-model None \
--init-opt data/models/blender/blender_3B/model.opt \
--dict-file data/models/blender/blender_3B/model.dict \
--model projects.anti_scaling.distillation:DistillTransformerAgent \
--teacher-model data/models/blender/blender_3B/model \
--batchsize 16 \
--embedding-size 2560 \
--ffn-size 10240 \
--fp16 True \
--gpu -1 \
--learningrate 0.0000625 \
--lr-scheduler reduceonplateau \
--max-lr-steps -1 \
--max-train-time -1 \
--model-parallel False \
--save-after-valid True \
--skip-generation True \
--task blended_skill_talk,wizard_of_wikipedia,convai2:normalized,empathetic_dialogues \
-veps -1 \
-vmm min \
-vmt ppl \
-vp 20 \
-vtim 900 \
-vstep 1000 \
--num-workers 8 \
--n-encoder-layers 2 \
--n-decoder-layers 9 \
#--embedding-loss-coeff 4 \
--hidden-loss-coeff 64 \
# --self-attn-loss-coeff 4 \
# --enc-dec-attn-loss-coeff 64 \
--encoder-loss-coeff 0 \
--pred-loss-coeff 64 \
--task-loss-coeff 1 \
--model-file blender_distilled/blender_distilled.pth \
-wblog True \
--wandb-project distill_blender \
