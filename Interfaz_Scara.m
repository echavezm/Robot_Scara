%Programa: Interfaz Robot Scara
% Version: 1.2
% Autor: Eduardo Chavez Mendiola
% Fecha:  13/11/2026

function createNewComponents
clc;


global fig;
fig = uifigure('Name','Interface Scara @ v1.3',...
               'Position',[50 50 1366 768],...
               'Resize', 'off',...
               'CloseRequestFcn',@(fig,event) cerrarPrograma(fig));
           
cp = uipanel('Parent', fig,...
             'Title','',...
             'Position',[800 90 500 280]);
         
infoLabel = uilabel(fig,...
            'Position',[880 650 320 60],...
            'Text','Scara Interface',...
            'FontSize',44,...
            'FontWeight', 'bold');
        
autorLabel = uilabel(fig,...
            'Position',[1145 0 160 22],...
            'Text','',... 
            'FontSize',13,...
            'FontWeight', 'bold');
        
versionLabel = uilabel(fig,...
            'Position',[1255 0 160 22],...
            'Text','version @ 1.3',...
            'FontSize',13,...
            'FontWeight', 'bold');


global ax;
ax = uiaxes(fig, ...
            'Position', [50 30 700 700]);
ax.XLim = [-10 10];
ax.YLim = [-10 10];
ax.ZLim = [-2 15];
ax.XGrid = 'on';
ax.YGrid = 'on';
ax.ZGrid = 'on';

%%%%%%%%%%%%%%%%%%% ESCTRUCTURA DEL SCARA %%%%%%%%%%%%%%%%%%%%
global x y z;
global xtv ytv ztv;
global xth yth zth;
global xs ys zs;

% BASE HEXAGONAL - 4 DE LADO x 1 DE ALTURA
x= [ -2 2 4 2 -2 -4 ; 2 4 2 -2 -4 -2 ; 2 4 2 -2 -4 -2 ; -2 2 4 2 -2 -4 ];
y= [ -(2*sqrt(3)) -(2*sqrt(3)) 0 (2*sqrt(3)) (2*sqrt(3)) 0 ; -(2*sqrt(3)) 0 (2*sqrt(3)) (2*sqrt(3)) 0 -(2*sqrt(3)) ; -(2*sqrt(3)) 0 (2*sqrt(3)) (2*sqrt(3)) 0 -(2*sqrt(3)) ; -(2*sqrt(3)) -(2*sqrt(3)) 0 (2*sqrt(3)) (2*sqrt(3)) 0];
z= [ -1 -1 -1 -1 -1 -1 ; -1 -1 -1 -1 -1 -1 ; 0.5 0.5 0.5 0.5 0.5 0.5 ; 0.5 0.5 0.5 0.5 0.5 0.5 ];

% TORRE RECTANGULAR VERTICAL UNIDA A BASE - 2 DE BASE * 5 DE ALTURA
xtv = [ -1.5 1.5 1.5 -1.5 -1.5 -1.5 ; 1.5 1.5 -1.5 -1.5 1.5 1.5 ; 1.5 1.5 -1.5 -1.5 1.5 1.5 ; -1.5 1.5 1.5 -1.5 -1.5 -1.5 ];
ytv = [ -1.5 -1.5 1.5 1.5 -1.5 -1.5 ; -1.5 1.5 1.5 -1.5 -1.5 -1.5 ; -1.5 1.5 1.5 -1.5 1.5 1.5 ; -1.5 -1.5 1.5 1.5 1.5 1.5 ];
ztv = [ 0.5 0.5 0.5 0.5 0.5 6.5 ; 0.5 0.5 0.5 0.5 0.5 6.5 ; 6.5 6.5 6.5 6.5 0.5 6.5 ; 6.5 6.5 6.5 6.5 0.5 6.5];

% TORRE RECTANGULAR HORIZONTAL
xth = [ -1.5 1.5 1.5 -1.5 -1.5 -1.5 ; 1.5 1.5 -1.5 -1.5 1.5 1.5 ; 1.5 1.5 -1.5 -1.5 1.5 1.5 ; -1.5 1.5 1.5 -1.5 -1.5 -1.5 ];
yth = [ -7 -7 1.5 1.5 -7 -7 ; -7 1.5 1.5 -7 -7 -7 ; -7 1.5 1.5 -7 1.5 1.5 ; -7 -7 1.5 1.5 1.5 1.5 ];
zth = [ 6.5 6.5 6.5 6.5 6.5 8 ; 6.5 6.5 6.5 6.5 6.5 8 ; 8 8 8 8 6.5 8 ; 8 8 8 8 6.5 8 ];

% SHAFT
xs = [ -0.75 0.75 0.75 -0.75 -0.75 -0.75; 0.75 0.75 -0.75 -0.75 0.75 0.75; 0.75 0.75 -0.75 -0.75 0.75 0.75 ; -0.75 0.75 0.75 -0.75 -0.75 -0.75];
ys = [ -8 -8 -7 -7 -8 -8; -8 -7 -7 -8 -8 -8; -8 -7 -7 -8 -7 -7; -8 -8 -7 -7 -7 -7];
zs = [ 6 6 6 6 14 6; 6 6 6 6 14 6; 14 14 14 14 14 6; 14 14 14 14 14 6];
%zs = [ 6 6 6 6 12 6; 6 6 6 6 12 6; 12 12 12 12 12 6; 12 12 12 12 12 6];

% PLOTEO INICIAL DE LA ESTRUCTURA
plot3(x, y , z, 'Parent', ax)
hold( ax, 'on' )
plot3(xtv, ytv , ztv, 'Parent', ax)
plot3(xth, yth , zth, 'Parent', ax)
plot3(xs, ys , zs, 'Parent', ax)
hold( ax, 'off' )

%%%%%%%%%%%%%%%%%%%%%% SLIDERS Y LABELS %%%%%%%%%%%%%%%%%%%%%%%

%///////// LABELS //////////

% LABEL DE LA BASE 
global BaseLabel;
BaseLabel = uilabel(fig,...
            'Parent', cp,...
            'Position',[65 225 160 22],...
            'Text','Base: 0�',... 
            'FontSize',16);
        
% LABEL DEL BRAZO
global BrazoLabel;
BrazoLabel = uilabel(fig,...
            'Parent', cp,...
            'Position',[65 100 160 22],...
            'Text','Brazo: 0�',...
            'FontSize',16);
        
% LABEL DEL SHAFT 
global ShafterLabel;
ShafterLabel = uilabel(fig,...
            'Parent', cp,...
            'Position',[375 225 160 22],...
            'Text','Shaft: 0 cm',...
            'FontSize',16);

%///////// SLIDERS //////////
% SLIDER DE LA BASE
global BaseSlider;        
BaseSlider = uislider(fig,...
               'Parent', cp,...
               'Position',[70 215 270 3],...
               'Limits', [0 360],...
               'Enable', 'on', ...
               'ValueChangingFcn',@(BaseSlider,event) baseUpdateLabel(event, BaseLabel),...
               'ValueChangedFcn',@(BaseSlider,event) baseMov(event));

% SLIDER DEL BRAZO
global BrazoSlider;        
BrazoSlider = uislider(fig,...
               'Parent', cp,...
               'Position',[70 90 270 3],...
               'Limits', [0 360],...
               'Enable', 'on', ...
               'ValueChangingFcn',@(BrazoSlider,event) brazoUpdateLabel(event, BrazoLabel),...
               'ValueChangedFcn',@(BrazoSlider,event) brazoMov(event));

% SLIDER DEL SHAFTER           
global shafterSlider;
shafterSlider = uislider(fig,...
               'Parent', cp,...
               'Position',[410 65 150 3],...
               'Orientation', 'Vertical',...
               'Limits', [0 5],...
               'Enable', 'on', ...
               'ValueChangingFcn',@(shafterSlider,event) shafterUpdateLabel(event, ShafterLabel),...
               'ValueChangedFcn',@(shafterSlider,event) shafterMov(event));  

%%%%%%%%%%%%%%%%%%%%%% VARIABLES CONTROL ROTACION %%%%%%%%%%%%%%%%%%%%%%%

% GRADOS DE CADA EJE
global thetaBase thetaBrazo distShafter;
thetaBase = 0; thetaBrazo = 0; distShafter = 0; 

% MATRICES DE ROTACION
global Tzb Tzbr Tzsh;

Tzb = [ cosd(thetaBase) -sind(thetaBase) 0 0; sind(thetaBase) cosd(thetaBase) 0 0 ; 0 0 1 0 ; 0 0 0 1];
Tzbr = [ cosd(thetaBase + thetaBrazo) -sind( thetaBase + thetaBrazo) 0 0; sind( thetaBase + thetaBrazo) cosd(thetaBase + thetaBrazo) 0 0 ; 0 0 1 0 ; 0 0 0 1];
Tzsh = [ cosd(thetaBase + thetaBrazo) -sind( thetaBase + thetaBrazo) 0 0; sind( thetaBase + thetaBrazo) cosd(thetaBase + thetaBrazo) 0 0 ; 0 0 1 0 ; 0 0 0 1];

global savedBase savedBrazo savedShafter;
savedBase = 0; savedBrazo = 0; savedShafter = 0;

global ciclosBase ciclosBrazo ciclosShafter;
ciclosBase = 0; ciclosBrazo = 0; ciclosShafter = 0;

global enMovimiento;
enMovimiento = false;

global movBase movBrazo movShafter;
movBase = false; movBrazo = false; movShafter = false;

global savedValShafter;
savedValShafter = 0;

global iteBase iteBrazo iteShafter;
iteBase = 1; iteBrazo = 1; iteShafter = 1;

end

% ValueChangingFcn CALLBACK DE LA BASE
function baseUpdateLabel(event, BaseLabel)
    valor = num2str(floor(event.Value));
    formato = sprintf('Base: %s�', valor);
    BaseLabel.Text = formato;
end

% ValueChangedFcn CALLBACK DE LA BASE
function baseMov(event)
global enMovimiento;
global thetaBase;
global ciclosBase savedBase movBase;
global BaseSlider BrazoSlider shafterSlider;

thetaBase = floor(event.Value);
ciclosBase = thetaBase - savedBase;

movBase = true;

    if ~enMovimiento
        enMovimiento = true;
        BaseSlider.Enable = 'off';
        BrazoSlider.Enable = 'off';
        shafterSlider.Enable = 'off';
        rotaciones();
    end

end

% ValueChangingFcn CALLBACK DEL BRAZO
function brazoUpdateLabel(event, BrazoLabel)
    valor = num2str(floor(event.Value));
    formato = sprintf('Brazo: %s�', valor);
    BrazoLabel.Text = formato;
end

% ValueChangedFcn CALLBACK DEL BRAZO
function brazoMov(event)
global enMovimiento;
global thetaBrazo;
global ciclosBrazo savedBrazo movBrazo;
global BaseSlider BrazoSlider shafterSlider;

thetaBrazo = floor(event.Value);
ciclosBrazo = thetaBrazo - savedBrazo;

movBrazo = true;

    if ~enMovimiento
        enMovimiento = true;
        BaseSlider.Enable = 'off';
        BrazoSlider.Enable = 'off';
        shafterSlider.Enable = 'off';
        rotaciones();
    end
end

% ValueChangingFcn CALLBACK DEL SHAFTER
function shafterUpdateLabel(event, ShafterLabel)
    valor = num2str(round(event.Value,2));
    formato = sprintf('Shaft: %s cm', valor);
    ShafterLabel.Text = formato;
end
% ValueChangedFcn CALLBACK DEL SHAFTER
function shafterMov(event)
global enMovimiento;
global distShafter;
global ciclosShafter savedShafter movShafter;
global BaseSlider BrazoSlider shafterSlider;

distShafter = event.Value;
ciclosShafter = distShafter - savedShafter;

movShafter = true;

    if ~enMovimiento
        enMovimiento = true;
        BaseSlider.Enable = 'off';
        BrazoSlider.Enable = 'off';
        shafterSlider.Enable = 'off';
        rotaciones();
    end
end

% ////////////////FUNCIONES PRINCIPALES////////////////////
% FUNCION QUE CONTROLA TODO EL SISTEMA DE ROTACION
function rotaciones()
global enMovimiento;

%BASE
global x y z ax;
global xtv ytv ztv;
%BRAZO
global xth yth zth;
%SHAFTER
global xs ys zs;

%MATRICES
global Tzb Tzbr Tzsh;

global savedBase savedBrazo savedShafter;
global thetaBase thetaBrazo distShafter;
global ciclosBase ciclosBrazo ciclosShafter;
global movBase movBrazo movShafter;
global BaseSlider BrazoSlider shafterSlider;

global iteBase iteBrazo iteShafter;
    
    thetaBaseT = savedBase;
    thetaBrazoT = savedBrazo;
    distShafterT = savedShafter;
  
    clc;
     
    % ITERACIONES PARA CADA PARTE
     stepShafter = 0.1;   
    
    %CICLOS * 10 PARA OBTENER PASOS EN MULTIPLO DE 10
    nuevoCicloShaft = ciclosShafter * 10;
    
     for iteracion = 1:1080
   
        if ciclosBase > 0 && (iteBase <= ciclosBase) && movBase
            thetaBaseT = savedBase + iteBase;
                        iteBase = iteBase + 1;
        elseif ciclosBase < 0 && (iteBase <= abs(ciclosBase)) && movBase
            thetaBaseT = savedBase - iteBase;
                       iteBase = iteBase + 1;
        else 
            iteBase = 1;
            movBase = false;
        end
        
        if ciclosBrazo > 0 && (iteBrazo <= ciclosBrazo) && movBrazo
            thetaBrazoT = savedBrazo + iteBrazo;
                        iteBrazo = iteBrazo + 1;
        elseif ciclosBrazo < 0 && (iteBrazo <= abs(ciclosBrazo)) && movBrazo
            thetaBrazoT = savedBrazo - iteBrazo;
                        iteBrazo = iteBrazo + 1;
        else 
            iteBrazo = 1;
            movBrazo = false;
        end       
        
        %LOS CICLOS SERAN EN MULTIPLOS DE 10 PARA EL SHAFT
        %Y LOS PASOS DE 0.1
        if nuevoCicloShaft > 0 && (iteShafter <= nuevoCicloShaft) && movShafter
            distShafterT = savedShafter + stepShafter;
            stepShafter = stepShafter + 0.1;
                        iteShafter = iteShafter + 1;        
        elseif nuevoCicloShaft < 0 && (iteShafter <= abs(nuevoCicloShaft)) && movShafter
            distShafterT = savedShafter - stepShafter;
            stepShafter = stepShafter + 0.1;
                        iteShafter = iteShafter + 1;            
        else 
            iteShafter = 1;
            stepShafter = 0.1;
            movShafter = false;
        end
        
        
        Tzb = [ cosd(thetaBaseT) -sind(thetaBaseT) 0 0; sind(thetaBaseT) cosd(thetaBaseT) 0 0 ; 0 0 1 0 ; 0 0 0 1];
        Tzbr = [ cosd(thetaBrazoT + thetaBaseT) -sind(thetaBrazoT + thetaBaseT) 0 0; sind(thetaBrazoT + thetaBaseT) cosd(thetaBrazoT + thetaBaseT) 0 0 ; 0 0 1 0 ; 0 0 0 1];   
        Tzsh = [ cosd(thetaBrazoT + thetaBaseT) -sind(thetaBrazoT + thetaBaseT) 0 0; sind(thetaBrazoT + thetaBaseT) cosd(thetaBrazoT + thetaBaseT) 0 0 ; 0 0 1 -distShafterT ; 0 0 0 1];
      
        
        Tc = Tzb; %Matriz Base
        Tc1 = Tzbr; %Matriz Brazo
        Tc2 = Tzsh; %Matriz Shaft

        T = Tc;
        T1 = Tc1;
        T2 = Tc2;
         
        for i=1:4
           for j=1:6
                   
                   r=[x(i,j);y(i,j);z(i,j);1];
                   r1=[xtv(i,j);ytv(i,j);ztv(i,j);1];
                   r2=[xth(i,j);yth(i,j);zth(i,j);1];
                   r3=[xs(i,j);ys(i,j);zs(i,j);1];

                   rc=T * r;
                   rc1=T * r1;
                   rc2=T1 * r2;
                   rc3=T2 * r3;
                  
                   % BASE
                   px(i, j)=rc(1,1);
                   py(i, j)=rc(2,1);
                   pz(i, j)=rc(3,1);  
                   % TORRE VERTICAL
                   px1(i, j)=rc1(1,1);
                   py1(i, j)=rc1(2,1);
                   pz1(i, j)=rc1(3,1); 
                    
                   % BRAZO
                   px2(i, j)=rc2(1,1);
                   py2(i, j)=rc2(2,1);
                   pz2(i, j)=rc2(3,1); 
                   
                   % SHAFT
                   px3(i, j)=rc3(1,1);
                   py3(i, j)=rc3(2,1);
                   pz3(i, j)=rc3(3,1); 
               
           end
        end  
        
        pause(0.01);
        
 %PLOTEOS
        plot3 (px, py, pz, 'Parent', ax);
        hold( ax, 'on' );
        plot3 (px1, py1, pz1, 'Parent', ax);
        plot3 (px2, py2, pz2, 'Parent', ax);
        plot3 (px3, py3, pz3, 'Parent', ax);
        hold( ax, 'off' );

        if ~movBase && ~movBrazo && ~movShafter           
           break;
        end
     end
    
    enMovimiento = false;
    BaseSlider.Enable = 'on';
    BrazoSlider.Enable = 'on';
    shafterSlider.Enable = 'on';

    savedBase = thetaBase;
    savedBrazo = thetaBrazo;
    savedShafter = distShafter;
    
    ciclosBase = 0;
    ciclosBrazo = 0;
    ciclosShafter = 0;
    
 end

% ////////////////CREACION DE LAS FUNCIONES SECUNDARIAS////////////////////

function cerrarPrograma(event) 
    global fig;
    delete(fig); 
    disp('Programa finalizado.');
end

