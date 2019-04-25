mkdir tmp
cp README.md tmp
cp matlab/* tmp
cp -r matlab/simplified/ tmp
cd tmp
zip -r dpc_matlab.zip .
cd ..
cp tmp/dpc_matlab.zip .

rm -rf tmp

mkdir tmp
cp README.md tmp
cp python/* tmp
cp -r python/simplified/ tmp
cd tmp
zip -r dpc_python.zip .
cd ..
cp tmp/dpc_python.zip .
rm -rf tmp
