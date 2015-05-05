__author__ = '1988'
# coding=utf-8

from fpnode import fpnode

class treebuilder:
    def __init__(self,items,facts):
        self.items=items #特征项
        self.facts=facts #样本记录列表
        self.itemcount=self.getitemcount() #{特征项:支持度}
        self.itemtable=self.getitemtable() #头表
        self.tree=self.growtree() #树

    def getitemcount(self):
        itemcount={}
        for fact in self.facts:
            for item in self.items:
                if item in fact:
                    itemcount.setdefault(item,0)
                    itemcount[item]+=1
        return itemcount

    def getitemtable(self):
        itemtable={}
        for item in self.items:
            itemtable.setdefault(item,[])
        return itemtable

    def addnode2itemtable(self,item,node):
        #self.itemtable.setdefault(item,[])
        self.itemtable[item].append(node)

    def rankfact(self,fact):
        #return fact
        rs=sorted(fact,key=lambda i:self.itemcount[i],reverse=True)
        return rs

    #生成树
    def growtree(self):
        #create root node
        tree=fpnode(None,None,None,self.addnode2itemtable,isroot=True)
        for fact in self.facts:
            ranked_fact=self.rankfact(fact)
            tree.grow(ranked_fact)
        return tree

    def getrandeditems(self):
        return sorted(self.items,key=lambda i:self.itemcount[i])




