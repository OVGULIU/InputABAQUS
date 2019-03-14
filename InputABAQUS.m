%function [NODE,C3D8R,C3D6]=InputABAQUS(ft)
%读取ABAQUS前处理的节点和网格信息；
%*************************
%Author:ZHOUKAI
%E-mail:1020155056@qq.com
%Date:2019/03/14
%*************************

%% 文件位置以及文件名称；
filepath='D:\temp\';
filename='2019031303.inp';
ft=fopen(strcat(filepath,filename),'r');
str1='*Node';
str2='*Element, type=C3D8R';
str3='*Element, type=C3D6';
str4='*Nset, nset=Set-1, generate';
t1=1;
t2=1;
t3=1;
NODE=zeros(4,10000);
C3D8R=zeros(9,10000);%六面体单元；
C3D6=zeros(7,10000);%楔形单元；（根据需要可以自由添加）

%% 开始读取；
while ~feof(ft)
    tline=fgetl(ft);
    while strcmp(tline,str1)
        tline=fgetl(ft);
        %disp(tline);
        while ~strcmp(tline,str2)
            tline(find(isspace(tline)))=[];
            NODE(:,t1)=sscanf(tline,'%d,%f,%f,%f');
            t1=t1+1;
            tline=fgetl(ft);
        end
        tline=fgetl(ft);
        while ~strcmp(tline,str3)
            tline(find(isspace(tline)))=[];
            C3D8R(:,t2)=sscanf(tline,'%d,%f,%f,%f,%f,%f,%f,%f,%f');
            t2=t2+1;
            tline=fgetl(ft);
        end
        tline=fgetl(ft);
        while ~strcmp(tline,str4)
            tline(find(isspace(tline)))=[];
            C3D6(:,t3)=sscanf(tline,'%d,%f,%f,%f,%f,%f,%f');
            t3=t3+1;
            tline=fgetl(ft);
        end
    end
end

%% 将结点和单元信息进行存储；
NODE=NODE';
i1=max(NODE(:,1));
NODE(i1+1:10000,:)=[];
C3D8R=C3D8R';
i2=max(C3D8R(:,1));
C3D8R(i2+1:10000,:)=[];
C3D6=C3D6';
i3=max(C3D6(:,1));
i4=C3D6(1,1);
C3D6(i3-i4+2:10000,:)=[];
%end