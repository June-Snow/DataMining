 
 WminRow =[1 1 2 2;
0 0 0 0;
0 0 0 0];
 WminCol = [1 1 1 -1;
1 1 0 -1;
1 1 0 -1;]


 blockInf(:,:,1) = WminRow; 
 blockInf(:,:,2) = WminCol;
 imageInf  = getImageInf( blockInf )
 
 imageCol = consisImg( ones(3,4), WminCol,3,4 )