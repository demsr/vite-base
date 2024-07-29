FROM node as buildstage
RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app
WORKDIR /home/node/app
COPY package*.json ./
USER node
RUN yarn install
COPY --chown=node:node . .
RUN yarn build
FROM nginx:latest
COPY --from=buildstage /home/node/app/dist /usr/share/nginx/html
EXPOSE 80