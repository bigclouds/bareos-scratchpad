

cmake .. -DCMAKE_INSTALL_PREFIX=$HOME/bareos/bareos-cmake\
   -Dlibdir=$HOME/bareos/bareos-cmake/lib

#  --prefix=%{_prefix} \
#  --libdir=%{library_dir} \
#  --sbindir=%{_sbindir} \
#  --with-sbin-perm=755 \
#  --sysconfdir=%{_sysconfdir} \
#  --with-confdir=%{_sysconfdir}/bareos \
#  --mandir=%{_mandir} \
#  --docdir=%{_docdir}/%{name} \
#  --htmldir=%{_docdir}/%{name}/html \
#  --with-archivedir=/var/lib/bareos/storage \
#  --with-backenddir=%{backend_dir} \
#  --with-scriptdir=%{script_dir} \
#  --with-working-dir=%{working_dir} \
#  --with-plugindir=%{plugin_dir} \
#  --with-pid-dir=%{pid_dir} \
#  --with-bsrdir=%{bsr_dir} \
#  --with-logdir=/var/log/bareos \
#  --with-subsys-dir=%{_subsysdir} \
#%if 0%{?python_plugins}
#  --with-python \
#%endif
#  --enable-smartalloc \
#  --disable-conio \
#  --enable-readline \
#  --enable-batch-insert \
#  --enable-dynamic-cats-backends \
#  --enable-dynamic-storage-backends \
#  --enable-scsi-crypto \
#  --enable-lmdb \
#  --enable-ndmp \
#  --enable-ipv6 \
#  --enable-acl \
#  --enable-xattr \
#%if 0%{?build_bat}
#  --enable-bat \
#%endif
#%if 0%{?build_qt_monitor}
#  --enable-traymonitor \
#%endif
#%if 0%{?client_only}
#  --enable-client-only \
#%endif
#  --with-postgresql \
#  --with-mysql \
#%if 0%{?build_sqlite3}
#  --with-sqlite3 \
#%endif
#  --with-tcp-wrappers \
#  --with-dir-user=%{director_daemon_user} \
#  --with-dir-group=%{daemon_group} \
#  --with-sd-user=%{storage_daemon_user} \
#  --with-sd-group=%{storage_daemon_group} \
#  --with-fd-user=%{file_daemon_user} \
#  --with-fd-group=%{daemon_group} \
#  --with-dir-password="XXX_REPLACE_WITH_DIRECTOR_PASSWORD_XXX" \
#  --with-fd-password="XXX_REPLACE_WITH_CLIENT_PASSWORD_XXX" \
#  --with-sd-password="XXX_REPLACE_WITH_STORAGE_PASSWORD_XXX" \
#  --with-mon-dir-password="XXX_REPLACE_WITH_DIRECTOR_MONITOR_PASSWORD_XXX" \
#  --with-mon-fd-password="XXX_REPLACE_WITH_CLIENT_MONITOR_PASSWORD_XXX" \
#  --with-mon-sd-password="XXX_REPLACE_WITH_STORAGE_MONITOR_PASSWORD_XXX" \
#  --with-openssl \
#  --with-basename="XXX_REPLACE_WITH_LOCAL_HOSTNAME_XXX" \
#  --with-hostname="XXX_REPLACE_WITH_LOCAL_HOSTNAME_XXX" \
#%if 0%{?systemd_support}
#  --with-systemd \
#%endif
#  --enable-includes
#
