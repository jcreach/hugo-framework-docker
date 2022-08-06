FROM mcr.microsoft.com/powershell:lts-nanoserver-1809

LABEL author="Julien Creach"
LABEL maintainer="julien.creach@pm.me"


USER ContainerAdministrator
SHELL ["pwsh", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV HUGO_EXT_VERSION=0.98.0 \ 
    HUGO_BASEURL="http://localhost/" \
    HUGO_SITE="c:\hugo-site"
# Env var hugo extended
RUN $newPath = ('c:\hugo-ext;{0}' -f $env:PATH); 	Write-Host ('Updating PATH: {0}' -f $newPath); 	setx /M PATH $newPath;

# Download hugo extended
ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_EXT_VERSION}/hugo_extended_${HUGO_EXT_VERSION}_Windows-64bit.zip hugo-ext.zip

# Install hugo extended
RUN Expand-Archive .\hugo-ext.zip -DestinationPath c:\hugo-ext;
RUN Write-Host 'Verifying install ("hugo version") ...';
RUN hugo version;

# Clean files
RUN Write-Host 'Removing ...';
RUN Remove-Item .\hugo-ext.zip -Force;

WORKDIR ${HUGO_SITE}

VOLUME ${HUGO_SITE}

EXPOSE 1313

CMD ["hugo", "server", "--bind", "0.0.0.0", "--navigateToChanged", "--templateMetrics", "--buildDrafts", "--appendPort=false", "--minify", "--gc", "--baseURL", "echo ${HUGO_BASEURL}"]