__author__ = 'wei'

class util:
    def __init__(self):
        self.comdict={}

    '''
    获取列表的长为m的组合
    '''
    def getcombination(self,l,m):
        if l is None or (type(l) is not list and type(l) is not tuple):
            return None
        ll=len(l)
        if ll == 0 or m==0:
            return ()
        if m>=ll:
            return (tuple(l),)
        if m==1:
            return tuple([(item,) for item in l])
        else:
            s=self.getsequence(ll,m)
            return self.createcombination(l,s)


    def getsequence(self,ll,m):
        if (ll,m) in self.comdict:
            return self.comdict[(ll,m)]
        else:
            olist=[1]*m+[0]*(ll-m)
            return self.createsequence(olist,[])

    def createsequence(self,olist,rs):
        if olist not in rs:
            rs.append(olist)
            for i in range(0,len(olist)-1):
                if olist[i]==1 and olist[i+1]==0:
                    newlist=olist[:]
                    newlist[i]=0
                    newlist[i+1]=1
                    if newlist not in rs:
                        rs=self.createsequence(newlist,rs)
        return rs

    def createcombination(self,l,s):
        rs=[]
        for cs in s:
            comb=[]
            for i in range(0,len(cs)):
                if cs[i]==1:
                    comb.append(l[i])
            rs.append(tuple(comb))
        return tuple(rs)
