function angle =getangles( pointlist )
%由三个点坐标求三角形三个点角度
%pointlist:3*2
angle=[];
%第一个点
x0 = pointlist(1,1);y0 = pointlist(1,2);
x1 = pointlist(2,1);y1 = pointlist(2,2);
x2 = pointlist(3,1);y2 = pointlist(3,2);
a2 = (x1-x0)*(x1-x0)+(y1-y0)*(y1-y0);
b2 = (x2-x0)*(x2-x0)+(y2-y0)*(y2-y0);
c2 = (x1-x2)*(x1-x2)+(y1-y2)*(y1-y2);
cosval = (a2+b2-c2)/sqrt(4*a2*b2);
angle2 = acos(cosval);
angle = [angle;angle2*180/pi];
%第二个点
x0 = pointlist(2,1);y0 = pointlist(2,2);
x1 = pointlist(1,1);y1 = pointlist(1,2);
x2 = pointlist(3,1);y2 = pointlist(3,2);
a2 = (x1-x0)*(x1-x0)+(y1-y0)*(y1-y0);
b2 = (x2-x0)*(x2-x0)+(y2-y0)*(y2-y0);
c2 = (x1-x2)*(x1-x2)+(y1-y2)*(y1-y2);
cosval = (a2+b2-c2)/sqrt(4*a2*b2);
angle2 = acos(cosval);
angle = [angle;angle2*180/pi];
%第三个点
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

