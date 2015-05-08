FROM heroku/cedar:14

# Install Haskell and Cabal
RUN apt-get update && \
    apt-get -y install haskell-platform wget libncurses5-dev && \
    apt-get clean
RUN cabal update && cabal install cabal-install

# Elm 0.15, per http://elm-lang.org/Install.elm
# Modify this instruction for newer releases.
ENV ELM_VERSION 0.15
ENV CABAL_INSTALL cabal install --disable-documentation -j
RUN ${CABAL_INSTALL} elm-compiler-0.15 elm-package-0.5 elm-make-0.1.2 && \
    ${CABAL_INSTALL} elm-repl-0.4.1 elm-reactor-0.3.1
ENV PATH /root/.cabal/bin:$PATH

# RUN useradd -d /app -m app
# USER app
WORKDIR /app
# ENV HOME /app

ENV PORT 3000

# RUN mkdir -p /app/heroku/
# RUN mkdir -p /app/src
# RUN curl -s https://s3pository.heroku.com/node/v$NODE_ENGINE/node-v$NODE_ENGINE-linux-x64.tar.gz | tar --strip-components=1 -xz -C /app/heroku/node
# ENV PATH /app/heroku/node/bin:$PATH

# RUN mkdir -p /app/.profile.d
# RUN echo "export PATH=\"/app/heroku/node/bin:/app/bin:/app/src/node_modules/.bin:\$PATH\"" > /app/.profile.d/nodejs.sh
# RUN echo "cd /app/src" >> /app/.profile.d/nodejs.sh
WORKDIR /app/src

EXPOSE 3000

ONBUILD COPY . /app/src
ONBUILD RUN elm-make *.elm
