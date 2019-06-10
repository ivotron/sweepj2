#!/usr/bin/env python

import argparse
import os
import yaml
import re
import itertools
from subprocess import check_output

parser = argparse.ArgumentParser()
parser.add_argument(
    '--template',
    help='',
    default='./new/demo_script.sh',
    required=False
)
parser.add_argument(
    '--space',
    help='Path to parameter space .',
    default="./new/space.yml",
    required=False
)

if not os.path.exists("./output"):
    os.makedirs("./output")
args = vars(parser.parse_args())
ext = os.path.splitext(args['template'])[1]
with open(args['template']) as temp:
    template = temp.read()
    print(template)

with open(args['space']) as f:
    # use safe_load instead load
    dataMap = yaml.safe_load(f)

    # print(dataMap.items())
params = re.findall(r'(?<={__).*?(?=__})', template)
params.sort()
new_params = list(map(lambda x: "__" + x + "__", params))

# print(new_params)
kw = {}
vals = []
for k, v in sorted(dataMap.items()):
    vals.append(v)
for comb in itertools.product(*vals):
    # print(zip(new_params, comb))
    for tup in zip(new_params, comb):
        kw[tup[0]] = tup[1]
    # print(kw)
    print(template.format(**kw))
    with open("./output/output-{}{}".format(comb, ext), 'a') as f:
        f.write(template.format(**kw))
