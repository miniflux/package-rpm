Name:    miniflux
Version: 2.0.7
Release: 1.0
Summary: Minimalist feed reader
URL: https://miniflux.net/
License: Apache Software License 2.0
Source0: miniflux
Source1: miniflux.service
Source2: miniflux.conf
BuildRoot: %{_topdir}/BUILD/%{name}-%{version}-%{release}
BuildArch: x86_64
Requires(pre): shadow-utils

%{?systemd_requires}
BuildRequires: systemd

%description
%{summary}

%install
mkdir -p %{buildroot}/%{_bindir}
install -p -m 755 %{SOURCE0} %{buildroot}/%{_bindir}
install -D -m 644 %{SOURCE1} %{buildroot}%{_unitdir}/miniflux.service
install -D -m 644 %{SOURCE2} %{buildroot}%{_sysconfdir}/miniflux.conf

%files
%defattr(755,root,root)
%{_bindir}/miniflux
%defattr(644,root,root)
%{_unitdir}/miniflux.service
%defattr(644,root,root)
%config(noreplace) %{_sysconfdir}/miniflux.conf

%pre
getent group miniflux >/dev/null || groupadd -r miniflux
getent passwd miniflux >/dev/null || \
    useradd -r -g miniflux -d /dev/null -s /sbin/nologin \
    -c "Miniflux Daemon" miniflux
exit 0

%post
%systemd_post miniflux.service

%preun
%systemd_preun miniflux.service

%postun
%systemd_postun_with_restart miniflux.service

%changelog
