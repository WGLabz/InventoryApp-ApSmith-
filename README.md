## Setup

Use the docker-compose file to set u the stack.

## Setup MngoDB replication,
> login to the monoDB container and run the following command,

```js
rs.initiate({
  _id: "rs0",
  members: [
    { _id: 0, host: "mongo1:27017" }
  ]
})

```
