img = imread('��ά��1.jpg');          %read the img
imgbw = im2bw(img,graythresh(img));  %binaryzation by auto threshhold
imgfiltered = filter2(fspecial('average',5),imgbw); %filtered using 5*5
imgbw2 = im2bw(imgfiltered,graythresh(imgfiltered));
pixelsize = 0;
npixelsize = 0;
%processing by row
[nrow,ncol] = size(imgbw);
edgemat = [];
matcenterx = [];
matcentery = [];
for i = 1:nrow
    maybeedge = zeros(1,2);
    pieces = zeros(1,1);
    count = 0;
    for j = 1:(ncol-1)
        if(imgbw2(i,j)~=imgbw2(i,j+1))%this pixel ~=next pixel
            maybeedge = [maybeedge;i,j];
            pieces = [pieces,count];
            count = 0;
        else
            count = count + 1;
        end
    end %finish one row
    pieces = [pieces,count];
    pieces = pieces(1,2:size(pieces,2));
    npieces = size(pieces,2);
    maybeedge = maybeedge(2:size(maybeedge,1),:);
    if(npieces>6)%position sign maybe existed this row
        for k=3:(npieces-2)%find pos sign
            ratio = 1;
            if(abs(pieces(k)/pieces(k-1)-3)<ratio)
                if(abs(pieces(k)/pieces(k-2)-3)<ratio)
                    if(abs(pieces(k)/pieces(k+1)-3)<ratio)
                        if(abs(pieces(k)/pieces(k+2)-3)<ratio)
                            %pos sign edge found
                            edgemat = [edgemat;i,maybeedge((k-1),2)];
                            edgemat = [edgemat;i,maybeedge(k,2)];
                            matcenterx = [matcenterx;i,round((maybeedge((k-1),2)+maybeedge(k,2))/2)];
                            npixelsize = npixelsize + 1;
                            pixelsize = pixelsize*(npixelsize-1)+round(pieces(k)/3);
                            pixelsize = round(pixelsize/npixelsize);
                        end
                    end
                end
            end
        end
    end
end
edgelistx = edgemat;
edgeimx = ~zeros(size(imgbw,1),size(imgbw,2));
for i = 1:size(edgelistx,1)
    edgeimx(edgelistx(i,1),edgelistx(i,2)) = 0;
end

centerimx = ~zeros(size(imgbw,1),size(imgbw,2));
for i = 1:size(matcenterx,1)
    centerimx(matcenterx(i,1),matcenterx(i,2)) = 0;
end
%finish processing rows,get edgelistx/edgeimx

%processing cols
edgemat = [];
for j = 1:ncol
    maybeedge = zeros(1,2);
    pieces = zeros(1,1);
    count = 0;
    for i = 1:(nrow-1)
        if(imgbw2(i,j)~=imgbw2(i+1,j))
            maybeedge = [maybeedge;i,j];
            pieces = [pieces,count];
            count = 0;
        else
            count = count + 1;
        end
    end %finish one col
    pieces = [pieces,count];
    pieces = pieces(1,2:size(pieces,2));
    npieces = size(pieces,2);
    maybeedge = maybeedge(2:size(maybeedge,1),:);
    if(npieces>6)
        for k=3:(npieces-2)
            ratio = 1;
            if(abs(pieces(k)/pieces(k-1)-3)<ratio)
                if(abs(pieces(k)/pieces(k-2)-3)<ratio)
                    if(abs(pieces(k)/pieces(k+1)-3)<ratio)
                        if(abs(pieces(k)/pieces(k+2)-3)<ratio)
                            %found edge
                            edgemat = [edgemat;maybeedge((k-1),1),j];
                            edgemat = [edgemat;maybeedge(k,1),j];
                            matcentery = [matcentery;round((maybeedge((k-1),1)+maybeedge(k,1))/2),j];
                            npixelsize = npixelsize + 1;
                            pixelsize = pixelsize*(npixelsize-1)+round(pieces(k)/3);
                            pixelsize = round(pixelsize/npixelsize);
                        end
                    end
                end
            end
        end
    end
end
edgelisty = edgemat;
edgeimy = ~zeros(size(imgbw,1),size(imgbw,2));
for i = 1:size(edgelisty,1)
    edgeimy(edgelisty(i,1),edgelisty(i,2)) = 0;
end

centerimy = ~zeros(size(imgbw,1),size(imgbw,2));
for i = 1:size(matcentery,1)
    centerimy(matcentery(i,1),matcentery(i,2)) = 0;
end
%finish rol

edgeim = edgeimx&edgeimy;
edgeimf = filter2(fspecial('average',3),edgeim); %filtered using 3*3
edgebw = im2bw(edgeimf,graythresh(edgeimf)); 

centerim = centerimx|centerimy;
numofcontrol = sum(sum(~centerim));
if(numofcontrol~=3) %succeed to get the pos control sign
    disp('failed to get the 3 control points');
    return;
end
[centerlistx,centerlisty]=find(centerim~=1); %find the 3 centers
centerlist=[centerlistx,centerlisty];

%cut
xdistance=min([max(centerlistx)-median(centerlistx),median(centerlistx)-min(centerlistx)]);
ydistance=min([max(centerlisty)-median(centerlisty),median(centerlisty)-min(centerlisty)]);
left = max([0,round(min(centerlistx)-xdistance-6.364*pixelsize)]);
right = min([size(imgbw2,2),round(max(centerlistx)+xdistance+6.364*pixelsize)]);
up = max([0,round(min(centerlisty)-ydistance-6.364*pixelsize)]);
down = min([size(imgbw2,1),round(max(centerlisty)+ydistance+6.364*pixelsize)]);
imgbw3 = imgbw2(left:right,up:down);%up:down,left:right
centerim3 = centerim(left:right,up:down);
[centerlistx3,centerlisty3]=find(centerim3~=1); %find the 3 centers
centerlist3=[centerlistx3,centerlisty3];
%finish cutting(get centerlist3,imgbw3,)

finalimg = imgbw3;
imshow(finalimg);
hold on;
%imshow(edgebw);
%plot(edgelisty(:,2),edgelisty(:,1),'r.');
%plot(edgelistx(:,2),edgelistx(:,1),'b.');
plot(centerlist3(:,2),centerlist3(:,1),'r.');