function x = GetScalar(journalfile,scalarfile,t0,t1)


J=Journal(journalfile);
X=matlabfm('new_DoubleVector');
matlabjournal('Journal_ReadScalarSequence',ptr(J),scalarfile,X,t0,t1);
x=matfm('DoubleVector2mxArray',X);
matlabfm('delete_DoubleVector',X);
