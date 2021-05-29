FROM r-base
WORKDIR /r_work/
RUN groupadd -r we_r && useradd -r -g we_r we_r
RUN chgrp -R we_r . && chmod -R g=u .
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get dist-upgrade -y && \
    apt-get clean all && \
    apt-get install --no-install-recommends -y \
    apt-utils
RUN apt-get install --no-install-recommends -y \
    git \
    curl
USER we_r
RUN git clone https://github.com/smatsmats/r_public.git
RUN ls -lR
USER root
RUN R -f r_public/covid19_install_packages.R
USER we_r
CMD ["Rscript", "r_public/covid19_work.R"]
