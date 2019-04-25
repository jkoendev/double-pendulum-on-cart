mkdir tmp
cp README.md tmp
cp matlab/dpc_draw.m tmp
cp matlab/dpc_draw_frame.m tmp
cp matlab/dpc_draw_prepare.m tmp
cp matlab/dpc_endpositions.m tmp
cp matlab/dpc_lagrange.m tmp
cp matlab/dpc_simulate.m tmp
cp -r matlab/simplified/ tmp
cd tmp
zip -r dpc_matlab.zip .
cd ..
cp tmp/dpc_matlab.zip .

rm -rf tmp

mkdir tmp
cp README.md tmp
cp python/dpc_draw.py tmp
cp python/dpc_lagrange.py tmp
cp python/dpc_simulate.py tmp
cp -r python/simplified/ tmp
cd tmp
zip -r dpc_python.zip .
cd ..
cp tmp/dpc_python.zip .
rm -rf tmp
