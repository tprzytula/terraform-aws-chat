const AWS = require("aws-sdk");
const {
  DynamoDBClient,
  PutItemCommand,
  ScanCommand,
} = require("@aws-sdk/client-dynamodb");
const { randomUUID } = require("crypto");
const client = new DynamoDBClient({ region: "eu-west-2" });

const getConnections = () => {
  const command = new ScanCommand({
    TableName: "connections",
  });

  return client.send(command);
};

const addMessage = async (message) => {
  const id = randomUUID();

  const command = new PutItemCommand({
    TableName: "messages",
    Item: {
      id: { S: id },
      message: { S: message },
      visible: { BOOL: true },
    },
  });

  return client.send(command);
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

exports.handler = async (event, context, callback) => {
  const { connectionId } = event.requestContext;
  const apiGatewayAPI = createAPIGatewayAPI(event);
  const parsedMessage = JSON.parse(event.body);
  const { message } = parsedMessage.payload;
  const messageId = await addMessage(message);

  parsedMessage.payload.id = messageId;

  console.log(`Received a message ${event.body} from ${connectionId}`);

  getConnections().then((data) => {
    data.Items.forEach(({ id }) => {
      console.log(`Sending message to connection ${id}`);
      sendMessage({
        client: apiGatewayAPI,
        connectionId: id,
        message: JSON.stringify(parsedMessage),
      });
    });
  });

  callback(null, { statusCode: 200 });
};
