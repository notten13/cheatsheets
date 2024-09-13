Name:           myrpm
Version:        0.1.0
Release:        1%{?dist}
Summary:        A simple RPM package that says hello
BuildArch:      noarch

License:        GPL
Source0:        %{name}-%{version}.tar.gz

Requires:       bash

%description
A simple RPM package that says hello

%prep
%setup -q

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT/%{_bindir}
install -m 755 myrpm.sh $RPM_BUILD_ROOT/%{_bindir}/myrpm.sh

%clean
rm -rf $RPM_BUILD_ROOT

%files
%{_bindir}/%{name}.sh

%changelog
# Nothing here yet