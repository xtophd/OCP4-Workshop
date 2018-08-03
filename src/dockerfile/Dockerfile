FROM registry.access.redhat.com/rhscl/php-71-rhel7
MAINTAINER Christoph Doerbeck cdoerbec@redhat.com
USER 0
COPY index.php /tmp/src/
RUN /usr/libexec/s2i/assemble
CMD /usr/libexec/s2i/run
Expose 80
