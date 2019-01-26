set -euo pipefail

export rvm_project_rvmrc=0
# dpkg --list imagemagick
sudo apt-get update
sudo apt-get autoremove -y imagemagick --purge
sudo apt-get install -y build-essential libx11-dev libxext-dev zlib1g-dev libpng-dev libjpeg-dev libfreetype6-dev libxml2-dev vim ghostscript
# sudo apt-get build-dep -y imagemagick
case $IMAGEMAGICK_VERSION in
    latest)
        wget http://www.imagemagick.org/download/ImageMagick.tar.xz
        tar -xf ImageMagick.tar.xz
        cd ImageMagick-*
    ;;
    *)
        wget http://www.imagemagick.org/download/releases/ImageMagick-${IMAGEMAGICK_VERSION}.tar.xz
        tar -xf ImageMagick-${IMAGEMAGICK_VERSION}.tar.xz
        cd ImageMagick-${IMAGEMAGICK_VERSION}
    ;;
esac

if [ -v CONFIGURE_OPTIONS ]; then
  ./configure --prefix=/usr $CONFIGURE_OPTIONS
else
  ./configure --prefix=/usr
fi

sudo make install
cd ..
sudo ldconfig

gem install bundler -v 1.17.3
