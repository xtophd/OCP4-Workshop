
mkdir -p /var/www/html

echo "Server up and running" > /var/www/html/test.txt

restorecon -Rv /var/www

docker run -d -p 8000:8000 --name="python_web" \
    -v /usr/sbin:/usr/sbin \
    -v /usr/bin:/usr/bin \
    -v /usr/lib64:/usr/lib64 \
    -v /var/www/html:/var/www/html \
    -w /var/www/html  \
    rhel /bin/python -m SimpleHTTPServer 8000

