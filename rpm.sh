# Install required dependencies
sudo dnf install -y rpmdevtools rpmlint

# Setup the folder tree that is required for RPM to work properly
# This is a "rpmbuild" folder containing folders such as "SOURCES", "SPECS"...
rpmdev-setuptree

# Create something you want to package, here we'll use a simple shell script
cat << EOF > myrpm.sh
#!/bin/sh
echo "Hello! This is my first RPM!"
EOF

# Place the script in a folder called <package-name>-<version>
mkdir myrpm-0.1.0
mv myrpm.sh myrpm-0.1.0
tar --create --file myrpm-0.1.0.tar.gz myrpm-0.1.0

# Now place the archive in the SOURCES folder
mv myrpm-0.1.0.tar.gz rpmbuild/SOURCES

# Generate a spec file
# The .spec file defines what the software is, how it should be installed, what
# dependencies it has and how it should be uninstalled
cd rpmbuild/SPECS
rpmdev-newspec myrpm

# Build the package
rpmbuild -ba rpmbuild/SPECS/myrpm.spec

# Install the package
dnf install rpm/RPMS/noarch/myrpm-0.0.1-1.fc40.noarch.rpm

# Check the files installed by an RPM
rpm -ql myrpm

# Removing the package
rpm remove myrpm
