img = imread('ЖўЮЌТы1.jpg');          %read the img
imgbw = im2bw(img,graythresh(img));  %binaryzation by auto threshhold
imgfiltered = filter2(fspecial('average',5),imgbw); %filtered using 5*5
imgbw2 = im2bw(imgfiltered,graythresh(imgfiltered));
pixelsize = 0;
npixelsize = 0;
%processing by row
[nrow,ncol] = size(imgbw);
edgemat = zeros(1,2);
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
edgelistx = edgemat(2:size(edgemat,1),:);
edgeimx = ~zeros(size(imgbw,1),size(imgbw,2));
for i = 1:size(edgelistx,1)
    edgeimx(edgelistx(i,1),edgelistx(i,2)) = 0;
end
%finish processing rows,get edgelistx/edgeimx

%processing cols
edgemat = zeros(1,2);
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
edgelisty = edgemat(2:size(edgemat,1),:);
edgeimy = ~zeros(size(imgbw,1),size(imgbw,2));
for i = 1:size(edgelisty,1)
    edgeimy(edgelisty(i,1),edgelisty(i,2)) = 0;
end
%finish rol
edgeim = edgeimx&edgeimy;
edgeimf = filter2(fspecial('average',3),edgeim); %filtered using 3*3
edgebw = im2bw(edgeimf,graythresh(edgeimf)); 

finalimg = imgbw2;
imshow(finalimg);
hold on;
%imshow(edgebw);
plot(edgelisty(:,2),edgelisty(:,1),'r.');
plot(edgelistx(:,2),edgelistx(:,1),'b.');