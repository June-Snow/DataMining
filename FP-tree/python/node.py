__author__ = '1988'

import drawtree

class node:
    def __init__(self,parent,isroot=False):
        self.parent=parent
        self.root=isroot
        self.children=[]

    def show(self,i=0,drawtool=drawtree.drawtree().showdraw):
        if not drawtool:
            return
        elif drawtool=='print':
            if self.root:
                print(self.getnodetext())
            else:
                indent="   "*i
                print(indent+self.getnodetext())
            i+=1
            for child in self.children:
                child.show(i=i)
        else:
            drawtool(self)

    def getnodetext(self):
        return 'node'

    def isleaf(self):
        if not self.children:return True
        return len(self.children)==0

    def getwidth(self,step=1):
        if self.isleaf():
            return step
        else:
            return sum([child.getwidth(step=step) for child in self.children])

    def getheight(self):
        if self.isleaf():
            return 1
        else:
            return 1+max([child.getheight() for child in self.children])

    #获取所有子孙节点
    def getallchildren(self):
        if self.isleaf():
            return []
        return self.getallnodeslist()[1:]

    #获取所有子孙节点+自身
    def getallnodeslist(self):
        if self.isleaf():
            return [self]
        return [self]+[child.getallchildren() for child in self.children]