FROM node:4-onbuild
# replace this with your application's default port
EXPOSE 8888
RUN apt-get -y update && apt-get install -y build-essential git libopus-dev zlib1g-dev yasm checkinstall
RUN git clone --depth 1 git://source.ffmpeg.org/ffmpeg.git
RUN cd ffmpeg && ./configure --enable-shared --prefix=/usr && make -j4 && checkinstall --pkgname=FFmpeg --fstrans=no --backup=no --pkgversion="$(date +%Y%m%d)-git" --deldoc=yes --default
RUN npm install node-opus
RUN npm install
CMD node lethe.js $EMAIL $PASSWORD
