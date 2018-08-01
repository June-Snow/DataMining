__author__ = '1988'
# coding=utf-8

import node

class fpnode(node.node):
    def __init__(self,parent,item,count,notify,isroot=False):
        node.node.__init__(self,parent=parent,isroot=isroot)
        self.item=item
        self.count=count
        self.children=[]
        self.notify=notify

    def addchild(self,child):
        self.children.append(child)
        self.notify(child.item,child)


    def additem(self,fact,index):
        if type(fact[0]) is tuple:
            count=fact[index][1]
            item=fact[index][0]
        else:
            count=1
            item=fact[index]
        c=self.findchildbyitem(item)
        next=index+1
        if c:
            c.count+=count
            c.grow(fact,next)
        else:
            c=fpnode(self,item,count,self.notify)
            self.addchild(c)
            c.grow(fact,next)

    def findchildbyitem(self,item):
        for c in self.children:
            if c.item==item:
                return c
        return None

    def grow(self,fact,index=0):
        if len(fact)>0 and index<len(fact):
            self.additem(fact,index)

    def getnodetext(self):
        if self.root:
            return 'ROOT'
        return str(self.item)+':'+str(self.count)

    # 生成某个节点的条件模式基
    def getCPB(self,itemnodes):
        rs=[]
        for node in itemnodes:
            path=[]
            count=node.count
            currentnode=node.parent
            while not currentnode.root:
                path.insert(0,(currentnode.item,count))
                currentnode=currentnode.parent
            rs.append(path)
        return rs

