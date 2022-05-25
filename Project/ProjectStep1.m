clc;clear all;
e230481_IPEK("Input_file_example1.txt","library.csv")
function [S_base,V_base,N_circuit,N_bundle,D_bundle,length,conductor_name,outside_diameter,R_AC,GMR_conductor]=e230481_IPEK(text_path,library_path)
fid = fopen(text_path);
while true
    if fgetl(fid) == 'Sbase (MVA)'
        S_base=str2double(fgetl(fid))*1000000;
    end
    if fgetl(fid) == 'Vbase (kV)'
        V_base=str2double(fgetl(fid))*1000;
    end
    if fgetl(fid) == 'Number of circuits'
        N_circuit=str2double(fgetl(fid));
    end
    if fgetl(fid) == 'Number of bundle conductors per phase'
        N_bundle=str2double(fgetl(fid));
    end
    if fgetl(fid) == 'Bundle distance (m)'
        D_bundle=str2double(fgetl(fid));
    end
    if fgetl(fid) == 'Length of the line (km)'
        length=str2double(fgetl(fid))*1000;
    end
    if fgetl(fid) == 'ACSR conductor name'
        conductor_name=fgetl(fid);
        break
    end
end
fclose(fid);
T = readtable(library_path,'VariableNamingRule','preserve') % converting csv to table T
names=table2array(T(:,1)); % Extracting conductor names from table T
index = find(strcmp(names, conductor_name)); % Finding index where our conductor is 
outside_diameters=table2array(T(:,5)); % Extracting outside diameter values from table T
outside_diameter=outside_diameters(index); % Finding desired outside diameter in in
outside_diameter= outside_diameter * 0.0254; % Converting in to m ( 1 in == 0.0254 m)
RACs=table2array(T(:,7)); % Extracting AC resistance values from table T
R_AC=RACs(index); % Finding desired outside diameter in ohm/mil
R_AC= R_AC / 1609.344;  % Converting ohm/mil to ohm/m ( 1 mil == 1609.344 m)
GMRconductors=table2array(T(:,8)); % Extracting AC resistance values from table T
GMR_conductor=GMRconductors(index); % Finding desired GMR in ft
GMR_conductor=GMR_conductor *0.3048; % Converting ft to m ( 1 ft == 0.3048 m)
end
