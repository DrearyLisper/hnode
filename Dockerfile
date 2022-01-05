FROM debian:stable-slim as build

COPY hnode /
CMD /hnode
