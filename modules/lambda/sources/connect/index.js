const { DynamoDBClient, PutItemCommand } = require("@aws-sdk/client-dynamodb");
const client = new DynamoDBClient({ region: "eu-west-2" });

const addConnectionId = async (connectionId) => {
  const command = new PutItemCommand({
    TableName: "connections",
    Item: { id: { S: connectionId } },
  });

  return client.send(command);
};

exports.handler = (event, context, callback) => {
  const { connectionId } = event.requestContext;

  addConnectionId(connectionId).then(() => {
    callback(null, { statusCode: 200 });
  });
};
