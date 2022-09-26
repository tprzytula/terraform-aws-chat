const AWS = require("aws-sdk");
const ddb = new AWS.DynamoDB.DocumentClient();

const getMessage = async (id) => {
  return ddb
    .get({
      TableName: "messages",
      Key: { id },
      AttributesToGet: ["id"],
    })
    .promise();
};

exports.handler = async (event, context, callback) => {
  const { id } = JSON.parse(event.body).payload;
  console.log("received id", id);

  const message = await getMessage(id);
  console.log("Retrieved message", message);

  callback(null, { statusCode: 200 });
};
