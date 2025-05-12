FROM oraclelinux:8

# Install Perl, DBI, and build tools
RUN dnf install -y perl perl-DBI gcc make wget unzip && \
    dnf clean all

# Install Oracle Instant Client
RUN mkdir -p /opt/oracle && \
    cd /opt/oracle && \
    wget https://download.oracle.com/otn_software/linux/instantclient/instantclient-basiclite-linuxx64.zip && \
    wget https://download.oracle.com/otn_software/linux/instantclient/instantclient-sqlplus-linuxx64.zip && \
    wget https://download.oracle.com/otn_software/linux/instantclient/instantclient-sdk-linuxx64.zip && \
    unzip -q -o instantclient-basiclite-linuxx64.zip && \
    unzip -q -o instantclient-sqlplus-linuxx64.zip && \
    unzip -q -o instantclient-sdk-linuxx64.zip && \
    rm -f *.zip && \
    cd /opt/oracle/instantclient_* && \
    rm -f *jdbc* *occi* *mysql* *mql1* *ipc1* *jar uidrvci genezi adrci && \
    echo /opt/oracle/instantclient_* > /etc/ld.so.conf.d/oracle-instantclient.conf && \
    ldconfig

# Set Oracle environment variables
ENV ORACLE_HOME=/opt/oracle/instantclient_23_8
ENV LD_LIBRARY_PATH=$ORACLE_HOME
ENV PATH=$ORACLE_HOME:$PATH
ENV C_INCLUDE_PATH=$ORACLE_HOME/sdk/include
ENV CPLUS_INCLUDE_PATH=$ORACLE_HOME/sdk/include

# Install DBD::Oracle via CPAN
RUN cpan DBD::Oracle

# Create test script
RUN printf '#!/usr/bin/perl\nuse strict;\nuse warnings;\n\nprint "Testing Perl modules...\n";\n\neval {\n    require DBI;\n    print "DBI version: $DBI::VERSION\n";\n} or do {\n    print "Error loading DBI: $@\n";\n};\n\neval {\n    require DBD::Oracle;\n    print "DBD::Oracle version: $DBD::Oracle::VERSION\n";\n} or do {\n    print "Error loading DBD::Oracle: $@\n";\n};\n\nprint "\nEnvironment variables:\n";\nprint "ORACLE_HOME: $ENV{ORACLE_HOME}\n";\nprint "LD_LIBRARY_PATH: $ENV{LD_LIBRARY_PATH}\n";\nprint "PATH: $ENV{PATH}\n";' > /usr/local/bin/test-perl-oracle && \
    chmod +x /usr/local/bin/test-perl-oracle

# Keep container running
CMD ["tail", "-f", "/dev/null"]
