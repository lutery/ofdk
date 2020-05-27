FROM luctery/java8

ADD office-service-1.0.0.jar /office-service.jar
# ADD Apache_OpenOffice_4.1.7_Linux_x86-64_install-deb_zh-CN.tar.gz /Apache_OpenOffice_4.1.7_Linux_x86-64_install-deb_zh-CN
RUN cd /
RUN apt-get update
RUN apt-get install -y wget
RUN wget -P / https://jaist.dl.sourceforge.net/project/openofficeorg.mirror/4.1.7/binaries/zh-CN/Apache_OpenOffice_4.1.7_Linux_x86-64_install-deb_zh-CN.tar.gz
RUN tar -xvf Apache_OpenOffice*.tar.gz
RUN pwd
RUN ls
# RUN dpkg -i /Apache_OpenOffice_4.1.7_Linux_x86-64_install-deb_zh-CN/zh-CN/DEBS/*.deb
RUN dpkg -i zh-CN/DEBS/*.deb
RUN ls /opt/openoffice4/program
RUN find / -name soffice.bin
RUN rm -rf zh-CN
RUN apt-get update
RUN apt-get install -y xserver-xorg
RUN apt-get install -y x-window-system-core
RUN dpkg-reconfigure xserver-xorg 

ENV PATH=/opt/openoffice4/program:$PATH

EXPOSE 8080
EXPOSE 8100

# ENTRYPOINT ["/opt/openoffice4/program/soffice", "-headless", "-nofirststartwizard", "-accept=\"socket,host=0.0.0.0,port=8100;urp;\""]
#启动服务，占用8100端口
CMD /opt/openoffice4/program/soffice -headless -nofirststartwizard  -accept="socket,host=0.0.0.0,port=8100;urp;"
ENTRYPOINT ["java", "-jar", "/office-service.jar"]