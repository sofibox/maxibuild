mkdir -p /usr/local/maxicode/maxibuild

git clone https://github.com/sofibox/maxibuild_public.git /usr/local/maxicode/maxibuild

chmod +x /usr/local/maxicode/maxibuild/maxibuild

ln -s /usr/local/maxicode/maxibuild/maxibuild /usr/local/bin

maxibuild --version
