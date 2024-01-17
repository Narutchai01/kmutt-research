FROM node:20.9.0

# Create app directory
WORKDIR /user/src/app

# Install app dependencies
COPY package*.json ./

RUN npm install && tsc 


# Bundle app source
COPY ./dist /user/src/app/dist

COPY .env /user/src/app/.env


CMD ["node","--watch","./dist/server.js"]