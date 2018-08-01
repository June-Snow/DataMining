__author__ = '1988'
from PIL import Image,ImageDraw

import os
class drawtree:
    def __init__(self,lheight=70,leafwidth=65):
        self.lmargin,self.rmargin=100,100
        self.lheight=lheight
        self.lwidth=leafwidth
        self.tmargin,self.bmargin=50,50

    def showdraw(self,root,roottext='ROOT',title=None):
        img=self.draw(root,roottext,title)
        img.show()

    def saveimg(self,root,savepath,filename,title=None):
        if not os.path.exists(savepath):
            os.makedirs(savepath)
        img=self.draw(root,title=title)
        img.save(savepath+'/'+filename)

    def draw(self,root,roottext='ROOT',title=None):
        imgwidth=self.tmargin+self.bmargin+root.getwidth(step=self.lwidth)
        imgheight=self.tmargin+self.bmargin+root.getheight()*self.lheight
        img=Image.new('RGB',(imgwidth,imgheight),(255,255,255))
        draw=ImageDraw.Draw(img)
        x=imgwidth/2
        y=self.tmargin
        self.drawnode(draw,root,y,self.lmargin)
        if title:
            draw.text((0,0),title,(0,0,0))
        return img

    def drawnode(self,draw,node,y,left):
        if not node.isleaf():
            childwidth=[child.getwidth(step=self.lwidth) for child in node.children]
            correct_x=self.getcorrectx(node,left)
            draw.text((correct_x-20,y-10),node.getnodetext(),(0,0,0))
            i=0
            y1=y+self.lheight
            for child in node.children:
                x1=self.getcorrectx(child,left)
                self.drawnode(draw,child,y1,left)
                draw.line((correct_x,y,x1,y1),fill=(255,0,0))
                left+=childwidth[i]
                i+=1
        else:
            draw.text((left-20,y-10),node.getnodetext(),(0,0,0))


    def getcorrectx(self,node,left):
        if node.isleaf():
            return left
        childwidth=[child.getwidth(step=self.lwidth) for child in node.children]
        childcount=len(node.children)
        if childcount%2==0:
            mid=childcount//2
            correct_x=sum(childwidth[0:mid])+left
        else:
            if childcount==1:
                return left
            if childcount==3:
                return left+childwidth[0]+childwidth[1]/2
            mid=childcount//2+1
            correct_x=sum(childwidth[0:mid])+left-childwidth[mid]/2
        # if childcount%2==0:
        #     correct_x=(childwidth[childcount//2-1]+childwidth[childcount//2])*.5+left
        # else:
        #     correct_x=childwidth[childcount//2]+left
        return correct_x

