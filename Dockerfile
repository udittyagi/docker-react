#We will use here multistep build process
#STEP 1 - Builder Step
FROM node:16-alpine AS builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
# This is not the default command so we use RUN
RUN npm run build

# STEP 2 - Run Step
# In step 2 only the things we copy will remain in the final image rest things
# such as node_modules will be discarded
FROM nginx
#Copy the result of bulder stage
COPY --from=builder /app/build /usr/share/nginx/html
