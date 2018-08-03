FROM registry.access.redhat.com/rhscl/php-71-rhel7
MAINTAINER Christoph Doerbeck cdoerbec@redhat.com
COPY index.php /var/www/html
RUN /usr/libexec/s2i/assemble
CMD /usr/libexec/s2i/run
Expose 80
