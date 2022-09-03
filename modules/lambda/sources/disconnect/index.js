const AWS = require('aws-sdk');
const ddb = new AWS.DynamoDB.DocumentClient();
const removeConnectionId = (connectionId) => {
    return ddb.delete({
        TableName: 'connections',
        Key: {            
            id: connectionId,
        },    
    }).promise();
}
exports.handler = (event, context, callback) => {    
    const connectionId = event.requestContext.connectionId;    
    removeConnectionId(connectionId).then(() => {    
        callback(null, {
            statusCode: 200,
        })    
    });
}
