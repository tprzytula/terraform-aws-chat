const {
  DynamoDBClient,
  DeleteItemCommand,
} = require("@aws-sdk/client-dynamodb");
const client = new DynamoDBClient({ region: "eu-west-2" });

const removeConnectionId = (connectionId) => {
  new DeleteItemCommand({ TableName: "connections", Key: {} });
  const command = new DeleteItemCommand({
    TableName: "connections",
    Key: { id: { S: connectionId } },
  });

  return client.send(command);
};

exports.handler = async (event, context, callback) => {
  const { connectionId } = event.requestContext;

  await removeConnectionId(connectionId);

  callback(null, {
    statusCode: 200,
  });
};
