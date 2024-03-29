% Ngan Jennifer Tram Su [260923530]

function plotconc(rs, Fo, dr, theta, b)
% Phillip Servio (c) 2021
% Figure 1 produces a 2D plot of spatial concentration
% Figure 2 produces a 3D plot of spatial concentration

xx=rs'*ones(1,length(Fo));
figure(1);
thetar=flipud(theta);
thetar(end,:)=[];
theta2=[thetar; theta];
xr=-flipud(xx);
xr(end,:)=[];
xx=[xr; xx];
AX=plot(xx,theta2);
xlabel('r*','fontsize',10,'fontangle','italic')
ylabel('\theta_w*','fontsize',10,'fontangle','italic')
title('\theta_w* vs r* for a sphere with increasing F_{om}',...
    'fontsize',12)
set(gca,'ylim',[0 1],'box','on','TickDir', 'out','XTick',-1:0.1:1,...
    'XTickLabel',...
    {'1','0.9','0.8','0.7','0.6','0.5','0.4','0.3','0.2','0.1','0'...
    '0.1','0.2','0.3','0.4','0.5','0.6','0.7','0.8','0.9','1'})
set(AX,'linewidth',1)
grid off

% Create concentric circles of varying radius about the xy origin as a
% mesh for plotting. Circles are from the center out. This is for Figure (2)
% which is the 3D plot
ths=0:2*pi/dr:2*pi;
[r,th] = meshgrid(rs,ths);
[x,y] = pol2cart(th,r);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2);
colormap winter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(3,2,1)
surf(x,y,(theta(:,1)*ones(1,dr+1))');
set(gca,'zlim',[0 1],'box','off','xTick',-1:1,...
    'xTickLabel',...
    {'1','0','1'},...
    'yTick',-1:1,...
    'yTickLabel',...
    {'1','0','1'})
shading interp
lighting phong%, light

colorbar
xlabel('r*','fontsize',10)
ylabel('r*','fontsize',10)
zlabel('\theta_w*','fontsize',10)
title('F_{om} = 1e-6','fontsize',10)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(3,2,2)
surf(x,y,(theta(:,2)*ones(1,dr+1))');
set(gca,'zlim',[0 1],'box','off','xTick',-1:1,...
    'xTickLabel',...
    {'1','0','1'},...
    'yTick',-1:1,...
    'yTickLabel',...
    {'1','0','1'})
shading interp
lighting phong %, light
colorbar
xlabel('r*','fontsize',10)
ylabel('r*','fontsize',10)
zlabel('\theta_w*','fontsize',10)
title('F_{om} = 0.02','fontsize',10)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(3,2,3)
surf(x,y,(theta(:,6)*ones(1,dr+1))');
set(gca,'zlim',[0 1],'box','off','xTick',-1:1,...
    'xTickLabel',...
    {'1','0','1'},...
    'yTick',-1:1,...
    'yTickLabel',...
    {'1','0','1'})
shading interp
lighting phong%, light
colorbar
xlabel('r*','fontsize',10)
ylabel('r*','fontsize',10)
zlabel('\theta_w*','fontsize',10)
title('F_{om} = 0.1','fontsize',10)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(3,2,4)
surf(x,y,(theta(:,11)*ones(1,dr+1))');
set(gca,'zlim',[0 1],'box','off','xTick',-1:1,...
    'xTickLabel',...
    {'1','0','1'},...
    'yTick',-1:1,...
    'yTickLabel',...
    {'1','0','1'})
shading interp

lighting phong%, light
colorbar
xlabel('r*','fontsize',10)
ylabel('r*','fontsize',10)
zlabel('\theta_w*','fontsize',10)
title('F_{om} = 0.2','fontsize',10)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(3,2,5)
surf(x,y,(theta(:,21)*ones(1,dr+1))');
set(gca,'zlim',[0 1],'box','off','xTick',-1:1,...
    'xTickLabel',...
    {'1','0','1'},...
    'yTick',-1:1,...
    'yTickLabel',...
    {'1','0','1'})
shading interp
lighting phong%, light
colorbar
xlabel('r*','fontsize',10)
ylabel('r*','fontsize',10)
zlabel('\theta_w*','fontsize',10)
title('F_{om} = 0.4','fontsize',10)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(3,2,6)
surf(x,y,(theta(:,end)*ones(1,dr+1))');
set(gca,'zlim',[0 1],'box','off','xTick',-1:1,...
    'xTickLabel',...
    {'1','0','1'},...
    'yTick',-1:1,...
    'yTickLabel',...
    {'1','0','1'})
shading interp
lighting phong%, light
colorbar
xlabel('r*','fontsize',10)
ylabel('r*','fontsize',10)
zlabel('\theta_w*','fontsize',10)
title('F_{om} = 2','fontsize',10)
print(figure(1),'-dpng','-r400',strcat('picture1_', b, '.png'))
print(figure(2),'-dpng','-r600',strcat('picture2_', b, '.png'))

end