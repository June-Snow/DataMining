__author__ = 'wei'

from treebuilder import treebuilder
from cpbtreebuilder import cpbtreebuilder
from util import util
from drawtree import drawtree

class fptreemining:
    def __init__(self,saveimg=False,saveto=None):
        self.fsetdict={}
        self.util=util()
        self.saveimg=saveimg
        self.saveto=saveto
        if saveimg and saveto:
            self.drawtool=drawtree()

    def mine(self,facts,items,threshold):
        root=treebuilder(items,facts)
        print('所有特征项及其频度',root.itemcount)
        self.drawtool.saveimg(root.tree,self.saveto,'Root.jpg',title=None)
        self.multipathhandler(None,root,threshold)

    def gettreebuilder(self,facts,items):
        root=treebuilder(items=items,facts=facts)
        return root

    def getcpbtreebuilder(self,treebuilder,item):
        cpbtreebuilder=treebuilder.tree.getCPB(treebuilder.itemtable[item])
        return cpbtreebuilder

    #检查是否为单路径的树,如果是返回1,不是返回0,如果空树则返回-1
    def checksinglepathtree(self,node,threshold):
        if node.root and node.isleaf():
            return 0
        if node.isleaf():
            return 1
        else:
            if node.root or node.count>=threshold:
                ccc=0 #count of child has children
                for child in node.children:
                    if not child.isleaf():
                        ccc+=1
                        notleafchild=child
                    if child.isleaf() and not node.root:
                        return 1
                if ccc>1:
                    return ccc
                elif ccc==1:
                    if notleafchild.count<threshold:
                        return 0
                    else:
                        return self.checksinglepathtree(notleafchild,threshold)
                else:
                    return 0
            else:
                return 1

    def getsinglepathtree(self,node,threshold,rs):
        if node.root:
            for child in node.children:
                if child.count>=threshold:
                    return self.getsinglepathtree(child,threshold,[])
        if node.count>=threshold:
            rs.append(node)
            if node.isleaf():
                return rs
            for child in node.children:
                if child.count>=threshold:
                    return self.getsinglepathtree(child,threshold,rs)
        return rs

    def unionhandler(self,item,cpb,threshold):
        #将树上所有节点与item做并集
        for newitem in cpb.items:
            count=cpb.itemcount[newitem]
            if count>=threshold:
                pairs=((newitem,count),)
                self.getfrequentset(item,pairs)

    #单路径树求所有组合
    def singlepathhandler(self,item,cpb,threshold):
        #寻找该单元路径上所有的组合,组合最小长度为2
        spath=self.getsinglepathtree(cpb.tree,threshold,[])
        nodepairs=[(node.item,node.count) for node in spath]
        for cpairs in self.getcombineoflist(nodepairs):
            self.getfrequentset(item,cpairs)

    def multipathhandler(self,orgitem,tb,threshold):
        itemrank=tb.getrandeditems()
        #print(itemrank)
        for newitem in itemrank:
            if tb.itemcount[newitem]<threshold:
                continue
            if orgitem is None or len(orgitem)==0:
                item=(newitem,)
            else:
                item=tuple(list(orgitem)+[newitem])
            cpb_facts=tb.tree.getCPB(tb.itemtable[newitem])
            cpb=cpbtreebuilder(cpb_facts)
            cpb_tree=cpb.tree
            if self.drawtool:
                title='-'.join(item)+"_cpb tree"
                filename=title+".jpg"
                self.drawtool.saveimg(cpb_tree,self.saveto,filename,title=title)
            if item == ('milk','eggs'):
                ddd=1
            pathcount=self.checksinglepathtree(cpb_tree,threshold)
            if pathcount>1:
                self.multipathhandler(item,cpb,threshold)
            if pathcount==1:
                self.singlepathhandler(item,cpb,threshold)
            self.unionhandler(item,cpb,threshold)

    def getcombineoflist(self,nodepairs):
        for i in range(2,len(nodepairs)+1):
            combs=self.util.getcombination(nodepairs,i)
            for comb in combs:
                yield comb

    def getfrequentset(self,item,cpairs):
        orgitem=list(item)
        items=tuple(orgitem+[pair[0] for pair in cpairs])
        count=min([pair[1] for pair in cpairs])
        if items in self.fsetdict:
            print('repeat frequent items',items,item )
        self.fsetdict[items]=count

    #对挖掘结果排序显示
    def showfset(self):
        rankkeys=sorted(self.fsetdict.keys(),key= lambda k:self.fsetdict[k],reverse=True)
        for key in rankkeys:
            print(key,self.fsetdict[key])