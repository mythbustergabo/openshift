#!/bin/bash

# Deshabilitamos el firewall
systemctl disable firewalld
systemctl stop firewalld

#Ponemos SeLinux a permisivo
sed -i "s/enforcing/disabled/g" /etc/selinux/config


#Obteniendo la IP del servidor
interface=""
IP=`ip a show $interface | grep -v inet6 | grep inet | awk -F "inet" {'print $2'} | awk -F "\/" {'print $1'}`

#Ponemos el nombre del servidor en el hosts
echo "$IP master" >> /etc/hosts

#Poniendo las llaves para conectarnos entre servidores
cat > ~/.ssh/id_rsa.pub << EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC4uWqOrpAF3AB38h63bnAtE5v6RvCRJTxUkK401tlV0s/Q7TMgeLew8GaZukwsnphJ9jcQBmexe2hGlVcZNnqrLMaI2URxAX3QbPOtP/CSYszrk/j+zjs3ppuc/yKmDXpxeKTOyraV121+RZR6EM9l/MJJe/FrxR4P+wYdZ+5U9sMjVgFXaYQoO+/8kap9GyFOOjjVfmFttoeUcugeVgHw4B4FkdbCLCNKiSPQRSdbH02n3+c7gcZ4yC05vOKihnn7czqTL7+bNqxB8RMkjWXKqdEyYSgEhQDwKI62tSPtdfY3Ay9e9NGf/N21xC+WZqHlDGr2c2RYjiMpRa29BU+N root@openshift
EOF

cat > ~/.ssh/authorized_keys << EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC4uWqOrpAF3AB38h63bnAtE5v6RvCRJTxUkK401tlV0s/Q7TMgeLew8GaZukwsnphJ9jcQBmexe2hGlVcZNnqrLMaI2URxAX3QbPOtP/CSYszrk/j+zjs3ppuc/yKmDXpxeKTOyraV121+RZR6EM9l/MJJe/FrxR4P+wYdZ+5U9sMjVgFXaYQoO+/8kap9GyFOOjjVfmFttoeUcugeVgHw4B4FkdbCLCNKiSPQRSdbH02n3+c7gcZ4yC05vOKihnn7czqTL7+bNqxB8RMkjWXKqdEyYSgEhQDwKI62tSPtdfY3Ay9e9NGf/N21xC+WZqHlDGr2c2RYjiMpRa29BU+N root@openshift
EOF

cat > ~/.ssh/id_rsa << EOF
-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAABFwAAAAdzc2gtcn
NhAAAAAwEAAQAAAQEAuLlqjq6QBdwAd/Iet25wLROb+kbwkSU8VJCuNNbZVdLP0O0zIHi3
sPBmmbpMLJ6YSfY3EAZnsXtoRpVXGTZ6qyzGiNlEcQF90GzzrT/wkmLM65P4/s47N6abnP
8ipg16cXikzsq2lddtfkWUehDPZfzCSXvxa8UeD/sGHWfuVPbDI1YBV2mEKDvv/JGqfRsh
Tjo41X5hbbaHlHLoHlYB8OAeBZHWwiwjSokj0EUnWx9Np9/nO4HGeMgtObziooZ5+3M6ky
+/mzasQfETJI1lyqnRMmEoBIUA8CiOtrUj7XX2NwMvXvTRn/zdtcQvlmah5Qxq9nNkWI4j
KUWtvQVPjQAAA8AWVf8hFlX/IQAAAAdzc2gtcnNhAAABAQC4uWqOrpAF3AB38h63bnAtE5
v6RvCRJTxUkK401tlV0s/Q7TMgeLew8GaZukwsnphJ9jcQBmexe2hGlVcZNnqrLMaI2URx
AX3QbPOtP/CSYszrk/j+zjs3ppuc/yKmDXpxeKTOyraV121+RZR6EM9l/MJJe/FrxR4P+w
YdZ+5U9sMjVgFXaYQoO+/8kap9GyFOOjjVfmFttoeUcugeVgHw4B4FkdbCLCNKiSPQRSdb
H02n3+c7gcZ4yC05vOKihnn7czqTL7+bNqxB8RMkjWXKqdEyYSgEhQDwKI62tSPtdfY3Ay
9e9NGf/N21xC+WZqHlDGr2c2RYjiMpRa29BU+NAAAAAwEAAQAAAQBvWv7cYmjZz2TM6b0Q
kNe4pLCLcEZHCS5UQB90JOxBK2MxrDv84CjD1jfThhWzdCuTsoRA+ct6l00l95LY1RmfpM
9N4cO7Z83DXlqK3xeT91FW1g3s9L+H7byzKK5ncYqVasfXDSaCL6qGy0UVTJrp/TPV/oxr
jhlwQr/N7EAlINIHx3TbZd9bwVa+UULIBF5w4OJfP6d2yIfBrCjdg3ZQG6miz1F5LxthR3
xhJ+VpoO5VoP9ozfbT7YXDG6w47iNXXGpWqkUry6kjWh14SNhyVlIez298KAfdArveiRg8
wCVuBGapxqS6iAqC5Rf5P8A/eJLFybtx6u1rLl1Y8S4hAAAAgDPMX4PsS6Kso39qYXjNzp
zZTKgXL0b6Vgj8llL7cL1jIu8KG3uxAOiT2IcT5vTGdDNal6UOzz6kSfB4aL810scq4Dux
kuxm2WgUCX7Dxgd2DqD3vxMwXUfAuhpkxltVhVQfnL2QWdzYjpPoooezBfV0AUlnVrkS2v
Fv1rO2uHnnAAAAgQDdwXybuazlZNbjy6/3+4Kyu6bwaEZn6Chr8xiufYTJ9a2408APgYl/
TerrZwlTyZC5W/2/40MJ4O4KzXTFlQk0jeVidZ53pA/L/pnywOo3csxupP7u46v7/fRleZ
m8sN06ubVmpdo360B5Ar3Ilq1CpefYByiQCLZE1pOAHUkmOQAAAIEA1T/9H28GdAznfZPt
I9z5N/wNbT6Olh/NRSiOK7LXlUFUHj//aF79XjPfap6PqmythVf/pK+d/JHPgm5YkFAHWv
hjAfzkX5wrTwX2H8ViVrl8RlaNz7DLaVaf9FQwRRhlyVlNhT2YgDuGanKG6W+1/in0cklu
MD52OkjZF8WZk/UAAAALcm9vdEBkZWJpYW4=
-----END OPENSSH PRIVATE KEY-----
EOF

#Cambiando permisos al authorized_keys
chmod 600 ~/.ssh/authorized_keys
