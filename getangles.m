function angle =getangles( pointlist )
%��������������������������Ƕ�
%pointlist:3*2
angle=[];
%��һ����
x0 = pointlist(1,1);y0 = pointlist(1,2);
x1 = pointlist(2,1);y1 = pointlist(2,2);
x2 = pointlist(3,1);y2 = pointlist(3,2);
a2 = (x1-x0)*(x1-x0)+(y1-y0)*(y1-y0);
b2 = (x2-x0)*(x2-x0)+(y2-y0)*(y2-y0);
c2 = (x1-x2)*(x1-x2)+(y1-y2)*(y1-y2);
cosval = (a2+b2-c2)/sqrt(4*a2*b2);
angle2 = acos(cosval);
angle = [angle;angle2*180/pi];
%�ڶ�����
x0 = pointlist(2,1);y0 = pointlist(2,2);
x1 = pointlist(1,1);y1 = pointlist(1,2);
x2 = pointlist(3,1);y2 = pointlist(3,2);
a2 = (x1-x0)*(x1-x0)+(y1-y0)*(y1-y0);
b2 = (x2-x0)*(x2-x0)+(y2-y0)*(y2-y0);
c2 = (x1-x2)*(x1-x2)+(y1-y2)*(y1-y2);
cosval = (a2+b2-c2)/sqrt(4*a2*b2);
angle2 = acos(cosval);
angle = [angle;angle2*180/pi];
%��������
x0 = pointlist(3,1);y0 = pointlist(3,2);
x1 = pointlist(2,1);y1 = pointlist(2,2);
x2 = pointlist(1,1);y2 = pointlist(1,2);
a2 = (x1-x0)*(x1-x0)+(y1-y0)*(y1-y0);
b2 = (x2-x0)*(x2-x0)+(y2-y0)*(y2-y0);
c2 = (x1-x2)*(x1-x2)+(y1-y2)*(y1-y2);
cosval = (a2+b2-c2)/sqrt(4*a2*b2);
angle2 = acos(cosval);
angle = [angle;angle2*180/pi];

end

