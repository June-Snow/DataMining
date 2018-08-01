__author__ = 'wei'

from fpnode import fpnode
from treebuilder import treebuilder

class cpbtreebuilder(treebuilder):
    def __init__(self,cpb):
        self.cpb=cpb
        self.items=self.getitems()
        self.itemtable=self.getitemtable()
        self.itemcount=self.getitemcount()
        self.tree=self.growtree()

    def getitems(self):
        items=[]
        for path in self.cpb:
            for node in path:
                if node[0] not in items:
                    items.append(node[0])
        return items

    def growtree(self):
        #create root node
        tree=fpnode(None,None,None,self.addnode2itemtable,isroot=True)
        for path in self.cpb:
            path_sorted=sorted(path,key=lambda n:self.itemcount[n[0]],reverse=True)
            tree.grow(path_sorted)
        return tree

    def getitemcount(self):
        itemcount={}
        for path in self.cpb:
            for item in path:
                itemcount.setdefault(item[0],0)
                itemcount[item[0]]+=item[1]
        return itemcount

