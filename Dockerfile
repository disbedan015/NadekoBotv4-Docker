FROM ubuntu:jammy

#NadekoBotV4
COPY scripts/ /opt/scripts/
CMD ["chmod", "+x" "/opt/scripts/00_Installer.sh"]
CMD ["bash", "/opt/scripts/00_Installer.sh"]