const AWS = require('aws-sdk');
const ddb = new AWS.DynamoDB.DocumentClient();

const addConnectionId = (connectionId) => {    
    return ddb.put({
        TableName: 'connections',
        Item: { id: connectionId }
    }).promise();
}

exports.handler = (event, context, callback) => {    
    const { connectionId } = event.requestContext;

    addConnectionId(connectionId).then(() => {
        callback(null, { statusCode: 200 });
    });
}
