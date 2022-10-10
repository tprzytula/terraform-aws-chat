const AWS = require("aws-sdk");
const {
  DynamoDBClient,
  UpdateItemCommand,
  ScanCommand,
} = require("@aws-sdk/client-dynamodb");
const client = new DynamoDBClient({ region: "eu-west-2" });

const getConnections = async () => {
  const command = new ScanCommand({
    TableName: "connections",
  });

  return client.send(command);
};

const makeMessageInvisible = async (id) => {
  const command = new UpdateItemCommand({
    TableName: "messages",
    Key: { id: { S: id } },
    UpdateExpression: "set visible = :v",
    ExpressionAttributeValues: {
      ":v": { BOOL: false },
    },
  });

  client.send(command);
};

const createAPIGatewayAPI = (event) => {
  return new AWS.ApiGatewayManagementApi({
    apiVersion: "2018-11-29",
    endpoint:
      event.requestContext.domainName + "/" + event.requestContext.stage,
  });
};

const sendMessage = async ({ connectionId, message, client }) => {
  await client
    .postToConnection({
      ConnectionId: connectionId,
      Data: message,
    })
    .promise();
};

const updateConnections = async ({ message, apiGatewayAPI }) => {
  const connections = await getConnections();

  connections.Items.forEach(({ id: { S: connectionId } }) => {
    console.log("Sending message to connection ", connectionId);
    sendMessage({
      client: apiGatewayAPI,
      connectionId,
      message,
    });
  });
};

exports.handler = async (event, context, callback) => {
  const { id } = JSON.parse(event.body).payload;
  const apiGatewayAPI = createAPIGatewayAPI(event);
  console.log("received id", id);

  try {
    await makeMessageInvisible(id);
    await updateConnections({
      message: event.body,
      apiGatewayAPI,
    });

    callback(null, { statusCode: 200 });
  } catch (error) {
    console.log("Encountered error:", error);
    callback(null, { statusCode: 500 });
  }
};
