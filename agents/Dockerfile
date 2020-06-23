
FROM demos/spdy-ng:latest as test
WORKDIR /src
COPY testapp .
RUN npm run test_ci

FROM test as build
RUN npm run build_ci

FROM scratch as export
COPY --from=build /src/dist/testapp /
