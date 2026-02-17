FROM node:22-alpine

WORKDIR /app

RUN apk update && apk upgrade && \
  apk add git

COPY . /app/
RUN yarn install
RUN yarn build

EXPOSE 3000

ENV NUXT_HOST=0.0.0.0
ENV NUXT_PORT=3000

CMD [ "yarn", "preview" ]
