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
# Static file server
RUN ${CABAL_INSTALL} wai-app-static
ENV PATH /root/.cabal/bin:$PATH

ENV PORT 3000

RUN mkdir -p /app/.profile.d
RUN echo "export PATH=\"/app/bin:\$PATH\"" > /app/.profile.d/warp.sh
RUN echo "cd /app" >> /app/.profile.d/warp.sh

EXPOSE 3000

# Build the Elm project; copy generated and static files to /app; get rid of
# /app/src to save on slug size.
ONBUILD RUN mkdir /app/bin && cp $(which warp) /app/bin
ONBUILD ADD elm-package.json /app/src/
ONBUILD WORKDIR /app/src
ONBUILD RUN elm-package install --yes
ONBUILD COPY . /app/src
ONBUILD RUN elm-make *.elm --output=index.html
ONBUILD RUN cp index.html /app
ONBUILD WORKDIR /app
ONBUILD RUN rm -rf /app/src
