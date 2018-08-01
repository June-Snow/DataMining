__author__ = 'wei'


import sample
import fptreemining
import treebuilder

#显示树
# root=treebuilder.treebuilder(items=sample.items,facts=sample.sample)
# root.tree.show()

'''
进行挖掘
saveimg:是否生成每一步FP树图片,saveto:生成图片的地址目录(地址中尽量不要有中文)
'''
f=fptreemining.fptreemining(saveimg=True,saveto='C:/Users/litao/Desktop/FP-tree/')
#items:样本的特征项,facts:样本,threshold:最小支持度
f.mine(items=sample.items,facts=sample.sample,threshold=3)
f.showfset()




