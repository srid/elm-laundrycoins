FROM ubuntu:14.04

MAINTAINER Sridhar Ratnakumar <srid@srid.ca>

# Install Elm
# ###########

# Install Haskell and Cabal
RUN apt-get update && \
    apt-get -y install haskell-platform wget libncurses5-dev && \
    apt-get clean
RUN cabal update && cabal install cabal-install

# Elm 0.15, per http://elm-lang.org/Install.elm
# Modify this instruction for newer releases.
RUN cabal install -j elm-compiler-0.15 elm-package-0.5 elm-make-0.1.2 && \
    cabal install -j elm-repl-0.4.1 elm-reactor-0.3.1


# Add source and build
ADD . /app
WORKDIR /app
RUN make

EXPOSE 8080
CMD "python -m SimpleHTTPServer 8080 ."
