
FROM agent:latest as test
WORKDIR /src
RUN ng test --browsers ChromeHeadless

FROM test as build
RUN npm run build --production
