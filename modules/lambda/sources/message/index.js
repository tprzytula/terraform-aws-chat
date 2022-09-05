const AWS = require("aws-sdk");
const { randomUUID } = require("crypto");
const ddb = new AWS.DynamoDB.DocumentClient();

const getConnections = () => {
  return ddb
    .scan({
      TableName: "connections",
    })
    .promise();
};

const addMessage = async (message) => {
  const id = randomUUID();

  await ddb
    .put({
      TableName: "messages",
      Item: { id, message },
    })
    .promise();

  return id;
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

  console.log(`Received a message ${parsedMessage} from ${connectionId}`);

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
