@echo on
echo delete files£¬please wait...

cd mOCRDLL
call clearmyself.bat
cd ..

cd mOCVDLL
call clearmyself.bat
cd ..

cd mPDFDLL
call clearmyself.bat
cd .

cd mSMARTdll
call clearmyself.bat
cd ..

cd SMVII
call clearmyself.bat
cd ..

cd SMVIIDos
call clearmyself.bat
cd ..

cd mSWDIdll
call clearmyself.bat
cd ..

echo finished!

rd/q/s .\_temp
rd/q/s .\_bin
del/q  .\SDKdll\lib\mSmart*.*
