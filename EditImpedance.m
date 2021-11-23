function EditImpedance(fid, ImpedanceName, Resistance, Reactance, InfGroundPlane)
    
    if (nargin < 4)
        Reactance=0;
        InfGroundPlane = 'false';
    elseif (nargin == 4)
        InfGroundPlane = 'false';
    end
    
    % Preamble.
    fprintf(fid, '\n');
    fprintf(fid, 'Set oModule = oDesign.GetModule("BoundarySetup") \n');
    fprintf(fid, '\n');
    fprintf(fid, 'oModule.EditImpedance "%s",_\n',ImpedanceName);
    fprintf(fid, 'Array( _\n');
    fprintf(fid, '"NAME:%s", _\n', ImpedanceName);
%     fprintf(fid, '"Faces:=", Array(%d), _\n', SheetObject);
%     fprintf(fid, '"Objects:=", Array("%s"), _\n', SheetObject);
    fprintf(fid, '"Resistance:=", "%f", _\n', Resistance);
    fprintf(fid, '"Reactance:=", "%f", _\n', Reactance);
    fprintf(fid, '"InfGroundPlane:=", %s)\n', InfGroundPlane);

end