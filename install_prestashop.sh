#/sbin/bash
#########################################################
# script d'installation auomatisé par sbeteta@beteta.org#
#########################################################

#Installation des dépendances fonctionnelles
echo "Installation des dépendances fonctionnelles"
apt install -y net-tools apache2 mariadb-serverphp7.3 php7.3-gd php7.3-mbstring php7.3-mysql php7.3-curl php-xml php7.3-intl php7.3-zip php-simplexml php-zip

# on relance apache et mariadb
echo "on relance apache et mariadb"
/etc/init.d/apache2 restart
/etc/init.d/mysql restart

# creation de la base de données
echo "creation de la base de données"
mysql -u root -e "create database presta;"
mysql -u root -e "grant all privileges on presta.* to 'root'@'localhost' identified by 'operations';"
mysql -u root -e "flush privileges;"

################################################
#Téléchargement et installation de Prestatshop #
################################################

#on se déplace dans le dossier /tmp
cd /tmp

# on télécharge sur github l’archive zip de prestashop...
echo "on télécharge sur github l’archive zip de prestashop..." 
wget -c https://github.com/PrestaShop/PrestaShop/releases/download/1.7.6.0/prestashop_1.7.6.0.zip

# 0n créer le dossier pour prestashop
mkdir prestashop

# on dézippe l’archive dans le dossier prestashop
echo "on dézippe l’archive dans le dossier prestashop"
unzip prestashop_1.7.6.0.zip -d prestashop/

#On va dans le dossier prestashop
cd prestashop/
echo " On dezippe l'archive zip de PRESTASHOP"
unzip prestashop.zip 

#on déplace le dossier prestatshop dans /var/www/html
echo "on déplace le dossier prestatshop dans /var/www/html"
cd ..
mv prestashop /var/www/html/

#on met les droits et persmissions sur le dossier prestatshop
chown -R www-data:www-data /var/www/html/prestashop/
chmod -R 755 /var/www/html/prestashop/

# Mise à jour de serveur web APACHE2
echo "Mise à jour de serveur web APACHE2"
a2enmod rewrite
systemctl restart apache2
echo "Installation de PRESTASHOP terminé."
